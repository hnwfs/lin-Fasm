format ELF64 executable 3

;syntax: ln [-s] target link_name
;
;example: ln -s ln.asm ln-source.asm

entry start

segment readable executable

start:
    pop     rbx                                   ; argc
    pop     rsi                                   ; argv[0]

    .n1:
        lodsb
        or      al,al
        jnz     .n1

        cmp     rbx, 0x3
        jb      .quit

        pop     rdi                               ; target or '-s'
        pop     rsi                               ; link_name

        cmp     word [rdi],"-s"
        jnz     .hardlink
        mov     rdi, rsi                          ; target
        pop     rsi                               ; if '-s' this is link_name

    .symlink:
        ;rsi                                      ; linkpath
        ;rdi                                      ; target
        mov     rax, 88                           ; symlink target, linkpath
        syscall

    .quit:
        xor     rdi, rdi
        mov     rax, 60                           ; exit
        syscall

    .hardlink:
        ;rsi                                      ; linkpath
        ;rdi                                      ; target
        mov     rax, 86                           ; link target, linkpath
        syscall

        jmp    .quit
