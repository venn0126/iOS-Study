//
//  ViewController.m
//  TestSiriDemo
//
//  Created by Augus on 2022/8/11.
//

#import "ViewController.h"
#import "HotListIntent.h"
#import "Intents/Intents.h"
#import <IntentsUI/IntentsUI.h>
//#import "SNPlayNewsIntent.h"

@interface ViewController ()<INUIAddVoiceShortcutViewControllerDelegate, INUIEditVoiceShortcutViewControllerDelegate>

@property (nonatomic, strong) UIButton *addShortCutsButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.addShortCutsButton];
    
//    [self donatedUserActivity];
    
    [self donateIntents];
}


- (void)donatedUserActivity {
    
    NSUserActivity* userActivity = [[NSUserActivity alloc] initWithActivityType:@"SNSportIntent"];
    userActivity.title = [NSString stringWithFormat:@"我要打开%@", @"体育频道"];
    userActivity.suggestedInvocationPhrase = @"我要打开体育频道";
    userActivity.eligibleForPrediction = YES;
    userActivity.requiredUserInfoKeys = [NSSet setWithArray:userActivity.userInfo.allKeys];
    self.userActivity = userActivity; // Calls becomeCurrent/resignCurrent for us...
    [self.userActivity resignCurrent];

}

- (void)donateIntents {
    
//    INStartWorkoutIntent *intent = [[INStartWorkoutIntent alloc] init];
//    intent.suggestedInvocationPhrase = @"测试打开财经新闻频道";
//
//
//    INInteraction *interaction = [[INInteraction alloc] initWithIntent:intent response:nil];
    
//    [INInteraction deleteInteractionsWithGroupIdentifier:@"SNSportsIntent" completion:^(NSError * _Nullable error) {
//
//        if (error) {
//            NSLog(@"我要打开体育新闻 捐赠删除失败");
//            return;
//        }
//        NSLog(@"我要打开体育新闻 捐赠删除成功");
//
//    }];
    
//    [interaction donateInteractionWithCompletion:^(NSError * _Nullable error) {
//
//        if (error) {
//            NSLog(@"测试打开财经新闻 捐赠失败");
//            return;
//        }
//        NSLog(@"测试财经新闻 捐赠成功");
//    }];
    
    
//    INPlayMediaIntent *playIntent = [[INPlayMediaIntent alloc] init];
//    playIntent.suggestedInvocationPhrase = @"搜狐消息播放热门视频";
//
//    INInteraction *interaction = [[INInteraction alloc] initWithIntent:playIntent response:nil];
//    if (interaction) {
//        [interaction donateInteractionWithCompletion:^(NSError * _Nullable error) {
//            if (error) {
//                 NSLog(@"测试捷径搜索 捐赠失败");
//                 return;
//             }
//             NSLog(@"测试捷径搜索 捐赠成功");
//        }];
//    }
    
    
    NSArray *playChannelNames = @[@"今日新闻",@"真人播报",@"热榜"];
    NSString *url = nil;
    NSString *title = @"今月心闻";
    
    NSString *item = nil;
    NSString *channelName = nil;
    BOOL isEnd = NO;
    
    for (int i = 0; i < title.length; i++) {
        if (isEnd) {
            break;
        }
        isEnd = NO;
        item = [title substringWithRange:NSMakeRange(i, 1)];
        NSLog(@"内侧 %@",item);
        for (int i = 0; i < playChannelNames.count; i++) {
            NSLog(@"外侧 %ld",(long)i);
            channelName = playChannelNames[i];
            if ([channelName rangeOfString:item].location != NSNotFound) {
                if (i == 0) {
                    url = @"0";
                } else if(i == 1) {
                    url = @"1";
                }else {
                    url = @"2";
                }
                isEnd = YES;
                break;
            }
        }
    }
    
    NSLog(@"url %@",url);
}


- (void)updateUserActivityState:(NSUserActivity *)activity {
    
//    [activity addUserInfoEntriesFromDictionary:nil];
}


- (void)addHotListActivity {
    
    // 根据infoPlist中的NSUserActivityTypes 数组中的字段进行添加
    NSUserActivity *hotListActivity = [[NSUserActivity alloc] initWithActivityType:@"HotListIntent"];
    
    // 设置YES，通过系统的搜索，可以搜索到该activity
    hotListActivity.eligibleForSearch = YES;
    
    // 允许系统预测用户行为，并在合适的时候给出提醒（搜索界面，锁屏界面）
    if(@available(iOS 12.0, *)) {
        hotListActivity.eligibleForPrediction = YES;
    }
    
    hotListActivity.title = @"打开搜狐热榜";
    
    // 引导用户新建语音引导
    if (@available(iOS 12, *)) {
        hotListActivity.suggestedInvocationPhrase = @"新闻热榜";
    }
    
    INShortcut *shortCuts = [[INShortcut alloc] initWithUserActivity:hotListActivity];
    INUIAddVoiceShortcutViewController *vc = [[INUIAddVoiceShortcutViewController alloc] initWithShortcut:shortCuts];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:^{
       
        NSLog(@"跳转添加新闻热榜成功");
    }];
    
    
}


- (void)buildShortcuts {
    
    HotListIntent *intent = [[HotListIntent alloc] init];
    intent.inputValue = @"augus";
    intent.storeKey = @"name";
    
    INInteraction *action = [[INInteraction alloc] initWithIntent:intent response:nil];
    [action donateInteractionWithCompletion:^(NSError * _Nullable error) {
       
        if (error) {
            NSLog(@"donate error %@",error);
            return;
        }
        
        NSLog(@"donate success");
    }];
    
    
    // 开启siri权限
    
    // 系统版本要求
    
    if(@available(iOS 12.0, *)) {
        
        [[INVoiceShortcutCenter sharedCenter] getAllVoiceShortcutsWithCompletion:^(NSArray<INVoiceShortcut *> * _Nullable voiceShortcuts, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"getAllVoiceShortcutsWithCompletion error %@",error);
                return;
            }
           
            dispatch_async(dispatch_get_main_queue(), ^{
               
                
                BOOL addShortcuts = NO;
                for (INVoiceShortcut *shortCuts in voiceShortcuts) {
                    NSLog(@"voiceShortcut.identifier = %@",shortCuts.identifier);
                    NSLog(@"voiceShortcut.invocationPhrase = %@",shortCuts.invocationPhrase);
                    NSLog(@"voiceShortcut.shortcut = %@",shortCuts.shortcut.userActivity.title);
                    NSLog(@"voiceShortcut.shortcut = %@",shortCuts.shortcut.userActivity.userInfo);
                    
                    if ([shortCuts.shortcut.intent isKindOfClass:[HotListIntent class]]) {
                        addShortcuts = YES;
                    }
                }
                
                if (addShortcuts) {
                    
                    INUIEditVoiceShortcutViewController *editVoiceShortcutViewController = [[INUIEditVoiceShortcutViewController alloc] initWithVoiceShortcut:voiceShortcuts[0]];
                    editVoiceShortcutViewController.delegate = self;
                    [self presentViewController:editVoiceShortcutViewController animated:YES completion:nil];
                } else {
                    INShortcut *shortCut = [[INShortcut alloc] initWithIntent:intent];
                    
                    INUIAddVoiceShortcutViewController *addVoiceVC = [[INUIAddVoiceShortcutViewController alloc] initWithShortcut:shortCut];
                    addVoiceVC.delegate = self;
                    [self presentViewController:addVoiceVC animated:YES completion:nil];
                }
                
                
            });
        }];
        
    } else {
        NSLog(@"iOS system not suppport");
    }
}


#pragma mark - INUIAddVoiceShortcutViewControllerDelegate


-(void)addVoiceShortcutViewControllerDidCancel:(INUIAddVoiceShortcutViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)addVoiceShortcutViewController:(INUIAddVoiceShortcutViewController *)controller didFinishWithVoiceShortcut:(INVoiceShortcut *)voiceShortcut error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}
 

#pragma mark - INUIEditVoiceShortcutViewControllerDelegate

- (void)editVoiceShortcutViewController:(INUIEditVoiceShortcutViewController *)controller didUpdateVoiceShortcut:(nullable INVoiceShortcut *)voiceShortcut error:(nullable NSError *)error{
    
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)editVoiceShortcutViewController:(INUIEditVoiceShortcutViewController *)controller didDeleteVoiceShortcutWithIdentifier:(NSUUID *)deletedVoiceShortcutIdentifier{
    
    [controller dismissViewControllerAnimated:YES completion:nil];

}
 

- (void)editVoiceShortcutViewControllerDidCancel:(INUIEditVoiceShortcutViewController *)controller{
    
    [controller dismissViewControllerAnimated:YES completion:nil];

}


#pragma mark - Lazy Load

- (UIButton *)addShortCutsButton {
    if (!_addShortCutsButton) {
        _addShortCutsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addShortCutsButton setTitle:@"添加捷径" forState:UIControlStateNormal];
//        [_addShortCutsButton addTarget:self action:@selector(buildShortcuts) forControlEvents:UIControlEventTouchUpInside];
                [_addShortCutsButton addTarget:self action:@selector(addHotListActivity) forControlEvents:UIControlEventTouchUpInside];

        _addShortCutsButton.frame = CGRectMake(100, 100, 100, 50);
        _addShortCutsButton.backgroundColor = UIColor.greenColor;
        [_addShortCutsButton sizeToFit];
    }
    return _addShortCutsButton;
}

@end
