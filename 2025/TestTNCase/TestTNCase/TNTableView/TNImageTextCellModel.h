//
//  TNImageTextCellModel.h
//  TestHookEncryption
//
//  Created by Augus on 2025/5/7.
//

#import "TNTextCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TNImageTextCellModel : TNTextCellModel

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, assign) CGFloat imageSpacing;
@property (nonatomic, assign) BOOL imageOnLeft; // 图片位置，YES为左侧，NO为右侧

@end

NS_ASSUME_NONNULL_END
