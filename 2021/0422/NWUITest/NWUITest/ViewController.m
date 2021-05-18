//
//  ViewController.m
//  NWUITest
//
//  Created by Augus on 2021/4/22.
//

#import "ViewController.h"
#import "TwoController.h"


//@import Foundation.NSURL;
//#import "mach/mach.h"
#import <Masonry/Masonry.h>

#import "NWSpeechController.h"
//#import "NWPlayerController.m"

#import "GTPlayerController.h"
#import "GTRecorderController.h"

#import <MediaPlayer/MediaPlayer.h>

#include <CommonCrypto/CommonHMAC.h>

#import "AVMetadataItem+NWAdditions.h"

#import "NSObject+Tian.h"

#import <objc/runtime.h>

#import "TestObj.h"
#import "TestSonObj.h"
#import "TestSonObj+TSOCateory.h"

#import "OneView.h"
#import "TwoButton.h"




static const NSString *YSPlayerItemStatusContext;


@interface ViewController ()<GTPlayerControllerDelegate>

@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *pushButton;

@property (nonatomic, strong) NSMutableArray *mutableArray;
@property (nonatomic, strong) AVPlayer *ysPlayer;



@end

@implementation ViewController {
    
    GTPlayerController *_nwPlayer;
    GTRecorderController *_recorder;
}


//- (instancetype)init {
//
//    if (!self) {
//        NSLog(@"self is nil");
//    } else {
//        self.view.backgroundColor = UIColor.redColor;
//    }
//    return [super init];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self testAutoUITest];
//    [self testGCDSync1];
    
    
//    NSLog(@"%@---%@--",@(LONG_MIN),@(LONG_MAX));
    // -9223372036854775808
    //  9223372036854775807
    
    // -2147483647
    //  2147483647
    

        
//    [self testCopy];
    
//    [self testCompressPriorityForView];
    
//    [self testHuggingPriority];
    
//    [self testNWSpeechSynthesizer];

//    [self testNWPlayer];
    
//    NSTimeInterval timestamp = [NSDate timeIntervalSinceReferenceDate];
//    NSLog(@"time--%@",@(timestamp));
    
//    [self testGTRecorder];
    
//    [self testAssert];
    
//    [self testAVPlayer];
    
    
    
  
    
//    [self testJYZXSign];
    

//    [self testObjcMsgSend];
    
//    [self testProperty];
    
//    [self testSemphare];
    
    
//    [self findNumberForBottle:4];
    
//    [self test2Obj];

//    [self testbarrierGCD];
    

//    [self testBAIDU];
    
    [self testBlock];
    
    
}

int a = 3;
- (void)testBlock {
    
    static int b = 2;
    void (^myBlock)(void) = ^{
        
        NSLog(@"全局变量 %d,静态局部变量 %d",a,b);
    };
    // <__NSGlobalBlock__: 0x10e5aa2f8>
    // 只用到全局和静态局部也是全局block 不持有对象
    NSLog(@"%@",myBlock);
    myBlock();
    
    // stack block 是不持有对象的 _NSConcreteStackBlock
    
    __block int temp = 10;
//    int temp = 10; // stack
//    NSLog(@"stack block --%@",^{NSLog(@"temp %d",temp);});
    NSLog(@"before %p",&temp);//before 0x7ffee7478d20-140742198063840
    void (^tBlock)(void) = ^{
        
        // 内部捕获的变量，都是赋值给block的结构体，相当于const不可更改
        // 为了访问并修改外部变量，需要加上__block修饰符
        temp *= 2;
        NSLog(@"in block %p",&temp);//in block 0x600000f285d8-175921844550184
        
        
        
        /**
         
         
        高堆从高到低
         
        低 栈从低到高
         
         */
        
        
    };
    
    NSLog(@"after %p",&temp);//after 0x600000f285d8

    tBlock();
    
    
    // unsigned long int 2^32 - 1
//    uintptr_t cc = 0;
//    NSLog(@"%lu",cc);
    
    
    
    
    
}

- (void)testBAIDU {
    
//        TestObj *obj = [TestObj new];
//        [obj printName];
        
//        TestSonObj *son = [TestSonObj new];
//        [son printName];
    
    
//    OneView *one = [OneView new];
//    one.backgroundColor = UIColor.greenColor;
//    [self.view addSubview:one];
//    one.clipsToBounds = YES;
//
//    one.frame = CGRectMake(100, 100, 100, 100);
//
//    TwoButton *two = [TwoButton new];
//    two.backgroundColor = UIColor.redColor;
//    [two addTarget:self action:@selector(twoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [one addSubview:two];
//
//    two.frame = CGRectMake(0, 50, 100, 120);
    
    
}



- (void)twoButtonAction:(UIButton *)sender {
    
    NSLog(@"%@ : %@",@(__PRETTY_FUNCTION__),@(__LINE__));

}

- (void)testbarrierGCD {
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.fosafer.concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    void (^blk0)(void) = ^{
        NSLog(@"blk-0");
        sleep(3);
    };
    void (^blk1)(void) = ^{
        NSLog(@"blk-1");
        sleep(2);
    };
    
    void (^blk2)(void) = ^{
        NSLog(@"blk-2");
        
    };
    
    void (^barrerBlk)(void) = ^{
        NSLog(@"blk-barrier");
    };
    
    
    dispatch_async(concurrentQueue, blk0);
    dispatch_async(concurrentQueue, blk1);
    dispatch_barrier_async(concurrentQueue, barrerBlk);
    dispatch_async(concurrentQueue, blk2);
}

struct nw_objc_class {

    Class isa;
    Class cache_t;
};

- (void)test2Obj {
    
    
    
    Class cls1 = NSClassFromString(@"TestObj");
    NSLog(@"cls1 %p",cls1);
    
    
    
    NSObject *obj = [[NSObject alloc] init];
    
    // 类对象
//    Class cls = [NSObject class];
    struct nw_objc_class *cls = (__bridge  struct nw_objc_class*)[NSObject class];
    
    // 元类对象
//    Class metaCls = object_getClass([NSObject class]);
    struct nw_objc_class *metaCls = (__bridge struct nw_objc_class *)object_getClass([NSObject class]);
    
    NSLog(@"obj %p,cls %p,metaCls %p",obj,cls,metaCls);
    
    // 0x00007fff86d54660
    
    
    
    // 0x00007fff86d54660
    
    
//    TestObj *tian = [[TestObj alloc] init];
//
//    NSLog(@"tian %p",tian);
    
    
//    UITextView *tv = [UITextView new];
//
//    UITextField *tf = [UITextField new];
//
//    UISplitViewController *sv = [UISplitViewController new];

//    UIVideoEditorController *ve = [UIVideoEditorController new];
    
    /// spin lock
//    bool lock = false;
//    while (lock) { //  申请锁
//
//        // 操作处理 ...
//
//        // 处理完成
//        lock = false;
//    }
    
}

// 原子操作
bool test_and_set(bool *target) {
    
    bool rv = *target;
    *target = true;
    return rv;
}


/// 找出有毒的瓶子 15瓶子 4只老鼠

- (void)findNumberForBottle:(NSInteger)mouseNum {
    
    
    
    
    NSMutableArray *mouseArray = [NSMutableArray new];
    for (NSInteger i = 0; i < mouseNum; i++) {
        [mouseArray addObject:@0];
    }
    
    // 0存活 1死亡
    NSInteger bottleNum = 0;
    for (NSInteger i = 0; i < mouseNum; i++) {
        mouseArray[i] = @(arc4random() % 2);
    }
    
    NSLog(@"%@",mouseArray);
        
    
    for (NSInteger i = 0; i < mouseNum; i++) {
        bottleNum |= [mouseArray[i] intValue] << (mouseNum - i - 1);
    }
   
    if (bottleNum == 0) {
        NSLog(@"无毒");
    } else {
        NSLog(@"有毒瓶子是 %ld",(long)bottleNum);

    }
}


- (void)testSemphare {
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        
        NSArray *list = @[@1,@4,@3];
        // value < 0,return NULL
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            
            [self fetchConfigureWithCompletion:^(NSDictionary *dict) {
               
                NSLog(@"back net wrok - %@",obj);
                dispatch_semaphore_signal(semaphore);
            }];
            
            NSLog(@"front---%@",@(idx));
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            
        }];
    });
    
    
    // 如果一个semaphore在使用中，重新赋值或者销毁会引起崩溃
//    dispatch_semaphore_t s =  dispatch_semaphore_create(1);
//    dispatch_semaphore_wait(s, DISPATCH_TIME_FOREVER);
//    s = NULL;
}



- (void)fetchConfigureWithCompletion:(void(^)(NSDictionary *dict))completion {
    
    // 模拟网络请求
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        sleep(3);
        !completion ? nil : completion(nil);
    });
}

- (void)testProperty {
    
//    objc_property_t
    objc_property_t property_t = class_getProperty([NWSpeechController class], "synthesizer");
    const char *name = property_getName(property_t);
    NSLog(@"%s", name);

//    property_getName(<#objc_property_t  _Nonnull property#>)
}

- (void)testObjcMsgSend {
    
    
    // 根据cateory的机制，因为声明了+tian方法，但是未实现所以会出现警告
    // 但是-tian方法会被添加到nsobject实例方法列表中
    
    // 首先根据isa指针，去nsobject的meta class中寻找，未找到；继续在superclass中寻找
    // nsobject的metaclass的superclass就是nsobject本身
    
    // 于是又回到nsobject类方法中查找tian方法,根据sel名字找到
    

    [NSObject tian];
    
    
    //
    [[NSObject new] tian];
    
}

- (void)testDlopen {
    
//    char *dylibPath = "/Applications/myapp.app/mydylib2.dylib";
//    void *libHandle = dlopen(dylibPath, RTLD_NOW);
//    if (libHandle != NULL) {
//        NSString * (*someMethod)() = dlsym(libHandle, "someMethod");
//        if (someMethod != NULL)  {
//            NSLog(someMethod());
//        }
//        dlclose(libHandle);
//    }
}


- (void)testAVPlayer {
    
//    AVPlayer
    
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"SampleVideo_1280x720_1mb" withExtension:@"mp4"];
//    AVAsset *asset = [AVAsset assetWithURL:url];
//    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:asset];
//
//    [playerItem addObserver:self forKeyPath:@"status" options:0 context:&YSPlayerItemStatusContext];
//
//    self.ysPlayer = [AVPlayer playerWithPlayerItem:playerItem];
//    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.ysPlayer];
//    [self.view.layer addSublayer:playerLayer];
    
    
    // 0.5 sec
    CMTime haflSecond = CMTimeMake(1, 2);
    NSLog(@"half---%lld---%d",haflSecond.value,haflSecond.timescale);
    // 5s
    CMTime fiveSec = CMTimeMake(5, 1);
    
    // one sample from a 44.1 kHz audio file
    CMTime oneSample = CMTimeMake(1, 44100);
    
    
    // zero time value
    CMTime zero = kCMTimeZero;
    
//    self.ysPlayer addPeriodicTimeObserverForInterval:<#(CMTime)#> queue:<#(nullable dispatch_queue_t)#> usingBlock:<#^(CMTime time)block#>
    
    CMTime mtime = CMTimeMake(1, 2);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    void (^callBack)(CMTime time) = ^(CMTime time){
      
        
        NSTimeInterval currentTime = CMTimeGetSeconds(time);
        
    };
    
   id timeObserver = [self.ysPlayer addPeriodicTimeObserverForInterval:mtime queue:mainQueue usingBlock:callBack];
    
    
    
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (context == &YSPlayerItemStatusContext) {
        AVPlayerItem *playerItem = (AVPlayerItem *)object;
        NSLog(@"status ===%@",@(playerItem.status));

        if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
            // process playback
            [self.ysPlayer play];
            CMTime curTime = self.ysPlayer.currentTime;
            
            
        }
    }
}

- (void)testJYZXSign {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"11" ofType:@"jpg"];
    NSData *imageData = [[NSData alloc] initWithContentsOfFile:path];
    NSString *base64Str = [self base64forData:imageData];
    
    NSString *name = @"冯花";
    NSString *pubKey = @"2FD9AD11D80E42B6BB036759FD0C9E77";
    NSString *orderId = @"3be1600b257f4cf485e7e6222a02dff1";
//    NSString *merchantId = @"M100000068";
    NSString *identity = @"460032197910193621";
    
//    NSLog(@"base64---%@",base64Str);
    
//    NSDictionary *dict = @{@"name" : @"冯花",
//                           @"pubKey" : @"2FD9AD11D80E42B6BB036759FD0C9E77",
//                           @"orderId" : @"3be1600b257f4cf485e7e6222a02dff7",
//                           @"merchantId" : @"M100000068",
//                           @"identity" : @"460032197910193621",
//    };
    
    
    NSString *signRaw = [self toFormatJson:orderId identity:identity name:name sourceType:@"1" pubKey:pubKey preDeal:@"true" photo:base64Str];
    NSLog(@"md0--%@",signRaw);
    
    NSString *md5Str = [self getMD5String:signRaw];
    NSLog(@"md1--%@",md5Str);
    
}

- (NSString *)getMD5String:(NSString *)aString {
    
    NSData *dataString = [aString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutData = [[NSMutableData alloc] initWithData:dataString];
    const char * original_str = (const char *)[mutData bytes];
    unsigned char digist[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)mutData.length, digist);
    NSData *data = [NSData dataWithBytes:(const void *)digist length:sizeof(unsigned char)*CC_MD5_DIGEST_LENGTH];
    return [self convertDataToHexStr:data];
}

- (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string ;
}


- (NSString *)toFormatJson:(NSString *)orderId
                  identity:(NSString *)identity
                      name:(NSString *)name
                sourceType:(NSString *)sourceType
                    pubKey:(NSString *)pubKey
                   preDeal:(NSString *)preDeal
                     photo:(NSString *)photo  {
    
    
    // \"
    NSString *photoStr = [NSString stringWithFormat:@"{\"orderId\":\"%@\",\"identity\":\"%@\",\"name\":\"%@\",\"sourceType\":\"%@\",\"photo\":\"%@\"}",orderId,identity,name,sourceType,photo];
    
    NSString *nameStr = [NSString stringWithFormat:@"{\"orderId\":\"%@\",\"identity\":\"%@\",\"name\":\"%@\",\"sourceType\":\"%@\"}",orderId,identity,name,sourceType];
    
    
    if (photo && photo.length > 0) {
        return [photoStr stringByAppendingString:pubKey];;
    } else {
        return [nameStr stringByAppendingString:pubKey];;
    }
}

- (NSString*)base64forData:(NSData*)theData{
    
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}


- (void)testAssert {
    
//    AVAssetTrack *track = [AVAssetTrack valueForKey:@""];
//    NSArray<AVAssetTrack *> *assets =  track.asset.tracks;
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"SampleVideo_1280x720_1mb" ofType:@"mp4"];
//    NSURL *url = [NSURL URLWithString:path];
//    AVAsset *asset = [AVAsset assetWithURL:url];
//
//    if ([asset isKindOfClass:[AVURLAsset class]]) {
//        NSLog(@"asset is urlasset");
//    } else {
//        NSLog(@"asset is not urlasset");
//    }
//
//    NSDictionary *options = @{AVURLAssetPreferPreciseDurationAndTimingKey : @YES};
//    AVAsset *assetOptions = [[AVURLAsset alloc] initWithURL:url options:options];
//
//
//    MPMediaPropertyPredicate *artistPredicate = [MPMediaPropertyPredicate predicateWithValue:@"Jay" forProperty:MPMediaItemPropertyArtist];
//
//    MPMediaPropertyPredicate *albumPredicate = [MPMediaPropertyPredicate predicateWithValue:@"In you honur" forProperty:MPMediaItemPropertyAlbumTitle];
//
//    MPMediaPropertyPredicate *songPredicate = [MPMediaPropertyPredicate predicateWithValue:@"Best of you" forProperty:MPMediaItemPropertyTitle];
//
//    MPMediaQuery *query = [MPMediaQuery new];
//    [query addFilterPredicate:artistPredicate];
//    [query addFilterPredicate:albumPredicate];
//    [query addFilterPredicate:songPredicate];
//
//    NSArray *results = query.items;
//    if (results.count > 0) {
//        MPMediaItem *item = results[0];
//        NSURL *assetURL = [item valueForProperty:MPMediaItemPropertyAssetURL];
//        AVAsset *asset = [AVAsset assetWithURL:assetURL];
//        // asset created
//    }
    
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"SampleVideo_1280x720_1mb" withExtension:@"mp4"];
    AVAsset *asset = [AVAsset assetWithURL:url];
    NSArray *metaData = [asset metadataForFormat:AVMetadataFormatiTunesMetadata];
    for (AVMetadataItem *item in metaData) {
        NSLog(@"%@ : %@",item.keyString,item.value);
    }
    
    
}


- (void)testAsyncLoadAsset {
    
    NSURL *url = [[NSBundle mainBundle]
                      URLForResource:@"sample1" withExtension:@"caf"];

    AVAsset *asset = [AVAsset assetWithURL:url];
    
    // async load the asset's track property
    NSArray *keys = @[@"tracks"];
    [asset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
       
        
        // capture the statuc of the tracks property
        NSError *error = nil;
        AVKeyValueStatus status = [asset statusOfValueForKey:@"tracks" error:&error];
        switch (status) {
            case AVKeyValueStatusLoaded:
                // continue process
                break;
            case AVKeyValueStatusFailed:
                // handle failed error
                break;
            case AVKeyValueStatusCancelled:
                // handle explicit cancel
                break;
                
            default:
                // handle all other cases
                break;
        }
    }];
    
}



- (void)testGTRecorder {
    
    [self setupUI];
    _recorder = [[GTRecorderController alloc] init];
    
}


- (void)testNWPlayer {
    
    [self setupUI];
    _nwPlayer = [[GTPlayerController alloc] init];
    _nwPlayer.delegate = self;
    
    
}

#pragma mark - GTPlayerControllerDelegate

- (void)playbackStoppedForPlayerController:(GTPlayerController *)player {
    
    // interruption begin and stop player ,update UI
    
}

- (void)playbackBeganForPlayerController:(GTPlayerController *)player {
    
    // interruption end and to play,update UI
}


- (void)setupUI {
    
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i;
        [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(100, i * 100 + 70, 100, 50);
        btn.backgroundColor = UIColor.greenColor;
        [self.view addSubview:btn];
    }
}

- (void)buttonAction:(UIButton *)sender {
    
//    if (sender.tag == 0) {
//        [_nwPlayer play];
//    }else if(sender.tag == 1) {
//        [_nwPlayer stop];
//    } else {
//        [_nwPlayer adjustRate:1.5];
//    }
    
    if (sender.tag == 0) {
//        [_nwPlayer play];
       BOOL success = [_recorder record];
        if (!success) {
            NSLog(@"init fail recorder");
        }
    }else if(sender.tag == 1) {
//        [_nwPlayer stop];
        [_recorder pause];
    } else if(sender.tag == 2) {
        [_recorder stopWithCompletionHander:^(BOOL success) {
                    
            if (success) {
                NSLog(@"audio finish recording");
            }
        }];
    } else if(sender.tag == 3) {
      
        [_recorder saveRecordingWithName:@"test1.caf" completionHander:^(BOOL success, id  _Nullable memo) {
           
            
//            if (memo) {
//
//            }
            
            if (success) {
                NSLog(@"save success memo---%@",memo);
            } else {
                NSLog(@"save fail");
            }
        }];
    }
}

- (void)testNWSpeechSynthesizer {
    
    NWSpeechController *speechController = [NWSpeechController speechController];
    [speechController beginConversation];
}

- (NSArray *)nw_superViews:(UIView *)view {
    
    if (!view) {
        return nil;
    }
    
    NSMutableArray *tempArray = [NSMutableArray array];
    while (view) {
        [tempArray addObject:view];
        view = view.superview;
    }
    
    return [tempArray copy];
}

- (UIView *)commonViewForView1:(UIView *)view1 view2:(UIView *)view2 {
    
    UIView *resView = nil;
    NSArray *arr1 = [self nw_superViews:view1];
    NSArray *arr2 = [self nw_superViews:view2];
    NSSet *set2 = [NSSet setWithArray:arr2];
    for (int i = 0; i < arr1.count; i++) {
        if ([set2 containsObject:arr1[i]]) {
            resView = arr1[i];
            return resView;
        }
    }
    
    return resView;
}


/// 最近公共父view
- (NSArray *)superViewsFor:(UIView *)view {
    
    if (!view) {
        return nil;
    }
    
    NSMutableArray *temp = [NSMutableArray array];
    while (view) {
        [temp addObject:view];
        view = view.superview;
    }
    
    return [temp copy];
}

- (UIView *)commonView2:(UIView *)view view:(UIView *)view1 {
    
    NSArray *arr1 = [self superViewsFor:view];
    NSArray *arr2 = [self superViewsFor:view1];
    NSSet *s1 = [NSSet setWithArray:arr1];
    UIView *temp = nil;
    for (int i = 0; i < arr2.count; i++) {
        if ([s1 containsObject:arr2[i]]) {
            temp = arr2[i];
            break;
        }
    }
    
    
    return temp;
}


- (void)testHuggingPriority {
    
    
    UILabel *lable = [UILabel new];
    lable.text = @"说是爱你";
    lable.backgroundColor = UIColor.greenColor;
    [self.view addSubview:lable];
    [lable sizeToFit];
    
    [self.view setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    CGFloat padding = 50;
    
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.view).offset(padding);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view).offset(-padding);
    }];
    
    
//    NSMapTable *map = [[NSMapTable alloc] init];
    
    NSMapTable *swMap = [NSMapTable strongToWeakObjectsMapTable];
    [swMap setObject:self.view forKey:@"view"];
    
//    NSHashTable *hashTable = [[NSHashTable alloc] init];
    
    
//    NSProxy *proxy = [NSProxy conformsToProtocol:@protocol(@"hhh")];
    
    
    
}


- (void)testCompressPriorityForView {
    
    UILabel *leftLabel = [UILabel new];
    leftLabel.text = @"人做的畜生之事，众人主治，不可为";
    leftLabel.backgroundColor = UIColor.greenColor;
    [self.view addSubview:leftLabel];
    [leftLabel sizeToFit];
    [leftLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    
    UILabel *rightLabel = [UILabel new];
    rightLabel.text = @"2021-04-24 18:00:32";
    rightLabel.backgroundColor = UIColor.yellowColor;
    [self.view addSubview:rightLabel];
    [rightLabel sizeToFit];
    
//    [rightLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    
    
    // layout
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(self.view).offset(10);
        make.centerY.mas_equalTo(self.view);
        make.right.mas_lessThanOrEqualTo(rightLabel.mas_left);
        
    }];
    
    
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        
        make.height.mas_equalTo(20);
        make.left.mas_greaterThanOrEqualTo(leftLabel.mas_right);
        make.right.mas_equalTo(self.view).offset(-10);
        make.centerY.mas_equalTo(leftLabel);
    }];
    
    
    
}


- (void)testCopy {
    
//    NSString *aString = @"123";
//    NSString *tempString = [aString copy]; // pointer copy
    
    NSMutableString *mutStr = [[NSMutableString alloc] initWithString:@"456"]; // content copy
    NSString *tempMut = [mutStr mutableCopy];
    
    
    
    
    NSLog(@"%p-----%p",mutStr,tempMut);
    
    
    // immutable copy
    // immutable mutablecopy
    
    // mutable copy
    // mutable mutablecopy
    
    
    
    
}

- (float)__getMemoryUsedPer1
{
//    struct mach_task_basic_info info;
//    mach_msg_type_number_t size = sizeof(info);
//    kern_return_t kerr = task_info(mach_task_self(), MACH_TASK_BASIC_INFO, (task_info_t)&info, &size);
//    if (kerr == KERN_SUCCESS)
//    {
//        float used_bytes = info.resident_size;
//        float total_bytes = [NSProcessInfo processInfo].physicalMemory;
//        NSLog(@"Used: %f MB out of %f MB (%f%%)", used_bytes / 1024.0f / 1024.0f, total_bytes / 1024.0f / 1024.0f, used_bytes * 100.0f / total_bytes);
////        NSLog(@"used_byte--%.2f",used_bytes,);
//        return used_bytes / total_bytes;
//    }
    return 1;
}


- (UIImage * _Nullable )toImageFromCMPiexlBuffer:(CMSampleBufferRef _Nullable)buffer {
    
    
    if (buffer == NULL) {
        return nil;
    }
    
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(buffer);
    if (imageBuffer == NULL) {
        return nil;
    }
    
    CVReturn cvRes = CVPixelBufferLockBaseAddress(imageBuffer, 0);
    if (cvRes != kCVReturnSuccess) {
        return nil;
    }
    
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    
    if (baseAddress == NULL) {
        return nil;
    }
    
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    size_t bytesOfRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context =  CGBitmapContextCreate(baseAddress, width, height, 8, bytesOfRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaFirst);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // release
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    
    
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    // release
    CGImageRelease(imageRef);

    return image;
}


- (void)testGCDSync1 {
    
    
    // @property (nonatomic, strong) NSMutableArray *mutableArray;
    // 这里的self.mutableArray 做了两件事 第一件事 self setMutableArray:，KVO
    // 另外在初始化时候，类有可能只进行部分初始化，造成crash
//    for (int i = 0; i < 100; i++) {
//        self.mutableArray = [NSMutableArray new];
//    }
    
    
    
    
    
    
    // 3 2 4 1
    // 2 3 4 1
    
    


    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        NSLog(@"1");
    });
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        NSLog(@"2");
    });
    
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
       
        NSLog(@"3");
    });
    
    NSLog(@"4");
    
    
    
    
    /*
    
    添加异步
    添加异步
     添加同步
     添加4
     
     2or3 4 1
     
     */
    
    
    // 3 1 4 2
    // 1 3 4 2
    
    
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        NSLog(@"1");
    });

    dispatch_async(dispatch_get_main_queue(), ^{// =>

        NSLog(@"2");
    });

    dispatch_sync(dispatch_get_global_queue(0, 0), ^{ // ==> 同步+全局队列=主队列=串行队列

        NSLog(@"3");
    });

    NSLog(@"4");
    
    /**

    添加异步
    添加异步
    添加同步
    添加4

 
     
   
     
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1");  任务1
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"2");  任务2
        });
        NSLog(@"3");  任务3
    });
    NSLog(@"4");  任务4
    while (1) {  主队列阻塞
    }
    NSLog(@"5");  任务5
    
     
     
     
     
     
     
     添加异步
     添加4
     添加while 卡住主线程
     
     1or4
    
     
     
     
     
     
    
     
     将异步操作任务4 循环 任务5加入主队列
     1or4
     将1 同步操作 3 加入到全局队列
     因为异步加入任务1，所以1和4不确定
     
     同步操作加入主队列2，在4后面，4 2
     因为4完成后，while循环导致主队列阻塞，所以2无法完成，3也等待2的完成
     1 4
     4 1
     
     
    
    
    NSLog(@"1"); // 任务1
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2"); // 任务2
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"3"); // 任务3
        });
        NSLog(@"4"); // 任务4
    });
    NSLog(@"5"); // 任务5
     
     
     
     
     
     
     
     
     
     
     添加1
     添加异步---》添加2，添加同步，添加4
     添加5
     
     1 5or2 3 4
     
    
    
     
     将1 异步操作 5 加入主队列
     因为异步操作所以 5 2顺行不一定
     
     将2 同步操作 4 加入到全局队列
     因为同步操作将3添加到主队列，所以在5后面，阻塞线程，4等待3完成
     1 5 2 3 4
     1 2 5 3 4
     
     
     
     */
    
    
    dispatch_queue_t queue = dispatch_queue_create("com.demo.serialQueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1"); // 任务1
    dispatch_async(queue, ^{
        NSLog(@"2"); // 任务2
        dispatch_sync(queue, ^{
            NSLog(@"3"); // 任务3
        });
        NSLog(@"4"); // 任务4
    });
    NSLog(@"5"); // 任务5
    
    
    
    
    
    
    
    
    
    
    /*
     添加1
     添加异步---》添加2，添加同步，添加4
     添加5
     
     1 5or2
     
     */
    
    
    
    /**
     
     将1  异步操作 5 加入到主队列
     因为异步操作 所以2和5 顺行不一定
     
     将2 同步操作 4 加入到串行队列
     
     同步操作将3 加入到4后面
     4等待3的完成，3也等待4的完成
     
     1 5 2
     1 2 5
     
     
     */
    
    
    NSLog(@"1"); // 任务1
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"2"); // 任务2
    });
    NSLog(@"3"); // 任务3
    
    
    
    
    
    
    
    
    
    
    
    /**
     
     异步
     dispatch_async:把任务添加到队列，紧接着唤醒队列，通过vtable，找到wakeup指针，调用该函数，
     并取出工作队列，如果没有需要新建，然后再工作线程中取出链表头部的block进行执行
     
     同步
     dispatch_sync：实现比较简单，分发到那个队列，就进行相应的处理，进入到主队列就由runloop处理
     进入到其他队列由线程池处理；与线程绑定的信号量实现串行
     
     
     group--notify----async---value
     
     将1 同步操作 3 加入到主队列
     同步操作将2加入全局队列
     3会等待同步线程执行结束
     
     
     1 2 3
     
     */
    
}


- (NSInteger)objectForIndex:(NSInteger)index {
    
    
    NSMutableArray *list = [NSMutableArray array];
    NSInteger size = list.count;
    NSInteger offSet = 6;
    
    NSInteger fetechIndex = index + offSet;
    NSInteger realIndex = fetechIndex - (size > fetechIndex ?  0 : size);
    
    
    /**
     
     remove or insert ===> update offset pointer
     1.625 扩充
     
     
     */
    return realIndex;
}

- (void)printName:(NSString *)name {
    NSLog(@"the fun no callback %@",name);
}

- (void)printName:(NSString *)name callBack:(callBack)callBack {
    
    NSLog(@"the func has callback %@",name);
    if (callBack) {
        callBack(name);
    }
}

- (void)testAutoUITest {
    
    // textfield
    [self.view addSubview:self.passwordTextField];
    self.passwordTextField.frame = CGRectMake(100, 200, 200, 30);
    
    [self.view addSubview:self.pushButton];
    self.pushButton.frame = CGRectMake(100, 300, 100, 50);
    
    
}

- (void)pushButtonAction:(UIButton *)sender {
    

    TwoController *two = [[TwoController alloc] init];
    [self.navigationController pushViewController:two animated:YES];
    
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.placeholder = @"please input some charc";
        _passwordTextField.backgroundColor = UIColor.greenColor;
        
    }
    return _passwordTextField;
}

- (UIButton *)pushButton {
    if (!_pushButton) {
        _pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pushButton setTitle:@"push" forState:UIControlStateNormal];
        [_pushButton addTarget:self action:@selector(pushButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_pushButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
        _pushButton.backgroundColor = UIColor.redColor;
    }
    return _pushButton;
}




@end
