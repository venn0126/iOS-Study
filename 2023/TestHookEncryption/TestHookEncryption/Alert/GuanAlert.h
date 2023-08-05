//
//  GuanAlert.h
//  TestHookEncryption
//
//  Created by Augus on 2023/8/4.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIAlertController+AddAction.h"

NS_ASSUME_NONNULL_BEGIN

@interface GuanAlert : NSObject

typedef void (^AlertConfirmHandle)(void);
typedef void (^AlertCancelHandle)(void);
typedef void (^AlertDestructiveHandle)(void);
typedef void (^AlertMarker)(UIAlertController *maker);


/**
 Quick to show Alert only with confirm and cancel
 when confirmTitle or cancelTitle equel nil, only show one action

 @param title - Alert's title
 @param message - any message you want to show
 @param confirmTitle - the title of confirm button (UIAlertActionStyleDefault)
 @param cancelTitle - the title of cancel button (UIAlertActionStyleCancel)
 @param preferredStyle -   UIAlertControllerStyle
 @param confirmHandle - confirm opeartion
 @param cancleHandle - cancel opeartion
 */
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              confirmTitle:(NSString *)confirmTitle
               cancelTitle:(NSString *)cancelTitle
            preferredStyle:(UIAlertControllerStyle)preferredStyle
             confirmHandle:(AlertConfirmHandle)confirmHandle
              cancleHandle:(AlertCancelHandle)cancleHandle;


/**
 Quick to show Alert from  three type of UIAlertActionStyle
 You can omit any one
 
 @param title - Alert's title
 @param message - any message you want to show
 @param confirmTitle - the title of confirm button (UIAlertActionStyleDefault)
 @param cancelTitle - the title of cancel button (UIAlertActionStyleCancel)
 @param destructiveTitle - the title of destructive button (UIAlertActionStyleDestructive)
 @param preferredStyle -   UIAlertControllerStyle
 @param confirmHandle - confirm opeartion
 @param cancleHandle - cancel opeartion
 */

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              confirmTitle:(NSString *)confirmTitle
               cancelTitle:(NSString *)cancelTitle
          destructiveTitle:(NSString *)destructiveTitle
            preferredStyle:(UIAlertControllerStyle)preferredStyle
             confirmHandle:(AlertConfirmHandle)confirmHandle
              cancleHandle:(AlertCancelHandle)cancleHandle
         destructiveHandle:(AlertDestructiveHandle)AlertdestructiveHandle;


/**
 Custom Alert built

 @param title - Alert's title
 @param message - any message you want to show
 @param preferredStyle -   UIAlertControllerStyle
 @param actionMaker - to add UIAlertAction by actionMaker
 */
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
            preferredStyle:(UIAlertControllerStyle)preferredStyle
               actionMaker:(AlertMarker)actionMaker;
/**
 Only show Alert Message and auto dismiss

 @param title - Alert's title
 @param message - any message you want to show
 @param preferredStyle - show style (ActionSheet / Alert)
 @param autoDismissTime alert will auto dismiss after autoDismissTime
 */
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
            preferredStyle:(UIAlertControllerStyle)preferredStyle
           autoDismissTime:(int)autoDismissTime;


@end

NS_ASSUME_NONNULL_END
