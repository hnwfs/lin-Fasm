format ELF64 executable 3
entry start

segment readable executable

start:
    pop     rbp

    .env:
        inc     rbp
        mov     rsi, [rsp + rbp * 8]
        test    rsi, rsi
        jz      do_exit
        mov     rcx, rsi                          ; save RSI
        xor     rdx, rdx
        dec     rdx

    .slen:
        inc     rdx
        lodsb
        test    al, al
        jnz     .slen
        mov     [rsi-1], byte 0xa                 ; replace last character
                                                  ; with newline 0x0 => 0xa
        inc     rdx                               ; count
        mov     rsi, rcx                          ; restore RSI, buffer
        mov     rdi, 1                            ; fd, 1=STDOUT
        mov     rax, 1                            ; write
        syscall
        jmp     .env

do_exit:
    xor     rdi, rdi
    mov     rax, 60                               ; exit
    syscall

segment readable writeable
