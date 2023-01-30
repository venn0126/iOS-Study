//
//  GTPerosn.m
//  TestObjc
//
//  Created by Augus on 2023/1/13.
//

#import "GTPerosn.h"


//#define kGTPersonTallMask 1
//#define kGTPersonRichMask 2
//#define kGTPersonHandsomeMask 4


//#define kGTPersonTallMask 0b00000001
//#define kGTPersonRichMask 0b00000010
//#define kGTPersonHandsomeMask 0b00000100


#define kGTPersonTallMask       (1 << 0) //
#define kGTPersonRichMask       (1 << 1) //0b00000001向左移动1位，然后原来的位置补0就是0b00000010
#define kGTPersonHandsomeMask   (1 << 2)
#define kGTPersonThinMask       (1 << 3)



@interface GTPerosn ()



@end

@implementation GTPerosn {
    
    // 用一个字节来存储三个bool值
//    char _tallRichHandsome;
    
//    struct {
//
//        // 位域，代表tall只占一位
//        char tall : 1;
//        char rich : 1;
//        char handsome : 1;
//
//    } _tallRichHandsome;
    
    // 共用体
    union {
        
        // 1个字节
        char bits;
        
        // 1个字节，三个1位
        // 在这里只是摆设，没有实际作用
        struct {
            // 位域，代表tall只占一位
            char tall : 1;
            char rich : 1;
            char handsome : 1;
            char thin : 1;
        };
        
        // 因为是共用体所以总共占一个字节
        // 相当于就是一开始声明的char _tallRichHandsome;
        // 但是提高了代码的可读性
        
    } _tallRichHandsome;
}


//- (instancetype)init {
//    self = [super init];
//    if(!self) return nil;
//
//    // 最后一位是tall
//    // 倒数第二位是rich
//    // 倒数第三位是handsome
//    _tallRichHandsome = 0b00000001;
//
//    return self;
//}


#pragma mark - Getter


- (BOOL)isTall {
    /*
     0b0000 0101
       0000 0001
     */
    //  使用一位存储有可能会溢出
    // 比如如果是0b1
    // 这里返回的是BOOL1个字节，8位，那就是1111 1111，就会返回-1
    // 解决方法：使用两位存储，0b01，返回的8位就会死0000 0001
    // 使用双反取值
    return !!(_tallRichHandsome.bits & kGTPersonTallMask);
}


- (BOOL)isRich {
    /*
     0b0000 0101
       0000 0010
     */
    return !!(_tallRichHandsome.bits & kGTPersonRichMask);
}


- (BOOL)isHandsome {
    /*
     0b0000 0101
       0000 0100
     */
    return !!(_tallRichHandsome.bits & kGTPersonHandsomeMask);
}

- (BOOL)isThin {
    return  !!(_tallRichHandsome.bits & kGTPersonThinMask);
}

//- (BOOL)isTall {
//    /*
//     0b0000 0101
//       0000 0001
//     */
//    return !!_tallRichHandsome.tall;
//}
//
//
//- (BOOL)isRich {
//    /*
//     0b0000 0101
//       0000 0010
//     */
//    return !!_tallRichHandsome.rich;
//}
//
//
//- (BOOL)isHandsome {
//    /*
//     0b0000 0101
//       0000 0100
//     */
//    return !!_tallRichHandsome.handsome;
//}

//- (BOOL)isTall {
//    /*
//     0b0000 0101
//       0000 0001
//     */
//    return _tallRichHandsome & kGTPersonTallMask;
//}
//
//
//- (BOOL)isRich {
//    /*
//     0b0000 0101
//       0000 0010
//     */
//    return _tallRichHandsome & kGTPersonRichMask;
//}
//
//
//- (BOOL)isHandsome {
//    /*
//     0b0000 0101
//       0000 0100
//     */
//    return _tallRichHandsome & kGTPersonHandsomeMask;
//}


#pragma mark - Setter


- (void)setTall:(BOOL)tall {

    /*

     按位或运算，只要有一个是1，就是1，否则是0
        0000 0010 // 需要将tall设置为1，最后一位
     |  0000 0001 // 该属性的掩码
        0000 0011

     */

    if(tall) {
//        _tallRichHandsome = _tallRichHandsome | kGTPersonTallMask;
        _tallRichHandsome.bits |= kGTPersonTallMask;
    } else {
        // 将目的位设置为0，和某个掩码进行按位&，其余的位是1，目的位是0即可
        // 也就是掩码取反符号，取反符号，取反符号 ~kGTPersonTallMask == ~0b00000001
        _tallRichHandsome.bits &= ~kGTPersonTallMask;
    }

}


- (void)setRich:(BOOL)rich {
    if(rich) {
//        _tallRichHandsome = _tallRichHandsome | kGTPersonTallMask;
        _tallRichHandsome.bits |= kGTPersonRichMask;
    } else {
        // 将目的位设置为0，和某个掩码进行按位&，其余的位是1，目的位是0即可
        // 也就是掩码取反符号，取反符号，取反符号 ~kGTPersonTallMask == ~0b00000001
        _tallRichHandsome.bits &= ~kGTPersonRichMask;
    }
}


- (void)setHandsome:(BOOL)handsome {

    if(handsome) {
//        _tallRichHandsome = _tallRichHandsome | kGTPersonTallMask;
        _tallRichHandsome.bits |= kGTPersonHandsomeMask;
    } else {
        // 将目的位设置为0，和某个掩码进行按位&，其余的位是1，目的位是0即可
        // 也就是掩码取反符号，取反符号，取反符号 ~kGTPersonTallMask == ~0b00000001
        _tallRichHandsome.bits &= ~kGTPersonHandsomeMask;
    }
}


- (void)setThin:(BOOL)thin {

    if(thin) {
//        _tallRichHandsome = _tallRichHandsome | kGTPersonTallMask;
        _tallRichHandsome.bits |= kGTPersonThinMask;
    } else {
        // 将目的位设置为0，和某个掩码进行按位&，其余的位是1，目的位是0即可
        // 也就是掩码取反符号，取反符号，取反符号 ~kGTPersonTallMask == ~0b00000001
        _tallRichHandsome.bits &= ~kGTPersonThinMask;
    }
}


//- (void)setTall:(BOOL)tall {
//
//    _tallRichHandsome.tall = tall;
//
//}
//
//
//- (void)setRich:(BOOL)rich {
//
//    _tallRichHandsome.rich = rich;
//}
//
//
//- (void)setHandsome:(BOOL)handsome {
//
//    _tallRichHandsome.handsome = handsome;
//}


//- (void)setTall:(BOOL)tall {
//
//    /*
//
//     按位或运算，只要有一个是1，就是1，否则是0
//        0000 0010 // 需要将tall设置为1，最后一位
//     |  0000 0001 // 该属性的掩码
//        0000 0011
//
//     */
//
//    if(tall) {
////        _tallRichHandsome = _tallRichHandsome | kGTPersonTallMask;
//        _tallRichHandsome |= kGTPersonTallMask;
//    } else {
//        // 将目的位设置为0，和某个掩码进行按位&，其余的位是1，目的位是0即可
//        // 也就是掩码取反符号，取反符号，取反符号 ~kGTPersonTallMask == ~0b00000001
//        _tallRichHandsome &= ~kGTPersonTallMask;
//    }
//
//}
//
//
//- (void)setRich:(BOOL)rich {
//    if(rich) {
////        _tallRichHandsome = _tallRichHandsome | kGTPersonTallMask;
//        _tallRichHandsome |= kGTPersonRichMask;
//    } else {
//        // 将目的位设置为0，和某个掩码进行按位&，其余的位是1，目的位是0即可
//        // 也就是掩码取反符号，取反符号，取反符号 ~kGTPersonTallMask == ~0b00000001
//        _tallRichHandsome &= ~kGTPersonRichMask;
//    }
//}
//
//
//- (void)setHandsome:(BOOL)handsome {
//
//    if(handsome) {
////        _tallRichHandsome = _tallRichHandsome | kGTPersonTallMask;
//        _tallRichHandsome |= kGTPersonHandsomeMask;
//    } else {
//        // 将目的位设置为0，和某个掩码进行按位&，其余的位是1，目的位是0即可
//        // 也就是掩码取反符号，取反符号，取反符号 ~kGTPersonTallMask == ~0b00000001
//        _tallRichHandsome &= ~kGTPersonHandsomeMask;
//    }
//}


- (void)personTest {
    
    NSLog(@"%s", __func__);
    
}


#pragma mark - Cycle Reference of Block

- (void)test {
    
    
    void (^block)(void) = ^{
        
        NSLog(@"it is a block %@",self);
    };
    
    block();
}

@end
