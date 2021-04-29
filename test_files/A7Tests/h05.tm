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
* FUNCTION cat
 39:     ST  3,-1(1)	Store return address 
* COMPOUND
* CALL output
 40:     ST  1,-3(1)	Store fp in ghost frame for output 
 41:     LD  3,-2(1)	Load base address of array x 
 42:    LDC  3,3(6)	Load of type int constant 
 43:     LD  5,-2(1)	Load base address of array x into AC2 
 44:    SUB  5,5,3	Compute offset for array 
 45:     LD  3,0(5)	Load array element x from AC into loc from AC2 
 46:     ST  3,-5(1)	Push parameter onto new frame 
* Begin call
 47:    LDA  1,-3(1)	Move the fp to the new frame 
 48:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
 49:    JMP  7,-44(7)	Call function 
 50:    LDA  3,0(2)	Save return result in accumulator 
* END CALL output
* CALL outnl
 51:     ST  1,-3(1)	Store fp in ghost frame for outnl 
* Begin call
 52:    LDA  1,-3(1)	Move the fp to the new frame 
 53:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
 54:    JMP  7,-21(7)	Call function 
 55:    LDA  3,0(2)	Save return result in accumulator 
* END CALL outnl
* BEGIN IF BLOCK
 56:     LD  3,-2(1)	Load base address of array x 
 57:    LDC  3,3(6)	Load of type int constant 
 58:     LD  5,-2(1)	Load base address of array x into AC2 
 59:    SUB  5,5,3	Compute offset for array 
 60:     LD  3,0(5)	Load array element x from AC into loc from AC2 
 61:     ST  3,-3(1)	Push left side onto temp variable stack 
 62:    LDC  3,0(6)	Load of type int constant 
 63:     LD  4,-3(1)	Pop left hand side into AC1 
 64:    TGT  3,4,3	Greather than > operation store in AC 
* IF JUMP TO ELSE
* COMPOUND
 66:     LD  3,-2(1)	Load base address of array x 
 67:    LDC  3,3(6)	Load of type int constant 
 68:     ST  3,-3(1)	Push array index onto temp stack 
 69:    LDC  3,1(6)	Load of type int constant 
 70:     LD  4,-3(1)	Pop array index into AC1 
 71:     LD  5,-2(1)	Load base address of array x into AC2 
 72:    SUB  5,5,4	Compute offset for array 
 73:     LD  4,0(5)	Load lhs variable 
 74:    SUB  3,4,3	-= operation 
 75:     ST  3,0(5)	Store variable x from AC into loc from AC2 
* CALL cat
 76:     ST  1,-3(1)	Store fp in ghost frame for cat 
 77:     LD  3,-2(1)	Load base address of array x 
 78:     ST  3,-5(1)	Push parameter onto new frame 
* Begin call
 79:    LDA  1,-3(1)	Move the fp to the new frame 
 80:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
 81:    JMP  7,-43(7)	Call function 
 82:    LDA  3,0(2)	Save return result in accumulator 
* END CALL cat
* END COMPOUND
* IF JUMP TO END
 65:    JZR  3,18(7)	IF JMP TO ELSE 
 83:    LDA  7,0(7)	JUMP TO END 
* END IF
 84:    LDA  2,0(3)	Copy accumulator to return register 
 85:     LD  3,-1(1)	Load return address 
 86:     LD  1,0(1)	Adjust fp 
 87:    JMP  7,0(3)	Return 
* END COMPOUND
* Add standard closing in case there is no return statement
 88:    LDC  2,0(6)	Set return value to 0 
 89:     LD  3,-1(1)	Load return address 
 90:     LD  1,0(1)	Adjust fp 
 91:    JMP  7,0(3)	Return 
* END FUNCTION cat
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION main
 92:     ST  3,-1(1)	Store return address 
* COMPOUND
 93:    LDA  3,-1(0)	Load base address of array x 
 94:    LDC  3,3(6)	Load of type int constant 
 95:     ST  3,-2(1)	Push array index onto temp stack 
 96:    LDC  3,12(6)	Load of type int constant 
 97:     LD  4,-2(1)	Pop array index into AC1 
 98:    LDA  5,-1(0)	Load base address of array x into AC2 
 99:    SUB  5,5,4	Compute offset for array 
100:     ST  3,0(5)	Store variable x from AC into loc from AC2 
* CALL cat
101:     ST  1,-2(1)	Store fp in ghost frame for cat 
102:    LDA  3,-1(0)	Load base address of array x 
103:     ST  3,-4(1)	Push parameter onto new frame 
* Begin call
104:    LDA  1,-2(1)	Move the fp to the new frame 
105:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
106:    JMP  7,-68(7)	Call function 
107:    LDA  3,0(2)	Save return result in accumulator 
* END CALL cat
* END COMPOUND
* Add standard closing in case there is no return statement
108:    LDC  2,0(6)	Set return value to 0 
109:     LD  3,-1(1)	Load return address 
110:     LD  1,0(1)	Adjust fp 
111:    JMP  7,0(3)	Return 
* END FUNCTION main
* 
  0:    JMP  7,111(7)	Jump to init [backpatch] 
* INIT
112:    LDA  1,-19(0)	set first frame at end of globals 
113:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
114:    LDC  3,18(6)	Load size of x into AC 
115:     ST  3,0(0)	Store size of x in data memory 
* END INIT GLOBALS AND STATICS
116:    LDA  3,1(7)	Return address in ac 
117:    JMP  7,-26(7)	Jump to main 
118:   HALT  0,0,0	DONE! 
* END INIT
