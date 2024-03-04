# int a[5] = {1, 2, 3, 4, 5};
# int b[5] = {6, 7, 8, 9, 10};

# int main() {
#     int i, sop = 0;
    
#     for (i = 0; i < 5; i++) {
#         sop += a[i] * b[i];
#     }
    
#     printf("The dot product is: %d\n", sop);
#     return 0;
# }

.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10

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
    add x19, x18, x9    # add i * 4 to the base address of a and put it to x19
    
    lw x20, 0(x19)      # load a[i] to x21
    lw x21, 0(x19)      # load b[i] to x22

    mul x21, x20, x21   # multiply a[i] with b[i]
    add x6, x6, x21     # sop += a[i] * b[i]
    addi x8 x8, 1        # i++
    j loop1

end_loop1:
    # print_int
    addi a0, x0, 1
    add a1, x0, x6
    ecall

    # exit cleanly
    addi a0, x0, 10
    ecall
