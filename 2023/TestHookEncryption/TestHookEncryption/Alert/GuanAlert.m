//
//  GuanAlert.m
//  TestHookEncryption
//
//  Created by Augus on 2023/8/4.
//

#import "GuanAlert.h"

@implementation GuanAlert

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              confirmTitle:(NSString *)confirmTitle
               cancelTitle:(NSString *)cancelTitle
            preferredStyle:(UIAlertControllerStyle)preferredStyle
             confirmHandle:(AlertConfirmHandle)confirmHandle
              cancleHandle:(AlertCancelHandle)cancleHandle {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title
                                                                     message:message
                                                              preferredStyle: preferredStyle];
    
    if (cancelTitle != nil) {
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancelTitle
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 if (cancleHandle) {
                                                                     cancleHandle();
                                                                 }
                                                             }];
        [alertVC addAction:cancleAction];
    }
    


    if (confirmTitle != nil) {
        UIAlertAction *confirAction = [UIAlertAction actionWithTitle:confirmTitle
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 if (confirmHandle) {
                                                                     confirmHandle();
                                                                 }
                                                             }];
        [alertVC addAction:confirAction];
    }

     [[GuanAlert currentViewController] presentViewController:alertVC animated:YES completion: nil];
}


+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              confirmTitle:(NSString *)confirmTitle
               cancelTitle:(NSString *)cancelTitle
            preferredStyle:(UIAlertControllerStyle)preferredStyle
             confirmHandle:(AlertConfirmHandle)confirmHandle
              cancleHandle:(AlertCancelHandle)cancleHandle
   isNeedOneInputTextField:(BOOL)isNeedOneInputTextField
OneInputTextFieldPlaceHolder:(NSString *)OneInputTextFieldPlaceHolder
    confirmTextFieldHandle:(AlertConfirmWithTextFieldHandle)confirmTextFieldHandle {
    
    [self showAlertWithTitle:title message:message confirmTitle:confirmTitle cancelTitle:cancelTitle preferredStyle:preferredStyle confirmHandle:confirmHandle cancleHandle:cancleHandle isNeedOneInputTextField:isNeedOneInputTextField textFieldPlaceHolder:OneInputTextFieldPlaceHolder textFieldKeyboardType:UIKeyboardTypeDefault confirmTextFieldHandle:confirmTextFieldHandle];
}


+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              confirmTitle:(NSString *)confirmTitle
               cancelTitle:(NSString *)cancelTitle
            preferredStyle:(UIAlertControllerStyle)preferredStyle
             confirmHandle:(_Nullable AlertConfirmHandle)confirmHandle
              cancleHandle:(AlertCancelHandle)cancleHandle
   isNeedOneInputTextField:(BOOL)isNeedOneInputTextField
      textFieldPlaceHolder:(NSString *)textFieldPlaceHolder
     textFieldKeyboardType:(UIKeyboardType)keyboardType
    confirmTextFieldHandle:(AlertConfirmWithTextFieldHandle)confirmTextFieldHandle {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title
                                                                     message:message
                                                              preferredStyle:preferredStyle];
    
    if (cancelTitle != nil) {
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancelTitle
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * _Nonnull action) {
            if (cancleHandle) {
                cancleHandle();
            }
        }];
        [alertVC addAction:cancleAction];
    }
    

    if (confirmTitle != nil) {
        UIAlertAction *confirAction = [UIAlertAction actionWithTitle:confirmTitle
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
            if(isNeedOneInputTextField) {
                if(confirmTextFieldHandle) {
                    NSArray<UITextField *> *array = alertVC.textFields;
                    UITextField *firstTextField = array.firstObject;
                    confirmTextFieldHandle(firstTextField.text);
                } else {
                    if (confirmHandle) {
                        confirmHandle();
                    }
                }
            }
        }];
        [alertVC addAction:confirAction];
    }
    
    
    if(isNeedOneInputTextField) {
        [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = textFieldPlaceHolder;
            textField.keyboardType = keyboardType;
        }];
    }

     [[GuanAlert currentViewController] presentViewController:alertVC animated:YES completion: nil];
    
}



+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              confirmTitle:(NSString *)confirmTitle
               cancelTitle:(NSString *)cancelTitle
          destructiveTitle:(NSString *)destructiveTitle
            preferredStyle:(UIAlertControllerStyle)preferredStyle
             confirmHandle:(AlertConfirmHandle)confirmHandle
              cancleHandle:(AlertCancelHandle)cancleHandle
         destructiveHandle:(AlertDestructiveHandle)AlertdestructiveHandle {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title
                                                                     message:message
                                                              preferredStyle: preferredStyle];
    
    if (cancelTitle != nil) {
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancelTitle
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 if (cancleHandle) {
                                                                     cancleHandle();
                                                                 }
                                                             }];
        [alertVC addAction:cancleAction];
    }
    
    
    
    if (confirmTitle != nil) {
        UIAlertAction *confirAction = [UIAlertAction actionWithTitle:confirmTitle
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 if (confirmHandle) {
                                                                     confirmHandle();
                                                                 }
                                                             }];
        [alertVC addAction:confirAction];
    }
    
    if (destructiveTitle != nil) {
        UIAlertAction *confirAction = [UIAlertAction actionWithTitle:destructiveTitle
                                                               style:UIAlertActionStyleDestructive
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 if (confirmHandle) {
                                                                     confirmHandle();
                                                                 }
                                                             }];
        [alertVC addAction:confirAction];
    }
    
    [[GuanAlert currentViewController] presentViewController:alertVC animated:YES completion: nil];
}

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
            preferredStyle:(UIAlertControllerStyle)preferredStyle
               actionMaker:(AlertMarker)actionMaker {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title
                                                                     message:message
                                                              preferredStyle: preferredStyle];
    __weak typeof(alertVC) weakAlert = alertVC;
    if (actionMaker) {
        actionMaker(weakAlert);
    }
    
    [[GuanAlert currentViewController] presentViewController:alertVC animated:YES completion:^{
        if (actionMaker == nil || alertVC.actions.count <= 0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakAlert dismissViewControllerAnimated:YES completion:nil];
            });
        }
    }];}


+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
            preferredStyle:(UIAlertControllerStyle)preferredStyle
           autoDismissTime:(int)autoDismissTime {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title
                                                                     message:message
                                                              preferredStyle: preferredStyle];
    __weak typeof(alertVC) weakAlert = alertVC;
    [[GuanAlert currentViewController] presentViewController:alertVC animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(autoDismissTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakAlert dismissViewControllerAnimated:YES completion:nil];
            });
    }];
}



// find currentViewController

+ (UIWindow *)keyWindow {
    UIWindow *keyWindow;
    if (@available(iOS 13, *)) {
        NSSet *scenes = [UIApplication sharedApplication].connectedScenes;
        for (UIWindowScene *windowScene in scenes) {
            if(windowScene.activationState == UISceneActivationStateForegroundActive) {
                for (UIWindow *window in windowScene.windows) {
                    if(window.isKeyWindow) {
                        keyWindow = window;
                    }
                }
            }
        }
    } else {
        keyWindow = [UIApplication sharedApplication].keyWindow;
    }
    return keyWindow;
}

+ (UIViewController *)currentViewController
{
    UIViewController *resultVC;
    resultVC = [self topViewController:[[self keyWindow] rootViewController]];
    while (resultVC.presentedViewController)
    {
        resultVC = [self topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}


+ (UIViewController *)topViewController:(UIViewController *)vc
{
    if ([vc isKindOfClass:[UINavigationController class]])
    {
        return [self topViewController:[(UINavigationController *)vc topViewController]];
    }
    else if ([vc isKindOfClass:[UITabBarController class]])
    {
        return [self topViewController:[(UITabBarController *)vc selectedViewController]];
    }
    else
    {
        return vc;
    }
    return nil;
}


@end
