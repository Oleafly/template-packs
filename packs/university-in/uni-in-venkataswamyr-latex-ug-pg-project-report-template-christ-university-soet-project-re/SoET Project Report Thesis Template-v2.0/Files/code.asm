; Addition of two 8 bit numbers
ORG 0000H	; Starting address of the program
MOV R1,#10H	; First number
MOV R2,#20H	; Second number
MOV A,R1	; Input first number from R1 to A
MOV B,R2	; Input second number from R2 to B
ADD A,B		; Add A and B
MOV R3,A	; Store the result in R3
RET
