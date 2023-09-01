//
//  GuanTestWebController.h
//  TestHookEncryption
//
//  Created by Augus on 2023/8/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GuanTestWebController : UIViewController

/// 通过一个地址字符串初始化视图控制器
/// - Parameter aString: 地址字符串
- (instancetype)initWithURLString:(NSString *)aString;

@end

NS_ASSUME_NONNULL_END
