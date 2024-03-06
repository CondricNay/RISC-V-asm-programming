.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
text: .string "The dot product is: "
newline: .string "\n"

.text
main:
    # pass the first argument to a0
    # pass the second argument to a1
    # pass the third argument int size = 5
    la a0, a
    la a1, b
    addi a2, x0, 5
    jal dot_prod

    mv s0, a0   # by convention the return value is always in a0

    # print text
    addi a0, x0, 4
    la a1 text
    ecall

    # print answer
    addi a0, x0, 1
    mv a1, s0
    ecall

    # print newline
    li a0 4
    la a1 newline
    ecall

    # exit cleanly
    addi a0, x0, 10
    ecall

dot_prod:
    # base case
    # compare a1 with 1, if the two are equal you exit the dot_prod function
    addi t0, x0, 1
    beq a2, t0, exit_base_case      # branch if size == 1 to exit_base_case

    # recursive case
    addi sp sp -12
    sw a0 8(sp)  # storing a[i]
    sw a1 4(sp)  # storing b[i]
    sw ra, 0(sp) # storing the ra value on to the stack

    # change data
    addi a0 a0 4    # a[i] -> a[i+1]
    addi a1 a1 4    # b[i] -> b[i+1]
    addi a2 a2 -1   # size - 1
    jal dot_prod    # dot_prod(a+1, b+1, size-1)

    # load data on the stack
    lw t1 8(sp)  # loading a[i] (not a[i+1])
    lw t2 4(sp)  # loading b[i] (not b[i+1])
    lw ra 0(sp)  # Load ra

    lw t1 0(t1) # loading the value from a[i]
    lw t2 0(t2) # loading the value from b[i]

    # a[i] += a[i] * b[i]
    mul t1 t1 t2    
    add a0 a0 t1

    addi sp sp 12   # restore stack pointer
    jr ra

exit_base_case:
    # return result to a0
    lw t1 0(a0) # loading the value from a[0]
    lw t2 0(a1) # loading the value from b[0]
    mul a0 t1 t2 # a[0] * b[0]
    jr ra
