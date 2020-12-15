//
//  FSVoiceButton.h
//  fosFloatView
//
//  Created by Augus on 2020/11/10.
//

#import <UIKit/UIKit.h>




NS_ASSUME_NONNULL_BEGIN

@interface FSVoiceButton : UIButton

@property (nonatomic,strong) CALayer *backgroudLayer;

@property (nonatomic,strong) UIImage *norImage;
@property (nonatomic,strong) UIImage *selectedImage;


+ (instancetype)buttonWithBackImageNor:(NSString *)backImageNor backImageSelected:(NSString *)backImageSelected imageNor:(NSString *)imageNor imageSelected:(NSString *)imageSelected frame:(CGRect)frame isMicPhone:(BOOL)isMicPhone;

@end

NS_ASSUME_NONNULL_END
