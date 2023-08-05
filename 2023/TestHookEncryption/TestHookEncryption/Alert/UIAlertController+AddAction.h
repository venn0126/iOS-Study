//
//  UIAlertController+AddAction.h
//  TestHookEncryption
//
//  Created by Augus on 2023/8/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^TextFiledHanler)(NSString * _Nullable text);


@interface UIAlertController (AddAction)

/**
 to add UIAlertAction with UIAlertActionStyleDefault

 @param title - the title of UIAlertAction
 @param handler - to handle your business
 */
- (void)addAlertDefaultActionWithTitle:(NSString *_Nullable)title
                               handler:(void (^_Nullable)(UIAlertAction * _Nullable  action))handler;


/**
 to add UIAlertAction with Custom Style


 @param title - the title of UIAlertAction
 @param actionStyle - to chose UIAlertActionStyle
 @param handler - to handle your business
 */
- (void)addAlertActionWithTitle:(NSString *_Nullable)title
                    actionStyle:(UIAlertActionStyle)actionStyle
                        handler:(void (^ __nullable)(UIAlertAction * _Nullable action))handler;


/**
 to add TextField in your alert , callback the  text which  you input
 it only support in Alert Styple

 @param placeholder - set TextField's placeholder
 @param secureTextEntry - set Secure input Mode
 @param textHandler - to get text which  you input
 */
- (void)addTextFieldWithPlaceholder:(NSString *_Nullable)placeholder
                    secureTextEntry:(BOOL)secureTextEntry
                            textHandler:(TextFiledHanler _Nullable )textHandler;


/**
 to add TextField in your alert, callback the  textFiled which  you built
 it only support in Alert Styple

 @param placeholder - set TextField's placeholder
 @param secureTextEntry - set Secure input Mode
 @param textFiledhandler - to handle textField which you can do anything
 */
- (void)addTextFieldWithPlaceholder:(NSString *_Nullable)placeholder
                    secureTextEntry:(BOOL)secureTextEntry
                   textFiledhandler:(void(^_Nullable)(UITextField * _Nonnull textField))textFiledhandler;

@end

NS_ASSUME_NONNULL_END
