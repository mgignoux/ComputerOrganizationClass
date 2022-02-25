.global main

mystring: .asciz "Names: Madeleine Gignoux, Sonia Welinder \nStudent Numbers: 2695118, 2706057\nAssignment Name: hello\n"

main: 
    movq    $0, %rax
    movq    $mystring, %rdi
    call    printf

end:
    mov$0,  %rdi
    call    exit
