//
//  ViewController.h
//  TesLock
//
//  Created by Augus on 2021/1/20.
//

#import <UIKit/UIKit.h>

typedef void(^TestBlock) (void);

@interface ViewController : UIViewController

/*
 
 struct Block_descriptor_1 {
    // uinptr_t:uintptr_t is an unsigned integer type that is capable of storing a data pointer. Which typically means that it's the same size as a pointer.
    uinptr_t reserved;
    uinprt_t size;
 }
 
 struct Block_layout {
    void *isa;
    如在C语言中，volatile关键字可以用来提醒编译器它后面所定义的变量随时有可能改变，因此编译后的程序每次需要存储或读取这个变量的时候，都会直接从变量地址中读取数据。如果没有volatile关键字，则编译器可能优化读取和存储，可能暂时使用寄存器中的值，如果这个变量由别的程序更新了的话，将出现不一致的现象。
    volatile int32_t flags;
    int32_t reserved;
    void (*invoke)(void *,...);
    struct Block_descriptor_1 *descriptor;
    // import variables;
    
 }
 */

@property (nonatomic, copy, nullable) TestBlock testBlock;


@end

