format ELF64 executable 3

segment readable executable

entry main

include 'io.inc'

main:
    lea  rdi, [msg]                               ; address of msg goes into rdi
    call print
    lea  rdi, [msg2]                              ; address of msg2 goes into rdi
    call print
    xor  rdi, rdi                                 ; exit code 0
    mov  rax, 60                                  ; sys_exit
    syscall

segment readable writable

msg  db 'Hello World!', 10, 0
msg2 db 'This is my other string.', 10, 0
