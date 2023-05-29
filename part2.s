.data
inputPrompt: .asciiz "Enter a value for x (0 to exit): "
resultPrompt: .asciiz "Result for x = "
resultSuffix: .asciiz "\n"
x: .word 0 # variable to store user input
result: .word 0 # variable to store result

.text
.globl main

# Procedure to calculate f(x) = (6x-5)x-21
# $a0 - input value of x
# $v0 - output value of f(x)
calculateFx:
    addi $sp, $sp, -4 # allocate space on the stack
    sw $ra, 0($sp) # save return address

    mul $t0, $a0, 6 # 6x
    sub $t0, $t0, 5 # 6x-5
    mul $v0, $t0, $a0 # (6x-5)x
    sub $v0, $v0, 21 # (6x-5)x - 21

    lw $ra, 0($sp) # restore return address
    addi $sp, $sp, 4 # deallocate space on the stack
    jr $ra # return to caller

main:
    li $t1, 0 # set x to 0 initially to start the loop

    loop:
        # Prompt user for input
        li $v0, 4 # system call for print string
        la $a0, inputPrompt # load input prompt string
        syscall 

        # Read user input
        li $v0, 5 # system call for read integer
        syscall
        move $t1, $v0 # store user input in $t1

        # Check if input is 0, exit if true
        beq $t1, $zero, exit

        # Call calculateFx procedure with x in $t1
        addi $a0, $t1, 0 # move x to $a0
        jal calculateFx # jump to calculateFx procedure

        # Store result in memory and print it
        sw $v0, result # store result in memory
        li $v0, 4 # system call for print string
        la $a0, resultPrompt # load result prompt string
        syscall
        lw $a0, result # load result into $a0
        li $v0, 1 # system call for print integer
        syscall
        la $a0, resultSuffix # load result suffix string
        li $v0, 4 # system call for print string
        syscall
        j loop

    exit:
        # exit
        li $v0, 10
        syscall
