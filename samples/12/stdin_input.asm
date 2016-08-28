format ELF executable 3
entry start

segment readable executable

start:
    mov     eax,4                                 ; System call 'write'
    mov     ebx,1                                 ; 'stdout'
    mov     ecx,message                           ; Address of message
    mov     edx,message_length                    ; Length  of message
    int     0x80                                  ; All system calls are done via this interrupt

    mov     eax,3                                 ; System call 'read'
    mov     ebx,0                                 ; 'stdin'
    mov     ecx,input                             ; address to save input to
    mov     edx,input_length                      ; 1
    int     0x80

    mov     eax,4                                 ; System call 'write'
    mov     ebx,1                                 ; 'stdout'
    mov     ecx,response                          ; Address of message
    mov     edx,response_length                   ; Length  of message
    int     0x80                                  ; All system calls are done via this interrupt

    mov     eax,4                                 ; System call 'write'
    mov     ebx,1                                 ; 'stdout'
    mov     ecx,input                             ; Address of message
    mov     edx,2                                 ; Length  of message
    int     0x80                                  ; All system calls are done via this interrupt

    mov     eax,1                                 ; System call 'exit'
    xor     ebx,ebx                               ; Exitcode: 0 ('xor ebx,ebx' saves time; 'mov ebx, 0' would be slower)
    int     0x80

segment readable writeable
    input           db '' ,0xA
    input_length    db '2'

    message         db 'Please enter a char: ' ;,0xA ; 0xA is ascii for line free
    message_length  = $-message

    response        db 'You entered: ' ;,0xA
    response_length = $-response
