format ELF64 executable 3

segment readable executable

entry main

include 'io.inc'
include 'unistd64.inc'

main:
    lea  rdi, [prompt]
    call print
    lea  rsi, [buf]
    mov  rdi, 64                                  ; size of buffer
    call read
    mov  rdi, rsi                                 ; move address of buf to rdi
    call print
    xor  rdi, rdi                                 ; exit code 0
    mov  rax, sys_exit
    syscall

segment readable writable

prompt db 'Please type your name: ', 0
buf    rb 64
