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
* FUNCTION dog
 39:     ST  3,-1(1)	Store return address 
 40:     LD  3,-2(1)	Load variable x into accumulator 
 41:     ST  3,-4(1)	Push left side onto temp variable stack 
 42:     LD  3,-3(1)	Load variable y into accumulator 
 43:     LD  4,-4(1)	Pop left hand side into AC1 
 44:    MUL  3,4,3	* Multiplication Operation 
 45:    LDA  2,0(3)	Copy accumulator to return register 
 46:     LD  3,-1(1)	Load return address 
 47:     LD  1,0(1)	Adjust fp 
 48:    JMP  7,0(3)	Return 
* Add standard closing in case there is no return statement
 49:    LDC  2,0(6)	Set return value to 0 
 50:     LD  3,-1(1)	Load return address 
 51:     LD  1,0(1)	Adjust fp 
 52:    JMP  7,0(3)	Return 
* END FUNCTION dog
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION main
 53:     ST  3,-1(1)	Store return address 
* COMPOUND
* CALL output
 54:     ST  1,-5(1)	Store fp in ghost frame for output 
* CALL dog
 55:     ST  1,-8(1)	Store fp in ghost frame for dog 
 56:    LDC  3,111(6)	Load of type int constant 
 57:     ST  3,-10(1)	Push parameter onto new frame 
 58:    LDC  3,222(6)	Load of type int constant 
 59:     ST  3,-11(1)	Push parameter onto new frame 
* Begin call
 60:    LDA  1,-8(1)	Move the fp to the new frame 
 61:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
 62:    JMP  7,-24(7)	Call function 
 63:    LDA  3,0(2)	Save return result in accumulator 
* END CALL dog
 64:     ST  3,-7(1)	Push parameter onto new frame 
* Begin call
 65:    LDA  1,-5(1)	Move the fp to the new frame 
 66:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
 67:    JMP  7,-62(7)	Call function 
 68:    LDA  3,0(2)	Save return result in accumulator 
* END CALL output
* COMPOUND
 69:    LDC  3,333(6)	Load of type int constant 
 70:     ST  3,-2(1)	Assigning variable x in Local 
 71:    LDC  3,444(6)	Load of type int constant 
 72:     ST  3,-3(1)	Assigning variable y in Local 
 73:    LDC  3,555(6)	Load of type int constant 
 74:     ST  3,-4(1)	Assigning variable z in Local 
* CALL output
 75:     ST  1,-5(1)	Store fp in ghost frame for output 
* CALL dog
 76:     ST  1,-8(1)	Store fp in ghost frame for dog 
 77:     LD  3,-2(1)	Load variable x into accumulator 
 78:     ST  3,-10(1)	Push parameter onto new frame 
 79:     LD  3,-3(1)	Load variable y into accumulator 
 80:     ST  3,-11(1)	Push parameter onto new frame 
* Begin call
 81:    LDA  1,-8(1)	Move the fp to the new frame 
 82:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
 83:    JMP  7,-45(7)	Call function 
 84:    LDA  3,0(2)	Save return result in accumulator 
* END CALL dog
 85:     ST  3,-7(1)	Push parameter onto new frame 
* Begin call
 86:    LDA  1,-5(1)	Move the fp to the new frame 
 87:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
 88:    JMP  7,-83(7)	Call function 
 89:    LDA  3,0(2)	Save return result in accumulator 
* END CALL output
* END COMPOUND
* CALL output
 90:     ST  1,-5(1)	Store fp in ghost frame for output 
* CALL dog
 91:     ST  1,-8(1)	Store fp in ghost frame for dog 
 92:    LDC  3,333(6)	Load of type int constant 
 93:     ST  3,-12(1)	Push left side onto temp variable stack 
 94:    LDC  3,33(6)	Load of type int constant 
 95:     LD  4,-12(1)	Pop left hand side into AC1 
 96:    ADD  3,4,3	+ Operation 
 97:     ST  3,-10(1)	Push parameter onto new frame 
 98:    LDC  3,444(6)	Load of type int constant 
 99:     ST  3,-12(1)	Push left side onto temp variable stack 
100:    LDC  3,44(6)	Load of type int constant 
101:     LD  4,-12(1)	Pop left hand side into AC1 
102:    MUL  3,4,3	* Multiplication Operation 
103:     ST  3,-11(1)	Push parameter onto new frame 
* Begin call
104:    LDA  1,-8(1)	Move the fp to the new frame 
105:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
106:    JMP  7,-68(7)	Call function 
107:    LDA  3,0(2)	Save return result in accumulator 
* END CALL dog
108:     ST  3,-7(1)	Push parameter onto new frame 
* Begin call
109:    LDA  1,-5(1)	Move the fp to the new frame 
110:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
111:    JMP  7,-106(7)	Call function 
112:    LDA  3,0(2)	Save return result in accumulator 
* END CALL output
* END COMPOUND
* Add standard closing in case there is no return statement
113:    LDC  2,0(6)	Set return value to 0 
114:     LD  3,-1(1)	Load return address 
115:     LD  1,0(1)	Adjust fp 
116:    JMP  7,0(3)	Return 
* END FUNCTION main
* 
  0:    JMP  7,116(7)	Jump to init [backpatch] 
* INIT
117:    LDA  1,-1(0)	set first frame at end of globals 
118:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
119:    LDA  3,1(7)	Return address in ac 
120:    JMP  7,-68(7)	Jump to main 
121:   HALT  0,0,0	DONE! 
* END INIT