//
//  GuanCxxxx.c
//  TestHookEncryption
//
//  Created by Augus on 2023/8/21.
//

#include "GuanCxxxx.h"

void startAntiHook(void)
{
        
    // backup registers
    __asm__ volatile(
                     "str x8,  [sp, #-16]!\n"  //arm64标准：sp % 16 必须等于0
                     "stp x6, x7, [sp, #-16]!\n"
                     "stp x4, x5, [sp, #-16]!\n"
                     "stp x2, x3, [sp, #-16]!\n"
                     "stp x0, x1, [sp, #-16]!\n"
                     );
    
    
    __asm volatile (
                    "mov lr, x0\n"
                    );
    
    // restore registers
    __asm volatile (
                    "ldp x0, x1, [sp], #16\n"
                    "ldp x2, x3, [sp], #16\n"
                    "ldp x4, x5, [sp], #16\n"
                    "ldp x6, x7, [sp], #16\n"
                    "ldr x8,  [sp], #16\n"
                    );
    
    
    __asm volatile (
                    "bl __exit"
                    );
    
    __asm volatile ("ret");
  
}
