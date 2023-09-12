format PE CONSOLE
include 'win32ax.inc'
include 'encoding\utf8.inc'
entry start 
;================
;section data
;================
section '.data' data  readable writeable

firstmes du "Количество программистов в комнате: ",13,10,0
_len  = 38
progsF du " программистов" , 0
_lenF = 16
progsS du " программист" , 0
_lenS = 12
progsT du " программиста" , 0
_lenT = 13

lastmes du "В комнате ", 0
_lenL = 11

section '.bss' data  readable writeable

countProg dd ?
currentCountProg dd ?

;================
;section code
;================
section '.code' code readable executable
start:
    ccall [SetConsoleOutputCP], 1251
    push -11
    call [GetStdHandle]
    push 0
    push 0
    push _len
    push firstmes
    push eax
    call [WriteConsoleW]
    invoke scanf, "%d", countProg
    mov eax, [countProg]
    mov ebx, 100
    mov edx, 0
    idiv ebx

    mov [currentCountProg], edx
    cmp [currentCountProg], 4
    ja betweenFiveAndTwenty
    jmp equalOne

betweenFiveAndTwenty:
    mov eax, 21
    cmp eax, [currentCountProg] 
    ja betweenFiveAndTwentyCode
    jmp equalOne

betweenFiveAndTwentyCode:
    push -11
    call [GetStdHandle]
    push 0
    push 0
    push _lenL
    push lastmes
    push eax
    call [WriteConsoleW]
    invoke printf, "%d", [countProg]
    push -11
    call [GetStdHandle]
    push 0
    push 0
    push _lenF
    push progsF
    push eax
    call [WriteConsoleW]
    invoke ExitProcess, 0

betweenTwoAndFour:
    mov eax, 5
    cmp eax, [currentCountProg] 
    ja betweenTwoAndFourCode

betweenTwoAndFourCode:
    push -11
    call [GetStdHandle]
    push 0
    push 0
    push _lenL
    push lastmes
    push eax
    call [WriteConsoleW]
    invoke printf, "%d", [countProg]
    push -11
    call [GetStdHandle]
    push 0
    push 0
    push _lenT
    push progsT
    push eax
    call [WriteConsoleW]
    invoke ExitProcess, 0

equalOne:
    mov eax, [currentCountProg]
    mov ebx, 10
    mov edx, 0
    idiv ebx
    mov [currentCountProg], edx

    mov eax, 1
    cmp [currentCountProg], eax 
    je equalOneCode
    cmp [currentCountProg], 1
    ja betweenTwoAndFour

equalOneCode:
    push -11
    call [GetStdHandle]
    push 0
    push 0
    push _lenL
    push lastmes
    push eax
    call [WriteConsoleW]
    invoke printf, "%d", [countProg]
    push -11
    call [GetStdHandle]
    push 0
    push 0
    push _lenS
    push progsS
    push eax
    call [WriteConsoleW]
    invoke ExitProcess, 0

;================
;section import (win32)
;================
section '.idata' import data readable writeable
    library kernel,'KERNEL32.DLL', msvcrt, 'msvcrt.dll'
    import kernel, ExitProcess,'ExitProcess' ,\
    SetConsoleOutputCP, 'SetConsoleOutputCP', \
    GetStdHandle, "GetStdHandle", \
    WriteConsoleW, "WriteConsoleW"
    import msvcrt,\ 
    printf,'printf',\ 
    scanf, 'scanf'
    
;======FIN=======
