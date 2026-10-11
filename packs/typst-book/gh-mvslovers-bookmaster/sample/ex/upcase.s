         COPY  PDPTOP
         CSECT
* Program text area
@@LC0    EQU   *
         DC    C'DD:SYSIN'
         DC    X'0'
@@LC1    EQU   *
         DC    C'r'
         DC    X'0'
@@LC2    EQU   *
         DC    C'DD:SYSPRINT'
         DC    X'0'
@@LC3    EQU   *
         DC    C'w'
         DC    X'0'
@@LC4    EQU   *
         DC    C'%ld records copied'
         DC    X'15'
         DC    X'0'
         DS    0F
         DC    C'GCCMVS!!'
         EXTRN @@CRT0
         ENTRY @@MAIN
@@MAIN   DS    0H
         BALR  15,0
         USING *,15
         L     15,=V(@@CRT0)
         BR    15
         DROP  15
         LTORG
* X-func main prologue
MAIN     PDPPRLG CINDEX=0,FRAME=192,BASER=12,ENTRY=YES
         B     @@FEN0
         LTORG
@@FEN0   EQU   *
         DROP  12
         BALR  12,0
         USING *,12
@@PG0    EQU   *
         LR    11,1
         L     10,=A(@@PGT0)
* Function main code
         MVC   88(4,13),=A(@@LC0)
         MVC   92(4,13),=A(@@LC1)
         LA    1,88(,13)
         L     15,=V(FOPEN)
         BALR  14,15
         LR    5,15
         MVC   88(4,13),=A(@@LC2)
         MVC   92(4,13),=A(@@LC3)
         LA    1,88(,13)
         L     15,=V(FOPEN)
         BALR  14,15
         LR    4,15
         SLR   6,6
         LTR   5,5
         BE    @@L3
         LA    7,104(,13)
         LTR   15,15
         BNE   @@L4
@@L3     EQU   *
         L     12,0(,10)
         LA    15,8(0,0)
         B     @@L1
@@L10    EQU   *
         LA    15,104(,13)
         IC    2,0(15)
         CLM   2,1,=XL1'00'
         BE    @@L12
         L     2,=V(@@TOUP)
         L     3,0(2)
@@L9     EQU   *
         SLR   2,2
         IC    2,0(15)
         AR    2,2
         IC    2,1(2,3)
         STC   2,0(15)
         A     15,=F'1'
         IC    2,0(15)
         CLM   2,1,=XL1'00'
         BNE   @@L9
@@L12    EQU   *
         L     12,0(,10)
         ST    7,88(13)
         ST    4,92(13)
         LA    1,88(,13)
         L     15,=V(FPUTS)
         BALR  14,15
         A     6,=F'1'
@@L4     EQU   *
         L     12,0(,10)
         ST    7,88(13)
         MVC   92(4,13),=F'81'
         ST    5,96(13)
         LA    1,88(,13)
         L     15,=V(FGETS)
         BALR  14,15
         LTR   15,15
         BNE   @@L10
         ST    4,88(13)
         MVC   92(4,13),=A(@@LC4)
         ST    6,96(13)
         LA    1,88(,13)
         L     15,=V(FPRINTF)
         BALR  14,15
         ST    5,88(13)
         LA    1,88(,13)
         L     15,=V(FCLOSE)
         BALR  14,15
         ST    4,88(13)
         LA    1,88(,13)
         L     15,=V(FCLOSE)
         BALR  14,15
         SLR   15,15
@@L1     EQU   *
         L     12,0(,10)
* Function main epilogue
         PDPEPIL
* Function main literal pool
         DS    0F
         LTORG
* Function main page table
         DS    0F
@@PGT0   EQU   *
         DC    A(@@PG0)
         END   @@MAIN
