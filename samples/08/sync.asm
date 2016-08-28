format ELF64 executable 3
entry start

segment readable executable

start:
    mov	rax, 162                                  ; sync
    syscall

    xor     rdi, rdi
    mov     rax, 60                               ; exit
    syscall

segment readable writeable

