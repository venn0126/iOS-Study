//
//  augusArm.s
//  TestMutableDictionary
//
//  Created by Augus on 2022/7/1.
//


; arm code start
; 放在text段
.text

; 声明函数外部可见
.global _augusTest, _augusAdd, _augusSub, _augusCompare, _augusCompareInCondition, _augusLDR, _augusSTR

; 测试函数
_augusTest:
mov x0, #0x8 ;立即数 x0 = #0x8
mov x1, x0 ;寄存器赋值 x1 = x0
ret

; 测试加法函数
_augusAdd:
add x0, x0, x1
ret

// 测试减法函数
_augusSub:
sub x0, x0, x1
ret

; 比较指令测试
_augusCompare:
mov x0, #0x1
mov x1, #0x3
cmp x0, x1
; 跳转指令，一般跟cmp配合使用
b mycode
ret

mycode:
mov x1, #0x9
ret

; b指令带条件
_augusCompareInCondition:
    mov x0, #0x3
    mov x1, #0x3
    cmp x0, x1
    beq auguscode
    mov x0, #0x5
    ret

auguscode:
    mov x1, #0x6
    ret



_augusLDR:
    ; 测试ldr
    ; ldr w0, [x1]
    ; 测试ldp
    ldp w0, w1, [x2, #0x10]
    ret


_augusSTR:
    ; 测试str
    ; str w0, [x1]
    ; 测试stp
    stp w0, w1, [x1, #0x10]
    ret





