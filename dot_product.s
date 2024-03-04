.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
text: .string "The dot product is: "
newline: .string "\n"

.text
main:
    add x5, x0, x0  # int i = 0
    add x6, x0, x0  # int sop = 0
    addi, x7, x0, 5 # int size = 5
    
    la x8, a
    la x9, b

loop1:
    bge x5, x7, end_loop1
    slli x18, x5, 2     # set x18 to i * 4
    add x19, x18, x8    # add i * 4 to the base address of a and put it to x19
    add x20, x18, x9    # add i * 4 to the base address of a and put it to x20
    
    lw x21, 0(x19)      # load a[i] to x21
    lw x22, 0(x20)      # load b[i] to x22

    mul x22, x21, x22   # multiply a[i] with b[i]
    add x6, x6, x22     # sop += a[i] * b[i]
    addi x5 x5, 1        # i++
    j loop1

end_loop1:
    # print text
    addi a0, x0, 4
    la a1, text
    ecall

    # print sop
    addi a0, x0, 1
    add a1, x0, x6
    ecall

    # start new line
    addi a0, x0, 4
    la a1, newline
    ecall

    # exit cleanly
    addi a0, x0, 10
    ecall



