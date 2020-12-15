//
//  FSMessageModel.h
//  fosFloatView
//
//  Created by Augus on 2020/11/11.
//

#import <Foundation/Foundation.h>
#import "FSGlobal.h"

typedef NS_ENUM(NSInteger,FSMessageModelType){
    FSMessageModelTypeMe,
    FSMessageModelTypeOther,
    FSMessageModelTypeSpace
};


NS_ASSUME_NONNULL_BEGIN

@interface FSMessageModel : NSObject

/**
 正文
 */
@property (nonatomic, copy) NSString *text;

/**
 时间
 */
@property (nonatomic, copy) NSString *time;

/**
 消息类型
 */
@property (nonatomic, assign) FSMessageModelType type;

/**
 是否显示时间
 */
@property (nonatomic, assign) BOOL hiddenTime;

FSModelInit(FSMessageModel)

@end

NS_ASSUME_NONNULL_END
