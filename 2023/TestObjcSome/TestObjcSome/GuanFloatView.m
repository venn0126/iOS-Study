//
//  GuanFloatView.m
//  TestObjcSome
//
//  Created by Augus on 2023/6/25.
//

#import "GuanFloatView.h"
#import <objc/runtime.h>
#import "SNCalcuateView.h"

#define NavBarBottom 64
#define TabBarHeight 49
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kSmallViewWidth 50.0
#define kBigViewHeight 350.0

static char kActionHandlerTapBlockKey;
static char kActionHandlerTapGestureKey;


@interface GuanFloatView ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *closeContentButton;
@property (nonatomic, strong) SNCalcuateView *calculateView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation GuanFloatView
{
    BOOL mIsHalfInScreen;
}


CGFloat distanceBetweenPoints (CGPoint first, CGPoint second) {
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt(deltaX*deltaX + deltaY*deltaY );
};


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.stayEdgeDistance = 5;
        self.stayAnimateTime = 0.3;
        [self initStayLocation];
        
        [self addSubview:self.titleLabel];
        self.backgroundColor = [UIColor colorWithRed:151.0/255.0 green:204.0/255.0 blue:232.0/255.0 alpha:1];
        self.layer.cornerRadius = frame.size.width * 0.5;
        self.layer.masksToBounds = YES;
    }
    return self;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.isTouchBegin = YES;
    self.isTouchMoved = NO;
    
    self.touchPoint = [[touches anyObject] locationInView:self];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    
    if (distanceBetweenPoints([touch locationInView:self],self.touchPoint) > 10) {
        self.isTouchMoved = YES;
    }
    
    // 先让悬浮图片的alpha为1
    self.alpha = 1;
    // 获取手指当前的点
    CGPoint  curPoint = [touch locationInView:self];
    
    CGPoint prePoint = [touch previousLocationInView:self];
    
    // x方向移动的距离
    CGFloat deltaX = curPoint.x - prePoint.x;
    CGFloat deltaY = curPoint.y - prePoint.y;
    CGRect frame = self.frame;
    frame.origin.x += deltaX;
    frame.origin.y += deltaY;
    self.frame = frame;
}


- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.isTouchBegin = NO;
   [self moveStay];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.isTouchBegin = NO;
    [self moveStay];
    // 这里可以设置过几秒，alpha减小
//    __weak typeof(self) weakSelf = self;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [pThis animateHidden];
//    });
    
    if(!self.isTouchMoved) {
        if(self.tapActionWithBlock) {
            self.tapActionWithBlock();
        }
    }
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.isTouchBegin) {
        return YES;
    }else{
        return [super pointInside:point withEvent:event];
    }
}


#pragma mark - 设置浮动图片的初始位置
- (void)initStayLocation
{
    CGRect frame = self.frame;
    CGFloat stayWidth = frame.size.width;
    CGFloat initX = kScreenWidth - self.stayEdgeDistance - stayWidth;
    CGFloat initY = (kScreenHeight - NavBarBottom - TabBarHeight) * (2.0 / 3.0) + NavBarBottom;
    frame.origin.x = initX;
    frame.origin.y = initY;
    self.frame = frame;
    mIsHalfInScreen = NO;
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] init];
    swipe.direction = UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft;
    swipe.delegate = self;
    [self addGestureRecognizer:swipe];
}


- (void)setupSubviews {
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.calculateView];
    [self.contentView addSubview:self.closeContentButton];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
//    if(_contentView.hidden) {
//        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, kSmallViewWidth, kSmallViewWidth);
//    } else {
//        self.frame = CGRectMake(0, 200, kScreenWidth, kBigViewHeight);
//    }
//
//    self.contentView.frame = self.bounds;
//    self.calculateView.frame = self.contentView.frame;
//    self.closeContentButton.frame = CGRectMake(self.contentView.frame.size.width - kSmallViewWidth, 0, kSmallViewWidth, kSmallViewWidth);
    
}

#pragma mark - 根据 stayModel 来移动悬浮图片
- (void)moveStay
{
    bool isLeft = [self judgeLocationIsLeft];
    switch (_stayMode) {
        case GuanFloatViewStayModeLeftAndRight:
        {
            [self moveToBorder:isLeft];
        }
            break;
        case GuanFloatViewStayModeLeft:
        {
            [self moveToBorder:YES];
        }
            break;
        case GuanFloatViewStayModeRight:
        {
            [self moveToBorder:NO];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 移动到屏幕边缘
- (void)moveToBorder:(BOOL)isLeft
{
    CGRect frame = self.frame;
    CGFloat destinationX;
    if (isLeft) {
        destinationX = self.stayEdgeDistance;
    }
    else {
        CGFloat stayWidth = frame.size.width;
        destinationX = kScreenWidth - self.stayEdgeDistance - stayWidth;
    }
    frame.origin.x = destinationX;
    frame.origin.y = [self moveSafeLocationY];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:_stayAnimateTime animations:^{
        __strong typeof(self) pThis = weakSelf;
        pThis.frame = frame;
    }];
    mIsHalfInScreen = NO;
}

// 设置悬浮图片不高于屏幕顶端，不低于屏幕底端
- (CGFloat)moveSafeLocationY
{
    CGRect frame = self.frame;
    CGFloat stayHeight = frame.size.height;
    // 当前view的y值
    CGFloat curY = self.frame.origin.y;
    CGFloat destinationY = frame.origin.y;
    // 悬浮图片的最顶端Y值
    CGFloat stayMostTopY = NavBarBottom + _stayEdgeDistance;
    if (curY <= stayMostTopY) {
        destinationY = stayMostTopY;
    }
    // 悬浮图片的底端Y值
    CGFloat stayMostBottomY = kScreenHeight - TabBarHeight - _stayEdgeDistance - stayHeight;
    if (curY >= stayMostBottomY) {
        destinationY = stayMostBottomY;
    }
    return destinationY;
}

#pragma mark -  判断当前view是否在父界面的左边
- (bool)judgeLocationIsLeft
{
    // 手机屏幕中间位置x值
    CGFloat middleX = [UIScreen mainScreen].bounds.size.width / 2.0;
    // 当前view的x值
    CGFloat curX = self.frame.origin.x + self.bounds.size.width/2;
    if (curX <= middleX) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - 当滚动的时候悬浮图片居中在屏幕边缘
- (void)moveTohalfInScreenWhenScrolling
{
    bool isLeft = [self judgeLocationIsLeft];
    [self moveStayToMiddleInScreenBorder:isLeft];
    mIsHalfInScreen = YES;
}

// 悬浮图片居中在屏幕边缘
- (void)moveStayToMiddleInScreenBorder:(BOOL)isLeft
{
    CGRect frame = self.frame;
    CGFloat stayWidth = frame.size.width;
    CGFloat destinationX;
    if (isLeft == YES) {
        destinationX = - stayWidth/2;
    }
    else {
        destinationX = kScreenWidth - stayWidth + stayWidth/2;
    }
    frame.origin.x = destinationX;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        __strong typeof(self) pThis = weakSelf;
        pThis.frame = frame;
    }];
}

#pragma mark - 设置当前浮动图片的透明度
- (void)setCurrentAlpha:(CGFloat)stayAlpha
{
    if (stayAlpha <= 0) {
        stayAlpha = 1;
    }
    self.alpha = stayAlpha;
}


- (void)contentViewShowChange {
    self.contentView.hidden = !self.contentView.hidden;
    [self setNeedsLayout];
    
}

#pragma mark -  设置简单的轻点 block事件
- (void)setTapActionWithBlock:(void (^)(void))block
{
    // 为gesture添加关联是为了gesture只创建一次，objc_getAssociatedObject如果返回nil就创建一次
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
    
    if(block) {
        _tapActionWithBlock = block;
    }
}

- (void)handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        void(^action)(void) = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
        if (action)
        {
            // 先让悬浮图片的alpha为1
            self.alpha = 1;
            if (mIsHalfInScreen == NO) {
                action();
            }
            else {
                [self moveStay];
            }
        }
    }
}

#pragma mark - getter / setter
- (void)setImageWithName:(NSString *)imageName
{
    self.image = [UIImage imageNamed:imageName];
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    self.isTouchBegin = YES;

    return NO;
}


#pragma mark - Lazy Load

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"计算器";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _titleLabel;
}

- (UIView *)contentView {
    if(!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor colorWithRed:151.0/255.0 green:204.0/255.0 blue:232.0/255.0 alpha:1];
        _contentView.hidden = YES;
        _contentView.userInteractionEnabled = NO;
    }
    return _contentView;
}

- (UIButton *)closeContentButton {
    if(!_closeContentButton) {
        _closeContentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeContentButton setTitle:@"X" forState:UIControlStateNormal];
        [_closeContentButton addTarget:self action:@selector(contentViewShowChange) forControlEvents:UIControlEventTouchUpInside];
        _closeContentButton.backgroundColor = UIColor.redColor;
    }
    return _closeContentButton;
}

- (SNCalcuateView *)calculateView {
    if(!_calculateView) {
        _calculateView = [[SNCalcuateView alloc] init];
    }
    return _calculateView;
}
@end
