.data
A: .word 0
B: .word 0
C: .word 0
newline: .asciiz "\n"
prompt: .asciiz "Do you want to run again? (y/n) "
msg_A: .asciiz "Enter value for A: "
msg_B: .asciiz "Enter value for B: "
msg_result: .asciiz "Result: "

.text
main:
    # Prompt user to enter A and B values
    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, msg_A
    syscall

    li $v0, 5
    syscall
    sw $v0, A
    
    li $v0, 4
    la $a0, newline
    syscall
    
    li $v0, 4
    la $a0, msg_B
    syscall

    li $v0, 5
    syscall
    sw $v0, B
    
    # begin my pseudo-code implementation for addmem $rd, $rs, $rt
    lw $t0, A      # $t0 = Memory[$rs]
    lw $t1, B      # $t1 = Memory[$rt]
    add $t2, $t0, $t1  # $t2 = $t0 + $t1
    sw $t2, C      # Memory[$rd] = $t2
    # end of my pseudo-code
    
    # Display result on console screen
    li $v0, 4
    la $a0, msg_result
    syscall

    lw $a0, C
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, newline
    syscall
    
    # Ask user to rerun or not
    li $v0, 4
    la $a0, prompt
    syscall
    
    li $v0, 12
    syscall
    
    beq $v0, 121, main  # If user enters y, rerun program
    
    # Exit program if user enters n
    li $v0, 10
    syscall