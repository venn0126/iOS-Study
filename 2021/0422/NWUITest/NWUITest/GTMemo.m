//
//  GTMemo.m
//  NWUITest
//
//  Created by Augus on 2021/4/30.
//

#import "GTMemo.h"

@interface GTMemo ()

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, copy) NSString *name;


@end

@implementation GTMemo

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    return self;

}

+ (instancetype)memoWithTitle:(NSString *)name url:(NSURL *)url {

    GTMemo *memo = [[GTMemo alloc] init];
    memo.url = url;
    memo.name = name;
    return memo;

}

@end
