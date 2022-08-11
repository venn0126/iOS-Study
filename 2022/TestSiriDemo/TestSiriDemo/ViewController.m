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

@interface ViewController ()<INUIAddVoiceShortcutViewControllerDelegate, INUIEditVoiceShortcutViewControllerDelegate>

@property (nonatomic, strong) UIButton *addShortCutsButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    // 查看是否有权限进行操作
    [INPreferences requestSiriAuthorization:^(INSiriAuthorizationStatus status) {
        switch (status) {
            case INSiriAuthorizationStatusNotDetermined:
                //
                NSLog(@"用户尚未对该应用程序作出选择。");
                break;
            case INSiriAuthorizationStatusRestricted:
                NSLog(@"此应用程序无权使用Siri服务");
                break;
            case INSiriAuthorizationStatusDenied:
                NSLog(@"用户已明确拒绝此应用程序的授权");
                break;
            case INSiriAuthorizationStatusAuthorized:
                NSLog(@"用户可以使用此应用程序的授权");
                break;
            default:
                break;
        }
        
    }];
    
    
    [self.view addSubview:self.addShortCutsButton];
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
