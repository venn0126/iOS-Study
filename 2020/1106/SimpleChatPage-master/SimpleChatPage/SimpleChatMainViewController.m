//
//  SimpleChatMainViewController.m
//  SimpleChatPage
//
//  Created by 李海群 on 2018/6/15.
//  Copyright © 2018年 Gorilla. All rights reserved.
//

#import "SimpleChatMainViewController.h"
#import "MessageModel.h"
#import "MessageFrameModel.h"
#import "MessageCell.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define Font(a) [UIFont fontWithName:@"PingFangSC-Regular" size:a]

@interface SimpleChatMainViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, assign) int iPhoneX;

@property (nonatomic, strong) UITextField *inputTextField;

/**
 消息数组
 */
@property (nonatomic, strong) NSMutableArray *messages;

/**
 自动回复数组
 */
@property (nonatomic, strong) NSDictionary *autoResentDic;

@end

@implementation SimpleChatMainViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"聊天";
    if (kScreenHeight > 810) {
        self.iPhoneX = 10;
    }
    else
    {
        self.iPhoneX = 0;
    }
    [self createTableView];
}

-(NSMutableArray *)messages
{
    if (_messages == nil) {
        NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:fullPath];
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:dictArray.count];
        MessageModel *previousModel = nil;
        for (NSDictionary *dict in dictArray) {
            MessageFrameModel *frameM = [[MessageFrameModel alloc] init];
            
            MessageModel *message = [MessageModel messageModelWithDict:dict];
            
            //判断是否显示时间
            message.hiddenTime =  [message.time isEqualToString:previousModel.time];
            
            frameM.message = message;
            
            [models addObject:frameM];
            
            previousModel = message;
        }
        self.messages = [models mutableCopy];
    }
    return _messages;
}

-(NSDictionary *)autoResentDic
{
    if (_autoResentDic == nil) {
        NSString *strUrl = [[NSBundle mainBundle] pathForResource:@"autoResent.plist" ofType:nil];
        _autoResentDic = [NSDictionary dictionaryWithContentsOfFile:strUrl];
        
    }
    return _autoResentDic;
}

- (void) createTableView
{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 44 - self.iPhoneX) style:UITableViewStylePlain];
    self.mainTableView.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
    self.mainTableView.dataSource=self;
    self.mainTableView.delegate=self;
    self.mainTableView.estimatedRowHeight = 0;
    self.mainTableView.estimatedSectionHeaderHeight = 0;
    self.mainTableView.estimatedSectionFooterHeight = 0;
    self.mainTableView.separatorStyle=NO;
    [self.view addSubview:self.mainTableView];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mainTableView.frame.origin.y + self.mainTableView.frame.size.height, kScreenWidth, 44)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    self.inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 7, kScreenWidth - 100, 30)];
    //给文本输入框添加左边视图
    UIView *left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    self.inputTextField.leftView = left;
    self.inputTextField.layer.borderWidth = 0.5f;
    self.inputTextField.layer.cornerRadius = 5;
    self.inputTextField.returnKeyType = UIReturnKeySend;
    self.inputTextField.layer.borderColor = [UIColor grayColor].CGColor;
    self.inputTextField.backgroundColor = [UIColor clearColor];
    self.inputTextField.leftViewMode = UITextFieldViewModeAlways;
    [backView addSubview:self.inputTextField];
    
    //注册键盘显示通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //监听键盘sent点击
    self.inputTextField.delegate = self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self addMessage:textField.text type:MessageModelTypeMe];
    [self addMessage:[self autoReplayWith:textField.text] type:MessageModelTypeOther];
    NSIndexPath * path = [NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0];
    [self.mainTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    self.inputTextField.text = @"";
    return YES;
}

-(NSString *) autoReplayWith:(NSString *) content
{
    NSString *result = nil;
    for (int i = 0 ; i < content.length; i ++) {
        NSString *str = [content substringWithRange:NSMakeRange(i, 0)];
        result = self.autoResentDic[str];
        if (result != nil) {
            break;
        }
        else
        {
            result = [NSString stringWithFormat:@"%@好吧",content];
        }
    }
    return result;
}

-(void) addMessage:(NSString *) content type:(MessageModelType) type
{
    MessageModel *compareM = (MessageModel *)[[self.messages lastObject] message];
    
    //当前用户发送时间
    NSDate * date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    NSString *strDate = [formatter stringFromDate:date];
    
    
    //修改模型并且将模型保存数组
    MessageModel * message = [[MessageModel alloc] init];
    message.type = type;
    message.text = content;
    message.time = strDate;
    message.hiddenTime = [message.time isEqualToString:compareM.time];
    
    
    MessageFrameModel *mf = [[MessageFrameModel alloc] init];
    mf.message = message;
    
    [self.messages addObject:mf];
    //刷新表格
    [self.mainTableView reloadData];
}

-(void)keyBoardWillChange:(NSNotification *) notification
{
    //计算需要移动的距离
    NSDictionary *dict = notification.userInfo ;
    CGRect keyBoardFrame =  [[dict objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyBoardFrame.origin.y;
    CGFloat translationY = keyboardY - self.view.frame.size.height;
    //动画执行时间
    CGFloat time = [[dict objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //键盘弹出的节奏和view动画节奏一致:7 << 16
    [UIView animateKeyframesWithDuration:time delay:0.0 options:7 << 16 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, translationY);
    } completion:^(BOOL finished) {
        
    }];
    
}



-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell *cell = [MessageCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.messageFrame = self.messages[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageFrameModel *fm = [self.messages objectAtIndex:indexPath.row];
    return fm.cellHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
