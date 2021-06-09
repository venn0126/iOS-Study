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

#import "GTTimerController.h"
#import "QiPlayerVideoController.h"
#import "QiAudioPlayer.h"
#import "QiLocationController.h"
#import "QiDownloadController.h"

#import <dlfcn.h>



static const NSString *YSPlayerItemStatusContext;
NSString * const AppViewControllerRefreshNotificationName = @"AppViewControllerRefreshNotificationName";

@interface ViewController ()<GTPlayerControllerDelegate>

@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *pushButton;

@property (nonatomic, strong) NSMutableArray *mutableArray;
@property (nonatomic, strong) AVPlayer *ysPlayer;

@property (nonatomic, weak) NSTimer *backTimer;

@property (nonatomic, strong) UIColor *buttonBackgroundColor;
@property (nonatomic, strong) NSMutableArray<UIButton *> *mButtonArray;


@property (nonatomic, copy) NSString *target;




@property (nonatomic,strong) id runtime_Player;

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
    self.title = @"Home";
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
    
//    [self testBlock];
    
    
//    [self setupUI];
//    [self addNotification];
    
//    [self testDLOpen];
//    [self testManSDK];
    
    
//    [self testAnchoPoint];
    
    
//    [self testWeakAttibute];
    
}


- (void)largeDataCompute {
    
    
//    pthread_main_thread_np();
    
//    NSNotification *notification = [NSNotification notificationWithName:<#(nonnull NSNotificationName)#> object:<#(nullable id)#>]
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.fosafer.concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_block_t block = dispatch_block_create(0, ^{
       
        NSLog(@"normal do something");
    });
    
    dispatch_async(concurrentQueue, block);
    
    /**
     
     QOS_CLASS_USER_INTERACTIVE:等级表示任务需要被立即执行，用来在响应事件之后更新 UI，来提供好的用户体验。这个等级最好保持小规模。
             __QOS_CLASS_AVAILABLE(macos(10.10), ios(8.0)) = 0x21,
     QOS_CLASS_USER_INITIATED:等级表示任务由 UI 发起异步执行。适用场景是需要及时结果同时又可以继续交互的时候。
             __QOS_CLASS_AVAILABLE(macos(10.10), ios(8.0)) = 0x19,
     QOS_CLASS_DEFAULT:默认优先级
             __QOS_CLASS_AVAILABLE(macos(10.10), ios(8.0)) = 0x15,
     QOS_CLASS_UTILITY:等级表示需要长时间运行的任务，伴有用户可见进度指示器。经常会用来做计算，I/O，网络，持续的数据填充等任务。这个任务节能。
             __QOS_CLASS_AVAILABLE(macos(10.10), ios(8.0)) = 0x11,
     QOS_CLASS_BACKGROUND:等级表示用户不会察觉的任务，使用它来处理预加载，或者不需要用户交互和对时间不敏感的任务。
             __QOS_CLASS_AVAILABLE(macos(10.10), ios(8.0)) = 0x09,
     QOS_CLASS_UNSPECIFIED:未知的
             __QOS_CLASS_AVAILABLE(macos(10.10), ios(8.0)) = 0x00,
     */
    
    
    dispatch_block_t qosBlock = dispatch_block_create_with_qos_class(0, QOS_CLASS_UTILITY, 0, ^{
       
        NSLog(@"qos do something");
    });
    
    dispatch_async(concurrentQueue, qosBlock);
    
}


/// 递归删除指定路径下的文件
/// @param path 指定路径
- (void)deleteFiles:(NSString *)path {
    // 1.判断文件还是目录
    NSFileManager *fileManger = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExist = [fileManger fileExistsAtPath:path isDirectory:&isDir];
    if (isExist) {
        // 2.判断是不是目录
        if (isDir) {
            NSArray *dirArray = [fileManger contentsOfDirectoryAtPath:path error:nil];
            NSString *subPath = nil;
            for (NSString *str in dirArray) {
                subPath = [path stringByAppendingPathComponent:str];
                BOOL issubDir = NO;
                [fileManger fileExistsAtPath:subPath isDirectory:&issubDir];
                [self deleteFiles:subPath];
            }
        } else {
            NSLog(@"%@",path);
            [fileManger removeItemAtPath:path error:nil];
        }
    } else {
        NSLog(@"你打印的是目录或者不存在");
    }
}


- (void)testNotificationCenter {
    
    // 发送通知
    
    //NSNotificationName 发送通知的名字 唯一
    // object 保存发送者对象
//    [NSNotificationCenter defaultCenter] postNotificationName:(nonnull NSNotificationName) object:(nullable id)
    
    // userInfo 接受者可以额外接受的信息
//    [NSNotificationCenter defaultCenter] postNotificationName:<#(nonnull NSNotificationName)#> object:<#(nullable id)#> userInfo:<#(nullable NSDictionary *)#>
}


- (void)testPtrAndArray {
    
    int n = 3;
//    int (*p)[n]; // 数组指针，指向某n个元素组成的整个数组，返回值是整型指针类型
    // 指针数组
    // ptrArray是一个数组，数组有n个整数指针组成
    int *ptrArray[n];
    int var[3] = {10,100,100};
    for (int i = 0; i < n; i++) {
        ptrArray[i] = &var[i]; // 赋值为整数指针
    }

    for (int i = 0; i < n; i++) {
//        printf("ptr index is %d : %d\n",i,*ptrArray[i]);
    }
    
    
    
    // 指向字符的数组
    // names是一个数组，数组中有3个字符指针组成
    const char *names[3] = {"niu","wei","hao"};
    for (int i = 0; i < 3; i++) {
//        printf("%d : %s\n",i,names[i]);
    }
    
    
    // 数组指针：指向数组的指针
    // arr2 是一个指向&arr2[0]的指针，即数组的第一个元素的地址

    int arr2[4] = {3,6,7,9};
    int *ptr2 = (int *)(&arr2 + 1);
    printf("last value is %d\n",*(ptr2-1));
    
    
    int *pt3 = arr2;
    printf("last value 2 is: %d",*(pt3 + 3));

    // 3 6 7 9
    
    // 假设6000是基地址，一个int类型的数字，占4个字节，那么就有以下的排列结构
    // 6000 60004 60008 6012
    // 6000 -           6015 共16个字节
    //
    // &arr2+1,数组首地址+数组总长，6000 + 16 = 6016
    // 此时 ptr2就是一个新的数组，此时6016就是数组首地址
    // ptr2是首元素地址，ptr2-1是倒着取一个元素6012，ptr2-2是，6008，ptr2-3，6004

}

- (void)testWeakAttibute {
    
    // 是什么，有什么作用
//    OneView *one = [OneView alloc];
//    id __weak objc = one;
    
    
    // 结构
    
    // 源码
    
    // 场景
    
    // 延伸
    
    
//    dispatch_queue_t queue = dispatch_queue_create("com.fosafer.current", DISPATCH_QUEUE_CONCURRENT);
//
//    for (int i = 0; i < 10000; i++) {
//
//        dispatch_async(queue, ^{
//
//            NSString *str = [NSString stringWithFormat:@"%d:",i];
//            NSLog(@"%d %s %p",i,object_getClassName(str),str);
//            self.target = str;
//        });
//
//    }
    
    
}

- (void)testAnchoPoint {
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = UIColor.redColor;
    [self.view addSubview:view];
    
    
//    [UIView animateWithDuration:6 animations:^{
    
    // width and height bigger than begin,and origin also update
    // x = 100 - abs(oldw - neww) * 0.5
    
    view.bounds = CGRectMake(100, 100, 150, 150);//
//    }];
    
    
    NSLog(@"1 frame is %@",NSStringFromCGRect(view.frame));// 75 75 150 150
    
    view.layer.anchorPoint = CGPointMake(0.0, 0.0);
    // 默认锚点 是0.5 0.5跟position是重合的，
    // 更新锚点减小之后是右or下移动，增加origin，增大之后是往左or上侧移动，减小origin
    //
    NSLog(@"2 frame is %@",NSStringFromCGRect(view.frame));// 150 150 150 150

    // 增加scale只会更新size，origin不会变化 
    view.transform = CGAffineTransformMakeScale(2, 2);
    NSLog(@"3 frame is %@",NSStringFromCGRect(view.frame));// 150 150 300 300

}

- (void)testManSDK {
    
    // bundle 路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Man" ofType:@"bundle"];
    
    // sdk 路径
    NSString *sdkPath = [path stringByAppendingPathComponent:@"MangoSDK.framework/MangoSDK"];
    const char *cPath = [sdkPath UTF8String];
    
    void *lib = dlopen(cPath, RTLD_LAZY);
    if (lib == NULL) {
        NSLog(@"open lib error %s",dlerror());
    } else {
        Class mgCls = NSClassFromString(@"MGTool");
        SEL sel = NSSelectorFromString(@"new");
        id runInstance = [mgCls performSelector:sel];
        sel = NSSelectorFromString(@"mg_logName");
        [runInstance performSelector:sel];
        dlclose(lib);
        
    }
    
}

- (void)testDLOpen {
    
//    dlopen
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SomethingJustLikeThis" ofType:@"mp3"];
    /**
     mode:（可多选的）
     // 表示动态库中的symbol什么时候被加载
     RTLD_LAZY 暂缓决定，等有需要的时候再解析符号
     RTLD_NOW 立即决定，返回前解除所有未决定的符号
     // 表示symbol的可见性
     RTLD_GLOBLE 允许导出符号
     RTLD_LOCAL
     */
    void *lib = dlopen("/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk/System/Library/Frameworks/AVFoundation.framework/AVFoundation", RTLD_NOW | RTLD_GLOBAL);
    
    if (lib == NULL) {
        // open dynamic lib error
        NSLog(@"open dynamic error: %s",dlerror());
    } else {
        Class playerClass = NSClassFromString(@"AVAudioPlayer");
        SEL sel = NSSelectorFromString(@"initWithData:error:");
        _runtime_Player = [[playerClass alloc] performSelector:sel withObject:[NSData dataWithContentsOfFile:path] withObject:nil];
        sel = NSSelectorFromString(@"play");
        [_runtime_Player performSelector:sel];
        NSLog(@"dynamic load play");
        
        dlclose(lib);
    }
    
    
    

}

- (void)setupUI {
    [self setupButtons];

}

- (void)setupButtons {
    
    CGFloat topMargin = 200.0;
    CGFloat leftMargin = 20.0;
    CGFloat verticalMargin = 30.0;
    CGFloat btnW = [UIScreen mainScreen].bounds.size.width - leftMargin * 2;
    CGFloat btnH = 44.0;
    UIColor *btnColor = [UIColor grayColor];
    _buttonBackgroundColor = btnColor;
    _mButtonArray = [NSMutableArray array];
    
    UIButton *locationBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftMargin, topMargin, btnW, btnH)];
    [locationBtn setTitle:@"地图" forState:UIControlStateNormal];
    locationBtn.backgroundColor = btnColor;
    [self.view addSubview:locationBtn];
    [locationBtn addTarget:self action:@selector(locationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_mButtonArray addObject:locationBtn];
    
    UIButton *playBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftMargin, CGRectGetMaxY(locationBtn.frame) + verticalMargin, btnW, btnH)];
    [playBtn setTitle:@"播放音乐" forState:UIControlStateNormal];
    playBtn.backgroundColor = btnColor;
    [self.view addSubview:playBtn];
    [playBtn addTarget:self action:@selector(playButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_mButtonArray addObject:playBtn];
    
    UIButton *needRunInBgBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftMargin, CGRectGetMaxY(playBtn.frame) + verticalMargin, btnW, btnH)];
    [needRunInBgBtn setTitle:@"需要后台运行" forState:UIControlStateNormal];
    needRunInBgBtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:needRunInBgBtn];
    [needRunInBgBtn addTarget:self action:@selector(needRunInBackgroundButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *downloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftMargin, CGRectGetMaxY(needRunInBgBtn.frame) + verticalMargin, btnW, btnH)];
    [downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
    downloadBtn.backgroundColor = btnColor;
    [self.view addSubview:downloadBtn];
    [downloadBtn addTarget:self action:@selector(downloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_mButtonArray addObject:downloadBtn];
    
    UIButton *timerBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftMargin, CGRectGetMaxY(downloadBtn.frame) + verticalMargin, btnW, btnH)];
    [timerBtn setTitle:@"定时器" forState:UIControlStateNormal];
    timerBtn.backgroundColor = btnColor;
    [self.view addSubview:timerBtn];
    [timerBtn addTarget:self action:@selector(timerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_mButtonArray addObject:timerBtn];
    
    NSLog(@"*****%lu",(unsigned long)_mButtonArray.count);
}


#pragma mark - 地图视图
- (void)locationButtonClicked:(UIButton *)sender {
    
//    NSURL *url = [NSURL URLWithString:@"https://www.so.com"];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"错误信息：%@", error);
//        } else {
//            NSLog(@"数据长度：%lu", (unsigned long)data.length);
//        }
//    }];
//
//    [dataTask resume];
//    return;
    
    QiLocationController *location = [QiLocationController new];
    [self.navigationController pushViewController:location animated:YES];
}

#pragma mark - 播放音乐
- (void)playButtonClicked:(UIButton *)sender {
    
    QiPlayerVideoController *playVieoVC = [QiPlayerVideoController new];
    [self.navigationController pushViewController:playVieoVC animated:YES];
    
}

#pragma mark - 需要后台运行
- (void)needRunInBackgroundButtonClicked:(UIButton *)sender {
    
    NSLog(@"%s: 需要后台音乐播放",__func__);
    [QiAudioPlayer sharedInstance].needRunBackground = YES;
}

#pragma mark - 下载
- (void)downloadButtonClicked:(UIButton *)sender {
    
    QiDownloadController *downloadVC = [QiDownloadController new];
    [self.navigationController pushViewController:downloadVC animated:YES];
}


#pragma mark - 定时器
- (void)timerButtonClicked:(UIButton *)sender {
    
//    GTTimerController *timerVC = [GTTimerController new];
//    [self.navigationController pushViewController:timerVC animated:YES];
    
    [self testManSDK];
}


#pragma mark - 添加通知
- (void)addNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appRefreshNoti:) name:AppViewControllerRefreshNotificationName object:nil];
}

- (void)appRefreshNoti:(id)sender {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIColor *btnColor = [UIColor colorWithRed:(arc4random() % 256 / 255.0) green:(arc4random() % 256 / 255.0) blue:(arc4random() % 256 / 255.0) alpha:1.0];
        [self.mButtonArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.backgroundColor = btnColor;
        }];
    });
}

#pragma mark - 移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AppViewControllerRefreshNotificationName object:nil];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // UIBackgroundTaskIdentifier
    NSLog(@"applicationDidEnterBackground");
    UIBackgroundTaskIdentifier identifier =  [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            
        // your long time task
        NSLog(@"beginBackgroundTaskWithExpirationHandler");
//        self.backTimer = [NSTimer timerWithTimeInterval:2 * 60 repeats:NO block:^(NSTimer * _Nonnull timer) {
//
//
//        }];
        
    }];
    
    
    // 此处为执行任务代码 通常用来保存应用程序关键数据数据
    NSLog(@"task begin");
    sleep(2 * 60);
    NSLog(@"task finish");
   
    //当任务执行完成时 调用endBackgroundTask方法 调用后就会将app挂起
    
    //后台保活通常时间为3分钟，如果时间到期之前调用endBackgroundTask方法 就会强制杀掉进程，就会造成崩溃
    [application endBackgroundTask:identifier];
    
    
    
    NSLog(@"crash identifier is  %ld",identifier);
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


- (void)setupUI0 {
    
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
