//
//  ChengOperationView.m
//  TestHookEncryption
//
//  Created by Augus on 2024/9/2.
//

#import "ChengOperationView.h"
#import "UIView+Extension.h"
#import "GTControllableCThread.h"


static NSInteger const kChengOperationViewTagOffset = 2500;
static CGFloat const kChengOperationViewHeight = 130.0;
static CGFloat const kChengOperationViewButtonHeight = 40.0;
static CGFloat const kChengOperationViewButtonWidth = 150.0;
static CGFloat const kChengOperationViewButtonX = 10.0;

#define kChengOperationViewRandomIntervalType @"kChengOperationViewRandomIntervalType"
#define kChengOperationViewTimingStringKey @"kChengOperationViewTimingStringKey"
#define kChengOperationViewTimingOnKey @"kChengOperationViewTimingOnKey"
#define GuanUserDefaults [NSUserDefaults standardUserDefaults]
#define GuanNotificationCenter [NSNotificationCenter defaultCenter]


@interface ChengOperationView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic, strong) UIButton *guanStartButton;
@property(nonatomic, strong) UIButton *guanStopButton;

//@property(nonatomic, strong) UISegmentedControl *randomSegment;
//@property (nonatomic, strong) UILabel *randomLabel;
//@property (nonatomic, strong) NSArray *numbersArray;


@property(nonatomic, strong) UIPickerView *guanTimingPicker;
@property (nonatomic, strong) UILabel *resultTimingLabel;
@property(nonatomic, strong) UISwitch *guanTimingSwitch;
@property (nonatomic, strong) NSArray *hoursArray;
@property (nonatomic, strong) NSArray *minutesArray;
@property (nonatomic, strong) NSArray *secondsArray;

@property(nonatomic, strong) UILabel *taskStatusLabel;

/// 任务获取定时器和回收线程
@property (nonatomic, strong) NSTimer *guanTimer;
@property (nonatomic, strong) GTControllableCThread *augusThread;

@end


@implementation ChengOperationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(!self) return nil;
    
    
    // 返回前台通知
    [GuanNotificationCenter addObserver:self selector:@selector(guan_didBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    self.height = kChengOperationViewHeight;
    self.width = [UIScreen mainScreen].bounds.size.width;
    self.backgroundColor = UIColor.lightGrayColor;
//    self.numbersArray = @[@"0", @"1", @"2", @"3", @"4"];
    
    self.hoursArray = [self createArrayWithRange:24];   // 0-23小时
    self.minutesArray = [self createArrayWithRange:60]; // 0-59分钟
    self.secondsArray = [self createArrayWithRange:60]; // 0-59秒
    
    [self guan_setupSubview];
    return self;
}

- (void)guan_didBecomeActive {

    NSLog(@"guan_didBecomeActive didi2");
    // 继续开启定时器
    [self guanTimingSwitchAction:self.guanTimingSwitch];
}

- (void)dealloc {
    [GuanNotificationCenter removeObserver:self];
}



- (void)guan_setupSubview {
    
//    [self addSubview:self.randomLabel];
//    [self addSubview:self.randomSegment];
//    self.randomSegment.selectedSegmentIndex = [GuanUserDefaults integerForKey:kChengOperationViewRandomIntervalType] ?: 0;
    
    [self addSubview:self.taskStatusLabel];
    [self guan_setTaskStatusLabelText:ChengOperationViewTaskStatusReady];
    
    [self addSubview:self.resultTimingLabel];
    [self addSubview:self.guanTimingPicker];
    NSString *timeStr = [GuanUserDefaults objectForKey:kChengOperationViewTimingStringKey] ?: @"14:59:55";
    [self updateResultTimingLabel:timeStr];
    
    [self addSubview:self.guanTimingSwitch];
    self.guanTimingSwitch.on = NO;
    self.guanTimingPicker.userInteractionEnabled = !self.guanTimingSwitch.on;
    

    [self addSubview:self.guanStartButton];
    [self addSubview:self.guanStopButton];
    

}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.taskStatusLabel.frame = CGRectMake(kChengOperationViewButtonX, 5, 300, 16);
    
//    self.randomLabel.frame = CGRectMake(self.guanStopButton.right + kChengOperationViewButtonX, 0, 80, kChengOperationViewButtonHeight);
//    self.randomSegment.frame = CGRectMake(self.randomLabel.right, 0, 150, kChengOperationViewButtonHeight);
    
    self.resultTimingLabel.frame = CGRectMake(self.taskStatusLabel.left, self.taskStatusLabel.bottom, 110, 60);
    self.guanTimingPicker.frame = CGRectMake(self.resultTimingLabel.right, self.resultTimingLabel.top, 180, 60);
    
    self.guanTimingSwitch.frame = CGRectMake(self.guanTimingPicker.right + kChengOperationViewButtonX, 0, 0, 0);
    self.guanTimingSwitch.centerY = self.guanTimingPicker.centerY;


    self.guanStartButton.frame = CGRectMake(kChengOperationViewButtonX, self.guanTimingPicker.bottom, kChengOperationViewButtonWidth, kChengOperationViewButtonHeight);
    self.guanStopButton.frame = CGRectMake(self.guanStartButton.right + 30, self.guanStartButton.top, kChengOperationViewButtonWidth, kChengOperationViewButtonHeight);
}


#pragma mark - Button Action

- (void)startButtonAction:(UIButton *)sender {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(operationView:actionForTag:)] && !self.guanTimingSwitch.on) {
        [self.delegate operationView:self actionForTag:sender.tag];
        [self guan_setTaskStatusLabelText:ChengOperationViewTaskStatusRunning];
    }
}

- (void)stopButtonAction:(UIButton *)sender {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(operationView:actionForTag:)] && !self.guanTimingSwitch.on) {
        [self.delegate operationView:self actionForTag:sender.tag];
        [self guan_setTaskStatusLabelText:ChengOperationViewTaskStatusStopped];
    }
}


- (void)guan_randomSegmentAction:(UISegmentedControl *)sender {
    NSLog(@"[TaoLi] guan_sexSegmentAction %ld",sender.selectedSegmentIndex);
    [GuanUserDefaults setInteger:sender.selectedSegmentIndex forKey:kChengOperationViewRandomIntervalType];

}

- (void)guanTimingSwitchAction:(UISwitch *)sender {
    NSLog(@"guan switch %@",@(sender.on));
    [GuanUserDefaults setBool:sender.on forKey:kChengOperationViewTimingOnKey];
    self.guanTimingPicker.userInteractionEnabled = !sender.on;
    if(sender.on) {
        [self guan_startTimerInterval:0.5 block:^(NSTimer * _Nullable timer) {
            // 实时检测是否到了时间点
            [self checkIfTimeReached];
        }];
    } else {
        [self guan_stopTimer];
    }

}


#pragma mark - 数据源生成方法

- (NSArray *)createArrayWithRange:(NSInteger)range {
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < range; i++) {
        [array addObject:[NSString stringWithFormat:@"%02ld", (long)i]];
    }
    return array.copy;
}


- (void)guan_setTaskStatusLabelText:(ChengOperationViewTaskStatus)status {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *tempStr = @"当前任务状态:";
        switch (status) {
            case ChengOperationViewTaskStatusReady:
                tempStr = [tempStr stringByAppendingString:@"未开始"];
                break;
            case ChengOperationViewTaskStatusRunning:
                tempStr = [tempStr stringByAppendingString:@"运行中"];
                break;
            case ChengOperationViewTaskStatusStopped:
                tempStr = [tempStr stringByAppendingString:@"已停止"];
                break;
            default:
                tempStr = [tempStr stringByAppendingString:@"未知,请联系开发者"];
                break;
        }
        self.taskStatusLabel.text = tempStr;
    });

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
    [self updateResultTimingLabel:nil];
}


#pragma mark - 更新Label显示

- (void)updateResultTimingLabel:(NSString *)timeStr {
    
    if(timeStr) {// 从缓存取的
        // 更新pickerView
        [self setPickerViewBasedOnLabelTimeString:timeStr];
    } else {// 用户操作
        NSInteger selectedHour = [self.guanTimingPicker selectedRowInComponent:0];
        NSInteger selectedMinute = [self.guanTimingPicker selectedRowInComponent:1];
        NSInteger selectedSecond = [self.guanTimingPicker selectedRowInComponent:2];

        timeStr = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",
                                (long)selectedHour, (long)selectedMinute, (long)selectedSecond];
        [GuanUserDefaults setValue:timeStr forKey:kChengOperationViewTimingStringKey];
    }
    self.resultTimingLabel.text = [NSString stringWithFormat:@"倒计时:%@", timeStr];
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


- (NSDateFormatter *)getDateFormatter {
    static NSDateFormatter *dateFormater = nil;
    if (!dateFormater) {
        dateFormater = [[NSDateFormatter alloc] init];
        dateFormater.locale = [NSLocale systemLocale];
        dateFormater.calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
    }
    return dateFormater;
}

- (void)checkIfTimeReached {
    // 获取当前系统时间格式
    BOOL is24HourFormat = ![self isUsing12HourFormat];
    // 获取当前时间
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [self getDateFormatter];
    // 设置当前系统的时间格式
    NSString *currentHourFormat = is24HourFormat ? @"HH:mm:ss" : @"hh:mm:ss a";
    dateFormatter.dateFormat = currentHourFormat;
    NSString *currentTimeString = [dateFormatter stringFromDate:currentDate];

    // 获取选中的时间
    NSString *selectedTime = [GuanUserDefaults objectForKey:kChengOperationViewTimingStringKey] ?: @"00:00:00"; // 例如 "倒计时:14:30:45"
    // 将时间字符串转为NSDate对象,根据不同的时间格式
    NSDate *selectedDate = [self dateFromString:selectedTime withFormat:@"HH:mm:ss"];
    NSDate *currentTime = [self dateFromString:currentTimeString withFormat:currentHourFormat];

    // 比较时间
    NSComparisonResult result = [currentTime compare:selectedDate];
    if (result == NSOrderedSame || result == NSOrderedDescending) {
        NSLog(@"时间到了或者超过了设定的时间");
        if(self.delegate && [self.delegate respondsToSelector:@selector(operationView:actionForTag:)]) {
            [self.delegate operationView:self actionForTag:kChengOperationViewTagOffset + 1];
            [self guan_setTaskStatusLabelText:ChengOperationViewTaskStatusRunning];
        }
        [self guan_stopTimer];
    } else {
        NSLog(@"时间还没到");
    }
}


- (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *formatter = [self getDateFormatter];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:string];
    return date;
}

// 判断是否使用12小时制
- (BOOL)isUsing12HourFormat {
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    return [formatStringForHours containsString:@"a"];
}

#pragma mark - Timer

/// 开启定时器
- (void)guan_startTimerInterval:(NSTimeInterval)interval block:(ChengTimerBlock)block {


    if(!self.augusThread) {
        self.augusThread = [[GTControllableCThread alloc] init];
    }

    if(_guanTimer) {
        [self guan_stopTimer];
    }
    
    if(interval <= 0) {
        interval = 1;
    }

    [self.augusThread gt_cexecuteTask:^{
        self->_guanTimer = [NSTimer timerWithTimeInterval:interval repeats:YES block:block];
        [[NSRunLoop currentRunLoop] addTimer:self->_guanTimer forMode:NSRunLoopCommonModes];

    }];
}

/// 关闭定时器
- (void)guan_stopTimer {

    [_guanTimer invalidate];
    _guanTimer = nil;
    [GuanUserDefaults setBool:NO forKey:kChengOperationViewTimingOnKey];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.guanTimingSwitch.on = NO;
    });
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark - Lazy Load

- (UIButton *)guanStartButton {
    if(!_guanStartButton) {
        _guanStartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _guanStartButton.size = CGSizeMake(kChengOperationViewButtonWidth, kChengOperationViewButtonHeight);
        _guanStartButton.tag = kChengOperationViewTagOffset + 1;
        [_guanStartButton setTitle:@"开始" forState:UIControlStateNormal];
//        [_guanStartButton setBackgroundImage:[self imageWithColor:UIColor.greenColor] forState:UIControlStateNormal];
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
    }
    return _guanTimingSwitch;
}


//- (UISegmentedControl *)randomSegment {
//    if(!_randomSegment) {
//        _randomSegment = [[UISegmentedControl alloc] initWithItems:self.numbersArray];
//        [_randomSegment addTarget:self action:@selector(guan_randomSegmentAction:) forControlEvents:UIControlEventValueChanged];
//    }
//    return _randomSegment;
//}
//
//- (UILabel *)randomLabel {
//    if(!_randomLabel) {
//        _randomLabel = [[UILabel alloc] init];
//        _randomLabel.textColor = UIColor.blackColor;
//        _randomLabel.font = [UIFont systemFontOfSize:14];
//        _randomLabel.text = @"延迟档位";
//    }
//    return _randomLabel;
//}

- (UILabel *)taskStatusLabel {
    if(!_taskStatusLabel) {
        _taskStatusLabel = [[UILabel alloc] init];
        _taskStatusLabel.textColor = UIColor.blackColor;
        _taskStatusLabel.font = [UIFont systemFontOfSize:14];
        _taskStatusLabel.text = @"任务状态:";
        _taskStatusLabel.textColor = UIColor.blueColor;
        [_taskStatusLabel sizeToFit];
    }
    return _taskStatusLabel;
}
@end
