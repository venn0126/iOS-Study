//
//  SNGradientLabel.h
//  CADisplayLinkTest
//
//  Created by Augus on 2022/5/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNGradientLabel : UILabel


/// The gradient layer high color,default is red
@property (nonatomic, strong) UIColor *highColor;

/// The gradient layer low color,default is green
@property (nonatomic, strong) UIColor *lowColor;


/// Default is (0,0) location is bottom left
@property (nonatomic, assign) CGPoint startPoint;

/// Default is (1,1) location is top right
@property (nonatomic, assign) CGPoint endPoint;

@end

NS_ASSUME_NONNULL_END
