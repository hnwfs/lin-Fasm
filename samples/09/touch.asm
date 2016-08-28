format ELF64 executable 3

;syntax: touch [-c] file [file] ...
; -c = do not create files

entry start

segment readable executable

start:
    pop     rax
    pop     rax
    xor     rcx,rcx                               ; -c flag
    dec     rcx

    .next0:
        inc     rcx

    .next:
        pop     rax
        or      rax,rax
        jz      do_exit

    .continue:
        cmp     [rax], word 0x632d
        jz      .next0

    .create:
        mov     rdi,rax                           ; file path

        or      rcx,rcx
        jnz     .touchfile

        ;/usr/include/x86_64-linux-gnu/bits/fcntl-linux.h
        ;#define O_RDONLY             00
        ;#define O_WRONLY             01
        ;#define O_RDWR               02
        ;# define O_CREAT           0100

        ; create new file
        mov rdx, 0666o                            ; mode 666
        mov rsi, 0102                             ; O_RDWR|O_CREAT
        ;rdi = path
        mov     rax, 2                            ; open path, flags, mode
        syscall

    .touchfile:
        mov rsi, 0                                ; NULL
        ;rdi                                      ; path
        mov     rax, 235                          ; touch path NULL
        syscall

        jmp    .next

do_exit:
    mov     rax, 60                               ; exit
    syscall
