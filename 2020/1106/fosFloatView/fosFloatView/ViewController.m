//
//  ViewController.m
//  fosFloatView
//
//  Created by Augus on 2020/11/6.
//

#import "ViewController.h"
#import "FOSFloatManger.h"
#import "FSGuideController.h"

@interface ViewController ()<FSGuideViewControllerDataSource, FSGuideViewControllerDelegate>

@property(nonatomic, strong) UIButton *button;
@property(nonatomic, strong) UISlider *slider;
@property(nonatomic, strong) UISwitch *aSwitch;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    // 设置返回样式
    if (![[FosTool fs_currentViewController] isMemberOfClass:[ViewController class]]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [FSGuideController showsWithDataSource:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    self.title = @"Home";
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self initSubviews];
    
    [[FOSFloatManger shared] beginScreenEdgePanBack:nil];
    
}


- (void)initSubviews {
    
    [self.view addSubview:self.aSwitch];
    [self.view addSubview:self.slider];
    [self.view addSubview:self.button];
    
    // make constraints
    [self.slider.widthAnchor constraintEqualToConstant:128.0].active = YES;
    [self.slider.topAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.topAnchor constant:64.0].active = YES;
    [self.slider.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:64.0].active = YES;
    
    [self.aSwitch.centerYAnchor constraintEqualToAnchor:self.slider.bottomAnchor constant:128.0].active = YES;
    [self.aSwitch.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-32.0].active = YES;
    
    [self.button.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:32.0].active = YES;
    [self.button.topAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-128.0].active = YES;
}

- (void)backButtonAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [[FOSFloatManger shared] beginScreenEdgePanBack:nil];

}


//MARK: - FSGuideViewControllerDataSource
- (NSUInteger)numberOfGuidesInGuideViewController:(NSString *)identifier {
    return 2 + 1;
}

- (FSGuideItem *)guideViewController:(NSString *)identifier itemForGuideAtIndex:(NSUInteger)index {
    FSGuideItem *item = FSGuideItem.new;
    
    CGRect frame = CGRectZero;
    CGFloat cornerRadius = 0.0;
    if (index == 0) {
        frame = CGRectInset(self.button.frame, -8.0, -2.0);
        cornerRadius = 8.0;
    } else if (index == 1) {
        frame = self.aSwitch.frame;
        cornerRadius = CGRectGetHeight(frame) * 0.5;
    }
    
    item.highlightFrameOfAnnotated = frame;
    item.cornerRadiusOfAnnotated = cornerRadius;
    item.annotationText = @"演示自定义动画";
    item.annotationTitle = @"动画";
    item.iconImageName = @"bird";
    return item;
}

- (void)guideViewController:(NSString *)identifier animateToFrame:(CGRect)frame fromAnnotationView:(UIView<FSGuideAnnotationViewProtocol> *)oldAnnotationView toAnnotationView:(UIView<FSGuideAnnotationViewProtocol> *)newAnnotationView {
    // 自定义"注解"视图的出现和消失动画
    // 有两个注意点
    // 为了保证"新"视图位置大小正确，需要调用 newAnnotationView.frame = frame
    // 为了保证"旧"视图从superview中移除，需要调用 [oldAnnotationView removeFromSuperview]
    newAnnotationView.frame = frame;
    newAnnotationView.alpha = 0.0;
    [UIView animateWithDuration:2.0 animations:^{
        newAnnotationView.alpha = 1.0;
        oldAnnotationView.frame = CGRectOffset(oldAnnotationView.frame, -512, 0);
    } completion:^(BOOL finished) {
        [oldAnnotationView removeFromSuperview];
    }];
}

- (void)guideViewController:(NSString *)identifier animateToCenter:(CGPoint)center fromIndicatorView:(UIView *)oldIndicatorView toIndicatorView:(UIView *)newIndicatorView {
    // 自定义指示器视图的出现和消失动画
    // 有两个注意点
    // 为了保证"新"视图位置正确，需要调用 newIndicatorView.center = center
    // 为了保证"旧"视图从superview中移除，需要调用 [oldIndicatorView removeFromSuperview]
    newIndicatorView.alpha = 0.0;
    [UIView animateWithDuration:2.0 animations:^{
        newIndicatorView.alpha = 1.0;
        newIndicatorView.center = center;
        oldIndicatorView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [oldIndicatorView removeFromSuperview];
    }];
}

//MARK: - FSGuideViewControllerDelegate
- (void)guideViewControllerDidSelectSkipTutorial:(NSString *)identifier {
    NSLog(@"跳过教程");
}

- (void)guideViewControllerDidSelectNeverRemind:(NSString *)identifier {
    NSLog(@"不再提醒");
}


//MARK: - Getter & Setter
- (UIButton *)button {
    if (!_button) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button = button;
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setTitle:@"i am a button" forState:UIControlStateNormal];
    }
    return _button;
}

- (UISlider *)slider {
    if (!_slider) {
        UISlider *slider = UISlider.new;
        _slider = slider;
        slider.translatesAutoresizingMaskIntoConstraints = NO;
        slider.value = 0.7;
    }
    return _slider;
}

- (UISwitch *)aSwitch {
    if (!_aSwitch) {
        UISwitch *aSwitch = UISwitch.new;
        _aSwitch = aSwitch;
        aSwitch.translatesAutoresizingMaskIntoConstraints = NO;
        aSwitch.on = YES;
    }
    return _aSwitch;
}

@end
