# ************************************************************************
# * Program name : sieve                                                 *
# * Description  : this program prints all the prime numbers below 1000  *
# ************************************************************************
.bss
NUMBERS:    .skip 1000          # memory space for the number table
.text
formatstr:  .asciz "%d\n"       # format string for number printing
.global main
# ************************************************************************
# * Subroutine  : main                                                   *
# * Description : application entry point                                *
# ************************************************************************
main:
pushq   %rbp                # store the caller's base pointer
movq    %rsp, %rbp          # initialize the base pointer
# Initialize the number table:
movq    $0, %rbx            # initialize 'i' to 0.
loop1:
movb    $1, NUMBERS(%rbx)   # set number table entry 'i' to 'true'
incq    %rbx                # increment 'i'                      
cmpq    $1000, %rbx         # while 'i' < 1000                   
jl      loop1               # go to start of loop1               
# The sieve algorithm:
pushq   $2                  # initialize 'number' to 2 on stack       
loop2:
movq    -8(%rbp), %rbx      # load 'number' into a register
cmpb    $1, NUMBERS(%rbx)   # compare NUMBERS[number] to '1'
jne     lp2end              # if not equal, jump to end of loop 2
movq    $formatstr, %rdi    # first argument: formatstr
movq    %rbx, %rsi          # second argument: the number
movq $0, %rax            # no vector arguments
call    printf              # print the number
movq    -8(%rbp), %rbx      # 'multiple' := 'number'
shlq    $1, %rbx            # multiply 'multiple' by 2
loop3:
cmpq     $1000, %rbx        # compare 'multiple' to 1000
jge     lp2end              # goto end of loop2 if greater/equal
movb    $0, NUMBERS(%rbx)   # set number table entry to 'false'
addq    -8(%rbp), %rbx      # add another 'number' to 'multiple'
jmp     loop3               # jump to the beginning of loop 3
lp2end:
movq    -8(%rbp), %rbx      # load 'number' into a register
incq    %rbx                # increment 'number' by one
movq    %rbx, -8(%rbp)      # store 'number' on the stack
cmpq    $1000, %rbx         # compare 'number' to 1000
jl      loop2               # if smaller, repeat loop2
end:
mov     $0, %rdi            # load program exit code
call    exit                # exit the program
