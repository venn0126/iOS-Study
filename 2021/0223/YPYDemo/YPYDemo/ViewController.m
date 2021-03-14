//
//  ViewController.m
//  YPYDemo
//
//  Created by Augus on 2021/3/5.
//

#import "ViewController.h"
#import "NWCacheIOP.h"
#import "SomeSDWebImage.h"
#import "NWPerson.h"


typedef int (^nwBlock) (int param1,int param2);

@interface ViewController ()<NSURLSessionDelegate>

@property (nonatomic, strong) NSCache *cache;
@property (nonatomic, strong) NWCacheIOP *cacheIOP;
@property (nonatomic, strong) NSMutableDictionary *mutableDictionary;
@property (nonatomic, strong) UIProgressView *nwProgressView;

@property (nonatomic,copy) UIView* (^nwSetBackgroundColor)(UIColor* color);



@end

@implementation ViewController{
    
    CFMutableDictionaryRef _cfMutableDict;
    CGFloat _totalLength;
    CGFloat _currentLength;
    NSMutableData *_fileData;
    
    NSFileHandle *_fileHandle;
    NSOutputStream *_outStream;
}

//- (void)loadView {
//
//    NSLog(@"111 ---%@----%@",@(__PRETTY_FUNCTION__),@(__LINE__));
    
//    self.view = [UIView new];
//    self.view.backgroundColor = UIColor.linkColor;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    NSHashTable
    
    // NSCache & NSMutableDictionary

//    [self testCache];
//    [self testSDWebImage];
//    _mutableDictionary = [NSMutableDictionary dictionary];
//    _cfMutableDict = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
//
//    _nwProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(50, 100, 300, 30)];
//    _nwProgressView.tintColor = UIColor.greenColor;
//    [self.view addSubview:_nwProgressView];
    
//    _fileData = [NSMutableData new];
//    [self testNSURLSessionDownload];
    
    // test maptable
//    for (int i = 5; i < 10; i++) {
//        [self testNSCacheAccess:(NSUInteger)pow(10, i)];
//    }
    
//    [self testKVO];
    
    [self testFuncProgramm];
    
//    self.nwSetBackgroundColor([UIColor yellowColor]);
    
    
}


- (void)testFuncProgramm {
    
    // 返回的是实例对象
    
    // 需要操作的属性是block参数
    
    // 操作的结果保存在block的返回值
    
    
    NWPerson *nw = [[NWPerson alloc] init];
    BOOL isEqual = [[[nw caculator:^int(int result) {
        // 计算自定义数值的和
        NSLog(@"000---%@",@(result));
        // 一个值进行 2 * 5
        result += 2;
        result *= 6;
        
        return result;// 结果保存
    }] equal:^BOOL(int result) {

        NSLog(@"222result--%d",result);
        return result == 12;
    }] nwEqual];
    
    
    int res = [NWPerson makeCaculators:^(NWPerson * _Nonnull make) {
       
        make.add(1).add(2).muilt(3);
    }];
    
    NSLog(@"res---%d",res);
    
    
//   BOOL isEqual = [[[nw caculator:^int(int result) {
//
//        result += 2;
//        result *= 5;
//        return result;
//    }] equal:^BOOL(int result) {
//
//        return result == 10;
//    }] nwEqual];
    
    NSLog(@"----%@",@(isEqual));
    
    
//    nw.with.driveCar();
//    nw.with.eatFood();
//    nw.with.e


//    int a = [self plus:^int(int param1, int param2) {
//
//        return param1 - param2;
//    }];
//
//    NSLog(@"a---%d",a);
    
    
//   int res = [NWPerson makeCaculators:^(NWPerson * _Nonnull make) {
//
//       return make.add(1).add(2).add(3).muilt(4);
//
//    }] ;
    
//    NSLog(@"res---%d",res);
    
    
    
    
    
    
}

- (int)plus:(nwBlock)nw {
    return nw(10,4);
}

-(UIView *(^)(UIColor *))nwSetBackgroundColor {
    
    return ^(UIColor *color) {
        self.view.backgroundColor = color;
        return self.view;
    };
}

- (void)testKVO {
    
    SomeSDWebImage *some = [[SomeSDWebImage alloc] initWithName:@"niu"];
    [some setValue:@"niu" forKey:@"firstName"];
    NSString *value = [some valueForKey:@"firstName"];

//    [some setValue:@"wei" forUndefinedKey:@"userName"];
//    NSString *value = [some valueForUndefinedKey:@"firstName"];
    NSLog(@"value---%@",value);
    
}

- (void)testNSURLSessionDownload {
    
    // 创建url
    NSURL *url = [NSURL URLWithString:@"http://sony.it168.com/data/attachment/forum/201410/20/2154195j037033ujs7cio0.jpg"];
    
    
//    NSURLSession *ssession = [NSURLSession sharedSession];
    
    // 创建请求session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    // 发送请求
    [[session dataTaskWithURL:url] resume];
    
    // session和代理之间循环引用 如果是全局 放在viewWillDisapper中去
//    [session invalidateAndCancel];
//    session = nil;
}

#pragma mark - NSURLSession Delegate


- (void)URLSession:(NSURLSession *)session dataTask:(nonnull NSURLSessionDataTask *)dataTask
didReceiveResponse:(nonnull NSURLResponse *)response
completionHandler:(nonnull void (^)(NSURLSessionResponseDisposition))completionHandler {
    
    NSLog(@"接收到服务器响应的时候调用---%@",[NSThread currentThread]);
    
    
    // 得到请求文件的数据大小
    _totalLength = response.expectedContentLength;
    // 默认不接受数据
    // 必须告诉系统是否接受服务返回的数据
    completionHandler(NSURLSessionResponseAllow);
    
    //
    NSString *fileName = response.suggestedFilename;
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fullPath = [fileName stringByAppendingPathComponent:cachePath];
    
    // 沙盒中创建一个空文件
//    [[NSFileManager defaultManager] createFileAtPath:fullPath contents:nil attributes:nil];
    // 创建文件句柄指向该文件
//    _fileHandle = [NSFileHandle fileHandleForWritingAtPath:fullPath];
    if (_currentLength == 0) {
        _outStream = [[NSOutputStream alloc] initToFileAtPath:fullPath append:YES];
    }
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
    // 接受到服务器返回数据的时候调用，可能会被调用多次
//    [_fileData appendData:data];
    
    // 文件句柄写数据
//    [_fileHandle writeData:data];
    [_outStream write:data.bytes maxLength:data.length];
    _currentLength += data.length;
    
    // 计算文件下载进度
//    _nwProgressView.progress = 1.0 * _fileData.length / _totalLenght;
    _nwProgressView.progress = _currentLength / (_totalLength);
    
    
    
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {

    // 保存数据到沙盒
//    NSString *fileName = task.response.suggestedFilename;
//    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *fullPath = [fileName stringByAppendingPathComponent:cachePath];
//    [_fileData writeToFile:fullPath atomically:YES];
//    _fileData = nil;
    // 关闭文件句柄
//    [_fileHandle closeFile];
    //关闭输出流
    [_outStream close];
    _currentLength = 0;
}



- (void)testNSCacheAccess:(NSUInteger)count {
    
    // 指数存取
    NSTimeInterval begin,end;
    begin = CACurrentMediaTime();
    // save
    for (NSUInteger i = 0; i < count; i++) {
//        [_cache setObject:@(i) forKey:@(i)];
//        [_mutableDictionary setObject:@(i) forKey:@(i)];
//        _cfMutableDict
        
        CFDictionarySetValue(_cfMutableDict, (__bridge const void *)(@(i)), (__bridge const void *)(@(i)));
    }
    // read
    for (NSUInteger i = 0; i < count; i++) {
//        [_cache objectForKey:@(i)];
//        [_mutableDictionary objectForKey:@(i)];
        CFDictionaryGetValue(_cfMutableDict, (__bridge const void *)(@(i)));

    }
    end = CACurrentMediaTime() - begin;
    NSLog(@"count is %ld cost %.2f",count,end);
    
    /*
     NSCache:
     count is 100000 time is 0.00
     count is 1000000 time is 0.05
     count is 10000000 time is 0.47
     count is 100000000 time is 4.48
     count is 1000000000 time is 45.42
     question: 大量相似的 key (比如 “1”, “2”, “3”, …)，NSCache 的存取性能会下降得非常厉害
     大量的时间被消耗在 CFStringEqual() 上，不知道是不是设计缺陷
     
     Dictionary
     count is 100000 cost 0.04
     count is 1000000 cost 0.57
     count is 10000000 cost 6.28
     count is 100000000 cost 78.27
     
     
     cfmutabledict
     count is 100000 cost 0.03
     count is 1000000 cost 0.56
     count is 10000000 cost 6.18
     count is 100000000 cost 73.30
     */
}

- (void)testSDWebImage {
    
//    SomeSDWebImage *some = [[SomeSDWebImage alloc] initWithName:nil];
//    NSLog(@"some name--%@",[some firstName]);
    
    
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {
//        block();
        
        NSLog(@"main thread");
    } else {
//        dispatch_async(dispatch_get_main_queue(), block);
    }
    
    
    
}

- (void)testCache {
    
    
    _cacheIOP = [NWCacheIOP new];
    
    _cache = [NSCache new];
    _cache.countLimit = 5;
    _cache.delegate = _cacheIOP;
    
    // add obj to cache
    [self nwAddObjcToCache];
    
    // memory warn nofitication
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nw_didReceiveMemoryWarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    
}


- (void)nwAddObjcToCache {
    
    for (int i = 0; i < 5; i++) {
        [_cache setObject:[NSString stringWithFormat:@"nw_%d",i] forKey:[NSString stringWithFormat:@"nw_%d",i]];
    }
    
    // 淘汰最近最少使用的LRU
//    [_cache objectForKey:@"nw_1"];
//    [_cache objectForKey:@"nw_3"];
//
    [_cache setObject:@"nw_5" forKey:@"nw_5"];
//    [_cache setObject:@"nw_6" forKey:@"nw_6"];
    
    // LFU 最不经常使用的淘汰
//    [_cache objectForKey:@"nw_1"];
//    [_cache objectForKey:@"nw_1"];
//    [_cache objectForKey:@"nw_3"];
//    [_cache objectForKey:@"nw_3"];
//    [_cache objectForKey:@"nw_2"];
//
//    [_cache setObject:@"nw_5" forKey:@"nw_5"];
//    [_cache setObject:@"nw_6" forKey:@"nw_6"];
    
//    [_cache removeAllObjects];
    
    // key
    
}

- (void)nw_getCacheObject {
    
    for (int i = 0; i < 10; i++) {
        NSLog(@"cache object:%@ at index:%d",[_cache objectForKey:[NSString stringWithFormat:@"nw_%d",i]],i);
    }
}


#pragma mark - Memory Warn

- (void)nw_didReceiveMemoryWarning:(NSNotification *)notification {
    
    NSLog(@"notitication---%@---%@ at line:%@",@(__PRETTY_FUNCTION__),notification,@(__LINE__));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 点击屏幕查看缓存中的内容
    [self nw_getCacheObject];
}


@end
