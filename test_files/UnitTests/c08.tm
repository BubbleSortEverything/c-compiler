* C- Generated Code
* Author: Oshan Karki
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION input
  1:     ST  3,-1(1)	Store return address 
  2:     IN  2,2,2	Grab int input 
  3:     LD  3,-1(1)	Load return address 
  4:     LD  1,0(1)	Adjust fp 
  5:    JMP  7,0(3)	Return 
* END FUNCTION input
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION output
  6:     ST  3,-1(1)	Store return address 
  7:     LD  3,-2(1)	Load parameter 
  8:    OUT  3,3,3	Output integer 
  9:     LD  3,-1(1)	Load return address 
 10:     LD  1,0(1)	Adjust fp 
 11:    JMP  7,0(3)	Return 
* END FUNCTION output
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION inputb
 12:     ST  3,-1(1)	Store return address 
 13:    INB  2,2,2	Grab bool input 
 14:     LD  3,-1(1)	Load return address 
 15:     LD  1,0(1)	Adjust fp 
 16:    JMP  7,0(3)	Return 
* END FUNCTION inputb
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION outputb
 17:     ST  3,-1(1)	Store return address 
 18:     LD  3,-2(1)	Load parameter 
 19:   OUTB  3,3,3	Output bool 
 20:     LD  3,-1(1)	Load return address 
 21:     LD  1,0(1)	Adjust fp 
 22:    JMP  7,0(3)	Return 
* END FUNCTION outputb
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION inputc
 23:     ST  3,-1(1)	Store return address 
 24:    INC  2,2,2	Grab char input 
 25:     LD  3,-1(1)	Load return address 
 26:     LD  1,0(1)	Adjust fp 
 27:    JMP  7,0(3)	Return 
* END FUNCTION inputc
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION outputc
 28:     ST  3,-1(1)	Store return address 
 29:     LD  3,-2(1)	Load parameter 
 30:   OUTC  3,3,3	Output char 
 31:     LD  3,-1(1)	Load return address 
 32:     LD  1,0(1)	Adjust fp 
 33:    JMP  7,0(3)	Return 
* END FUNCTION outputc
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION outnl
 34:     ST  3,-1(1)	Store return address 
 35:  OUTNL  3,3,3	Output a newline 
 36:     LD  3,-1(1)	Load return address 
 37:     LD  1,0(1)	Adjust fp 
 38:    JMP  7,0(3)	Return 
* END FUNCTION outnl
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION main
 39:     ST  3,-1(1)	Store return address 
* COMPOUND
 40:    LDA  3,-1(0)	Load base address of array x 
 41:    LDC  3,2(6)	Load of type int constant 
 42:     ST  3,-2(1)	Push array index onto temp stack 
 43:    LDC  3,1(6)	Load of type bool constant 
 44:     LD  4,-2(1)	Pop array index into AC1 
 45:    LDA  5,-1(0)	Load base address of array x into AC2 
 46:    SUB  5,5,4	Compute offset for array 
 47:     ST  3,0(5)	Store variable x from AC into loc from AC2 
 48:    LDA  3,-5(0)	Load base address of array y 
 49:    LDC  3,1(6)	Load of type int constant 
 50:     ST  3,-2(1)	Push array index onto temp stack 
 51:    LDC  3,0(6)	Load of type bool constant 
 52:     LD  4,-2(1)	Pop array index into AC1 
 53:    LDA  5,-5(0)	Load base address of array y into AC2 
 54:    SUB  5,5,4	Compute offset for array 
 55:     ST  3,0(5)	Store variable y from AC into loc from AC2 
* CALL outputb
 56:     ST  1,-2(1)	Store fp in ghost frame for outputb 
 57:    LDA  3,-1(0)	Load base address of array x 
 58:    LDC  3,2(6)	Load of type int constant 
 59:    LDA  5,-1(0)	Load base address of array x into AC2 
 60:    SUB  5,5,3	Compute offset for array 
 61:     LD  3,0(5)	Load array element x from AC into loc from AC2 
 62:     ST  3,-5(1)	Push left side onto temp variable stack 
 63:    LDA  3,-5(0)	Load base address of array y 
 64:    LDC  3,1(6)	Load of type int constant 
 65:    LDA  5,-5(0)	Load base address of array y into AC2 
 66:    SUB  5,5,3	Compute offset for array 
 67:     LD  3,0(5)	Load array element y from AC into loc from AC2 
 68:     LD  4,-5(1)	Pop left hand side into AC1 
 69:     OR  3,4,3	OR operation store in AC 
 70:     ST  3,-4(1)	Push parameter onto new frame 
* Begin call
 71:    LDA  1,-2(1)	Move the fp to the new frame 
 72:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
 73:    JMP  7,-57(7)	Call function 
 74:    LDA  3,0(2)	Save return result in accumulator 
* END CALL outputb
* CALL outnl
 75:     ST  1,-2(1)	Store fp in ghost frame for outnl 
* Begin call
 76:    LDA  1,-2(1)	Move the fp to the new frame 
 77:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
 78:    JMP  7,-45(7)	Call function 
 79:    LDA  3,0(2)	Save return result in accumulator 
* END CALL outnl
* END COMPOUND
* Add standard closing in case there is no return statement
 80:    LDC  2,0(6)	Set return value to 0 
 81:     LD  3,-1(1)	Load return address 
 82:     LD  1,0(1)	Adjust fp 
 83:    JMP  7,0(3)	Return 
* END FUNCTION main
* 
  0:    JMP  7,83(7)	Jump to init [backpatch] 
* INIT
 84:    LDA  1,-9(0)	set first frame at end of globals 
 85:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
 86:    LDC  3,3(6)	Load size of x into AC 
 87:     ST  3,0(0)	Store size of x in data memory 
 88:    LDC  3,4(6)	Load size of y into AC 
 89:     ST  3,-4(0)	Store size of y in data memory 
* END INIT GLOBALS AND STATICS
 90:    LDA  3,1(7)	Return address in ac 
 91:    JMP  7,-53(7)	Jump to main 
 92:   HALT  0,0,0	DONE! 
* END INIT