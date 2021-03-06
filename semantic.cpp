#include "string.h"
#include "symbolTable.h"
#include "semantic.h"
#include "globals.h"

#define NUM_OPS 18

extern int numErrors;
extern int numWarnings;
extern int localOffset;
extern int globalOffset;
extern TokenTree *syntaxTree;
extern SymbolTable *symbolTable;

void incermentError(TokenTree *node) 
{
    printf("ERROR(%d): ", node->getLineNum());
    numErrors++;
}

void incermentWarn(TokenTree *node) 
{
    printf("WARNING(%d): ", node->getLineNum());
    numWarnings++;
}

bool sameType(TokenTree *lhs, TokenTree *rhs) { return lhs->getExprType() == rhs->getExprType(); }

void handleBooleanComparison(TokenTree *tree) 
{
    tree->setExprType(ExprType::BOOL);
    TokenTree *lhs = tree->children[0];
    TokenTree *rhs = tree->children[1];

    if (!lhs->isExprTypeUndefined() and lhs->getExprType() != ExprType::BOOL) {
        incermentError(tree);
        printf("'%s' requires operands %s but lhs is %s.\n", tree->getStringValue(), tree->getTypeString(), lhs->getTypeString());
    }

    if (!rhs->isExprTypeUndefined() and rhs->getExprType() != ExprType::BOOL) {
        incermentError(tree);
        printf("'%s' requires operands %s but rhs is %s.\n", tree->getStringValue(), tree->getTypeString(), rhs->getTypeString());
    }
    
    if (lhs->isArray() or rhs->isArray()) {
        incermentError(tree);
        printf("The operation '%s' does not work with arrays.\n", tree->getStringValue());
    }
}

void handleNot(TokenTree *tree) 
{
    tree->setExprType(ExprType::BOOL);
    TokenTree *lhs = tree->children[0];
    
    if (tree->cascadingError() and lhs->getExprType() != ExprType::BOOL) {
        incermentError(tree);
        printf("Unary '%s' requires an operand of %s but was given %s.\n", tree->getStringValue(), tree->getType(), lhs->getType());
    }

    if (lhs->isArray()) {
        incermentError(tree);
        printf("The operation '%s' does not work with arrays.\n", tree->getStringValue());
    }
}

void handleMath(TokenTree *tree) 
{
    tree->setExprType(ExprType::INT);
    TokenTree *lhs = tree->children[0];
    TokenTree *rhs = tree->children[1];
    
    if (!lhs->isExprTypeUndefined() and lhs->getExprType() != ExprType::INT) {
        incermentError(tree);
        printf("'%s' requires operands %s but lhs is %s.\n", tree->getTokenString(), tree->getTypeString(), lhs->getTypeString());
    }
    
    if (!rhs->isExprTypeUndefined() and rhs->getExprType() != ExprType::INT) {
        incermentError(tree);
        printf("'%s' requires operands %s but rhs is %s.\n", tree->getTokenString(), tree->getTypeString(), rhs->getTypeString());
    }
    
    if (lhs->isArray() or rhs->isArray()) {
        incermentError(tree);
        printf("The operation '%s' does not work with arrays.\n", tree->getTokenString());
    }
}

void handleChsignOpK(TokenTree *tree) 
{
    if (tree->children[1] != NULL) { handleMath(tree); } 
    else {
        tree->setExprType(ExprType::INT);
        TokenTree *lhs = tree->children[0];
        
        if (tree->cascadingError() and lhs->getExprType() != ExprType::INT) {
            incermentError(tree);
            printf("Unary '%s' requires an operand of %s but was given %s.\n", tree->getStringValue(), tree->getType(), lhs->getType());
        }
        
        if (lhs->isArray()) {
            incermentError(tree);
            printf("The operation '%s' does not work with arrays.\n", tree->getStringValue());
        }
    }
}

void handleSizeofOpK(TokenTree *tree) 
{
    if (tree->children[1] != NULL) {
        handleMath(tree);
    } 
    else {
        TokenTree *lhs = tree->children[0];
        tree->setExprType(ExprType::INT);
        if (tree->cascadingError()) {
            if (!lhs->isArray()) {
                incermentError(tree);
                printf("The operation '%s' only works with arrays.\n", tree->getStringValue());
            }
        }
    }
}

void handleUnaryOpK(TokenTree *tree) 
{
    tree->setExprType(ExprType::INT);
    TokenTree *lhs = tree->children[0];
    if (lhs->getExprType() != ExprType::INT) {
        incermentError(tree);
        printf("Unary '%s' requires an operand of %s but was given %s.\n", tree->getStringValue(), tree->getTypeString(), lhs->getType());
    }
    if (lhs->isArray()) {
        incermentError(tree);
        printf("The operation '%s' does not work with arrays.\n", tree->getStringValue());
    }
}

void handleRandom(TokenTree *tree) 
{
    TokenTree *lhs = tree->children[0];
    tree->setExprType(lhs->getExprType());
    if (lhs->getExprType() != ExprType::INT) {
        incermentError(tree);
        printf("Unary '%s' requires an operand of %s but was given %s.\n", tree->getTokenString(), "type int", lhs->getType());
    }
    
    if (lhs->isArray()) {
        incermentError(tree);
        printf("The operation '%s' does not work with arrays.\n", tree->getTokenString());
    }
}

void handleComparison(TokenTree *tree) 
{
    tree->setExprType(ExprType::BOOL);
    TokenTree *lhs = tree->children[0];
    TokenTree *rhs = tree->children[1];
    if (tree->cascadingError()) {
        if (!sameType(lhs, rhs)) {
            incermentError(tree);
            printf("'%s' requires operands of the same type but lhs is %s and rhs is %s.\n", tree->getTokenString(), lhs->getType(), rhs->getType());
        }
    }
    
    if (lhs->isArray() ^ rhs->isArray()) {
        char *lhsStr = (char*) "";
        char *rhsStr = (char*) "";
        if (!lhs->isArray()) lhsStr = (char*) " not";
        if (!rhs->isArray()) rhsStr = (char*) " not";
        
        incermentError(tree);
        printf("'%s' requires both operands be arrays or not but lhs is%s an array and rhs is%s an array.\n", tree->getTokenString(), lhsStr, rhsStr);
    }
}

void handleArrayAccess(TokenTree *tree) 
{
    TokenTree *array = tree->children[0];
    tree->setExprType(array->getExprType());
    TokenTree *index = tree->children[1];
    if (array == NULL) {
        incermentError(tree);
        printf("Cannot index nonarray.\n");
        return;
    }
    
    if (!array->isArray()) {
        incermentError(tree);
        printf("Cannot index nonarray '%s'.\n", array->getStringValue());
    }
    
    if (!index->isExprTypeUndefined() and index->getExprType() != ExprType::INT) {
        incermentError(tree);
        printf("Array '%s' should be indexed by type int but got %s.\n", array->getStringValue(), index->getType());
    }
    
    if (index->isArray()) {
        incermentError(tree);
        printf("Array index is the unindexed array '%s'.\n", index->getStringValue());
    }
}

// used for operator checking
const char *operations[NUM_OPS] = { "<=", "<", ">=", ">", "&", "|", "!", "+", "-", "*", "/", "%", "++", "--", "?", "==", "!=", "[" };

// used for function checking
void (*functionPointers[NUM_OPS])(TokenTree *) = 
{
    handleComparison, handleComparison, handleComparison, handleComparison,
    handleBooleanComparison, handleBooleanComparison, handleNot, handleMath,
    handleChsignOpK, handleSizeofOpK, handleMath, handleMath, handleUnaryOpK,
    handleUnaryOpK, handleRandom,handleComparison, handleComparison, handleArrayAccess
};

int indexOfOperation(TokenTree *tree) 
{
    for (int i = 0; i < NUM_OPS; i++) {
        if (strcmp(tree->getTokenString(), operations[i]) == 0) {
            return i;
        }
    }
    return -1;
}

bool compoundShouldEnterScope(TokenTree *parent) 
{
    if (parent == NULL) return true;
    if (parent->getNodeKind() == NodeKind::DeclK and parent->getDeclKind() == DeclKind::FuncK) {
        return false;
    }
    if (parent->getNodeKind() == NodeKind::StmtK and parent->getStmtKind() == StmtKind::ForK) {
        return false;
    }

    return true;
}

// traverse child and check for scoping and incermentErrorors
void traverseChild(TokenTree *tree, bool *scopeEntered, int &previousLocalOffset) 
{
    if (tree->parent != NULL and tree->parent->getNodeKind() == NodeKind::ExpK and tree->parent->getExprKind() == ExprKind::CallK) {
        TokenTree *res = (TokenTree *) symbolTable->lookup(tree->parent->getStringValue());
        if (res != NULL) {
            int counter = 1;
            TokenTree *param = res->children[0];
            TokenTree *input = tree->parent->children[0]; 
            while (input != tree and param != NULL) { 
                param = param->sibling; 
                input = input->sibling;
                counter++;
            }
            
            if (param == NULL and input == tree) {
                incermentError(tree);
                printf("Too many parameters passed for function '%s' declared on line %d.\n", res->getStringValue(), res->getLineNum());
            }
        }
    }
    switch (static_cast<int>(tree->getNodeKind())) {
        case 0: {
            if (tree->getDeclKind() != DeclKind::VarK) {
                bool defined = !symbolTable->insert(tree->getStringValue(), tree);
                if (tree->getDeclKind() == DeclKind::FuncK) {
                    symbolTable->enter("Function: " + std::string(tree->getStringValue()));
                    *scopeEntered = true;
                    localOffset = -2;
                } 
                else { // Must be param
                    tree->setMemoryType(MemoryType::PARAM);
                    tree->calculateMemoryOffset();
                    tree->setIsInitialized(true);
                }

                if (defined) {
                    TokenTree *res = (TokenTree *) symbolTable->lookup(tree->getStringValue());
                    incermentError(tree);
                    printf("Symbol '%s' is already declared at line %d.\n", res->getStringValue(), res->getLineNum());
                }
            } 
            else {
                if (tree->parent == NULL) {
                    tree->setMemoryType(MemoryType::GLOBAL);
                } 
                else if (tree->isStatic()) {
                    tree->setMemoryType(MemoryType::LOCAL_STATIC);
                } 
                else {
                    tree->setMemoryType(MemoryType::LOCAL);
                }
                if (tree->children[0] != NULL) {
                    tree->setIsInitialized(true);
                }
            }            
            break;
        }
        case 1: {
            switch (static_cast<int>(tree->getExprKind())) {
                case 0: {

                    break;
                }
                case 1: {
                    TokenTree *res = (TokenTree *) symbolTable->lookup(tree->getStringValue());
                    if (res == NULL) {
                        incermentError(tree);
                        printf("Symbol '%s' is not declared.\n", tree->getStringValue());
                    } 
                    else {
                        tree->setExprType(res->getExprType());
                        if (res->getDeclKind() != DeclKind::FuncK) {
                            incermentError(tree);
                            printf("'%s' is a simple variable and cannot be called.\n", tree->getStringValue());
                            tree->setExprType(ExprType::UNDEFINED);
                        }
                    }
                    break;
                }
                case 2: {
                    if (tree->isArray()) {
                        tree->setMemoryType(MemoryType::GLOBAL);
                        tree->calculateMemoryOffset();
                    }
                    break;
                }
                case 3: {
                    TokenTree *res = (TokenTree *) symbolTable->lookup(tree->getStringValue());
                    if (res == NULL or (res->getDeclKind() == DeclKind::VarK and tree->hasParent(res, true))) {
                        incermentError(tree);
                        printf("Symbol '%s' is not declared.\n", tree->getStringValue());
                    } 
                    else if (res->getDeclKind() != DeclKind::FuncK) {
                        res->setIsUsed(true);
                        tree->copyMemoryInfo(res);
                        tree->setExprType(res->getExprType());
                        tree->setIsArray(res->isArray());
                        tree->setIsStatic(res->isStatic());
                        tree->setMemoryType(res->getMemoryType());
                        
                        if (tree->shouldCheckInit() and res->shouldCheckInit() and !res->isInitialized() and res->parent != NULL) {
                            incermentWarn(tree);
                            printf("Variable '%s' may be uninitialized when used here.\n", tree->getStringValue());
                            res->cancelCheckInit(false);
                        }
                    } 
                    else {
                        incermentError(tree);
                        printf("Cannot use function '%s' as a variable.\n", tree->getStringValue());
                    }
                    break;
                }
            }
            break;
        }
        case 2: {
            switch ( static_cast<int>(tree->getStmtKind()) ) {
                case 1: {
                    if (compoundShouldEnterScope(tree->parent)) {
                        *scopeEntered = true;
                        symbolTable->enter("Compound Statement");
                        previousLocalOffset = localOffset;
                        break;
                    }
                    break;
                }
                case 2: {
                    *scopeEntered = true;
                    symbolTable->enter("For Statement");
                    previousLocalOffset = localOffset;
                    TokenTree *child = tree->children[0];
                    TokenTree *array = tree->children[1];
                    TokenTree *res = (TokenTree *) symbolTable->lookup(array->getStringValue());
                    if (res != NULL) { child->setExprType(res->getExprType()); }
                    child->setIsInitialized(true);
                    break;
                }
                case 0: {
                    TokenTree *tmp = tree;
                    bool foundLoop = false;
                    while (tmp->parent != NULL) {
                        TokenTree *parent = tmp->parent;
                        if (parent->getNodeKind() == NodeKind::StmtK and (parent->getStmtKind() == StmtKind::WhileK or parent->getStmtKind() == StmtKind::ForK)) {
                            foundLoop = true;
                            break;
                        }
                        tmp = parent;
                    }

                    if (!foundLoop) {
                        incermentError(tree);
                        printf("Cannot have a break statement outside of loop.\n");
                    }
                    break;
                }
            }
            break;
        }
    }
}

void afterChild(TokenTree *tree, int childNo) 
{
    switch ( static_cast<int>(tree->getNodeKind()) ) {
        case 2: {
            switch ( static_cast<int>(tree->getStmtKind()) ) {
                case 2: {
                    if (childNo == 1) {
                        TokenTree *array = tree->children[1];
                        TokenTree *res = (TokenTree *) symbolTable->lookup(array->getStringValue());
                        if (res != NULL) { res->setIsInitialized(true); }
                        
                        if (res == NULL or !res->isArray()) {
                            // incermentError(tree);
                            // printf("For statement requires that symbol '%s' be an array to loop through.\n", array->getStringValue());
                        }
                    }
                    break;
                }
                case 5: {
                    if (childNo == 0) {
                        TokenTree *condition = tree->children[0];
                        if (!condition->isExprTypeUndefined()) {
                            if (condition->getExprType() != ExprType::BOOL) {
                                incermentError(tree);
                                printf("Expecting Boolean test condition in %s statement but got %s.\n", tree->getTokenString(), condition->getType());
                            }

                            if (condition->isArray()) {
                                incermentError(tree);
                                printf("Cannot use array as test condition in %s statement.\n", tree->getTokenString());
                            }
                        }
                    }
                    break;
                }
                case 3: {
                    if (childNo == 0) {
                        TokenTree *condition = tree->children[0];
                        if (!condition->isExprTypeUndefined()) {
                            if (condition->getExprType() != ExprType::BOOL) {
                                incermentError(tree);
                                printf("Expecting Boolean test condition in %s statement but got %s.\n", tree->getTokenString(), condition->getType());
                            }
                            if (condition->isArray()) {
                                incermentError(tree);
                                printf("Cannot use array as test condition in %s statement.\n", tree->getTokenString());
                            }
                        }
                    }
                    break;
                }
            }
            break;
        }
    }
}

void afterChildren(TokenTree *tree) 
{
    switch ( static_cast<int>(tree->getNodeKind()) ) {
        case 0: {
            switch ( static_cast<int>(tree->getDeclKind()) ) {
                case 1: {
                    if (tree->getExprType() != ExprType::VOID and !tree->hasReturn()) {
                        incermentWarn(tree);
                        printf("Expecting to return %s but function '%s' has no return statement.\n", tree->getType(), tree->getStringValue());
                    }
                    tree->calculateMemoryOfChildren();
                    break;
                }
                case 0: {
                    bool defined = !symbolTable->insert(tree->getStringValue(), tree);
                    tree->calculateMemoryOffset();
                    TokenTree *child = tree->children[0];
                    if (tree->children[0] != NULL and !tree->children[0]->isConstantExpression()) {
                        incermentError(tree);
                        printf("Initializer for variable '%s' is not a constant expression.\n", tree->getStringValue());
                    }
                    if (defined) {
                        TokenTree *res = (TokenTree *) symbolTable->lookup(tree->getStringValue());
                        incermentError(tree);
                        printf("Symbol '%s' is already declared at line %d.\n", res->getStringValue(), res->getLineNum());
                    }
                    if (child != NULL and !child->isExprTypeUndefined() and !sameType(tree, child)) {
                        incermentError(tree);
                        printf("Initializer for variable '%s' %s is %s\n", tree->getStringValue(), tree->getTypeString(), child->getTypeString());
                    }
                    break;
                }
            }
            break;
        }
        case 1: {
            switch ( static_cast<int>(tree->getExprKind()) ){
                case 0: {
                    TokenTree *lhs = tree->children[0];
                    TokenTree *rhs = tree->children[1];

                    // inc/dec
                    if (rhs == NULL) {
                        tree->setExprType(ExprType::INT);
                        if (tree->cascadingError()) {
                            if (lhs->getExprType() != ExprType::INT) {
                                incermentError(tree);
                                printf("Unary '%s' requires an operand of %s but was given %s.\n", tree->getTokenString(), tree->getType(), lhs->getType());
                            }
                        }
                        
                        if (lhs->isArray()) {
                            incermentError(tree);
                            printf("The operation '%s' does not work with arrays.\n", tree->getTokenString());
                        }
                    } 
                    // ASSIGN,ADDASS,SUBASS,MULASS,DIVASS
                    else { 
                        bool isAssign = (strcmp(tree->getStringValue(), "=") == 0);
                        if (isAssign) {
                            tree->setExprType(lhs->getExprType());
                            tree->setIsArray(lhs->isArray());
                            if (tree->cascadingError()) {
                                if (!sameType(lhs, rhs)) {
                                    incermentError(tree);
                                    printf("'%s' requires operands of the same type but lhs is %s and rhs is %s.\n", tree->getTokenString(), lhs->getType(), rhs->getType());
                                }
                            }
                            if (lhs->isArray() ^ rhs->isArray()) {
                                char *lhsStr = (char*) "";
                                char *rhsStr = (char*) "";
                                if (!lhs->isArray()) lhsStr = (char*) " not";
                                if (!rhs->isArray()) rhsStr = (char*) " not";
                                incermentError(tree);
                                printf("'%s' requires both operands be arrays or not but lhs is%s an array and rhs is%s an array.\n", tree->getTokenString(), lhsStr, rhsStr);
                            }
                        } else {
                            tree->setExprType(ExprType::INT);
                            if (!lhs->isExprTypeUndefined() and lhs->getExprType() != ExprType::INT) {
                                incermentError(tree);
                                printf("'%s' requires operands %s but lhs is of %s.\n", tree->getTokenString(), tree->getTypeString(), lhs->getType());
                            }
                            if (!rhs->isExprTypeUndefined() and rhs->getExprType() != ExprType::INT) {
                                incermentError(tree);
                                printf("'%s' requires operands %s but rhs is of %s.\n", tree->getTokenString(), tree->getTypeString(), rhs->getType());
                            }
                            if (lhs->isArray() or rhs->isArray()) {
                                incermentError(tree);
                                printf("The operation '%s' does not work with arrays.\n", tree->getTokenString());
                            }
                        }
                        TokenTree *res;
                        if (lhs->getExprKind() == ExprKind::IdK) {
                            res = (TokenTree *) symbolTable->lookup(lhs->getStringValue());
                        } else {
                            res = (TokenTree *) symbolTable->lookup(lhs->children[0]->getStringValue());
                        }
                        if (res == NULL or res->getDeclKind() == DeclKind::FuncK) break;
                        res->setIsInitialized(true);
                    }
                    break;
                }
                case 1: {
                    TokenTree *res = (TokenTree *) symbolTable->lookup(tree->getStringValue());
                    if (res != NULL) {
                        TokenTree *param = res->children[0];
                        TokenTree *input = tree->children[0];
                        int numParams, numInputs;
                        if (param == NULL) numParams = 0; else numParams = param->getNumSiblings(true);
                        if (input == NULL) numInputs = 0; else numInputs = input->getNumSiblings(true);

                        // Param inputs handled at bottom of this function.
                        // Reasoning is described there
                        // We only check for too few parameters here
                        if (numParams > numInputs) {
                            incermentError(tree);
                            printf("Too few parameters passed for function '%s' declared on line %d.\n", res->getStringValue(), res->getLineNum());
                        }
                        
                    }
                    break;
                }
                case 4: {
                    void (*fp)(TokenTree *) = functionPointers[indexOfOperation(tree)];
                    fp(tree);
                    break;
                }
                case 3: {                    
                    break;
                }
            }
            break;
        }
        case 2: {
            switch ( static_cast<int>(tree->getStmtKind()) ) {
                case 4: {
                    tree->function->setHasReturn(true);
                    TokenTree *returnValue = tree->children[0];
                    bool returnNodeExists = returnValue != NULL;
                    bool expectingReturn = tree->function->getExprType() != ExprType::VOID;
                    if (returnNodeExists) {
                        if (expectingReturn) {
                            if (!returnValue->isExprTypeUndefined() and returnValue->getExprType() != tree->function->getExprType()) {
                                incermentError(tree);
                                printf("Function '%s' at line %d is expecting to return %s but returns %s.\n", tree->function->getStringValue(), tree->function->getLineNum(), tree->function->getType(), returnValue->getType());
                            }
                        } else { // Function does not expect return
                            incermentError(tree);
                            printf("Function '%s' at line %d is expecting no return value, but return has a value.\n", tree->function->getStringValue(), tree->function->getLineNum());
                        }
                        if (returnValue->isArray()) {
                            incermentError(tree);
                            printf("Cannot return an array.\n");
                        }
                    } else { // No return node exists
                        if (expectingReturn) {
                            incermentError(tree);
                            printf("Function '%s' at line %d is expecting to return %s but return has no value.\n", tree->function->getStringValue(), tree->function->getLineNum(), tree->function->getType());
                        }
                    }
                    break;
                }
            }
            break;
        }
    }
    
    if (tree->parent != NULL and tree->parent->getNodeKind() == NodeKind::ExpK and tree->parent->getExprKind() == ExprKind::CallK) {
        TokenTree *res = (TokenTree *) symbolTable->lookup(tree->parent->getStringValue());
        if (res != NULL) {
            int counter = 1;
            TokenTree *param = res->children[0];
            TokenTree *input = tree->parent->children[0]; // Start back over in tree so we can tell the position
            while (input != tree and param != NULL) { // Travel accross siblings until we reach our desired input
                param = param->sibling; // Param is moved along with input to ensure matching
                input = input->sibling;
                counter++;
            }
            if (param != NULL) { // If param is null, then we had more inputs than function allowed
                if (!input->isExprTypeUndefined() and param->getExprType() != input->getExprType()) {
                    incermentError(tree);
                    printf("Expecting %s in parameter %i of call to '%s' declared on line %d but got %s.\n", param->getType(), counter, res->getStringValue(), res->getLineNum(), input->getType());
                }
                if (param->isArray() and !input->isArray()) {
                    incermentError(tree);
                    printf("Expecting array in parameter %i of call to '%s' declared on line %d.\n", counter, res->getStringValue(), res->getLineNum());
                } else if (!param->isArray() and input->isArray()) {
                    incermentError(tree);
                    printf("Not expecting array in parameter %i of call to '%s' declared on line %d.\n", counter, res->getStringValue(), res->getLineNum());
                }
            }
        }
    }
}

void checkUsage(std::string, void *node) {
    TokenTree *tree = (TokenTree *) node;
    NodeKind nk = tree->getNodeKind();
    if (nk == NodeKind::DeclK and tree->getDeclKind() != DeclKind::FuncK) {
        if (!tree->isUsed()) {
            incermentWarn(tree);
            if (tree->getDeclKind() == DeclKind::ParamK) {
                printf("The parameter '%s' seems not to be used.\n", tree->getStringValue());
            }
            else {
                printf("The variable '%s' seems not to be used.\n", tree->getStringValue());
            }
        }
    }
}

void buildSymbolTable(TokenTree *tree) 
{
    bool scopeEntered = false;
    int previousLocalOffset = -2;

    traverseChild(tree, &scopeEntered, previousLocalOffset);
    

    for (int i = 0; i < MAX_CHILDREN; i++) {
        TokenTree *child = tree->children[i];
        if (child != NULL) {
            buildSymbolTable(child);
        }
        afterChild(tree, i);
    }

    afterChildren(tree);

    if (scopeEntered) {
        symbolTable->applyToAll(checkUsage);
        symbolTable->leave();
        localOffset = previousLocalOffset;
    }

    if (tree->sibling != NULL) {
        buildSymbolTable(tree->sibling);
    }    
}

void buildIORoutines() 
{
    TokenTree *outnl = new TokenTree();
    outnl->setDeclKind(DeclKind::FuncK);
    outnl->setLineNum(-1);
    outnl->setTokenString((char *) "outnl");
    outnl->setStringValue((char *) "outnl");
    outnl->setExprType(ExprType::VOID);

    TokenTree *inputc = new TokenTree();
    inputc->setDeclKind(DeclKind::FuncK);
    inputc->setLineNum(-1);
    inputc->setTokenString((char *) "inputc");
    inputc->setStringValue((char *) "inputc");
    inputc->setExprType(ExprType::CHAR);
    inputc->setHasReturn(true);
    inputc->addSibling(outnl);

    TokenTree *inputb = new TokenTree();
    inputb->setDeclKind(DeclKind::FuncK);
    inputb->setLineNum(-1);
    inputb->setTokenString((char *) "inputb");
    inputb->setStringValue((char *) "inputb");
    inputb->setExprType(ExprType::BOOL);
    inputb->setHasReturn(true);
    inputb->addSibling(inputc);

    TokenTree *input = new TokenTree();
    input->setDeclKind(DeclKind::FuncK);
    input->setLineNum(-1);
    input->setTokenString((char *) "input");
    input->setStringValue((char *) "input");
    input->setExprType(ExprType::INT);
    input->setHasReturn(true);
    input->addSibling(inputb);

    TokenTree *charDummy = new TokenTree();
    charDummy->setDeclKind(DeclKind::ParamK);
    charDummy->setLineNum(-1);
    charDummy->setTokenString((char *) "*dummy*");
    charDummy->setStringValue((char *) "*dummy*");
    charDummy->setExprType(ExprType::CHAR);
    charDummy->cancelCheckInit(false);
    charDummy->setIsUsed(true);

    TokenTree *outputc = new TokenTree();
    outputc->setDeclKind(DeclKind::FuncK);
    outputc->setLineNum(-1);
    outputc->setTokenString((char *) "outputc");
    outputc->setStringValue((char *) "outputc");
    outputc->setExprType(ExprType::VOID);
    outputc->children[0] = charDummy;
    outputc->addSibling(input);

    TokenTree *boolDummy = new TokenTree();
    boolDummy->setDeclKind(DeclKind::ParamK);
    boolDummy->setLineNum(-1);
    boolDummy->setTokenString((char *) "*dummy*");
    boolDummy->setStringValue((char *) "*dummy*");
    boolDummy->setExprType(ExprType::BOOL);
    boolDummy->cancelCheckInit(false);
    boolDummy->setIsUsed(true);

    TokenTree *outputb = new TokenTree();
    outputb->setDeclKind(DeclKind::FuncK);
    outputb->setLineNum(-1);
    outputb->setTokenString((char *) "outputb");
    outputb->setStringValue((char *) "outputb");
    outputb->setExprType(ExprType::VOID);
    outputb->children[0] = boolDummy;
    outputb->addSibling(outputc);

    TokenTree *intDummy = new TokenTree();
    intDummy->setDeclKind(DeclKind::ParamK);
    intDummy->setLineNum(-1);
    intDummy->setTokenString((char *) "*dummy*");
    intDummy->setStringValue((char *) "*dummy*");
    intDummy->setExprType(ExprType::INT);
    intDummy->cancelCheckInit(false);
    intDummy->setIsUsed(true);

    TokenTree *output = new TokenTree();
    output->setDeclKind(DeclKind::FuncK);
    output->setLineNum(-1);
    output->setTokenString((char *) "output");
    output->setStringValue((char *) "output");
    output->setExprType(ExprType::VOID);
    output->children[0] = intDummy;
    output->addSibling(outputb);

    buildSymbolTable(output);
}

void buildSymbolTable() 
{
    buildIORoutines();
    buildSymbolTable(syntaxTree);
    TokenTree *main = (TokenTree *) symbolTable->lookupGlobal("main");

    if (main == NULL || main->getDeclKind() != DeclKind::FuncK) {
        printf("ERROR(LINKER): A function named 'main' with no parameters must be defined.\n");
        numErrors++;
    }
}
