global _start
extern printf, scanf


section .data
message db "Please input max Fib number: ", 0x0a
outFormat db  "%d", 0x0a, 0x00
inFormat db "%d", 0x00

section .bss
userInput resb 1

section .text
_start:
call printMessage   ; print intro message
call getInput
call initFib        ; set initial Fib values
call loopFib        ; calculate Fib numbers
call Exit           ; Exit the program

getInput:
sub rsp, 8  ; fix stack alignment
mov rdi, inFormat ;set 1st parameter for scanf
mov rsi, userInput ;set 2nd parameter (unserinput)
call scanf  ; scanf(inFormat, userInput)
add rsp, 8  ; restore stack alignment
ret

printMessage:
mov rax, 1           ; 1 is the write syscall number
mov rdi, 1          ; Set the first argument 
mov rsi, message    ; rsi: pointer to message
mov rdx, 29          ; rdx: print length of 20 bytes
syscall             ; call write syscall to the intro message
ret

initFib:
xor rax, rax        ; initialize rax to 0
xor rbx, rbx        ; initialize rbx to 0
inc rbx             ; increment rbx to 1
ret

printFib:
push rax            ; push registers to stack
push rbx
mov rdi, outFormat  ; set 1st argument (format specifier) 
mov rsi, rbx        ; set 2nd argument (Fib Number)
call printf         ; printf(outFormat, rbx)
pop rbx             ; restore registers from stack
pop rax
ret

loopFib:
call printFib       ; print current Fib number
add rax, rbx        ; get the next number
xchg rax, rbx       ; swap values
cmp rbx, [userInput]       ; do rbx - userinput 
js loopFib        ; jump if result is <0
ret

Exit:
mov rax, 60
mov rdi, 0
syscall

