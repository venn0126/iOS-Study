//
//  FSMessageFrameModel.h
//  fosFloatView
//
//  Created by Augus on 2020/11/11.
//

#import <Foundation/Foundation.h>
#import "FSMessageModel.h"


#define FSTextFont [UIFont systemFontOfSize:15]
#define FSEdgeInsets 20

NS_ASSUME_NONNULL_BEGIN

@interface FSMessageFrameModel : NSObject

/**
 数据模型
 */
@property (nonatomic, strong) FSMessageModel *message;

/**
 时间frame
 */
@property (nonatomic, assign) CGRect timeF;

/**
 头像frame
 */
@property (nonatomic, assign) CGRect iconF;


/**
 正文frame
 */
@property (nonatomic, assign) CGRect textF;

/**
 cell的高度
 */
@property (nonatomic, assign) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
