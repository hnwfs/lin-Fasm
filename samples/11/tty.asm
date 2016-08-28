format ELF64 executable 3

BUFSIZE = 0x1000

entry start

segment readable executable

start:
    mov     rdx, BUFSIZE
    mov     rsi, buf
    mov     rdi, fd0
    mov     rax, 89                               ; readlink fd0, buf, BUFSIZE
    syscall
    test    rax,rax
    js      do_exit

    mov     rdx,rax
    
    .next:
        ;; load byte from rsi to al and inc rsi
        lodsb
        or    al,al
        jnz     .next
        mov     [rsi-1], byte 0xa

        ;sys_write STDOUT
        inc     rdx
        mov     rsi, buf
        mov     rdi, 1                                ; stdout
        mov     eax, 1
        syscall                                       ; write fd=1, buf, len

do_exit:
    xor         rdi, rdi
    mov     rax, 60                               ; exit
    syscall

segment readable

fd0     db      "/proc/self/fd/0"                 ; ,EOL

segment readable writable

buf     rb      BUFSIZE
