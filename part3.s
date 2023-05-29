.data
input_prompt: .asciiz "Enter a non-negative integer to calculate its factorial: "
result_prompt: .asciiz "Result for x = "
newline: .asciiz "\n"

.text
main:
    li $t0, 1        # initialize loop counter
    li $s0, 0        # initialize factorial result

input_loop:
    # Prompt user for input
    li $v0, 4        # print string
    la $a0, input_prompt
    syscall

    # Read integer input from user
    li $v0, 5        # read integer
    syscall
    move $a0, $v0    # move input value to argument register

    # Exit loop if input is negative
    bltz $a0, end_program

    # Call factorial calculation function
    jal calculate_factorial
    move $s0, $v0    # move factorial result to register s0

    # Print result
    li $v0, 4        # print string
    la $a0, result_prompt
    syscall
    li $v0, 1        # print integer
    move $a0, $s0    # move factorial result to argument register
    syscall

    # Print new line
    li $v0, 4        # print string
    la $a0, newline
    syscall

    j input_loop     # repeat loop

end_program:
    li $v0, 10       # exit program
    syscall          # call syscall to exit the program

# Recursive factorial calculation function
calculate_factorial:
    addi $sp, $sp, -8    # reserve space for return address and n
    sw $ra, 4($sp)       # save return address on the stack
    sw $a0, 0($sp)       # save n on the stack

    # Base case: return 1 if n < 1
    li $v0, 1
    blez $a0, end_factorial_calculation

    # Recursive case: call calculate_factorial with n - 1
    addi $a0, $a0, -1
    jal calculate_factorial

    # Multiply n by factorial(n - 1)
    lw $a0, 0($sp)
    mul $v0, $v0, $a0

end_factorial_calculation:
    lw $a0, 0($sp)       # load n from the stack
    lw $ra, 4($sp)       # load return address from the stack
    addi $sp, $sp, 8     # deallocate space for return address and n
    jr $ra               # return to caller