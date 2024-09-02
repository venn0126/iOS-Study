//
//  ChengOperationView.m
//  TestHookEncryption
//
//  Created by Augus on 2024/9/2.
//

#import "ChengOperationView.h"
#import "UIView+Extension.h"


static NSInteger const kChengOperationViewTagOffset = 2500;
static CGFloat const kChengOperationViewHeight = 130.0;
static CGFloat const kChengOperationViewButtonHeight = 40.0;
static CGFloat const kChengOperationViewButtonWidth = 40.0;
static CGFloat const kChengOperationViewButtonX = 10.0;

@interface ChengOperationView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic, strong) UIButton *guanStartButton;
@property(nonatomic, strong) UIButton *guanStopButton;

@property(nonatomic, strong) UISegmentedControl *randomSegment;
@property (nonatomic, strong) UILabel *randomLabel;
@property (nonatomic, strong) NSArray *numbersArray;


@property(nonatomic, strong) UIPickerView *guanTimingPicker;
@property (nonatomic, strong) UILabel *resultTimingLabel;
@property(nonatomic, strong) UISwitch *guanTimingSwitch;
@property (nonatomic, strong) NSArray *hoursArray;
@property (nonatomic, strong) NSArray *minutesArray;
@property (nonatomic, strong) NSArray *secondsArray;



@end


@implementation ChengOperationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(!self) return nil;
    
    self.height = kChengOperationViewHeight;
    self.width = [UIScreen mainScreen].bounds.size.width;
    self.backgroundColor = UIColor.lightGrayColor;
    self.numbersArray = @[@"0", @"1", @"2", @"3", @"4"];
    
    self.hoursArray = [self createArrayWithRange:24];   // 0-23小时
    self.minutesArray = [self createArrayWithRange:60]; // 0-59分钟
    self.secondsArray = [self createArrayWithRange:60]; // 0-59秒
    
    [self guan_setupSubview];
    return self;
}


- (void)guan_setupSubview {
    
    [self addSubview:self.guanStartButton];
    [self addSubview:self.guanStopButton];

    [self addSubview:self.randomLabel];
    [self addSubview:self.randomSegment];
    self.randomSegment.selectedSegmentIndex = 0;
    
    [self addSubview:self.resultTimingLabel];
    [self addSubview:self.guanTimingPicker];
    [self addSubview:self.guanTimingSwitch];


}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.guanStartButton.frame = CGRectMake(kChengOperationViewButtonX, 0, kChengOperationViewButtonWidth, kChengOperationViewButtonHeight);
    self.guanStopButton.frame = CGRectMake(self.guanStartButton.right + kChengOperationViewButtonX, self.guanStartButton.top, kChengOperationViewButtonWidth, kChengOperationViewButtonHeight);
    
    self.randomLabel.frame = CGRectMake(self.guanStopButton.right + kChengOperationViewButtonX, 0, 100, kChengOperationViewButtonHeight);
    self.randomSegment.frame = CGRectMake(self.randomLabel.right, 0, 150, kChengOperationViewButtonHeight);
    
    self.resultTimingLabel.frame = CGRectMake(self.guanStartButton.left, kChengOperationViewHeight-60, 110, 60);
    self.guanTimingPicker.frame = CGRectMake(self.resultTimingLabel.right, self.resultTimingLabel.top, 180, 60);
    self.guanTimingSwitch.frame = CGRectMake(self.guanTimingPicker.right + kChengOperationViewButtonX, 0, 0, 0);
    self.guanTimingSwitch.centerY = self.guanTimingPicker.centerY;
    
    [self updateResultTimingLabel];

}


#pragma mark - Button Action

- (void)startButtonAction:(UIButton *)sender {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(operationView:actionForTag:)]) {
        [self.delegate operationView:self actionForTag:sender.tag];
    }
}

- (void)stopButtonAction:(UIButton *)sender {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(operationView:actionForTag:)]) {
        [self.delegate operationView:self actionForTag:sender.tag];
    }
}


- (void)guan_randomSegmentAction:(UISegmentedControl *)sender {
    NSLog(@"[TaoLi] guan_sexSegmentAction %ld",sender.selectedSegmentIndex);

}

- (void)guanTimingSwitchAction:(UISwitch *)sender {
    NSLog(@"guan switch %@",@(sender.on));
}


#pragma mark - 数据源生成方法

- (NSArray *)createArrayWithRange:(NSInteger)range {
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < range; i++) {
        [array addObject:[NSString stringWithFormat:@"%02ld", (long)i]];
    }
    return array.copy;
}


#pragma mark - UIPickerViewDataSource

// UIPickerView 共有多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3; // 时、分、秒
}

// UIPickerView 每列有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0: return self.hoursArray.count;   // 小时
        case 1: return self.minutesArray.count; // 分钟
        case 2: return self.secondsArray.count; // 秒
        default: return 0;
    }
}

#pragma mark - UIPickerViewDelegate

// UIPickerView 每行显示的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component) {
        case 0: return self.hoursArray[row];
        case 1: return self.minutesArray[row];
        case 2: return self.secondsArray[row];
        default: return @"";
    }
}

// 选择某一行时触发的事件
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self updateResultTimingLabel];
}


#pragma mark - 更新Label显示

- (void)updateResultTimingLabel {
    NSInteger selectedHour = [self.guanTimingPicker selectedRowInComponent:0];
    NSInteger selectedMinute = [self.guanTimingPicker selectedRowInComponent:1];
    NSInteger selectedSecond = [self.guanTimingPicker selectedRowInComponent:2];

    NSString *timeString = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",
                            (long)selectedHour, (long)selectedMinute, (long)selectedSecond];
    self.resultTimingLabel.text = [NSString stringWithFormat:@"倒计时:%@", timeString];
}


// 假设你有一个方法用来根据Label的时间设置UIPickerView
- (void)setPickerViewBasedOnLabelTimeString:(NSString *)timeString {
    timeString = [timeString stringByReplacingOccurrencesOfString:@"倒计时:" withString:@""];

    // 将时间字符串分解为小时、分钟和秒
    NSArray<NSString *> *timeComponents = [timeString componentsSeparatedByString:@":"];
    if (timeComponents.count == 3) {
        NSInteger hour = [timeComponents[0] integerValue];
        NSInteger minute = [timeComponents[1] integerValue];
        NSInteger second = [timeComponents[2] integerValue];

        // 设置UIPickerView的选中行
        [self.guanTimingPicker selectRow:hour inComponent:0 animated:YES];   // 小时
        [self.guanTimingPicker selectRow:minute inComponent:1 animated:YES]; // 分钟
        [self.guanTimingPicker selectRow:second inComponent:2 animated:YES]; // 秒
    }
}

#pragma mark - 比较时间
- (void)checkIfTimeReached {
    // 获取当前系统时间格式
    BOOL is24HourFormat = ![self isUsing12HourFormat];

    // 获取当前时间
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    // 根据系统设置格式化时间
    if (is24HourFormat) {
        dateFormatter.dateFormat = @"HH:mm:ss";
    } else {
        dateFormatter.dateFormat = @"hh:mm:ss a";
    }

    NSString *currentTimeString = [dateFormatter stringFromDate:currentDate];

    // 获取选中的时间
    NSString *selectedTime = self.resultTimingLabel.text; // 例如 "倒计时:14:30:45"
    selectedTime = [selectedTime stringByReplacingOccurrencesOfString:@"倒计时:" withString:@""];

    // 将时间字符串转为NSDate对象
    NSDate *selectedDate = [dateFormatter dateFromString:selectedTime];
    NSDate *currentTime = [dateFormatter dateFromString:currentTimeString];

    // 比较时间
    NSComparisonResult result = [currentTime compare:selectedDate];
    if (result == NSOrderedSame || result == NSOrderedDescending) {
        NSLog(@"时间到了或者超过了设定的时间");
    } else {
        NSLog(@"时间还没到");
    }
}

// 判断是否使用12小时制
- (BOOL)isUsing12HourFormat {
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    return [formatStringForHours containsString:@"a"];
}

#pragma mark - Lazy Load

- (UIButton *)guanStartButton {
    if(!_guanStartButton) {
        _guanStartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _guanStartButton.size = CGSizeMake(kChengOperationViewButtonWidth, kChengOperationViewButtonHeight);
        _guanStartButton.tag = kChengOperationViewTagOffset + 1;
        [_guanStartButton setTitle:@"开始" forState:UIControlStateNormal];
        [_guanStartButton addTarget:self action:@selector(startButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_guanStartButton setBackgroundColor:UIColor.greenColor];
        _guanStartButton.layer.cornerRadius = 5.0;
        _guanStartButton.layer.masksToBounds = YES;
        [_guanStartButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    }
    return _guanStartButton;
}

- (UIButton *)guanStopButton {
    if(!_guanStopButton) {
        _guanStopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _guanStopButton.size = CGSizeMake(kChengOperationViewButtonWidth, kChengOperationViewButtonHeight);
        _guanStopButton.tag = kChengOperationViewTagOffset + 2;
        [_guanStopButton setTitle:@"结束" forState:UIControlStateNormal];
        [_guanStopButton addTarget:self action:@selector(stopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_guanStopButton setBackgroundColor:UIColor.yellowColor];
        _guanStopButton.layer.cornerRadius = 5.0;
        _guanStopButton.layer.masksToBounds = YES;
        [_guanStopButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];

    }
    return _guanStopButton;
}

- (UIPickerView *)guanTimingPicker {
    if(!_guanTimingPicker) {
        _guanTimingPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _guanTimingPicker.delegate = self;
        _guanTimingPicker.dataSource = self;
//        _guanTimingPicker.backgroundColor = UIColor.blueColor;

    }
    return _guanTimingPicker;
}

- (UILabel *)resultTimingLabel {
    if(!_resultTimingLabel) {
        _resultTimingLabel = [[UILabel alloc] init];
        _resultTimingLabel.textColor = UIColor.blackColor;
        _resultTimingLabel.font = [UIFont systemFontOfSize:14];
//        _resultTimingLabel.backgroundColor = UIColor.redColor;
        
    }
    return _resultTimingLabel;
}

- (UISwitch *)guanTimingSwitch {
    if(!_guanTimingSwitch) {
        _guanTimingSwitch = [[UISwitch alloc] init];
        [_guanTimingSwitch addTarget:self action:@selector(guanTimingSwitchAction:) forControlEvents:UIControlEventValueChanged];
//        _guanTimingSwitch.on = [MengHelperConfig collectUserDataEnable];
    }
    return _guanTimingSwitch;
}


- (UISegmentedControl *)randomSegment {
    if(!_randomSegment) {
        _randomSegment = [[UISegmentedControl alloc] initWithItems:self.numbersArray];
        [_randomSegment addTarget:self action:@selector(guan_randomSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _randomSegment;
}

- (UILabel *)randomLabel {
    if(!_randomLabel) {
        _randomLabel = [[UILabel alloc] init];
        _randomLabel.textColor = UIColor.blackColor;
        _randomLabel.font = [UIFont systemFontOfSize:14];
        _randomLabel.text = @"抢单间隔档位";
    }
    return _randomLabel;
}


@end
