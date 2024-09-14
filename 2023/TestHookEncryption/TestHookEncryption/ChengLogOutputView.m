//
//  ChengLogOutputView.m
//  TestHookEncryption
//
//  Created by Augus Venn on 2024/9/13.
//

#import "ChengLogOutputView.h"

@interface ChengLogOutputView ()

@property(nonatomic, strong) UITextView *chengTextView;

@end


@implementation ChengLogOutputView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(!self) return nil;
    
    [self setupUI];
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.chengTextView];
    self.chengTextView.text = @"输出日志---";
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.chengTextView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}

#pragma mark - Public Methods

- (void)guan_appendLog:(NSString *)log {
    if(!log || ![log isKindOfClass:[NSString class]] || log.length == 0) return;
    NSString *fLog = [self.chengTextView.text stringByAppendingFormat:@"\n%@",log];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"写日志中 %@",fLog);
        self.chengTextView.text = fLog;
        // 自动滚动到文本底部
        NSRange bottom = NSMakeRange(self.chengTextView.text.length - 1, 1);
        [self.chengTextView scrollRangeToVisible:bottom];
    });
}

- (void)guan_clearLog {
    self.chengTextView.text = nil;
}

#pragma mark - Lazy Load

- (UITextView *)chengTextView {
    if(!_chengTextView) {
        _chengTextView = [[UITextView alloc] init];
        _chengTextView.backgroundColor = UIColor.yellowColor;
        _chengTextView.editable = NO;
        _chengTextView.textColor = UIColor.redColor;
        _chengTextView.layoutManager.allowsNonContiguousLayout = NO;
    }
    return _chengTextView;
}

@end
