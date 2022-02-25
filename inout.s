.global main

formatstr: .asciz "%ld"
mynumberoutput: .asciz "The result is: %ld \n"
inputprompt: .asciz "Please enter a number: \n"

main: 
    movq    $0, %rax
    movq    $inputprompt, %rdi
    call    printf
    call    inout
    call    end

inout: 
    pushq   %rbp
    movq    %rsp, %rbp
    subq    $8, %rsp
    leaq    -8(%rbp), %rsi
    movq    $formatstr, %rdi
    movq    $0, %rax
    call    scanf
    incq    -8(%rbp)
    movq    $0, %rax
    movq    $mynumberoutput, %rdi
    movq    -8(%rbp), %rsi
    call    printf
    movq    %rbp, %rsp
    popq    %rbp
    ret
    
end:
    mov     $0, %rdi
    call    exit
