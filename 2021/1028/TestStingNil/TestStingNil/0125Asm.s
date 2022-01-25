//
//  0125Asm.s
//  TestStingNil
//
//  Created by Augus on 2022/1/25.
//

.text
.global _AugusTest,_TianTest

_AugusTest:
    mov x0, #0xa0
    mov x1, #0x00
    add x1, x0, #0x14
    mov x0, x1
    bl _TianTest
    mov x0, #0x0
    ret
    
_TianTest:
    add x0, x0, #0x10
    ret
