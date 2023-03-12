//
//  GTBlockLog.m
//  TestObjcSome
//
//  Created by Augus on 2023/3/12.
//

#import "GTBlockLog.h"
#import "GTBlockDescription.h"

@implementation GTBlockLog

+ (GTBlockLogResult *)logWithBlock:(id)block{
    if(!block){
       NSAssert(NO, @"参数block为空");
    }
    NSString *blockClassName = NSStringFromClass([block class]);
    if(!([blockClassName isEqualToString:@"__NSGlobalBlock__"] || [blockClassName isEqualToString:@"__NSStackBlock__"] || [blockClassName isEqualToString:@"__NSMallocBlock__"])){
        NSAssert(NO, @"参数block不是block对象");
    }
    GTBlockDescription *blockDec = [[GTBlockDescription alloc]initWithBlock:block];
    GTBlockLogResult *logResult = [[GTBlockLogResult alloc]initWithMethodSignature:blockDec.blockSignature];
    return logResult;
}

@end
