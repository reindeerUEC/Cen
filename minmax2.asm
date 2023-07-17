.data
min: .asciiz " (min) "
max: .asciiz " (max) "
ln: .asciiz "\n"
inputcounter: .asciiz "inputcounter: "
maxinput: .asciiz "maxinput:"
mininput: .asciiz "mininput:"
.text
.globl main

#----------------------
# $s0: inputCounter
# $s1: maxinput
# $s2: mininput
# $s3: input[0]'s address #必要ないかもしれない
#
# $t0: dinamic address
# $t1: load word
#-----------------------


main:
    move $s0, $zero
    move $s3, $sp
scan_loop:
    li $v0, 5 # int m;
    syscall # scanf("%d", &m);
    beq $v0, $zero, scan_loop_exit
    addi $s0, $s0, 1
    add $sp, $sp, -4 # スタックに1ワードの領域を確保
    sw $v0, 0($sp) # $s0を退避
    j scan_loop
    jr $ra
scan_loop_exit:

    move $sp, $s3
    add $sp, $sp, -4

    lw $t1, 0($sp)
    move $s1, $t1 #  int max = A[N];
    move $s2, $t1 # int min = A[N];

minmax_loop:

    la $a0, max
    li $v0, 4
    syscall # print("max");
    move $a0, $s1
    li $v0, 1
    syscall # print($s1);
    la $a0, ln
    li $v0, 4
    syscall # printf("\n");

    la $a0, min
    li $v0, 4
    syscall # print("min");
    move $a0, $s2
    li $v0, 1
    syscall # print($s2);
    la $a0, ln
    li $v0, 4
    syscall # printf("\n");

    lw $t1, 0($sp)
    beq $t1, $zero, minmax_loop_exit
    add $sp, $sp, -4


    bge $t1, $s1, bigger
loop_end:
    ble $t1, $s2, lesser
    j minmax_loop

bigger:
    move $s1, $t1
    j loop_end

lesser: 
    move $s2, $t1
    j minmax_loop
minmax_loop_exit:


#---------------
# デバック用の場所
#----------------
    la $a0, inputcounter
    li $v0, 4
    syscall # print("counttime");
    move $a0, $s0
    li $v0, 1
    syscall # print($s0);
    la $a0, ln
    li $v0, 4
    syscall # printf("\n");

    la $a0, max
    li $v0, 4
    syscall # print("max");
    move $a0, $s1
    li $v0, 1
    syscall # print($s1);
    la $a0, ln
    li $v0, 4
    syscall # printf("\n");

    la $a0, min
    li $v0, 4
    syscall # print("min");
    move $a0, $s2
    li $v0, 1
    syscall # print($s2);
    la $a0, ln
    li $v0, 4
    syscall # printf("\n");
    jr $ra

