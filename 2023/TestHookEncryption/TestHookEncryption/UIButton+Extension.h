//
//  UIButton+Extension.h
//  TestHookEncryption
//
//  Created by Augus on 2023/8/31.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GTButtonEdgeInsetsStyle) {
    /// image在上，label在下
    GTButtonEdgeInsetsStyleTop,
    /// image在左，label在右
    GTButtonEdgeInsetsStyleLeft,
    /// image在下，label在上
    GTButtonEdgeInsetsStyleBottom,
    /// image在右，label在左
    GTButtonEdgeInsetsStyleRight
};


NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Extension)


/// 设置button的titleLabel和imageView的布局样式，及间距
/// - Parameters:
///   - style: titleLabel和imageView的布局样式
///   - space: titleLabel和imageView的间距
- (void)layoutButtonWithEdgeInsetsStyle:(GTButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;


@end

NS_ASSUME_NONNULL_END
