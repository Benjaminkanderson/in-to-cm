	.ORIG	x3000

	LEA	R0, INSTR
	STI	R0, TRAP60

	LEA	R0, PROMPTF
	PUTS
	LEA	R0, FNAME
	TRAP	x60

	LEA	R0, PROMPTL
	PUTS
	LEA	R0, LNAME
	TRAP	x60

	LEA	R0, WELCOME
	PUTS
	LEA	R0, FNAME
	PUTS
	LEA	R0, SPACE
	PUTS
	LEA	R0, LNAME
	PUTS
	LEA	R0, ENDSTR
	PUTS

	HALT

TRAP60	.FILL	x0060

FNAME	.BLKW	#20
LNAME	.BLKW	#80
PROMPTF	.STRINGZ	"Please enter your name:"
PROMPTL	.STRINGZ	"Please enter your last name:"
WELCOME	.STRINGZ	"Welcome to the LC-3 Simulator "
ENDSTR	.STRINGZ	". Enjoy your stay!"
SPACE	.STRINGZ	" "

INSTR	ST	R7, INSTR7
	ST	R0, INSTR0
	ST	R1, INSTR1
	ST	R2, INSTR2

	ADD	R1, R0, #0
	
INSLOOP GETC
	OUT
	ADD	R2, R0, #-10
	BRz	INSDONE
	STR	R0, R1, #0
	ADD	R1, R1, #1
	BRnzp	INSLOOP

INSDONE	STR	R2, R1, #0
	
	LD	R1, INSTR2
	LD	R2, INSTR2
	LD	R7, INSTR7
	RET

INSTR0	.FILL	#0
INSTR1	.FILL	#0
INSTR2	.FILL	#0
INSTR7	.FILL	#0

	.END