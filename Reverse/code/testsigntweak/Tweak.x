#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ViewController

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion;

@end


%hook ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 调用原来的逻辑
    %orig;

    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"这是一个提示框" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}


%end