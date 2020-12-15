//
//  MessageFrameModel.h
//  QQPage
//
//  Created by 李海群 on 2017/7/5.
//  Copyright © 2017年 李海群. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MessageModel.h"

#define HQTextFont [UIFont systemFontOfSize:15]
#define HQEdgeInsets 20

@interface MessageFrameModel : NSObject

/**
 数据模型
 */
@property (nonatomic, strong) MessageModel *message;

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
