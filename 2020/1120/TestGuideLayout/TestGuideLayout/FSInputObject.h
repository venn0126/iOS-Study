//
//  FSInputObject.h
//  TestGuideLayout
//
//  Created by Augus on 2021/1/19.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString * kInputObjectTextDidChangeNotification;

@interface FSInputObject : UIView<UIKeyInput>

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIView *inputAccessoryView;



@end

NS_ASSUME_NONNULL_END
