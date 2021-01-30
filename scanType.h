#ifndef _SCANTYPE_H_
#define _SCANTYPE_H_
// 
//  SCANNER TOKENDATA
// 
struct TokenData {
    int tokenclass;   // token class
    int linenum;      // line number where token found
    int idValue;      // location in array of values of variable
    int numValue;     // value of number if number
    int stringLen;    // string length
    char *tokenstr;   // literal string for token for use
    char *strValue;   // value of charconst and stringconst
};
#endif
