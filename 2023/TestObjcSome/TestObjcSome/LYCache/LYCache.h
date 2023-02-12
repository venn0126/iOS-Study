//
//  LYCache.h
//  jianzhimao_enterprise
//
//  Created by 林liouly on 15/12/22.
//  Copyright © 2015年 joiway. All rights reserved.
//
/**
 *  @author joiway_liouly
 *
 *  @brief  HTTP缓存工具类
 */

#import <Foundation/Foundation.h>
#import "LYCacheDefine.h"


@interface LYCache : NSObject

+(instancetype)shareInstance;

///设置缓存容量
-(void)ly_setCacheTotalCostLimit:(NSInteger)totalCostLimit;

///设置缓存数量
-(void)ly_setCacheCountLimit:(NSInteger)countLimit;

///磁盘缓存路径
-(NSString *)ly_diskCachePath;

///本地缓存容量大小
-(NSUInteger)ly_diskCacheCapacity;

///写入缓存数据
-(void)ly_write:(NSData *)data forKey:(NSString *)key;

///写入缓存数据
-(void)ly_write:(NSData *)data forKey:(NSString *)key toDisk:(BOOL)toDisk;

///读取缓存数据
-(NSData *)ly_readForKey:(NSString *)key;

///读取缓存数据
-(NSData *)ly_readForKey:(NSString *)key fromDisk:(BOOL)fromDisk;

///移除缓存数据
-(void)ly_removeCacheForKey:(NSString *)key fromDisk:(BOOL)fromDisk;

///清除所有数据
-(void)ly_cleanAllCache;

///清除所有内存缓存数据
-(void)ly_clearMemoryCache;

///清除所有本地缓存数据
- (void)ly_clearDisk;


@end
