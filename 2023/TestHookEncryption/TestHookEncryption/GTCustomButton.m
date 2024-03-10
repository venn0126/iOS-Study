//
//  GTCustomButton.m
//  TestHookEncryption
//
//  Created by Augus on 2024/3/9.
//

#import "GTCustomButton.h"
#import "NSString+Extension.h"
#import "UIView+Extension.h"


static const CGFloat kImageViewLabelPadding = 5.0;

@interface GTCustomButton ()<UIScrollViewDelegate>

@property(nonatomic, copy) NSString *title;
@property(nonatomic, strong) UIImage *image;

@property(nonatomic, strong) UIImageView *buttonImageView;
@property(nonatomic, strong) UIScrollView *containerView;

@end

@implementation GTCustomButton

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image frame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(!self) return nil;
    
    _title = title;
    _image = image;
    
    self.backgroundColor = UIColor.redColor;
    
    [self gt_setupUI];
        
    return self;
}


#pragma mark - Setup UI

- (void)gt_setupUI {
    
    [self addSubview:self.containerView];
    
    self.buttonImageView.image = _image;
    [self.containerView addSubview:self.buttonImageView];
    
    self.buttonLabel.text = _title;
    [self.containerView addSubview:self.buttonLabel];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.containerView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    // 总的宽度是外部传入的宽度
    CGFloat padding = 5.0;
    
    // 计算imageView
    CGFloat imageViewX = padding;
    CGFloat imageViewY = padding;
    CGFloat imageViewW =  self.frame.size.height - 2 * padding;
    self.buttonImageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewW);
    
    // 计算label
    CGFloat labelX = imageViewX + imageViewW + padding;
    // 计算文本的size
    CGSize textSize = [_title gt_singleLineTextSizeForMaxWidth:MAXFLOAT font:_buttonLabel.font];
    CGFloat labelW = textSize.width;
    CGFloat actualWidth = labelX + labelW + padding;
    if(actualWidth < self.frame.size.width) {
        // 重新计算padding
        padding = (self.frame.size.width - kImageViewLabelPadding - labelW - imageViewW) * 0.5;
    }
    
    self.buttonImageView.left = padding;
    
    self.buttonLabel.frame = CGRectMake(self.buttonImageView.right + 5.0, 0, labelW, self.frame.size.height);
    
    self.containerView.contentSize = CGSizeMake(self.buttonLabel.right + padding, 0);

        
}

#pragma mark - Public Methods

- (void)addTarget:(id)target action:(SEL)action {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    NSLog(@"scroll shouldRecognizeSimultaneouslyWithGestureRecognizer");
    
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"scrollViewDidScroll %@",scrollView);
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    
    return view;
}


#pragma mark - Lazy Load

- (UILabel *)buttonLabel {
    if(!_buttonLabel) {
        _buttonLabel = [[UILabel alloc] init];
        _buttonLabel.font = [UIFont boldSystemFontOfSize:15];
        _buttonLabel.textColor = UIColor.blackColor;
        _buttonLabel.textAlignment = NSTextAlignmentCenter;
        _buttonLabel.userInteractionEnabled = YES;
        _buttonLabel.numberOfLines = 1;
    }
    return _buttonLabel;
}

- (UIImageView *)buttonImageView {
    if(!_buttonImageView) {
        _buttonImageView = [[UIImageView alloc] init];
        _buttonImageView.contentMode = UIViewContentModeScaleAspectFit;
        _buttonImageView.userInteractionEnabled = YES;
    }
    return _buttonImageView;
}

- (UIScrollView *)containerView {
    if(!_containerView) {
        _containerView = [[UIScrollView alloc] initWithFrame:self.bounds];
        // 仅设置水平方向滚动
        _containerView.contentSize = CGSizeMake(self.frame.size.width, 0);
        _containerView.showsHorizontalScrollIndicator = NO;
        _containerView.backgroundColor = UIColor.greenColor;
        _containerView.userInteractionEnabled = YES;
        _containerView.delegate = self;
//        _containerView.bounces = NO;
    }
    return _containerView;
}


@end
