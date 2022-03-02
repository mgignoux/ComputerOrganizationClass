.global main                    # makes the subroutine main visible

mystring: .asciz "Names: Madeleine Gignoux, Sonia Welinder \nStudent Numbers: 2695118, 2706057\nAssignment Name: hello\n" 
                                # declares mystring as an asciz string

main: 
    movq    $0, %rax            # first argument of printf, sets no vector registers for use in printf
    movq    $mystring, %rdi     # second argument of printf, sets the adress of ths string in RDI
    call    printf              # calls printf

end:
    mov     $0,  %rdi           # first argument of exit, sets the exit code to 0
    call    exit                # calls exit
