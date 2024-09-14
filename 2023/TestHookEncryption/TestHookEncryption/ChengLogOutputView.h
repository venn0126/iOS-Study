//
//  ChengLogOutputView.h
//  TestHookEncryption
//
//  Created by Augus Venn on 2024/9/13.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

@interface ChengLogOutputView : UIView

- (void)guan_appendLog:(NSString *)log;

- (void)guan_clearLog;

@end

NS_ASSUME_NONNULL_END
