//
//  GTCustomButton.m
//  TestHookEncryption
//
//  Created by Augus on 2024/3/9.
//

#import "GTCustomButton.h"

@interface GTCustomButton ()

@property(nonatomic, copy) NSString *title;
@property(nonatomic, strong) UIImage *image;

@property(nonatomic, strong) UIImageView *buttonImageView;

@end

@implementation GTCustomButton

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image frame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(!self) return nil;
    
    _title = title;
    _image = image;
    
    self.backgroundColor = UIColor.greenColor;
    
    [self gt_setupUI];
        
    return self;
}


#pragma mark - Setup UI

- (void)gt_setupUI {
    
    
    self.buttonImageView.image = _image;
    [self addSubview:self.buttonImageView];
    
    self.buttonLabel.text = _title;
    [self addSubview:self.buttonLabel];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 总的宽度是外部传入的宽度
    CGFloat padding = 5.0;
    
    // 计算imageView
    CGFloat imageViewX = padding;
    CGFloat imageViewY = padding;
    CGFloat imageViewW =  self.frame.size.height - 2 * padding;
    self.buttonImageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewW);
    
    // 计算label
    CGFloat labelX = imageViewX + imageViewW + padding;
    CGFloat labelW = self.frame.size.width - padding - labelX;
    self.buttonLabel.frame = CGRectMake(labelX, 0, labelW, self.frame.size.height);
    
    int a =  floor(3.1);
    
}

#pragma mark - Public Methods

- (void)addTarget:(id)target action:(SEL)action {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
}

#pragma mark - Lazy Load

- (UILabel *)buttonLabel {
    if(!_buttonLabel) {
        _buttonLabel = [[UILabel alloc] init];
        _buttonLabel.font = [UIFont systemFontOfSize:16];
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


@end
