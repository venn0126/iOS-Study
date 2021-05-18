//
//  ThreeController.m
//  DDDemo
//
//  Created by Augus on 2021/5/16.
//

#import "ThreeController.h"
#import "DDTabBarController.h"


@interface ThreeController ()

@end

@implementation ThreeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Detail";
    self.view.backgroundColor = UIColor.whiteColor;
    [self someUI];
    
}

- (void)someUI {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"update" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [button setBackgroundColor:UIColor.redColor];
    [button addTarget:self action:@selector(updateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(100, 300, 100, 50);
    [self.view addSubview:button];
    
    
}

- (void)updateButtonAction:(UIButton *)sender {
    
    NSLog(@"update icon");
    
    UIWindow *window = nil;
    if (@available(iOS 13.0,*)) {
        NSSet *scenes = [[UIApplication sharedApplication] connectedScenes];
        for (UIWindowScene *scene in scenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive) {
                for (UIWindow *w in scene.windows) {
                    if (w.isKeyWindow) {
                        window = w;
                        break;
                    }
                }
            }
        }
        
        DDTabBarController *vc = (DDTabBarController *)window.rootViewController;
        [vc dd_updateTabBarIcon:^{
            
            NSLog(@"update success");
            
        }];
        
    } else {
        
        window = [[UIApplication sharedApplication] keyWindow];
        DDTabBarController *vc = (DDTabBarController *)window.rootViewController;
        [vc dd_updateTabBarIcon:^{

            NSLog(@"update success");

        }];
    }

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
