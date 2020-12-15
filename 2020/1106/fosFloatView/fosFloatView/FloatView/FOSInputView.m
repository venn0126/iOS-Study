//
//  FOSInputView.m
//  fosFloatView
//
//  Created by Augus on 2020/11/9.
//

#import "FOSInputView.h"
#import "FSMessageModel.h"
#import "FSMessageFrameModel.h"
#import "FSMessageCell.h"

@interface FOSInputView ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIButton *voiceButton;
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UITableView *chatTableView;

/**
 消息数组
 */
@property (nonatomic, strong) NSMutableArray *messageArray;

/**
 自动回复字典
 */
@property (nonatomic, strong) NSDictionary *autoReplyDic;


@end

@implementation FOSInputView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor greenColor];
        [self setupSubviews];
        
        
        //注册键盘显示通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        //监听键盘sent点击
        self.inputTextField.delegate = self;
    }
    return self;
}

- (void)setupSubviews {
    
    
    
    // 聊天表格
    [self chatTableView];
    
    // 语音button
    [self voiceButton];
    
    // 输入框
    [self inputTextField];
    
//    [self.inputTextField addSubview:self.voiceButton];
    
    [self addSubview:self.voiceButton];
    
    self.voiceButton.frame = CGRectMake(10, self.height - 35, 34, 34);
//    self.voiceButton.center = CGPointMake(15, self.inputView.centerY);
        
    
}


- (void)voiceAction:(UIButton *)sender {
    
    FOSLog(@"切换到录制语音");
    if (self.voiceBlock) {
        self.voiceBlock();
    }
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

#pragma mark - Notification

- (void)keyBoardWillChange:(NSNotification *)notification {
    
    //计算需要移动的距离
    NSDictionary *dict = notification.userInfo ;
    CGRect keyBoardFrame =  [[dict objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyBoardFrame.origin.y;
    // 100 为inputview frame相对于全屏幕的y偏移
    CGFloat translationY = keyboardY - self.height - 80;
    //动画执行时间
    CGFloat time = [[dict objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //键盘弹出的节奏和连坐动画节奏一致:7 << 16
    [UIView animateKeyframesWithDuration:time delay:0.0 options:7 << 16 animations:^{
        self.inputTextField.transform = CGAffineTransformMakeTranslation(0, translationY);
        self.voiceButton.transform = CGAffineTransformMakeTranslation(0, translationY);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - TextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    // 点击进滚动到最后一个行

    
    // 然后剩下进行动画处理
            
    [self addMessage:textField.text type:FSMessageModelTypeMe];
    [self addMessage:[self autoReplayWith:textField.text] type:FSMessageModelTypeOther];
    NSIndexPath * path = [NSIndexPath indexPathForRow:self.messageArray.count - 1 inSection:0];
    [self.chatTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    self.inputTextField.text = @"";
    
    
    return YES;
}



- (void)hideKeyboard {
    [self endEditing:YES];
}

#pragma mark - UITableViewDataSource

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}


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


#pragma mark - Lazy


- (UIButton *)voiceButton {
    if (!_voiceButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(-55, -10, 50, 50);
//        [btn setTitle:@"语音" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(voiceAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"chat_bottom_voice_nor"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"chat_bottom_voice_press"] forState:UIControlStateSelected];
        
        _voiceButton = btn;
    }
    return _voiceButton;
}

- (UITextField *)inputTextField {
    
    if (!_inputTextField) {
//        CGFloat y = (self.height - 30 ) * 0.5;
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(FOS_RATIO_WIDTH(60), self.height - 30, self.width - 100, 30)];
        field.layer.borderWidth = 0.5f;
        field.layer.cornerRadius = 5;
        field.returnKeyType = UIReturnKeySend;
        field.layer.borderColor = [UIColor grayColor].CGColor;
        field.backgroundColor = [UIColor clearColor];
        field.leftViewMode = UITextFieldViewModeAlways;
        
//        field.userInteractionEnabled  = YES;
//        field.bac
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

- (UITableView *)chatTableView {
    if (!_chatTableView) {
        CGFloat padding = 0;
        if (FOS_SCREEN_HEIGHT >= 812) {
            padding = 10;
        }
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, FOS_SCREEN_WIDTH, FOS_RATIO_HEIGHT(400)) style:UITableViewStylePlain];
        
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

@end
