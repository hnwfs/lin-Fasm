format ELF64 executable 3

;'false' utility is symlink to this executable

entry start

segment readable executable

start:
    pop     rsi
    pop     rsi
.n1:                                              ; how we are called?
    lodsb
    or      al,al
    jnz     .n1
    xor     rdi,rdi
    shr     byte [rsi-5],1                        ; last bit in CF
    rcl     rdi,1                                 ; CF into register

do_exit:
    mov     rax, 60                               ; exit
    syscall
