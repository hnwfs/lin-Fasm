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

print:
    call  strlen                                  ; get string length
    mov   rdx, rax                                ; move string length to rdx
    mov   rsi, rdi                                ; move address of string to rdi
    mov   rdi, 1                                  ; stdout
    mov   rax, sys_write
    syscall
    ret

read:
    mov   rdx, rdi                                ; size of buffer
    mov   rdi, 0                                  ; stdin
    mov   rax, sys_read
    syscall
    ret
