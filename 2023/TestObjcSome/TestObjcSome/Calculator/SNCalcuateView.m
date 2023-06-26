//
//  SNCalcuateView.m
//  SNCalculatorDemo
//
//  Created by Augus on 2023/6/24.
//

#import "SNCalcuateView.h"
#import "SNCalculateMethod.h"
#import <math.h>

static const NSInteger kTagOffset = 10000;
static const CGFloat kOutputTextFieldHeight = 80.0;


@interface SNCalcuateView ()

@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong) UITextField *outputTextField;
@property (nonatomic, strong) SNCalculateMethod *calculateMethod;


@end

@implementation SNCalcuateView


- (instancetype)initWithFrame:(CGRect)frame {
    
    
    self = [super initWithFrame:frame];
    if(!self) return nil;
    self.backgroundColor = UIColor.clearColor;
    
    // 根据不同的宽度适应不同的文字大小
    

    [self setupSubviews];
    
    return self;

}


- (void)setupSubviews {
    
    // 244 185 193
    
    [self addSubview:self.outputTextField];
    
    // 初始化输入框
    [self.calculateMethod displayString:@"0" withMethod:@"cover" outputTextField:self.outputTextField];
    
    // output 151 204 232
    for (int i = 0; i < self.dataArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *showText = self.dataArray[i];
        if([showText isEqualToString:@"C"]) {// 清空
            [button addTarget:self action:@selector(clearEntryAction:) forControlEvents:UIControlEventTouchUpInside];
        }else if([showText isEqualToString:@"."]) {// 点击了小数点
            [button addTarget:self action:@selector(isDecimalAction:) forControlEvents:UIControlEventTouchUpInside];
        }  else if([showText isEqualToString:@"+/-"] ||
                  [showText isEqualToString:@"-"] ||
                  [showText isEqualToString:@"%"] ||
                  [showText isEqualToString:@"×"] ||
                  [showText isEqualToString:@"+"] ||
                  [showText isEqualToString:@"÷"] ||
                   [showText isEqualToString:@"="]) {// 点击了操作符号
            [button addTarget:self action:@selector(operatorAction:) forControlEvents:UIControlEventTouchUpInside];
        } else {// 点击了数字键
            [button addTarget:self action:@selector(normalButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        [button setTitle:showText forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:32];
        [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor colorWithRed:244.0/255.0 green:185/255.0 blue:193/255.0 alpha:1]];
        
        button.tag = i + kTagOffset;
        [self addSubview:button];
    }
    
}


- (void)layoutSubviews {
    [super layoutSubviews];

    // outputTextField
    CGFloat viewWidth = self.frame.size.width;
    self.outputTextField.frame = CGRectMake(0, 0, viewWidth, kOutputTextFieldHeight);
    
    // other buttons
    CGFloat lastHeight = 0.0;
    for (int i = 0; i < self.dataArray.count; i++) {
        UIButton *button = [self viewWithTag:i + kTagOffset];
        CGFloat line = 0;
        // 判断该元素是第几行
        if(i < 4) {
            line = 0;
        } else if(i < 8) {
            line = 1;
        } else if(i < 12) {
            line = 2;
        } else if(i < 16) {
            line = 3;
        } else {
            line = 4;
        }
        CGFloat itemWidth = 0.0;
        CGFloat itemHeight = kOutputTextFieldHeight;
        if(line < 4) {
            itemWidth = viewWidth / 4.0;
        } else {
            itemWidth = viewWidth / 3.0;
        }
        
        CGFloat x = itemWidth * (i - 4 * line);
        CGFloat y = self.outputTextField.frame.origin.y + self.outputTextField.frame.size.height + itemHeight * line;
        
        button.frame = CGRectMake(x, y, itemWidth, itemHeight);
        lastHeight = button.frame.origin.y + itemHeight;
    }
    
    // update self size
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, viewWidth, lastHeight);
}


#pragma mark - Button Actions


// 清除输入框
- (void)clearEntryAction:(UIButton *)sender {
    
    [self.calculateMethod clear:self.outputTextField];
}


// 点击小数点
- (void)isDecimalAction:(UIButton *)sender {
    if(!self.calculateMethod.isDecimal) {
        self.calculateMethod.isDecimal = YES;
        [self.calculateMethod displayString:@"." withMethod:@"add" outputTextField:self.outputTextField];
    }
}

// 操作符
- (void)operatorAction:(UIButton *)sender {
    
    [self.calculateMethod processOp:sender.titleLabel.text outputTextField:self.outputTextField];
    
}

// 数字键
- (void)normalButtonAction:(UIButton *)sender {
    
    if(self.calculateMethod.totalDecimals <= 15) {
        self.calculateMethod.totalDecimals++;
        [self.calculateMethod processDigit:[sender.titleLabel.text intValue] outputTextField:self.outputTextField];
    }
}


#pragma mark - Lazy Load

- (NSArray *)dataArray {
    if(!_dataArray) {
        _dataArray = @[@"C",@"+/-",@"%",@"÷",
                       @"7",@"8",@"9",@"×",
                       @"4",@"5",@"6",@"-",
                       @"1",@"2",@"3",@"+",
                       @"0",@".",@"=",];
    }
    return _dataArray;
}

- (UITextField *)outputTextField {
    if(!_outputTextField) {
        // 67
        _outputTextField = [[UITextField alloc] init];
        _outputTextField.font = [UIFont systemFontOfSize:50];
        _outputTextField.textColor = UIColor.blackColor;
        _outputTextField.backgroundColor = [UIColor colorWithRed:151.0/255.0 green:204.0/255.0 blue:232.0/255.0 alpha:1];
        _outputTextField.userInteractionEnabled = NO;
        _outputTextField.textAlignment = NSTextAlignmentRight;
    }
    return _outputTextField;
}


- (SNCalculateMethod *)calculateMethod {
    if(!_calculateMethod) {
        _calculateMethod = [[SNCalculateMethod alloc] init];
    }
    return _calculateMethod;
}

@end
