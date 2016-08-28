format ELF64 executable 3

;ssize_t readlink(const char *path, char *buf, size_t bufsiz);
NR_readlink = 89

;ssize_t write(int fd, const void *buf, size_t count);
NR_write = 1

entry start

segment readable executable

start:
    pop   rbp
    pop   rax                                     ; Program name

    .next:
        dec     rbp
        jz      do_exit
        mov     rdx, 1024                         ; readlink bufsiz
        mov     rsi, buf                          ; readlink buf
        pop     rdi                               ; readlink path
        mov     eax, NR_readlink                  ; readlink
        syscall                                   ; eax=ssize_t readlink
        test    rax, rax
        jc      .next

        mov     rdx, rax                          ; write count
        mov     [rdx + buf], byte 0xa
        inc     rdx
                                                  ; rsi=write buf
        mov     rdi, 1                            ; write fd, 1=STDOUT
        mov     eax, NR_write                     ; write
        syscall

        jmp     .next

do_exit:
    xor     rdi, rdi
    mov     eax, 60                               ; exit
    syscall

segment readable writeable

buf rb  1025
