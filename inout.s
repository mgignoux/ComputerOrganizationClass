.global main                                    # makes the subroutine main visible

formatstr: .asciz "%ld"                         # formats the output number as .asciz
mynumberoutput: .asciz "The result is: %ld \n"  # formats the result
inputprompt: .asciz "Please enter a number: \n" # formats the input prompt

main: 
    movq    $0, %rax                            # first argument of printf, sets no vector registers for use in printf                     
    movq    $inputprompt, %rdi                  # second argument of printf, sets the adress of ths string in RDI
    call    printf                              # calls printf
    call    inout                               # calls the subroutine inout
    call    end                                 # calls the end subroutine when all other computations are done

inout: 
    pushq   %rbp                                # pushes the base pointer over
    movq    %rsp, %rbp                          # moves the RSP to the base pointer
    subq    $8, %rsp                            # reserves stack space for the variable
    leaq    -8(%rbp), %rsi                      # loads the value of the stack adress in RSI (ask ta)
    movq    $formatstr, %rdi                    # loads the value of formatstr for the result of the scan
    movq    $0, %rax                            # sets no vector registers for use
    call    scanf                               # calls scanf
    incq    -8(%rbp)                            # ask ta why we do this
    movq    $0, %rax                            # first argument of prinft, sets no vector registers for use
    movq    $mynumberoutput, %rdi               # second argument of printf, loads the value mynumberoutput into rdi
    movq    -8(%rbp), %rsi                      # third argument of printf, sets the adress of the string (down 8 from the base pointer) in RSI
    call    printf                              # calls printf
    movq    %rbp, %rsp                          # moves the base pointer to RSP in preparation for exiting the function
    popq    %rbp                                # pops the base pointer back
    ret                                         # returns out of the subroutine
    
end:
    mov     $0, %rdi                            # sets the exit code in rdi
    call    exit                                # calls exit
