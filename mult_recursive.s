.text
main:
    # pass the first argument to a0
    # pass the second argument
    addi a0, x0, 110
    addi a1, x0, 50
    jal mult
    
    # exit cleanly

mult:
    # base case
    # compaare a1 with 1 and with 1, if the two are equal you exit the mult function
    
    # recursive case
    addi sp, sp, -4
    sw ra, 0(sp) # storeing the value on to the stack
    
    
    # a + mult(a, b-1)

    #save a0 and a1 on to the stack
    
    #pass the first argument to a0
    # pass the second argument to a1

    jal mult
    
    # by convention the result is in a0
    # restrore a0 and a1 on to the stack
    
    # exit from the recursive case
    add a0, a0, t0 # where t0 is result from mult(a, b-1)
exit_base_case:
    jr ra