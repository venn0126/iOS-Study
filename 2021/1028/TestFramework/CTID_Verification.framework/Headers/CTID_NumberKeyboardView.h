//
//  CTID_NumberKeyboardView.h
//  CtidVerifyCodeSDK
//
//  Created by vince on 2018/8/22.
//  Copyright © 2018年 yuw. All rights reserved.
//

#import <UIKit/UIKit.h>


/** CTNumberKeyboardType自定义键盘类型
 *  纯数字键盘:CTNumberKeyboardNumber
 *  身份证键盘:CTNumberKeyboardCertNo
 */

typedef NS_ENUM(NSInteger,CTNumberKeyboardType) {
    CTNumberKeyboardNumber = 0,
    CTNumberKeyboardCertNo = 1,
    CTNumberKeyboardOrderNo = 2
};

/** CTNumberKeyboardType键盘类型
 *
 *  系统默认键盘:CTKeyboardTypeDefault
 *  自定义键盘:CTKeyboardTypeNumber
 */
typedef NS_ENUM(NSInteger,CTKeyboardType) {
    CTKeyboardTypeDefault = 0,  // 系统默认键盘
    CTKeyboardTypeNumber = 1   // 自定义键盘
};


@protocol CTNumberKeyboardDelegate;

@interface CTID_NumberKeyboardView : UIView

@property (nonatomic, weak) id<CTNumberKeyboardDelegate> delegate;

- (void)createdKeyboard;

@end

@protocol CTNumberKeyboardDelegate <NSObject>

/** 点击删除按钮 */
- (BOOL)textFieldShouldDelete:(CTID_NumberKeyboardView *)numberKeyboard;

/** 点击键盘输入相应数字及特殊字符 */
- (void)numberKeyboard:(CTID_NumberKeyboardView *)numberKeyboard replacementString:(NSString *)string;
/** 获取键盘类型 */
- (CTNumberKeyboardType)numberKeyboardType:(CTID_NumberKeyboardView *)numberKeyboard;
/** 隐藏键盘 */
-(void)hideKeyBoard;
/** 选中按钮点击 */
-(void)selectBtnFinishClickBtn:(UIButton *)btn  superView:(CTID_NumberKeyboardView *)superView;
@end



