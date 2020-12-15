//
//  FSBottomView.m
//  fosFloatView
//
//  Created by Augus on 2020/11/11.
//

#import "FSBottomView.h"
#import "FSVoiceView.h"
#import "FSMessageModel.h"
#import "FSMessageFrameModel.h"
#import "FSMessageCell.h"

#import "FOSGuideView.h"


static const CGFloat kVoiceViewHeigt = 180.f;


@interface FSBottomView ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) FSVoiceView *voiceView;

@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UIButton *voiceButton;

@property (nonatomic, strong) UITableView *chatTableView;

@property (nonatomic, strong) FOSGuideView *guideView;


/**
 消息数组
 */
@property (nonatomic, strong) NSMutableArray *messageArray;

/**
 自动回复字典
 */
@property (nonatomic, strong) NSDictionary *autoReplyDic;


@end

@implementation FSBottomView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.mode = FosBottomViewModeSpeech;
        
//        self.backgroundColor = [UIColor greenColor];
        
        //注册键盘显示通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        [self initSubviews];
        
        //监听键盘sent点击
        self.inputTextField.delegate = self;
        
        
    }
    return self;
}

- (void)initSubviews {
    
    
    // 底层的导航视图
    [self guideView];
    
    // 语音view
    [self voiceView];
    
    // 手动输入view
    [self inputTextField];
    [self.inputTextField.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:60].active = YES;
    [self.inputTextField.widthAnchor constraintEqualToConstant:(self.width - 100)].active = YES;
    [self.inputTextField.heightAnchor constraintEqualToConstant:30].active = YES;
    [self.inputTextField.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-15].active = YES;
    
    
    // 切换输入的语音按钮
    [self voiceButton];
    [self.voiceButton.widthAnchor constraintEqualToConstant:FOS_RATIO_WIDTH(34)].active = YES;
    [self.voiceButton.heightAnchor constraintEqualToConstant:FOS_RATIO_HEIGHT(34)].active = YES;
    [self.voiceButton.centerYAnchor constraintEqualToAnchor:self.inputTextField.centerYAnchor].active = YES;
    [self.voiceButton.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:20].active = YES;

    
    
    // 聊天列表
    [self chatTableView];
    
    // 聊天界面默认隐藏
    self.chatTableView.hidden = YES;
    
    
    // 界面回传
    __weak typeof(self)weakSelf = self;
    self.voiceView.voiceBlock = ^{
        // 切换为手动
//        FOSLog("gao---");        
        weakSelf.mode = FosBottomViewModeHand;
        
        
    };
    
}

#pragma mark - Setter

- (void)setMode:(FosBottomViewMode)mode {
    _mode = mode;
    if (mode == FosBottomViewModeHand) {
        self.voiceView.hidden = YES;
        self.inputTextField.hidden = NO;
        self.voiceButton.hidden = NO;
    } else {
        self.voiceView.hidden = NO;
        self.inputTextField.hidden = YES;
        self.voiceButton.hidden = YES;
    }
    
}

#pragma mark - UITableViewDataSource

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self endEditing:YES];
//}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FSMessageCell *cell = [FSMessageCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.messageFrame = self.messageArray[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.messageArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FSMessageFrameModel *fm = [self.messageArray objectAtIndex:indexPath.row];
    return fm.cellHeight;
    
}


#pragma mark - TextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    if (!self.guideView.hidden) {
        self.guideView.hidden = YES;
    }
    self.chatTableView.hidden = NO;
    
    // 更新模型
    [self addMessage:textField.text type:FSMessageModelTypeMe];
    [self addMessage:[self autoReplayWith:textField.text] type:FSMessageModelTypeOther];
    
    
    // 更新列表当前位置
    NSIndexPath * path = [NSIndexPath indexPathForRow:self.messageArray.count - 1 inSection:0];
    [self.chatTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    self.inputTextField.text = @"";
    
    
    return YES;
}

- (void)hideKeyboard {
    [self endEditing:YES];
}

#pragma mark - Message Action

-(void)addMessage:(NSString *)content type:(FSMessageModelType)type {
    FSMessageModel *compareM = (FSMessageModel *)[[self.messageArray lastObject] message];
    
    //当前用户发送时间
    NSDate * date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    NSString *strDate = [formatter stringFromDate:date];
    
    //修改模型并且将模型保存数组
    FSMessageModel * message = [[FSMessageModel alloc] init];
    message.type = type;
    message.text = content;
    message.time = strDate;
    message.hiddenTime = [message.time isEqualToString:compareM.time];
    
    FSMessageFrameModel *mf = [[FSMessageFrameModel alloc] init];
    mf.message = message;
    [self.messageArray addObject:mf];
    
    // 在每次对话的最后增加一个空白行 作为看到最新消息的标志
    if (type == FSMessageModelTypeOther) {
        FSMessageModel *messageSpace = [[FSMessageModel alloc] init];
        messageSpace.type = FSMessageModelTypeSpace;
        messageSpace.text = @"";
        messageSpace.time = strDate;
        messageSpace.hiddenTime = [messageSpace.time isEqualToString:compareM.time];;

        FSMessageFrameModel *mfSpace = [[FSMessageFrameModel alloc] init];
        mfSpace.message = messageSpace;

        [self.messageArray addObject:mfSpace];
    }
    
    
    //刷新表格
    [self.chatTableView reloadData];
}

// 自动回复
-(NSString *)autoReplayWith:(NSString *)content
{
    NSString *result = nil;
    for (int i = 0 ; i < content.length; i ++) {
        NSString *str = [content substringWithRange:NSMakeRange(i, 0)];
        result = self.autoReplyDic[str];
        if (result != nil) {
            break;
        }else{
            result = [NSString stringWithFormat:@"%@好吧",content];
        }
    }
    return result;
}


#pragma mark - Button  Aciton

- (void)voiceAction:(UIButton *)sender {
//    FOSLog("niu---");
    // 切换为语音
    self.mode = FosBottomViewModeSpeech;
    [self hideKeyboard];
   
}


#pragma mark - Notification

- (void)keyBoardWillChange:(NSNotification *)notification {
    
    //计算需要移动的距离
    NSDictionary *dict = notification.userInfo ;
    CGRect keyBoardFrame =  [[dict objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyBoardFrame.origin.y;
    // 100 为inputview frame相对于全屏幕的y偏移
    CGFloat translationY = keyboardY - self.height - 60;
    //动画执行时间
    CGFloat time = [[dict objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //键盘弹出的节奏和连坐动画节奏一致:7 << 16
    [UIView animateKeyframesWithDuration:time delay:0.0 options:7 << 16 animations:^{
        self.inputTextField.transform = CGAffineTransformMakeTranslation(0, translationY);
        self.voiceButton.transform = CGAffineTransformMakeTranslation(0, translationY);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Lazy

- (FSVoiceView *)voiceView {
    if (!_voiceView) {
        FSVoiceView *voice = [[FSVoiceView alloc] initWithFrame:CGRectMake(0, self.height - kVoiceViewHeigt, self.width, kVoiceViewHeigt)];
//        voice.backgroundColor = [UIColor whiteColor];
        [self addSubview:voice];
        _voiceView = voice;
        
    }
    return _voiceView;
}

- (UITextField *)inputTextField {
    
    if (!_inputTextField) {
//        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(FOS_RATIO_WIDTH(60), self.height - 35, self.width - 100, 30)];
        
        UITextField *field = [[UITextField alloc] init];
        field.layer.borderWidth = 0.5f;
        field.layer.cornerRadius = 5;
        field.returnKeyType = UIReturnKeySend;
        field.layer.borderColor = [UIColor grayColor].CGColor;
        field.backgroundColor = [UIColor clearColor];
        field.leftViewMode = UITextFieldViewModeAlways;
        field.translatesAutoresizingMaskIntoConstraints = NO;
        

        // 设置背景
        UIImage *textFieldBgImage = [[UIImage imageNamed:@"chat_bottom_textfield"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
           [field setBackground:textFieldBgImage];
        //
        UIView *left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        field.leftView = left;
        
        [self addSubview:field];
        _inputTextField = field;
    }
    return _inputTextField;
}

- (UIButton *)voiceButton {
    if (!_voiceButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(10, self.height - 35, 34, 34);
//        [btn setTitle:@"语音" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(voiceAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"chat_bottom_voice_nor"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"chat_bottom_voice_press"] forState:UIControlStateSelected];
        
        btn.backgroundColor = [UIColor greenColor];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:btn];
        _voiceButton = btn;
    }
    return _voiceButton;
}


- (UITableView *)chatTableView {
    if (!_chatTableView) {
//        CGFloat padding = 0;
//        if (FOS_SCREEN_HEIGHT >= 812) {
//            padding = 10;
//        }
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, FOS_SCREEN_WIDTH, FOS_RATIO_HEIGHT(260)) style:UITableViewStylePlain];
        
        tab.backgroundColor = RGB(45,40,88);
        tab.dataSource = self;
        tab.delegate = self;
        tab.estimatedRowHeight = 0;
        tab.estimatedSectionHeaderHeight = 0;
        tab.estimatedSectionFooterHeight = 0;
        tab.separatorStyle = NO;
        [self addSubview:tab];
        
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
            [tab addGestureRecognizer:gestureRecognizer];
        gestureRecognizer.cancelsTouchesInView = NO;//加上这句不会影响你 tableview 上的 action (button,cell selected...)
        
        
        
        
        _chatTableView = tab;
    }
    return _chatTableView;
}

-(NSMutableArray *)messageArray
{
    if (_messageArray == nil) {
        NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"1messages.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:fullPath];
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:dictArray.count];
        FSMessageModel *previousModel = nil;
        for (NSDictionary *dict in dictArray) {
            FSMessageFrameModel *frameM = [[FSMessageFrameModel alloc] init];
            FSMessageModel *message = [FSMessageModel FSMessageModelWithDict:dict];
            //判断是否显示时间
            message.hiddenTime =  [message.time isEqualToString:previousModel.time];
            frameM.message = message;
            [models addObject:frameM];
            previousModel = message;
        }
        self.messageArray = [models mutableCopy];
    }
    return _messageArray;
}


- (FOSGuideView *)guideView {
    if (!_guideView) {
        FOSGuideView *guide = [[FOSGuideView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - kVoiceViewHeigt)];
//        guide.backgroundColor = [UIColor greenColor];
        [self insertSubview:guide atIndex:0];
        _guideView = guide;
    }
    return _guideView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
