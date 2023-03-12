[BITS 16]
[ORG 0x7C00]

; ---------------------------------------------------------------------
;                           MAIN PROGRAM CODE                          
; ---------------------------------------------------------------------

cli                            ; Disable interrupts

mov ax, cs
mov ds, ax                     ; Set up data segment

mov ax, 0x07C0
mov sp, 1024                   ; Set up the stack 512 bytes after the
mov ss, ax                     ; end of where our code is loaded

mov al, 0x12                   ; Set video mode to 0x12
call set_video_mode            ; (graphics, 640x480, 16 colors)

mov si, str_hello
call print                     ; Print the message defined by str_hello

mov si, data_line_color_a
mov dx, 160
call draw_line                 ; Draw the first line

mov si, data_line_color_b
mov dx, 320
call draw_line                 ; Draw the second line

jmp $                          ; Stop here

; ---------------------------------------------------------------------
;                         FUNCTION DEFINITIONS                         
; ---------------------------------------------------------------------

set_video_mode:
  mov ah, 0x00
  int 0x10
  ret

draw_line:
  mov ah, 0x0C
  mov bh, 0x00
  mov cx, 230

  .draw_line_set_color:
    lodsb

  .draw_line_loop:
    push dx
    int 0x10
    inc dx
    int 0x10
    pop dx
    inc cx
    cmp cx, 290
    je .draw_line_set_color
    cmp cx, 350
    je .draw_line_set_color
    cmp cx, 410
    jne .draw_line_loop

  .draw_line_break:
    ret

print:
  .print_set_cursor_pos:
    mov ah, 0x02
    mov bh, 0x00
    mov dh, [data_curr_row]
    mov dl, [data_curr_col]
    int 0x10

  .print_inc_curr_row:
    mov cx, [data_curr_row]
    inc cx
    mov [data_curr_row], cx

  .print_setup:
    mov ah, 0x0E
    mov bh, 0x00

  .print_load_line_color:
    lodsb
    mov bl, al

  .print_loop:
    lodsb
    cmp al, 0x00
    je .print_break
    cmp al, 0x0A
    je .print_set_cursor_pos
    int 0x10
    jmp .print_loop
  
  .print_break:
    ret

; ---------------------------------------------------------------------
;                                 DATA                                 
; ---------------------------------------------------------------------

str_hello       db 0x0E, '         Tip of the day         ', 0x0A,
                db 0x0F, 'A computer program does what you', 0x0A,
                db 0x0F, 'tell it to do, not what you want', 0x0A,
                db 0x0F, '            it to do.           ', 0x00

data_curr_row   db 13
data_curr_col   db 24

data_line_color_a db 12, 14, 10
data_line_color_b db 11,  9, 13

times 510-($-$$) db 0
dw 0xAA55