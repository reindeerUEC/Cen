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
# $t0: general loop counter
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

    add $sp, $sp, 4
    lw $t1, 0($sp)
    move $s1, $t1 #  int max = A[N];
    move $s2, $t1 # int min = A[N];
    add $sp, $sp, -4

    move $t0, $s0
minmax_loop:
    beq $t0, $zero, minmax_loop_exit
    lw $t1, 0($sp)
    add $sp, $sp, 4
    bge $t1, $s1, bigger
    ble $t1, $s2, lesser
both_end:
    addi $t0, $t0, -1
    j minmax_loop

bigger:
    move $s1, $t1
    j both_end

lesser: 
    move $s2, $t1
    j both_end
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

