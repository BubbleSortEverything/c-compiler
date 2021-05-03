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
 40:    LDC  3,0(6)	Load of type int constant 
 41:     ST  3,-2(1)	Assigning variable x in Local 
* BEGIN IF BLOCK
 42:    LDC  3,1(6)	Load of type bool constant 
* IF JUMP TO ELSE
* Beginning WHILE statement
 44:     LD  3,-2(1)	Load variable x into accumulator 
 45:     ST  3,-3(1)	Push left side onto temp variable stack 
 46:    LDC  3,10(6)	Load of type int constant 
 47:     LD  4,-3(1)	Pop left hand side into AC1 
 48:    TLT  3,4,3	Less than < operation store in AC 
* COMPOUND
* CALL output
 50:     ST  1,-3(1)	Store fp in ghost frame for output 
 51:     LD  3,-2(1)	Load variable x into accumulator 
 52:     ST  3,-5(1)	Push parameter onto new frame 
* Begin call
 53:    LDA  1,-3(1)	Move the fp to the new frame 
 54:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
 55:    JMP  7,-50(7)	Call function 
 56:    LDA  3,0(2)	Save return result in accumulator 
* END CALL output
 57:     LD  3,-2(1)	Load variable x into accumulator 
 58:     ST  3,-3(1)	Push left side onto temp variable stack 
 59:    LDC  3,1(6)	Load of type int constant 
 60:     LD  4,-3(1)	Pop left hand side into AC1 
 61:    ADD  3,4,3	+ Operation 
 62:     ST  3,-2(1)	Assigning variable x in Local 
* END COMPOUND
 63:    JMP  7,-20(7)	Go to L1 
 49:    JZR  3,14(7)	JMP if condition is false 
* End WHILE statement
* IF JUMP TO END
 43:    JZR  3,21(7)	IF JMP TO ELSE 
* CALL output
 65:     ST  1,-3(1)	Store fp in ghost frame for output 
 66:    LDC  3,666(6)	Load of type int constant 
 67:     ST  3,-5(1)	Push parameter onto new frame 
* Begin call
 68:    LDA  1,-3(1)	Move the fp to the new frame 
 69:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
 70:    JMP  7,-65(7)	Call function 
 71:    LDA  3,0(2)	Save return result in accumulator 
* END CALL output
 64:    LDA  7,7(7)	JUMP TO END 
* END IF
 72:    LDC  3,0(6)	Load of type int constant 
 73:     ST  3,-2(1)	Assigning variable x in Local 
* BEGIN IF BLOCK
 74:    LDC  3,0(6)	Load of type bool constant 
* IF JUMP TO ELSE
* Beginning WHILE statement
 76:     LD  3,-2(1)	Load variable x into accumulator 
 77:     ST  3,-3(1)	Push left side onto temp variable stack 
 78:    LDC  3,10(6)	Load of type int constant 
 79:     LD  4,-3(1)	Pop left hand side into AC1 
 80:    TLT  3,4,3	Less than < operation store in AC 
* COMPOUND
* CALL output
 82:     ST  1,-3(1)	Store fp in ghost frame for output 
 83:     LD  3,-2(1)	Load variable x into accumulator 
 84:     ST  3,-5(1)	Push parameter onto new frame 
* Begin call
 85:    LDA  1,-3(1)	Move the fp to the new frame 
 86:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
 87:    JMP  7,-82(7)	Call function 
 88:    LDA  3,0(2)	Save return result in accumulator 
* END CALL output
 89:     LD  3,-2(1)	Load variable x into accumulator 
 90:     ST  3,-3(1)	Push left side onto temp variable stack 
 91:    LDC  3,1(6)	Load of type int constant 
 92:     LD  4,-3(1)	Pop left hand side into AC1 
 93:    ADD  3,4,3	+ Operation 
 94:     ST  3,-2(1)	Assigning variable x in Local 
* END COMPOUND
 95:    JMP  7,-20(7)	Go to L1 
 81:    JZR  3,14(7)	JMP if condition is false 
* End WHILE statement
* IF JUMP TO END
 75:    JZR  3,21(7)	IF JMP TO ELSE 
* CALL output
 97:     ST  1,-3(1)	Store fp in ghost frame for output 
 98:    LDC  3,666(6)	Load of type int constant 
 99:     ST  3,-5(1)	Push parameter onto new frame 
* Begin call
100:    LDA  1,-3(1)	Move the fp to the new frame 
101:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
102:    JMP  7,-97(7)	Call function 
103:    LDA  3,0(2)	Save return result in accumulator 
* END CALL output
 96:    LDA  7,7(7)	JUMP TO END 
* END IF
* END COMPOUND
* Add standard closing in case there is no return statement
104:    LDC  2,0(6)	Set return value to 0 
105:     LD  3,-1(1)	Load return address 
106:     LD  1,0(1)	Adjust fp 
107:    JMP  7,0(3)	Return 
* END FUNCTION main
* 
  0:    JMP  7,107(7)	Jump to init [backpatch] 
* INIT
108:    LDA  1,0(0)	set first frame at end of globals 
109:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
110:    LDA  3,1(7)	Return address in ac 
111:    JMP  7,-73(7)	Jump to main 
112:   HALT  0,0,0	DONE! 
* END INIT