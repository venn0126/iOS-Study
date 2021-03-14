//
//  SomeSDWebImage.m
//  YPYDemo
//
//  Created by Augus on 2021/3/6.
//

#import "SomeSDWebImage.h"


@interface SomeSDWebImage ()

//@property (nonatomic, copy) NSString *name;


@end

@implementation SomeSDWebImage

//- (instancetype)init {
//    return [self initWithName:nil];
//}

- (instancetype)init {
    NSAssert(false, @"unavaiable, use initWithName");
    return nil;
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _firstName = name;
    return self;
}

#pragma mark - Setter & Getter


//- (void)setFirstName:(NSString *)firstName {
//    _firstName = firstName;
//}

//- (NSString *)firstName {
//    return _firstName;
//}

/**
 @brief
 SDWebImage 源码解析
 
 
 
 1.UIImageView+WebCache,UIButton+Webcache;UIView+WebCache
 
 2.SDWebImageManger
 
 3.SDWebImageDownloader,SDWebImageDownloaderOperation
 
 4.SDWebImageDecoder,SDWebImageCompat
 
 从上倒下进行api 解析
 UIView+WebCache.h
 
 sd_setImageWithURL:(nullable NSRUL *)url placeholderImage:(nullable UIImage *)placeholder options:(SDWebImageOptions)options
 progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock completed:(nullable SDExternalCompletionBlock)completedBlock;
 
 新版本还给UIView增加了分类，UIView+WebCache，最终上述方法会走到下面的方法去具体操作，比如下载图片
 
 - （void)sd_internalSetImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder options:(SDWebImageOptions)options operationKey:(nullable NSString *)opertaionKey setImageBlock:(nullable SDImageBlock)setImageBlock progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock completed:(nullable SDExternalCompletionBlock)completedBlock context:(nullable NSDictionary<NSString *,id> *)context;
 
 >接下来对该方法进行解析
 第一步：取消当前正在进行的异步下载，确保每个UIImageView对象永远只存在一个operation，当前只允许一个图片网络请求
 该operation负责从缓存中获取image或者是重新下载image，具体执行代码是
 
 NSString *validOpertaionKey = operationKey ?: NSStringFromClass(self.class);
 // 取消先前的下载任务
 [self sd_cancelImageLoadOperationWithkey:vaildOperationKey];
 ... // download image
 // 将生成的加载操作赋值给UIView的自定义属性
 [self sd_setImageLoadOpertaion:operation forKey:validOpertionKey];
 
 第二步：设置占位图，作为图片下载完成之前的替代图片
 
 第三步：判断URL是否合法
 if (url) {
 ... download image
 } else {
 #if SD_UIKIT
  [self sd_removeActivityIndicator];
 #endif
 if (completedBlock) {
    NSError *error = [NSError ]...
    completedBlock(nil,error,SDImageCacheTypeNone,url);
 }
 }
 
 __weak __typeof(self)wself = self;
 第四步下载图片操作
 下载图片操作是由SDWebImageManer完成的，它是一个单例
 id <SDWebImageOpertion> operation = [SDWebImageManger.sharedManger loadImageWithURL:url options:options proress:progressBlock completed:^(UIImage *imgae,NSData *data,NSError *error,SDImageCacheType cacheType,BOOL finished,NSURL *imageURL){
    下载完成的回调操作
    __strong __typeof(wself)sself = wself;
    // 下载完成关闭加载动画
    // 查看sself是否被释放
    if (!sself) return;
    // 下载完成刷新UIImageView图片
    if (image && (options & SDWebImageAvoidAutoSetImage) && completedBlock) {
        completed(image, error, cacheType, url);
        return;
    } else if (image) {
        // 拿到image，给imageView设置图片+回调
        [sself sd_setImage:image imageData:data basedOnClassOrViaCustomSetImageBlock:setImageBlock];
        [sself sd_setNeedLayout];
 
    } else {
        // 如果是设置了SDWebImageDelayPlaceholder,就会在下载完成之后给自身赋值给placeholder
        if (options & SDWebImageDelayPlaceholder) {
            [sself sd_setImage:placeholder imageData:nil basedOnClassOrViaCustomSetImageBlock:setImageBlock];
        }
 
    }
    
    if (completed && finished) {
        // 完成调用
        completedBlock(image, error, cacheType, url);
    }
    
 }];
 
 // 绑定opertion 将生成的加载操作 赋值给UIView的关联属性
 [self sd_setImageLoadOpertion:opertion forkey:validOpertionKey];
 
 
 第四步：SDWebImageManger LoadImageWithURL
 - （id<SDWebImageOperation>）loadImageWithURL:(nullable NSURL *)url options:(SDWebImageOptions)options progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock completed:(nullable SDInternalCompletionBlock)completedBlock {
 
 NSAssert( completedBlock != nil,@"if you mean to prefetch the image,use -[SDWebImagePrefetcher prefetchURLs] instead");
 
 if ([url isKindOfClass:NSString.class]) {
    url = [NSURL URLWithString:(NSString *)url];
 }
 
 if (![url isKindOfClass:NSURL.class]) {
    url = nil;
 }
 
 // 生成新的任务
 __block SDWebImageCombinedOperation *opertion = [SDWebImageCombinedOperation new];
 __weak SDWebImageCombinedOperation *weakOperation = operation;
 BOOL isFailedUrl = NO;
 if (url) {
    @synchronized (self.failedURLs) {
        isFailedUrl = [self.failedURLs containsObject:url]
    }
 }
 // 判断url 为空，或者url下载失败并且设置了不再重试
 if (url.absoluteString.length == 0 || (!(options & SDWebImageRetryFailed) && isFailedUrl))
    [self callCompletionBlockForOpertaion:opertaion completion:completedBlock error:[NSError errorWithDomain:NSURLErrorDomain code:]]
    return opertaion;
 }
 
 // 保存操作,runningOperations是一个可变数组，保存所有的operation，主要用来监测是否有opertaion在执行
 即判断running状态
 
 @synchronized (self.runningOperations) {
    [self.runningOperations addObject:operation];
 }
 
 查找缓存:首先会在memory以及disk的cache中查找是否下载过相同的招牌呢，即调用imageCache方法
 NSString *key = [self cacheKeyForURL:url];
 operation.cacheOperation = [self.imageCache queryCacheOperationForKey:key done:^(UIImage *image, NSData *cacheData, SDImageCacheType cacheType){
 
    if (operation.isCancelled) {
        [self safelyRemoveOpertaionFromRunning:opertaion];
        return;
    }
 
 // 如果没有在缓存中找到图片，或者不管是否找到图片，只要opertiaon有SDWebImageRefreshCached标记
 那么SDWebImageMangerDelegate的shouldDownloadImageForURL方法返回true，即允许下载，
 使用imageDownloader的下载方法
 
 SDWebImageDownToken *subOpertaionToken = [self.imageDwonLoader downloadImageWithURL:url options:downloaderOptions progress:proregssBlock completed:^(UIImage *downloadedImage, NSData *downloadData, NSError *error,BOOL finished){
    __strong __typeof(weakOperation) strongOpertaion = weakOpertaion;
 
 // 判断异常情况
 如果操作为空或者是操作被取消什么都不做
 
 // 如果有error直接回调error，并且将url加入到failedURLs中去
 
 // 如果下载成功，若支持失败重试，将url从failedURLs里删除
 
 // 如果delegate实现了 imageManger:transformDownloadImage:withURL方法
 图片存入缓存之前需要做转换，在全局队列中调用，不阻塞线程，转化成功之后下载全部结束，图片存入缓存
 调用comletedBlock，第一个参数是转换后的image
 
 否则直接存书啊魂存，调用completedBlokc回调，第一个参数是下载的原始的image
 
 }]
 
 
 }];
 
 */

@end
