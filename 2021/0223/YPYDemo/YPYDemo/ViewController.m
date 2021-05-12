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
#import "UIImageView+NWBackground.h"

#import "NWCollectionViewCell.h"
#import "NWPerson+Extension.h"
#import "UIImage+CornerRadius.h"


#import "Person.h"
#import "NiuPersion.h"

#import "NWButton.h"


#import <objc/runtime.h>

#import "NWDispatchQueue.h"

#import <execinfo.h>

//#import "IOP"
#import <ImageIO/ImageIO.h>
#import "TwoController.h"


typedef void(^Testblock) (NSString *name);

static NSString *kCollectionCell = @"NWCollectionViewCell";
static const CGFloat kImageWidth = 100;

typedef int (^nwBlock) (int param1,int param2);

@interface ViewController ()<NSURLSessionDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, copy) Testblock testBlock;


@property (nonatomic, strong) NSCache *cache;
@property (nonatomic, strong) NWCacheIOP *cacheIOP;
@property (nonatomic, strong) NSMutableDictionary *mutableDictionary;
@property (nonatomic, strong) UIProgressView *nwProgressView;

@property (nonatomic,copy) UIView* (^nwSetBackgroundColor)(UIColor* color);
@property (nonatomic, strong) UICollectionView *nwCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;


@property (nonatomic, strong) NSMutableArray *imageSource;
@property (nonatomic, strong) UIPageControl *nwPageControl;

@property (nonatomic, strong) NSTimer *nwTimer;

@property (nonatomic, strong) UITableView *nwTableView;

@property (assign)  NSInteger gtSource;

@property (nonatomic, strong) UIButton *showButton;


@property (nonatomic, strong) NSMutableArray *mutArr;

@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *pushButton;






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

__weak id weakObj = nil;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    NSLog(@"will %@--%ld",weakObj,[self arc_retainCount:weakObj]);
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground) name: UIApplicationDidEnterBackgroundNotification object:nil];
    
}

- (void)applicationEnterBackground {
    
    NSLog(@"%@---%@",@(__PRETTY_FUNCTION__),@(__LINE__));
    
    

    [self testNWDispatchQueue];
}

//- app

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    NSLog(@"did %@--%ld",weakObj,[self arc_retainCount:weakObj]);
    
}

- (NSUInteger)arc_retainCount:(id)obj {
    return CFGetRetainCount((__bridge CFTypeRef)obj);
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    
    self = [super initWithCoder:coder];
    // 代码
    NSLog(@"initWithCoder");
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    // story and nib
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    NSLog(@"initWithNibName");

    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"awakeFromNib");

}

//- (void)loadView {
//
//    NSLog(@"loadview");
//    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.view.backgroundColor = UIColor.redColor;
//
//}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self testAutoUITest];
    
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


- (void)testAsync {
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"1");
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        NSLog(@"2");
    });
    
    
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
       
        NSLog(@"3--%@",[NSThread currentThread]);
    });
    
    
    NSLog(@"4");

    
}


- (void)test2018416 {
    

    /*
    
     //  使用  UIGraphicsBeginImageContextWithOptions生成的图片，每个像素需要4个字节表示
     建议使用 UIGraphicsImageRenderer，这个方法是从iOS10引入的，在iOS12上会自动选择最佳图像格式
     可以减少很多内存
     
     
     
     */
    
//    CGRect bounds = CGRectMake(0, 0, 300, 300);
////    UIGraphicsImageRenderer
//
//    UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:bounds.size];
////    UIImage *img = renderer.
//
//   UIImage *img = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
//
//        [[UIColor blackColor] setFill];
//        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(20, 20)];
//        [path addClip];
//        UIRectFill(bounds);
//
//    }];
//
//    if (img) {
//        // if u change color to tintColor of UIImageView
//
//    }
    

    

    // 缩减像素采样 downsampling 使用ImageIO进行处理图片
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"china_big_img" ofType:@"jpg"];
//    UIImage *imgOfContent = [UIImage imageWithContentsOfFile:path];
//    CGSize imgSize = imgOfContent.size;
    
    // Resizing image for not ImageIO
//    CGFloat scale = 0.2;
//    CGSize imgSize1 = CGSizeMake(imgOfContent.size.width * scale, imgOfContent.size.height * scale);
//    UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:imgSize1];
//    UIImage *resizingImage = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
//
//        [imgOfContent drawInRect:CGRectMake(0, 0, imgSize1.width, imgSize1.height)];
//
//    }];
    
    
    // for ImageIO
    NSURL *url = [NSURL URLWithString:path];
    
    CGImageSourceRef sourceRef = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
//    if (!sourceRef) {
//        NSLog(@"sourceref is null");
//        return;
//    }

    
    CFDictionaryRef imageOptions;
    CFStringRef imageKeys[2];
    CFTypeRef imageValues[2];
    
    imageKeys[0] = kCGImageSourceThumbnailMaxPixelSize;
    imageValues[0] = (CFTypeRef)100;
    
    imageKeys[1] = kCGImageSourceCreateThumbnailFromImageAlways;
    imageValues[1] = (CFTypeRef)YES;
    
    imageOptions = CFDictionaryCreate(kCFAllocatorNull, (const void **)imageKeys, (const void **)imageValues, 2, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
//
//    CGImageSourceRef sourceRef = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGImageRef imagRef = CGImageSourceCreateThumbnailAtIndex(sourceRef, 0, imageOptions);
    UIImage *scaleImage = [UIImage imageWithCGImage:imagRef];
    NSLog(@"IO----%@",NSStringFromCGSize(scaleImage.size));
    
    
    
    
    CFRelease(sourceRef);
//    CFRelease(imageOptions);
    CFRelease(imageKeys);
    CFRelease(imageValues);
    CFRelease(imagRef);
    
    
    
    
}


void handleSignalException(int signal) {
    
    NSMutableString *crashString = [NSMutableString new];
    void *callstack[128];
    int i,frames = backtrace(callstack, 128);
    char ** traceChar = backtrace_symbols(callstack, frames);
    for (i = 0; i < frames; i++) {
        [crashString appendFormat:@"%s\n",traceChar[i]];
    }
    
    NSLog(@"%@", crashString);
    
}

- (void)testNWDispatchQueue {
    
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.augus.concurrent", DISPATCH_QUEUE_CONCURRENT);
    NWDispatchQueue *nwQueue = [[NWDispatchQueue alloc] initWithQueue:concurrentQueue concurrentCount:3];
    
    
    
//    CFTimeInterval time1 = CACurrentMediaTime();
    
    [nwQueue async:^{

        for (int i = 0; i < 20; i++) {
            NSLog(@"开始(%d) --%@",i,[NSThread currentThread]);

            sleep(1);

            NSLog(@"结束(%d) --%@",i,[NSThread currentThread]);


        }

    }];
    
//    for (int i = 0; i < pow(10, 1); i++) {
//
//        NSLog(@"i---%@",@(i));
//        if (CACurrentMediaTime() - time1 > 3 * 60) {
//            handleSignalException(-1);
//        }
//    }
    
}


//
- (id)nw_objectAtIndex:(NSUInteger)index {
    
    NSUInteger _offset = 0,_size = 0;
    NSMutableArray *_list = [NSMutableArray array];
    
    NSUInteger fetchOffset = _offset + index;
    NSUInteger realIndex = fetchOffset - (_size > fetchOffset ? 0 : _size);
    
    return _list[realIndex];
    
}

- (void)testRetainCycle {
    
//    Person *p = [[Person alloc] init];
    
    
//    __block Person *bp = p;
//    p.name = @"niu";
//    p.pSpeak = ^{
//        NSLog(@"p name is %@",bp.name);
//        bp = nil;
//    };
//
//    p.pSpeak();
    
//    p.pNameSpeak = ^(NSString * _Nonnull name) {
//
//        NSLog(@"name is %@",name);
//    };
//    p.pNameSpeak(p.name);
    
    
//    __weak typeof(p)weakP = p;
//    p.pSpeak = ^{
//
//        __strong typeof(weakP)sp = weakP;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//            NSLog(@"p name is %@--%@",sp.name,sp);
//
//        });
//    };
//    p.pSpeak();
    
    dispatch_queue_t workConcurrentQueue = dispatch_queue_create("example.code", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t serialQueue = dispatch_queue_create("example.code.task",DISPATCH_QUEUE_SERIAL);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(4);
    for (NSInteger i = 0; i < 10; i++) {
        dispatch_async(serialQueue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            dispatch_async(workConcurrentQueue, ^{
                NSLog(@"thread-info:%@开始执行任务%d",[NSThread currentThread],(int)i);
                sleep(1);
                NSLog(@"thread-info:%@结束执行任务%d",[NSThread currentThread],(int)i);
                dispatch_semaphore_signal(semaphore);});
        });
    }
    NSLog(@"主线程...!");
    
    
    
    
}

- (void)findIMPForByCateory {
    
    Class currentClass = [NWPerson class];
    NWPerson *person = [[NWPerson alloc] init];
    
    if (currentClass) {
        unsigned int methodCount;
        Method *methodList = class_copyMethodList(currentClass, &methodCount);
        IMP lastImp = NULL;
        SEL lastSel = NULL;
        for (NSInteger i = 0; i < methodCount; i++) {
            Method method = methodList[i];
            NSString *methodName = [NSString stringWithUTF8String:sel_getName(method_getName(method))];
            
            if ([@"personPrint" isEqualToString:methodName]) {
                lastImp = method_getImplementation(method);
                lastSel = method_getName(method);
            }
        }
        typedef void(*fn) (id,SEL);
        if (lastImp) {
            fn f = (fn)lastImp;
            f(person,lastSel);
        }
        free(methodList);
    }
    
    
}

//#define GT_SON(name) typedef struct name##_a *name##_b


- (void)testTimerButtonTitle {
    
    
    NWButton *btn = [[NWButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    btn.backgroundColor = UIColor.greenColor;
    [btn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
    
    [btn startAnimation];
}

- (void)testClassAndMemoryAddress {
    
    
    
    
    /**
    类的隐藏参数：self and _cmd
     _cmd:表示当前调用的方法，其实就是一个方法选择器SEL
     // 压栈参数1: id self （4）
      压栈参数2:_cmd (3)
    id receiver :(等价于self) （1）
     Class super_class（等价于self.class）（2）
     objcet_msgSendSuper2(struct objc_super * super,SEL op,...)
     
     从那个viewDidLoad中入栈的高低顺序为
     self,_cmd,super_class,self,obj
     第一个self和和第二个_cmd是隐藏参数，第三个self.class和self是[super viewDidLoad]方法执行中的参数
     
    在调用self.name的时候，本质上是self指针的在内存向高位地址偏移一个指针
     
     
    obj---0x7ffee7b7b130
     self--- 0x7ffee7b7b138
     
     
     self---0x7ffee7b7b148
     
     - (Class)class {
         return object_getClass(self);
     }

     Class object_getClass(id obj)
     {
         if (obj) return obj->getIsa();
         else return Nil;
     }
     
     */
    
    
    
    
    NSLog(@"ViewController = %@,地址 = %p",self,&self);
    NSLog(@"%ld",sizeof(self));
    NSString *three = @"three";
    
    id cls = [Person class];
//    NSLog(@"Person class = %@,地址 = %p",cls,&cls);
    
//    id obj0 = &cls;
//    void *ivar = &obj0 + offset(N);
  // 0x7ffee4827130--->0x7ffee4827148 16，
// 20 4个指针大小 每个指针占8个字节
    // 20，2个位差是一个指针，0x7fff5c7b9a08---》0x7fff5c7b9a10，偏移一个指针

    //Objc中的对象是一个指向ClassObject地址的变量，即 id obj = &ClassObject ， 而对象的实例变量 void *ivar = &obj + offset(N)
    void *obj = &cls;
    NSLog(@"void *obj = %@,地址 = %p",obj,&obj);

    [(__bridge  id)obj speak];
    
    Person *p = [[Person alloc] init];
    NSLog(@"Person instance = %@,地址 = %p",p,&p);
    [p speak];
    
}

- (void)testWeakForSome {
    
    NSObject *ob = [NSObject new];
    
    // key:weak修饰的变量指向的对象
    // value:值就是weak修饰的变量
    
//    __weak id weakObj;
    // &weakObj __weak指针的地址
    // ob:需要进行弱引用的对象的指针
//    objc_initWeak(&weakObj,ob);
    
    __weak id weakObj = ob;
    
    NSLog(@"%@",weakObj);
//    NSLog(@"%@",objc_loadWeakRetained(&weakObj));
    
    
    // weakobj 离开作用域，销毁
//    objc_destroyWeak(&weakObj);
    
//    UIButton *btn = [UIButton new];
//    UIControl *con = [UIControl new];
    
//    NSProxy *pr = [NSProxy alloc];
    
    
    
    
    

}


- (NSArray *)testViewImageViews:(UIView *)aView {
    
    if (!aView) {
        return nil;
    }
        // 存放结果数组
    NSMutableArray *tempArray = [NSMutableArray array];
    for (UIView *sub in aView.subviews) {
        
        if ([sub isKindOfClass:[UIImageView class]]) {
            [tempArray addObject:sub];
        }
        
        // Recursion
        // recursion
        NSArray *subArray = [self testViewImageViews:sub];
        [tempArray addObjectsFromArray:subArray];
        
    }
    
    return tempArray;
}

- (void)testAtomic {
    
//    Person *p = [Person new];
    
    // atomic 指定编译器把读写方法设置为原子读写，并添加互斥锁进行保护
//    dispatch_queue_t gtQueue = dispatch_queue_create("gtQueue1", NULL);
//    dispatch_async(gtQueue, ^{
//        for (int i = 0; i < 1000; i++) {
//
//            self.gtSource += 1;
//        }
//
//        NSLog(@"gt source0 %ld",(long)self.gtSource);
//
//    });
//
//    dispatch_queue_t gtQueue2 = dispatch_queue_create("gtQueue2", NULL);
//    dispatch_async(gtQueue2, ^{
//        for (int i = 0; i < 1000; i++) {
//
//            self.gtSource += 1;
//        }
//        NSLog(@"gt source2 %ld",(long)self.gtSource);
//
//    });
//
//    NSLog(@"gt source1 %ld",(long)self.gtSource);
    
//    int __block a = 0;
//    dispatch_semaphore_t semA = dispatch_semaphore_create(1);
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//        intptr_t wait = dispatch_semaphore_wait(semA, DISPATCH_TIME_FOREVER);
//        // -1,if wait is bigger 0,and return ,or is block the current thread
////        @synchronized (self) {
//
//            for (int i = 0; i < 100; i++) {
//                a = 3;
//                NSLog(@"线程A---%d",a);
//            }
////        }
//        // +1,if signal is bigger 0,and return,or wake up someone thread,
//        intptr_t signal = dispatch_semaphore_signal(semA);
//
//    });
//
//
//    dispatch_semaphore_t semB = dispatch_semaphore_create(1);
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        dispatch_semaphore_wait(semB, DISPATCH_TIME_FOREVER);
//
////        @synchronized (self) {
//
//            for (int i = 0; i < 100; i++) {
//                a = 33;
//                NSLog(@"线程B---%d",a);
//            }
////        }
//        dispatch_semaphore_signal(semB);
//
//    });
    
    
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
    
    
//    BOOL lock = NO;
//    while (YES) {
        
        // 申请锁
//        lock = YES;
//        if (lock) {
//            NSLog(@"临界区");
//            lock = NO;
//        }
        
        
        // 释放锁
//    }

    
//    objc_sync_enter(self);
    
//    objc_sync_wait(self,0.23);
    
//    NSProxy *pro = [NSProxy alloc];
    
}

- (void)testCornerRadius {
    
    // for tableview
    [self.view addSubview:self.nwTableView];
    [self.nwTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"nwTableViewCell"];
    
    
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [self.view addSubview:imgView];
//
//    UIImage *tmpImage = [UIImage imageNamed:@"icon_11"];
//    imgView.image = [tmpImage nw_imageAddRadius:50 withSize:CGSizeMake(100, 100)];
    
    
}

#pragma mark - UITabelView DataSource


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return kImageWidth;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nwTableViewCell"];
    
    if (indexPath.row % 2 == 0) {
//        cell.imageView.image = [UIImage imageNamed:@"icon_04"];
        
        cell.textLabel.text=  @"niu wei";
        UIImage *tmpImage = [UIImage imageNamed:@"icon_11"];
        cell.imageView.image = [tmpImage nw_imageAddRadius:5 withSize:CGSizeMake(kImageWidth, kImageWidth)];
    } else {
        // 中文也没有影响了
        cell.textLabel.text = @"高田";
        cell.imageView.image = [UIImage imageNamed:@"1"];

    }
    
    // 会手动触发离屏渲染
//    cell.imageView.layer.shouldRasterize = YES;
    
    // 解决color blended layers
    cell.textLabel.backgroundColor = UIColor.whiteColor;
    
    
//    cell.imageView.layer.cornerRadius = 4.0;
//    cell.imageView.layer.masksToBounds = YES;
//    cell.imageView.backgroundColor = UIColor.whiteColor;
    
//    cell.backgroundColor = UIColor.whiteColor;
    cell.contentView.backgroundColor = UIColor.whiteColor;
    
    return cell;
}

- (NSArray *)findAllImageView:(UIView *)aView {
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    if (!aView) {
        return nil;
    }
    for (UIView *subView in aView.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            [tmpArray addObject:subView];
        }
        NSArray *interArray = [self findAllImageView:subView];
        [tmpArray addObjectsFromArray:interArray];
    }
    
    if (tmpArray.count <= 0) {
        tmpArray = nil;
    }

    return tmpArray;
}





- (void)testCateory {
    
    NWPerson *p1 = [[NWPerson alloc] init];
    [p1 personPrint];
    
    
    
    
}

- (void)testMapAndHashTable {
    
    /*
     
     
     /// set value for key
     void CFDictionarySetValue(CFMutableDictionaryRef dict, const void *key, const void *value) {
         /// 假如字典中存在key，match返回keyHash的存储位置
         /// 假如字典中不存在key，nomatch存储插入key的存储位置
         CFIndex match, nomatch;
         __CFDictionaryFindBuckets2(dict, key, &match, &nomatch);
         ......
         
         if (kCFNotFound != match) {
         /// 字典中已经存在key，修改操作
             CF_OBJC_KVO_WILLCHANGE(dict, key);
             ......
             CF_WRITE_BARRIER_ASSIGN(valuesAllocator, dict->_values[match], newValue);
             CF_OBJC_KVO_DIDCHANGE(dict, key);
         } else {
         /// 字典中不存在key，新增操作
             ......
             CF_OBJC_KVO_WILLCHANGE(dict, key);
             CF_WRITE_BARRIER_ASSIGN(keysAllocator, dict->_keys[nomatch], newKey);
             CF_WRITE_BARRIER_ASSIGN(valuesAllocator, dict->_values[nomatch], newValue);
             dict->_count++;
             CF_OBJC_KVO_DIDCHANGE(dict, key);
         }
     }
      
     /// 查找key存储位置
     static void __CFDictionaryFindBuckets2(CFDictionaryRef dict, const void *key, CFIndex *match, CFIndex *nomatch) {
         /// 对key进行hash化，获取keyHash
         const CFDictionaryKeyCallBacks *cb = __CFDictionaryGetKeyCallBacks(dict);
         CFHashCode keyHash = cb->hash ? (CFHashCode)INVOKE_CALLBACK2(((CFHashCode (*)(const void *, void *))cb->hash), key, dict->_context) : (CFHashCode)key;
         const void **keys = dict->_keys;
         uintptr_t marker = dict->_marker;
         CFIndex probe = keyHash % dict->_bucketsNum;
         CFIndex probeskip = 1;
         CFIndex start = probe;
         *match = kCFNotFound;
         *nomatch = kCFNotFound;
         
         for (;;) {
             uintptr_t currKey = (uintptr_t)keys[probe];
             /// 如果keyHash对应的桶是空桶，那么标记nomatch，返回未匹配
             if (marker == currKey) {
                 if (nomatch) *nomatch = probe;
                 return;
             } else if (~marker == currKey) {
                 if (nomatch) {
                     *nomatch = probe;
                     nomatch = NULL;
                 }
             } else if (currKey == (uintptr_t)key || (cb->equal && INVOKE_CALLBACK3((Boolean (*)(const void *, const void *, void*))cb->equal, (void *)currKey, key, dict->_context))) {
                 *match = probe;
                 return;
             }
             /// 如果未匹配，说明发生了冲突，那么将桶下标向后移动，直到找到空桶位置
             probe = probe + probeskip;
         
             if (dict->_bucketsNum <= probe) {
                 probe -= dict->_bucketsNum;
             }
             if (start == probe) {
                 return;
             }
         }
     }
     ————————————————
     */
    
    
    /*
     1 更广泛意义的NSSet,区别在于NSSet和NSMutableSet
     特性：
     NSHashTable可变的
     NSHashTable可以持有weak类型的成员变量
     NSHashTable可以添加成员变量的时候复制成员
     NSHashTable可以随意的存储指针并利用指针唯一性来检查hash同一性检测和对比操作
     
     NSPointerFunctionsOptions：
     
     NSHashTableStrongMemory 等价于NSPointFunctionsStrongMemory 对成员变量进行强引用，默认值
     这样NSHashTable和NSSet和NSMutableSet就无区别了
     
     NSHashTableWeakMemory 对成员变量进行弱引用，使用NSPointerFunctionsWeakMemory object在最后释放的时候会被指向NULL
     
     NSHashTableZeroingWeakMemory 已被抛弃，使用NSHashTableWeakMemory代替
     
     NSHashTableCopyin 在对象被加入集合之前进行复制，等同于NSPointerFunctionsCopyin
     
     NSHashTableTableObjectPointerPersonality 用指针来等同代替实际的值，当打印这个指针的时候相当于调用description方法
     和NSPointerFunctionsObjectPointerPersonality等同
     
     
     */
    
    NSHashTable *hashTable = [NSHashTable hashTableWithOptions:NSPointerFunctionsCopyIn];
    [hashTable addObject:@"1"];
    [hashTable addObject:@"bar"];
    [hashTable addObject:@"func"];
    
    [hashTable removeObject:@"bar"];
    NSLog(@"hash table %@",hashTable.allObjects);
    
    
    /*
     NSMapTable 是对更广泛意义的NSDictionary和Dictionary 有以下特性
     NSDictionary和NSMutableDictionary会复制keys 并且通过强引用values实现存储
     NSMapTable是可变的
     NSMapTable是可以通过弱引用来持有keys和values，所以当key或者value被dealloc的时候，所存储的实体也会被移除
     NSMapTable可以在添加value的时候对value进行复制
     
    
     */
    
//    id __weak
    SomeSDWebImage *some = [[SomeSDWebImage alloc] initWithName:@"niu"];
    id __weak someWeak = some;
    
    NSMapTable *mapTable = [NSMapTable mapTableWithKeyOptions:NSMapTableStrongMemory valueOptions:NSMapTableWeakMemory];
    
    [mapTable setObject:someWeak forKey:@"sweak"];
    NSLog(@"keys--%@",[[mapTable keyEnumerator] allObjects]);
    
}

- (void)testCGImageSet {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imageView];
    
    [imageView nw_setImage];
}


- (void)testAttributeRect {
    
    
    UILabel *nwLabel = [UILabel new];
    nwLabel.frame = CGRectMake(100, 100, 200, 50);
    nwLabel.backgroundColor = UIColor.greenColor;
    nwLabel.text = @"就是ai123";
    [self.view addSubview:nwLabel];
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    UIFont *nwFont = [UIFont systemFontOfSize:19];
    
    // 获取size
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *tmpString = @"就是爱你112233sadsadasd";
        CGRect nwRect = [tmpString boundingRectWithSize:CGSizeMake(200, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:nwFont, NSParagraphStyleAttributeName:paragraphStyle} context:nil];
        NSLog(@"rect: %@",NSStringFromCGRect(nwRect));
        
        
//        [tmpString drawWithRect:nwRect options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:nwFont, NSParagraphStyleAttributeName:paragraphStyle} context:nil];
        
        
    });
    

    
}

- (id)testErrorParam:(NSDictionary *)param error:(NSError *)error {
    
    NSArray *res = nil;
    if (res) {
        return res;
    } else {
        NSLog(@"222---%p",error);
//        if (!error) {
//            return nil;
//        }
        error = [NSError errorWithDomain:@"1026" code:1029 userInfo:nil];
        NSLog(@"333---%p",error);

    }
    /**
     
     **
     2021-03-16 09:40:51.748175+0800 YPYDemo[2711:52106] 000---0x0
     2021-03-16 09:40:51.748285+0800 YPYDemo[2711:52106] 222---0x7ffeedf62148
     2021-03-16 09:40:51.748387+0800 YPYDemo[2711:52106] 333---0x7ffeedf62148
     
     *
     2021-03-16 09:44:24.463939+0800 YPYDemo[2816:55225] 000---0x0
     2021-03-16 09:44:24.464031+0800 YPYDemo[2816:55225] 222---0x0
     2021-03-16 09:44:24.464111+0800 YPYDemo[2816:55225] 333---0x60000181cc90
     */
    return nil;
}

- (void)testCollectionPage {
    
    [self.view addSubview:self.nwCollectionView];
    [self.nwCollectionView registerClass:[NWCollectionViewCell class] forCellWithReuseIdentifier:kCollectionCell];
}

- (void)nw_addTimer {
        
    self.nwTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(nw_nextImage) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.nwTimer forMode:NSRunLoopCommonModes];
}

- (void)nw_nextImage {
    
    
    // 获取当前可见cell section
    
    // cell + 1
     
    // 判断是否为index 4 如果是4 index为0 section +1
    
    // 跳转
    
    // 获取当前
    NSIndexPath *currentIndexPath = [[self.nwCollectionView indexPathsForVisibleItems] lastObject];

    NSLog(@"currentIndexPath--%ld--%ld",(long)currentIndexPath.item,currentIndexPath.section);
    // 设置下一个滚动的item
    NSInteger nextItem = currentIndexPath.item + 1;
    NSInteger nextSection = currentIndexPath.section;
    
    //
//    self.nwPageControl.currentPage = nextItem;
    if (nextItem == self.imageSource.count) {
        nextItem = 0;
        nextSection++;
    }
    
    NSLog(@"nextIndexPath--%ld",(long)nextItem);

    
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    // 解决iOS 14+ 不能进行主动跳转item
    if (@available(iOS 14.0, *)) {
        UICollectionViewLayoutAttributes *attributesNext = [self.flowLayout layoutAttributesForItemAtIndexPath:nextIndexPath];
        [self.nwCollectionView setContentOffset:attributesNext.frame.origin animated:YES];
    } else {
        [self.nwCollectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];

    }
}

//- (void)nw_removeTimer {
//    [self.nwTimer invalidate];
//    self.nwTimer = nil;
//}
//
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [self nw_removeTimer];
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//
//    [self nw_addTimer];
//}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.imageSource.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[NWCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
    }
    
    cell.iconName = self.imageSource[indexPath.row];
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int page = (int)(scrollView.contentOffset.x / self.view.bounds.size.width) % self.imageSource.count;
    self.nwPageControl.currentPage = page;
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


#pragma mark - Lazy load

- (UICollectionView *)nwCollectionView {
    if (!_nwCollectionView) {
        
        _nwCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200) collectionViewLayout:self.flowLayout];
        _nwCollectionView.dataSource = self;
        _nwCollectionView.delegate = self;
        
        _nwCollectionView.pagingEnabled = YES;
        _nwCollectionView.backgroundColor = UIColor.greenColor;
        _nwCollectionView.showsHorizontalScrollIndicator = NO;
    }
    return _nwCollectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, 200);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing = 1.0;
        _flowLayout.minimumInteritemSpacing = 5.0;
    }
    return _flowLayout;
}

- (NSMutableArray *)imageSource {
    if (!_imageSource) {
        _imageSource = [NSMutableArray array];
        for (int i = 0; i< 5; i++) {
            NSString *imageName = [NSString stringWithFormat:@"icon_%d",i];
            [_imageSource addObject:imageName];
        }
        
    }
    return _imageSource;
}

- (UIPageControl *)nwPageControl {
    if (!_nwPageControl) {
        _nwPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 420, self.view.bounds.size.width, 30)];
        _nwPageControl.center = self.view.center;
        _nwPageControl.numberOfPages = self.imageSource.count;
        _nwPageControl.backgroundColor = UIColor.redColor;
    }
    return _nwPageControl;
}

- (UITableView *)nwTableView {
    if (!_nwTableView) {
        _nwTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _nwTableView.delegate = self;
        _nwTableView.dataSource = self;
        
    }
    return _nwTableView;
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
        [_pushButton setTitle:@"跳转" forState:UIControlStateNormal];
        [_pushButton addTarget:self action:@selector(pushButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_pushButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
        _pushButton.backgroundColor = UIColor.redColor;
    }
    return _pushButton;
}

@end
