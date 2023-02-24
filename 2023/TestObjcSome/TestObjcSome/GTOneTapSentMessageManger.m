//
//  GTOneTapSentMessageManger.m
//  TestObjcSome
//
//  Created by Augus on 2023/2/15.
//

#import "GTOneTapSentMessageManger.h"
#import "GTControllableCThread.h"

@interface GTOneTapSentMessageManger ()

@property (nonatomic, strong) NSTimer *augusTimer;
@property (nonatomic, strong) GTControllableCThread *augusThread;

@end

@implementation GTOneTapSentMessageManger

+ (instancetype)sharedInstance {
    
    
    static GTOneTapSentMessageManger *manger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[GTOneTapSentMessageManger alloc] init];
    });
    
    return manger;
}

- (void)gt_fetchConversationIdForSnapchatter:(GTOneTapSentMessageBlock)completion {
    
    if(!completion) return;
    if([GTOneTapSentMessageManger sharedInstance].sections.count != 28) return;
    
    /*
     
     // -[SCChatConversationDataCoordinator _fetchConversationIdAndMetadataForSnapchatter:(SCSnapchatter *)completion:(void(^)(_Bool, NSString *, SCChatActiveConversationMetadata *))]
     
     
     [#0x110c33860 _fetchConversationIdAndMetadataForSnapchatter:#0x282ece250 completion: ^void(BOOL isSuccess, NSString *str, SCChatActiveConversationMetadata *data) { array.push(str) }]
     
     
     
     
     
     */
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });

    
}

- (void)gt_startTimerWithTimeInterval:(NSTimeInterval)interval block:(void (NS_SWIFT_SENDABLE ^)(NSTimer *timer))block {

    if(!self.augusThread) {
        self.augusThread = [[GTControllableCThread alloc] init];
    }
    [self.augusThread gt_cexecuteTask:^{
        if(!self->_augusTimer) {
            self->_augusTimer = [NSTimer timerWithTimeInterval:interval repeats:YES block:block];
            [[NSRunLoop currentRunLoop] addTimer:self->_augusTimer forMode:NSDefaultRunLoopMode];
        }
    }];
}



- (void)gt_stopTimer {
    
    [_augusTimer invalidate];
    _augusTimer = nil;

}


#pragma mark - Some File Methods

+ (NSString *)gt_DocumentPath {
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


+ (NSString *)gt_CachePath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];;
}


+ (NSString *)gt_LibraryPath {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];;
}


+ (NSString *)gt_TempPath {
    return NSTemporaryDirectory();
}


+ (CGFloat)gt_folderSizeAtPath:(NSString *)folderPath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString *fileName;
    CGFloat folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize / (1024.0 * 1024.0);
}


+ (CGFloat)fileSizeAtPath:(NSString *)filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}


+ (void)gt_clearCaches:(NSString *)cachePath {
    
    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath:cachePath];
    //读取缓存大小
    CGFloat cacheSize = [self gt_folderSizeAtPath:cachePath] ;
    NSLog(@"augus 缓存大小:%.2fKB",cacheSize);
    for ( NSString * p in files) {
        NSError * error = nil ;
        //获取文件全路径
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent:p];
        
        if ([[NSFileManager defaultManager ] fileExistsAtPath:fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath:fileAbsolutePath error:&error];
        }
    }
}


+ (void)gt_clearAllCaches {
    
    [self gt_clearCaches:[self gt_DocumentPath]];
    [self gt_clearCaches:[self gt_LibraryPath]];
    [self gt_clearCaches:[self gt_CachePath]];
    [self gt_clearCaches:[self gt_TempPath]];

}

@end
