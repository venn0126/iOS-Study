//
//  GTBlockLogResult.m
//  TestObjcSome
//
//  Created by Augus on 2023/3/12.
//

#import "GTBlockLogResult.h"
#import "GTBlockLogTool.h"

@implementation GTBlockLogResult

- (instancetype)initWithMethodSignature:(NSMethodSignature *)methodSignature{
    if(self = [super init]){
        _returnDecription = [GTBlockLogTool getDecWithType:methodSignature.methodReturnType];
        NSUInteger argIndex = 0;
        NSMutableArray *argDecsArr = [NSMutableArray array];
        while (argIndex < methodSignature.numberOfArguments){
            if(argIndex){
                const char *argType = [methodSignature getArgumentTypeAtIndex:argIndex];
                NSString *argDec = [GTBlockLogTool getDecWithType:argType];
                [argDecsArr addObject:argDec];
            }
            argIndex ++;
        }
        _argDecriptions = [argDecsArr mutableCopy];
    }
    return self;
}
- (NSString *)description{
    NSString *declareArgs = @"";
    NSString *impleArgs = @"";
    long long argIndex = 0;
    for (NSString *argDec in self.argDecriptions) {
        argIndex ++;
        declareArgs = [declareArgs stringByAppendingString:[NSString stringWithFormat:@"%@,",argDec]];
        
        impleArgs = [impleArgs stringByAppendingString:[NSString stringWithFormat:@"%@arg%lld,",[argDec hasSuffix:@"*"] ? argDec : [argDec stringByAppendingString:@" "],argIndex]];
    }
    declareArgs = declareArgs.length ? [declareArgs substringToIndex:declareArgs.length - 1] : declareArgs;
    impleArgs = impleArgs.length ? [impleArgs substringToIndex:impleArgs.length - 1] : impleArgs;
    NSString *declareDescription = [NSString stringWithFormat:@"%@(^)(%@)",self.returnDecription,declareArgs];
    NSString *impleDescription = [NSString stringWithFormat:@"^%@(%@)",self.returnDecription,impleArgs];
    return [NSString stringWithFormat:@"\n----------------------[GTBlockLogStart]----------------------\n[Block声明]%@\n[Block实现]%@\n-----------------------[GTBlockLogEnd]-----------------------",declareDescription,impleDescription];
}

@end
