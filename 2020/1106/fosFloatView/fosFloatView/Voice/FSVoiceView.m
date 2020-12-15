//
//  FSVoiceView.m
//  fosFloatView
//
//  Created by Augus on 2020/11/10.
//

#import "FSVoiceView.h"
#import "FSTalkBackView.h"
//#import "F.h"

@interface FSVoiceView ()

@property (nonatomic,weak) FSTalkBackView *talkBackView;    // 对讲视图


@end

@implementation FSVoiceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor clearColor];
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {

    // 设置对讲界面
    [self talkBackView];

}

- (FSTalkBackView *)talkBackView {
    if (_talkBackView == nil) {
        FSTalkBackView *talkView = [[FSTalkBackView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
//        [self.contentScrollView addSubview:talkView];
        [self addSubview:talkView];
        _talkBackView = talkView;
        
        talkView.talkBackBlock = ^{
//            FOSLog(@"voice view input text");
            self.voiceBlock();
        };
    }
    return _talkBackView;
}
@end
