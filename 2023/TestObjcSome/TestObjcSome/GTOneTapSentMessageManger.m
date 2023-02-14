//
//  GTOneTapSentMessageManger.m
//  TestObjcSome
//
//  Created by Augus on 2023/2/15.
//

#import "GTOneTapSentMessageManger.h"

@implementation GTOneTapSentMessageManger

+ (instancetype)sharedInstance {
    
    
    static GTOneTapSentMessageManger *manger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[GTOneTapSentMessageManger alloc] init];
    });
    
    return manger;
}



@end
