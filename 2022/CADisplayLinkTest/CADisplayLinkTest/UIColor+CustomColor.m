//
//  UIColor+CustomColor.m
//  CADisplayLinkTest
//
//  Created by Augus on 2022/4/12.
//

#import "UIColor+CustomColor.h"

@implementation UIColor (CustomColor)

+ (UIColor *)BG1 {
    return [self fitColorSetName:@"BG1" orColor:UIColor.whiteColor];
}



/// Set color by different iOS versions
/// @param colorName a color name
/// @param color a Color not support method '[UIColor colorNamed:'
+ (UIColor *)fitColorSetName:(NSString *)colorName orColor:(UIColor *)color{
    
    if(@available(iOS 11.0, *)) {
        return [UIColor colorNamed:colorName];
    }else{
        return color;
    }
}

@end
