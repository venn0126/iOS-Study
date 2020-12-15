//
//  FOSFloatManger.h
//  fosFloatView
//
//  Created by Augus on 2020/11/9.
//

#import <Foundation/Foundation.h>
#import "HKFloatBall.h"

//NS_ASSUME_NONNULL_BEGIN

@interface FOSFloatManger : NSObject

@property(nonatomic, strong) HKFloatBall *floatBall;
@property(nonatomic, strong) UIViewController *floatViewController;

+ (instancetype)shared;

//+ (void)addFloatVcs:(NSArray<NSString *> *)vcClass;//注意.在导航控制器实例化之后调用
- (void)beginScreenEdgePanBack:(UIGestureRecognizer *)gestureRecognizer;


@end

//NS_ASSUME_NONNULL_END
