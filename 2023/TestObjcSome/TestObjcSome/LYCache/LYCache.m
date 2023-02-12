//
//  LYCache.m
//  jianzhimao_enterprise
//
//  Created by 林liouly on 15/12/22.
//  Copyright © 2015年 joiway. All rights reserved.
//

#import "LYCache.h"
#import "LYCacheUtils.h"



static LYCache *_instance = nil;


@interface LYCache()

///缓存工具
@property (nonatomic,strong) NSCache *cache;

///缓存路径
@property (nonatomic,strong) NSString *ly_diskCachePath;

///文件管理器
@property (nonatomic,strong) NSFileManager *ly_fileManager;

///文件操作队列
@property (nonatomic,strong) dispatch_queue_t ly_fileQueue;

@end

@implementation LYCache

+(instancetype)shareInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _instance = [[LYCache alloc]init];
        [_instance initCache];
    });
    return _instance;
}

-(void)initCache
{
    self.cache = [[NSCache alloc] init];
    
    self.ly_fileQueue = dispatch_queue_create("com.cache.liouly", DISPATCH_QUEUE_CONCURRENT);
}

-(NSFileManager *)fileManager
{
    return [NSFileManager defaultManager];
}

///设置缓存容量
-(void)ly_setCacheTotalCostLimit:(NSInteger)totalCostLimit
{
    if (totalCostLimit<=0) {
        totalCostLimit = LY_CAPACITY_DEFAULT_CACHE_10M;
    }
    self.cache.totalCostLimit = totalCostLimit;
}

///设置缓存数量
-(void)ly_setCacheCountLimit:(NSInteger)countLimit
{
    self.cache.countLimit = countLimit;
}

///写入缓存数据
-(void)ly_write:(NSData *)data forKey:(NSString *)key
{
    [self ly_write:data forKey:key toDisk:YES];
}

///写入缓存数据
-(void)ly_write:(NSData *)data forKey:(NSString *)key toDisk:(BOOL)toDisk
{
#if DEBUG
    NSAssert(key, @"key不能为空");
#endif
    
    if (key) {
        
        ///将数据加到缓存里
        [self.cache setObject:data forKey:key];
        
        if (toDisk) {
            
            ///将数据写入文件保存
            NSString *filePath = [self ly_filePathForKey:[LYCacheUtils ly_md5:key accessory:MD5_ACCESSORY_STR_LYCACHE]];
            dispatch_async(self.ly_fileQueue, ^{
                
                NSString *cachePath = [self ly_diskCachePath];
                
                if(![self.fileManager fileExistsAtPath:cachePath]){
                    //下面是对该文件进行制定路径的保存
                    [self.fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
                    
                }
                
                BOOL flag = [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
                
                if (flag) {
                    
                LYLog(@"%@文件创建成功",filePath);
                    
                }else{
                    
                    LYLog(@"%@文件创建失败",filePath);
                    
                }
                
            });
            
        }
        
    }
}

///磁盘缓存路径
-(NSString *)ly_diskCachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    
    NSString *cachePath = [NSString stringWithFormat:@"%@%@",cachesDir,NAME_PATH_CACHE];
    
    return cachePath;
}

///缓存文件路径
-(NSString *)ly_filePathForKey:(NSString *)key
{
    NSString *cachesDir = [self ly_diskCachePath];
    
    NSString *cachePath = [NSString stringWithFormat:@"%@/%@",cachesDir,key];
    
    return cachePath;
}

///读取缓存数据
-(NSData *)ly_readForKey:(NSString *)key
{
    return [self ly_readForKey:key fromDisk:YES];
}

///读取缓存数据
-(NSData *)ly_readForKey:(NSString *)key fromDisk:(BOOL)fromDisk
{
    
#if DEBUG
    NSAssert(key, @"key不能为空");
#endif
    
    NSData *data = nil;
    
    if (key) {
        
        ///先尝试从缓存中获取，没有再从文件获取，然后再把文件里的数据，赋值给缓存
        data = [self.cache objectForKey:key];
        
        if (fromDisk) {
            
            if (!data) {
                
                NSString *filePath = [self ly_filePathForKey:[LYCacheUtils ly_md5:key accessory:MD5_ACCESSORY_STR_LYCACHE]];
                
                data = [[NSFileManager defaultManager] contentsAtPath:filePath];
                
                if (data) {
                    
                    [self.cache setObject:data forKey:key];
                    
                }
                
            }
            
        }
        
    }
    
    

    return data;
}

///移除缓存数据
-(void)ly_removeCacheForKey:(NSString *)key fromDisk:(BOOL)fromDisk
{
    ///移除缓存数据
    [self.cache removeObjectForKey:key];
    
    if (fromDisk) {
        
        ///移除本地数据
        NSError *error = nil;
        NSString *filePath = [self ly_filePathForKey:key];
        
        if ([self.fileManager fileExistsAtPath:filePath]) {
            
            [self.fileManager removeItemAtPath:filePath error:&error];
            
            if (error) {
                [self logError:error];
            }
            
        }
        
    }
    
}

///清除所有数据
-(void)ly_cleanAllCache
{
    [self ly_clearMemoryCache];
    [self ly_clearDisk];
}

///清除所有内存缓存数据
-(void)ly_clearMemoryCache
{
    ///移除缓存数据
    [self.cache removeAllObjects];

}

///清除所有本地缓存数据
- (void)ly_clearDisk
{
    ///移除本地数据
    NSError *error = nil;
    NSString *diskCachePath = [self ly_diskCachePath];
    [self.fileManager removeItemAtPath:diskCachePath error:&error];
    
    if (error) {
        [self logError:error];
    }
}

///本地缓存容量大小
-(NSUInteger)ly_diskCacheCapacity
{
    __block NSUInteger size = 0;
    dispatch_sync(self.ly_fileQueue, ^{
        NSDirectoryEnumerator *fileEnumerator = [self.ly_fileManager enumeratorAtPath:self.ly_diskCachePath];
        for (NSString *fileName in fileEnumerator) {
            NSString *filePath = [self.ly_diskCachePath stringByAppendingPathComponent:fileName];
            NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
            size += [attrs fileSize];
        }
    });
    return size;
}

-(void)logError:(NSError *)error
{
    LYLog(@"操作错误，error:%@",error);
}

@end
