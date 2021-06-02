//
//  NWTimerCell.m
//  DDDemo
//
//  Created by Augus on 2021/5/19.
//

#import "NWTimerCell.h"

@interface NWTimerCell ()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) NSTimer *timer;


@end

@implementation NWTimerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    
    [self initSubviews];
    
    // 初始化timer
    [self initTimer];

    
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.timeLable];
    CGFloat width = 30;
    self.timeLabel.frame = CGRectMake(self.contentView.frame.size.width - width, 0, width, self.contentView.frame.size.height);
    
}

- (void)initTimer {
    
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
           
            // update text
            NSInteger time = [self.timeLabel.text integerValue];
            if (time > 0) {
                time--;
                self.timeLabel.text = [NSString stringWithFormat:@"%ld",time];
            }
        }];
        
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)destoryTimer {
    [_timer invalidate];
    _timer = nil;
    
    NSLog(@"destory Timer");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTimeText:(NSString *)timeText {
    
    self.timeLabel.text = timeText;
}

#pragma mark - Lazy Load

- (UILabel *)timeLable {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont systemFontOfSize:20];
        _timeLabel.textColor = UIColor.redColor;
//        _timeLabel.text = @"30";
        [_timeLabel sizeToFit];
        
    }
    return _timeLabel;
}

- (void)dealloc {
    [self destoryTimer];
}

@end
