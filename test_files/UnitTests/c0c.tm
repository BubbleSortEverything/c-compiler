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
 40:    LDC  3,753(6)	Load of type int constant 
 41:     ST  3,-2(1)	Assigning variable x in Local 
 42:    LDC  3,444(6)	Load of type int constant 
 43:     ST  3,-3(1)	Assigning variable y in Local 
* CALL output
 44:     ST  1,-5(1)	Store fp in ghost frame for output 
 45:     LD  3,-3(1)	Load variable y into accumulator 
 46:     ST  3,-2(1)	Assigning variable x in Local 
 47:     ST  3,-4(1)	Assigning variable z in Local 
 48:     ST  3,-7(1)	Push parameter onto new frame 
* Begin call
 49:    LDA  1,-5(1)	Move the fp to the new frame 
 50:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
 51:    JMP  7,-46(7)	Call function 
 52:    LDA  3,0(2)	Save return result in accumulator 
* END CALL output
* CALL outnl
 53:     ST  1,-5(1)	Store fp in ghost frame for outnl 
* Begin call
 54:    LDA  1,-5(1)	Move the fp to the new frame 
 55:    LDA  3,1(7)	Store the return address in ac (skip 1 ahead) 
 56:    JMP  7,-23(7)	Call function 
 57:    LDA  3,0(2)	Save return result in accumulator 
* END CALL outnl
* END COMPOUND
* Add standard closing in case there is no return statement
 58:    LDC  2,0(6)	Set return value to 0 
 59:     LD  3,-1(1)	Load return address 
 60:     LD  1,0(1)	Adjust fp 
 61:    JMP  7,0(3)	Return 
* END FUNCTION main
* 
  0:    JMP  7,61(7)	Jump to init [backpatch] 
* INIT
 62:    LDA  1,0(0)	set first frame at end of globals 
 63:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
 64:    LDA  3,1(7)	Return address in ac 
 65:    JMP  7,-27(7)	Jump to main 
 66:   HALT  0,0,0	DONE! 
* END INIT