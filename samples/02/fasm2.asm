format ELF64 executable 3

segment readable executable

entry main

main:
    lea   rdi, [msg]                              ; address of msg goes into rdi
    call  strlen
    mov   rdx, rax                                ; move rax to rdx
    mov   rsi, rdi                                ; move rdi to rsi
    mov   rdi, 1                                  ; stdout
    mov   rax, 1                                  ; sys_write
    syscall
    xor   rdi, rdi                                ; exit code 0
    mov   rax, 60                                 ; sys_exit
    syscall

strlen:
    push  rdi                                     ; push to stack
    push  rcx                                     ; push to stack
    sub   rcx, rcx                                ; set rcx to 0
    mov   rcx, -1                                 ; move -1 to rcx
    sub   al, al                                  ; set al to 0
    cld                                           ; clear the direction flags
    repne scasb                                   ; repeat if not equal to al
    neg   rcx                                     ; negate rcx
    sub   rcx, 1                                  ; subtract 1 from rcx
    mov   rax, rcx                                ; move value from rcx to rax
    pop   rcx                                     ; restore original rcx value
    pop   rdi                                     ; restore original rdi value
    ret

segment readable writable

msg  db 'Hello World!', 10, 0
