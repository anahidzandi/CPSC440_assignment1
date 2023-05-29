.data
x1: .word 3 # x = 3
x2: .word 2023 # x = 2023
result1: .word 0 # store result for x = 3
result2: .word 0 # store result for x = 2023

.text
.globl main
main:
    # evaluate f(x) for x = 3
    lw $t0, x1 # load x
    li $t1, 6 # load 6
    mul $t2, $t0, $t0 # x^2
    mul $t2, $t2, $t1 # 6x^2
    li $t1, 5 # load 5
    mul $t3, $t0, $t1 # 5x
    sub $t2, $t2, $t3 # 6x^2 - 5x
    li $t1, -21 # load -21
    add $t2, $t2, $t1 # 6x^2 - 5x - 21
    sw $t2, result1 # store result for x = 3 in result1
    move $t5, $t2  # store result for x = 3 in $t5

    # evaluate f(x) for x = 2023
    lw $t4, x2    # load x
    li $t1, 6       # load 6
    mul $t2, $t4, $t4   # x^2
    mul $t2, $t2, $t1   # 6x^2
    li $t1, 5       # load 5
    mul $t3, $t4, $t1   # 5x
    sub $t2, $t2, $t3   # 6x^2 - 5x
    li $t1, -21     # load -21
    add $t2, $t2, $t1   # 6x^2 - 5x - 21
    sw $t2, result2  # store result for x = 2023 in result2
    move $t6, $t2  # store result for x = 2023 in $t6

    # exit
    li $v0, 10
    syscall