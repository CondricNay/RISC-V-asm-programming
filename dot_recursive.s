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
    lw a0, a
    lw a1, b
    addi a2, x0, 5
    jal dot_prod

    # print int
    mv a1, a0   # by convention the return value is always in a0
    addi a0, x0, 1
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
    addi sp, sp, -4
    sw ra, 0(sp) # storing the ra value on to the stack

    # dot_prod(a+1, b-1, size-1)
    addi sp, sp, -4
    sw a0, 0(sp)

    addi a1, a1, -1
    jal dot_prod

    # a[0]*b[0] + dot_product_recursive(a+1, b+1, size-1)
    mv t1, a0

    # restore the original "a" value before the call to dot_prod
    lw a0, 0(sp)
    addi sp, sp, 4
    add a0, a0, t1

    lw ra, 0(sp)
    addi sp, sp, 4
    jr ra

exit_base_case:
    jr ra