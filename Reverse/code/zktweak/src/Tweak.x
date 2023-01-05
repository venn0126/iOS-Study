#import "GTHomeAdClearController.h"


/// 去除zk助手的广告，只作为学习交流，请勿商用


/// HomeViewController的前置声明
// @interface HomeViewController

// - (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion;

// @end


/// GDTMaskViewController的前置声明
@interface GDTMaskViewController

// - (void)dismissViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion;

@end


%hook GDTMaskViewController

/// 用于测试代码
// - (void)viewDidLoad {

// 	%orig;

// 	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CGFLOAT_MIN * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//         [self dismissViewControllerAnimated:NO completion:nil];
//     });
// }

- (id)init {
	GTHomeAdClearController *vc = [[GTHomeAdClearController alloc] init];
	NSLog(@"Tian is my wife init");
	return (GDTMaskViewController *)vc;
}


%end


// %hook HomeViewController

// - (void)viewDidLoad {

// 	%orig;
// 	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//         UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"这是一个弹窗" preferredStyle:UIAlertControllerStyleAlert];
//         UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
//         [alertVC addAction:action];
//         [self presentViewController:alertVC animated:NO completion:nil];
//     });
    
// }

// %end

