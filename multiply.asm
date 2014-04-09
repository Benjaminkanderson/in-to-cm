.ORIG x3000
START

AND R1, R1, #0;clear out R1
LD R4, STACK;use R4 as the stack
AND R5, R5, #0;use R5 as counter
LEA R0, MESSAGE
PUTS


INPUT
GETC
OUT
;test if enter or continue
ADD R2, R0, #-10;
BRz SETUP_INPUT_DONE
LD R3, NFORTYEIGHT
ADD R2, R0, R3
STR R2, R4, #0;store on stack
ADD R4, R4, #1;increment pointer to stack
ADD R5, R5, #1;increment counter

BRnzp INPUT

SETUP_INPUT_DONE
AND R0, R0, #0;clear R0
AND R6, R6, #0;clear register 6 for use in second input loop (put added numbers into here)
ADD R6, R6, #1
INPUT_DONE
;read from stack by number of pointer
ADD R4, R4, #-1;decrement stack pointer
LDR R1, R4, #0;grab next number into R1
ADD R5, R5, #-1;decrement counter


ADD R2, R6, #0
JSR MUL
ADD R0, R0, R3


;increment place multiplier
ADD R1, R6, #0
LD R2, TEN
JSR MUL
ADD R6, R3, #0


ADD R5, R5, #0;check if counter is to zero
BRp INPUT_DONE
;start conversion of number in R1
;multiply R1 by 254
ADD R1, R0, #0;load in result found earlier
LD R2, TFFOUR
JSR MUL
ADD R1, R3, #0;store result in R1
;divide result by 100
LD R2, HUNDRED
JSR DIV
;write answer to console

;write whole part of number
ADD R1, R3, #0
LEA R5, STACK;load location of stack for WRITER call
JSR WRITER

;write decimal
LD R0, DECIMAL
OUT
;write decimal part of number
ADD R1, R4, #0
LEA R5, STACK;load location of stack for WRITER call
JSR WRITER


;write breakline at end of program before restarting
LD R0, LINEBREAK
OUT

BRnzp START
TFFOUR .FILL #254
HUNDRED .FILL #100
DECIMAL .FILL #46
NFORTYEIGHT .FILL #-48
LINEBREAK .FILL #10





MUL ST R2, STORE1;store information to be restored
AND R3, R3, #0; CLEAR RESULT
ADDING
ADD R3, R3, R1
ADD R2, R2, #-1
ADD R2, R2, #0
BRp ADDING
LD R2, STORE1;
RET
STORE0 .FILL x0000
STORE1 .FILL x0000
STORE2 .FILL x0000
STORE3 .FILL x0000
STORE4 .FILL x0000
STORE5 .FILL x0000
STORE6 .FILL x0000

;DIVISION WILL DIVIDE R1 WITH R2 AND STORE IN R3(ANSWER) AND R4(REMAINDER) - R1/R2
DIV ST R1, STORE1;SAVE ENTERED NUMBERS
ST R2, STORE2
ST R5, STORE5

;CLEAR RESULT AREAS
AND R3, R3, #0
AND R4, R4, #0

NOT R5, R2
ADD R5, R5, #1;make R5 the negative of R2

;SUBTRACT R2 FROM R1 UNTIL NEGATIVE OR ZERO
DIVLOOP
ADD R3, R3, #1;increase counter
ADD R1, R5, R1;subtract a time

BRp DIVLOOP;continue subtracting
BRn NEGATIVE;store zero
BRz ZERO;store positive
NEGATIVE
ADD R4, R2, R1;add original number and store that as remainder 
ADD R3, R3, #-1;subtract 1 to make result correct

BRnzp END
ZERO
AND R4, R4, #0

END
LD R1, STORE1;load the registers back
LD R2, STORE2
LD R5, STORE5
RET

;writes the value stored in register 1 to the monitor; R5 must have location of stack when called
WRITER


STR R1, R5, #0;move return point to stack
ADD R5, R5, #1;increment stack

STR R3, R5, #0;move return point to stack
ADD R5, R5, #1;increment stack

STR R4, R5, #0;move return point to stack
ADD R5, R5, #1;increment stack

STR R7, R5, #0;move return point to stack
ADD R5, R5, #1;increment stack

LD R2, TEN;divide by ten
JSR DIV
ADD R1, R3, #0;load into R1

ADD R1, R1, #0;check if number is zero
BRz FINISH

JSR WRITER;call routine again

FINISH

ADD R0, R4, #0
LD R4, FEIGHT;load ascii conversion
ADD R0, R0, R4;change to ascii

TRAP x21


ADD R5, R5, #-1;decrement stack
LDR R7, R5, #0;load return point from stack


ADD R5, R5, #-1;decrement stack
LDR R4, R5, #0;load return point from stack


ADD R5, R5, #-1;decrement stack
LDR R3, R5, #0;load return point from stack


ADD R5, R5, #-1;decrement stack
LDR R1, R5, #0;load return point from stack
RET
TEN .FILL #10
FEIGHT .FILL #48
MESSAGE .STRINGZ "Please enter a number of centimeters to be conerted to inches\n"

STACK .FILL x4000
.END