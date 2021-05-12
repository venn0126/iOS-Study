//
//  NiuPersion.m
//  YPYDemo
//
//  Created by Augus on 2021/3/27.
//

#import "NiuPersion.h"

@implementation NiuPersion

//- (instancetype)init
//{
//   self = [super init];
//   if (self) {
//       NSLog(@"🔴类名与方法名：%s（在第%d行），描述：%@ %p", __PRETTY_FUNCTION__, __LINE__, NSStringFromClass([self class]),[self class]);
//       NSLog(@"🔴类名与方法名：%s（在第%d行），描述：%@ %p", __PRETTY_FUNCTION__, __LINE__, NSStringFromClass([super class]),[super class]);
//   }
//   return self;
//}

//- (void)setLastName:(NSString*)lastName
//{
   //设置方法一：如果setter采用是这种方式，就可能引起崩溃
//    if (![lastName isEqualToString:@"陈"])
//    {
//        [NSException raise:NSInvalidArgumentException format:@"姓不是陈"];
//    }
//    _lastName = lastName;
   
   //设置方法二：如果setter采用是这种方式，就可能引起崩溃
//   _lastName = @"陈";
//   NSLog(@"🔴类名与方法名：%s（在第%d行），描述：%@", __PRETTY_FUNCTION__, __LINE__, @"会调用这个方法,想一下为什么？");

//}

- (void)speak {
    [super speak];
    
}
@end
