//
//  FOSFloatManger.m
//  fosFloatView
//
//  Created by Augus on 2020/11/9.
//

#import "FOSFloatManger.h"
#import "HKFloatAreaView.h"
#import "HKTransitionPush.h"
#import "HKTransitionPop.h"
#import "FosFloatController.h"


#define kFloatAreaR  FOS_SCREEN_WIDTH * 0.45
#define kFloatMargin 30
#define kCoef        1.2
#define kBallSizeR   60

@interface FOSFloatManger ()<HKFloatBallDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property(nonatomic, strong) HKFloatAreaView *floatArea;
@property(nonatomic, strong) HKFloatAreaView *cancelFloatArea;
@property(nonatomic, strong) UIViewController *tempFloatViewController;

@property(nonatomic, strong) UIScreenEdgePanGestureRecognizer *edgePan;
@property(nonatomic, strong) CADisplayLink *link;
@property(nonatomic, assign) BOOL showFloatBall;
@end


@implementation FOSFloatManger

+ (instancetype)shared {
    static FOSFloatManger *floatManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        floatManager = [[super allocWithZone:nil] init];
//        floatManager.floatVcClass = [NSMutableArray array];
//        [floatManager hk_currentNavigationController].interactivePopGestureRecognizer.delegate = floatManager;
        [FosTool fs_currentNavigationController].delegate = floatManager;
    });
    return floatManager;
}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    //    if ([self hk_currentNavigationController].viewControllers.count > 1) {
    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panBack:)];
//    [[FOSFloatManger shared] beginScreenEdgePanBack:pan];
//    self.showFloatBall = YES;
//    return YES;
//    }
//    return NO;
//}


#pragma mark - Action

- (void)beginScreenEdgePanBack:(UIGestureRecognizer *)gestureRecognizer {

//    if ([self.floatVcClass containsObject:NSStringFromClass([[self hk_currentViewController] class])]) {
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panBack:)];
    
    self.edgePan = (UIScreenEdgePanGestureRecognizer *) pan;
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [kWindow addSubview:self.floatArea];
    self.tempFloatViewController = [[FosFloatController alloc] init];
    self.showFloatBall = YES;
//    }
}

- (void)panBack:(CADisplayLink *)link {
    if (self.edgePan.state == UIGestureRecognizerStateChanged) {
        CGPoint tPoint = [self.edgePan translationInView:kWindow];
        CGFloat x = MAX(FOS_SCREEN_WIDTH + kFloatMargin - kCoef * tPoint.x, FOS_SCREEN_WIDTH - kFloatAreaR);
        CGFloat y = MAX(FOS_SCREEN_HEIGHT + kFloatMargin - kCoef * tPoint.x, FOS_SCREEN_HEIGHT - kFloatAreaR);
        CGRect rect = CGRectMake(x, y, kFloatAreaR, kFloatAreaR);
        self.floatArea.frame = rect;

        CGPoint touchPoint = [kWindow convertPoint:[self.edgePan locationInView:kWindow] toView:self.floatArea];

        if (touchPoint.x > 0 && touchPoint.y > 0) {
            if (!self.showFloatBall) {
                if (pow((kFloatAreaR - touchPoint.x), 2) + pow((kFloatAreaR - touchPoint.y), 2) <= pow((kFloatAreaR), 2)) {
                    self.showFloatBall = YES;
                } else {
                    if (self.showFloatBall) {
                        self.showFloatBall = NO;
                    }
                }
            }
        } else {
            if (self.showFloatBall) {
                self.showFloatBall = NO;
            }
        }
    } else if (self.edgePan.state == UIGestureRecognizerStatePossible) {
        [UIView animateWithDuration:0.5 animations:^{
            self.floatArea.frame = CGRectMake(FOS_SCREEN_WIDTH, FOS_SCREEN_HEIGHT, kFloatAreaR, kFloatAreaR);
        }                completion:^(BOOL finished) {
            [self.floatArea removeFromSuperview];
            self.floatArea = nil;
            [self.link invalidate];
            self.link = nil;
            if (self.showFloatBall) {
                self.floatViewController = self.tempFloatViewController;
//                if ([self haveIconImage]) {
                self.floatBall.iconImageView.image = [UIImage imageNamed:@"icon_1"];
//                }
                self.floatBall.alpha = 1;
                [kWindow addSubview:self.floatBall];
            }
        }];
    }
}

#pragma mark - HKFloatBallDelegate

- (void)floatBallDidClick:(HKFloatBall *)floatBall {
//    [[self hk_currentNavigationController] pushViewController:self.floatViewController animated:YES];
    
    
    if (self.floatViewController != [FosTool fs_currentViewController]) {
        [[FosTool fs_currentNavigationController] pushViewController:self.floatViewController animated:YES];
    }
}

- (void)floatBallBeginMove:(HKFloatBall *)floatBall {
    if (!_cancelFloatArea) {
        [kWindow insertSubview:self.cancelFloatArea atIndex:1];
        [UIView animateWithDuration:0.5 animations:^{
            self.cancelFloatArea.frame = CGRectMake(FOS_SCREEN_WIDTH - kFloatAreaR, FOS_SCREEN_HEIGHT - kFloatAreaR, kFloatAreaR, kFloatAreaR);
        }];
    }
    CGPoint center_ball = [kWindow convertPoint:self.floatBall.center toView:self.cancelFloatArea];
    if (pow((kFloatAreaR - center_ball.x), 2) + pow((kFloatAreaR - center_ball.y), 2) <= pow((kFloatAreaR), 2)) {
        if (!self.cancelFloatArea.highlight) {
            self.cancelFloatArea.highlight = YES;
        }
    } else {
        if (self.cancelFloatArea.highlight) {
            self.cancelFloatArea.highlight = NO;
        }
    }
}

- (void)floatBallEndMove:(HKFloatBall *)floatBall {

    if (self.cancelFloatArea.highlight) {
        self.tempFloatViewController = nil;
        self.floatViewController = nil;
        [self.floatBall removeFromSuperview];
        self.floatBall = nil;
    }

    [UIView animateWithDuration:0.5 animations:^{
        self.cancelFloatArea.frame = CGRectMake(FOS_SCREEN_WIDTH, FOS_SCREEN_HEIGHT, kFloatAreaR, kFloatAreaR);
    }                completion:^(BOOL finished) {
        [self.cancelFloatArea removeFromSuperview];
        self.cancelFloatArea = nil;
    }];
}


#pragma UINavigationControllerDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {

    UIViewController *vc = self.floatViewController;
    if (vc) {
        if (operation == UINavigationControllerOperationPush) {
            if (toVC != vc) {
                return nil;
            }
            HKTransitionPush *transition = [[HKTransitionPush alloc] init];
            return transition;
        } else if (operation == UINavigationControllerOperationPop) {
            if (fromVC != vc) {
                return nil;
            }
            HKTransitionPop *transition = [[HKTransitionPop alloc] init];
            return transition;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

#pragma mark - Setter

- (void)setShowFloatBall:(BOOL)showFloatBall {
    _showFloatBall = showFloatBall;
    self.floatArea.highlight = showFloatBall;
}

#pragma mark - Lazy

- (CADisplayLink *)link {
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(panBack:)];
    }
    return _link;
}

- (HKFloatAreaView *)floatArea {
    if (!_floatArea) {
        _floatArea = [[HKFloatAreaView alloc] initWithFrame:CGRectMake(FOS_SCREEN_WIDTH + kFloatMargin, FOS_SCREEN_HEIGHT + kFloatMargin, kFloatAreaR, kFloatAreaR)];
        _floatArea.style = HKFloatAreaViewStyle_default;
    };
    return _floatArea;
}

- (HKFloatAreaView *)cancelFloatArea {
    if (!_cancelFloatArea) {
        _cancelFloatArea = [[HKFloatAreaView alloc] initWithFrame:CGRectMake(FOS_SCREEN_WIDTH, FOS_SCREEN_HEIGHT, kFloatAreaR, kFloatAreaR)];;
        _cancelFloatArea.style = HKFloatAreaViewStyle_cancel;
    };
    return _cancelFloatArea;
}

- (HKFloatBall *)floatBall {
    if (!_floatBall) {
        _floatBall = [[HKFloatBall alloc] initWithFrame:CGRectMake(FOS_SCREEN_WIDTH - kBallSizeR - 15, FOS_SCREEN_HEIGHT / 3, kBallSizeR, kBallSizeR)];
        _floatBall.delegate = self;
    };
    return _floatBall;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [FOSFloatManger shared];
}

- (id)copyWithZone:(NSZone *)zone {
    return [FOSFloatManger shared];
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return [FOSFloatManger shared];
}

@end
