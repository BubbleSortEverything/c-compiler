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
* FUNCTION factorial
 39:     ST  3,-1(1)	Store return address 
* COMPOUND
* BEGIN IF BLOCK
 40:     LD  3,-2(1)	Load variable n into accumulator 
 41:     ST  3,-3(1)	Push left side onto temp variable stack 
 42:    LDC  3,2(6)	Load of type int constant 
 43:     LD  4,-3(1)	Pop left hand side into AC1 
 44:    TLT  3,4,3	Less than < operation store in AC 
* IF JUMP TO ELSE
 46:    LDC  3,1(6)	Load of type int constant 
 47:    LDA  2,0(3)	Copy accumulator to return register 
 48:     LD  3,-1(1)	Load return address 
 49:     LD  1,0(1)	Adjust fp 
 50:    JMP  7,0(3)	Return 
* IF JUMP TO END
 45:    JZR  3,6(7)	IF JMP TO ELSE 
 52:     LD  3,-2(1)	Load variable n into accumulator 
 53:     ST  3,-3(1)	Push left side onto temp variable stack 
* CALL factorial
 54:     ST  1,-4(1)	Store fp in ghost frame for factorial 
 55:     LD  3,-2(1)	Load variable n into accumulator 
 56:     ST  3,-7(1)	Push left side onto temp variable stack 
 57:    LDC  3,1(6)	Load of type int constant 
 58:     LD  4,-7(1)	Pop left hand side into AC1 
 59:    SUB  3,4,3	- Subtraction Operation 
 60:     ST  3,-6(1)	Push parameter onto new frame 
* Begin call
 61:    LDA  1,-4(1)	Move the fp to the new frame 
 62:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
 63:    JMP  7,-25(7)	Call function 
 64:    LDA  3,0(2)	Save return result in accumulator 
* END CALL factorial
 65:     LD  4,-3(1)	Pop left hand side into AC1 
 66:    MUL  3,4,3	* Multiplication Operation 
 67:    LDA  2,0(3)	Copy accumulator to return register 
 68:     LD  3,-1(1)	Load return address 
 69:     LD  1,0(1)	Adjust fp 
 70:    JMP  7,0(3)	Return 
 51:    LDA  7,19(7)	JUMP TO END 
* END IF
* END COMPOUND
* Add standard closing in case there is no return statement
 71:    LDC  2,0(6)	Set return value to 0 
 72:     LD  3,-1(1)	Load return address 
 73:     LD  1,0(1)	Adjust fp 
 74:    JMP  7,0(3)	Return 
* END FUNCTION factorial
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION main
 75:     ST  3,-1(1)	Store return address 
* COMPOUND
* CALL input
 76:     ST  1,-3(1)	Store fp in ghost frame for input 
* Begin call
 77:    LDA  1,-3(1)	Move the fp to the new frame 
 78:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
 79:    JMP  7,-79(7)	Call function 
 80:    LDA  3,0(2)	Save return result in accumulator 
* END CALL input
 81:     ST  3,-2(1)	Assigning variable n in Local 
* CALL factorial
 82:     ST  1,-3(1)	Store fp in ghost frame for factorial 
 83:     LD  3,-2(1)	Load variable n into accumulator 
 84:     ST  3,-5(1)	Push parameter onto new frame 
* Begin call
 85:    LDA  1,-3(1)	Move the fp to the new frame 
 86:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
 87:    JMP  7,-49(7)	Call function 
 88:    LDA  3,0(2)	Save return result in accumulator 
* END CALL factorial
 89:     ST  3,-2(1)	Assigning variable n in Local 
* CALL output
 90:     ST  1,-3(1)	Store fp in ghost frame for output 
 91:     LD  3,-2(1)	Load variable n into accumulator 
 92:     ST  3,-5(1)	Push parameter onto new frame 
* Begin call
 93:    LDA  1,-3(1)	Move the fp to the new frame 
 94:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
 95:    JMP  7,-90(7)	Call function 
 96:    LDA  3,0(2)	Save return result in accumulator 
* END CALL output
* CALL outnl
 97:     ST  1,-3(1)	Store fp in ghost frame for outnl 
* Begin call
 98:    LDA  1,-3(1)	Move the fp to the new frame 
 99:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
100:    JMP  7,-67(7)	Call function 
101:    LDA  3,0(2)	Save return result in accumulator 
* END CALL outnl
* END COMPOUND
* Add standard closing in case there is no return statement
102:    LDC  2,0(6)	Set return value to 0 
103:     LD  3,-1(1)	Load return address 
104:     LD  1,0(1)	Adjust fp 
105:    JMP  7,0(3)	Return 
* END FUNCTION main
* 
  0:    JMP  7,105(7)	Jump to init [backpatch] 
* INIT
106:    LDA  1,0(0)	set first frame at end of globals 
107:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
108:    LDA  3,1(7)	Return address in ac 
109:    JMP  7,-35(7)	Jump to main 
110:   HALT  0,0,0	DONE! 
* END INIT