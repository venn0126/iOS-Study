//
//  ViewController.m
//  DDDemo
//
//  Created by Augus on 2021/5/14.
//

#import "ViewController.h"
#import <sys/signal.h>

#import <execinfo.h>
#import <mach/task.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // UIBackgroundTaskIdentifier
    NSLog(@"applicationDidEnterBackground");
    UIBackgroundTaskIdentifier identifier =  [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            
        // your long time task
        
        NSMutableArray *temoArray = [NSMutableArray array];
        for (int i = 0; i < pow(10, 9); i++) {
            [temoArray addObject:[NSNumber numberWithInt:i]];
        }
        
    }];
    
    NSLog(@"crash identifier is  %ld",identifier);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"Home";
    
//    NSArray *array = @[@-1,@0,@1,@2,@-1,@-4];
////    NSDictionary *res = [self twoSumForIndex2:array];
////    NSLog(@"0000 --%@",res);
//    NSArray *res = [self sumForZero:array];
//    NSLog(@"res ---%@",res);
    
    
//    [self testGCDTest];

    
//    [self testSemaphore];
    
//    [self testOCCrash];
    
//    NSLog(@"screen scale %.2f",[UIScreen mainScreen].scale);
  
    
//    [self testImageScale];
    
//    [self oldMethod:@"sss"];
    
//    self.view.superview.setNeedsLayout
    
    
//    handleSignalException(0);
    
    [self testPtrAndArray];
    
//    struct mach_task_basic_info info;
    
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
    // 6000 60004 60008 6012
    // 6000 -           6015 共16个字节
    //
    // &arr2+1,数组首地址+数组总长，6000 + 16 = 6016
    // 此时 onPtr就是一个新的数组，此时6016就是数组首地址
    // onPtr是首元素，onPtr-1是倒着取一个元素6012，onPtr-2是，6008，onPtr-3.6004

}



/// __attribute__ 演示
- (void)oldMethod:(NSString *)string __attribute__((availability(ios,introduced=2_0,deprecated=7_0,message="用 -newMethod: 这个方法替代 "))){
    NSLog(@"我是旧方法,不要调我");
}

- (void)newMethod:(NSString *)string{
    NSLog(@"我是新方法");
}


- (void)testImageScale {
    
//    CGBitmapContextCreate(void * _Nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef  _Nullable space, uint32_t bitmapInfo)
    
    UIImage *image = [UIImage imageNamed:@"icon"];
    NSLog(@"image size: %@",NSStringFromCGSize(image.size));
}

void registerSignalHandler(void) {
    
    signal(SIGSEGV, handleSignalException);
}

void handleSignalException(int signal) {
    
//    NSMutableString *crashString = [NSMutableString new];
//    void * callstack[128];
//    int i,frames = backtrace(callstack,128);
//    char **traceChar = backtrace_symbol(callstack,frames);
//    for (int i = 0; i < frames; i++) {
//        [crashString appendFormat:@"%s\n",[traceChar[i]];
//    }
    
    void *callstack[128];
    int frames = backtrace(callstack,128);
    char** strs = backtrace_symbols(callstack, frames);
    // 存放堆栈的数组
    NSMutableArray *backtraces = [NSMutableArray array];
    for (int i = 0; i < frames; i++) {
        [backtraces addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    NSLog(@"current stack %@",backtraces);
    free(strs);

    
}

- (void)testOCCrash {
    
    
    // 可捕获崩溃
    NSArray * arr = @[@(1), @(2), @(3),];
    NSLog(@"arr 4: %@", arr[4]);
    
    // 访问相册
    
}

- (void)testSemaphore {
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    int timeCount = 0;
    
    while (YES) {
        
        // 即对 semaphore.count 成功减 1，返回值为 0,顺利执行之后的逻辑
        // 即对 semaphore.count 没有任何影响，返回值为非 0，卡住当前线程
      long semaphoreWait = dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC));
        NSLog(@"long sem %ld",semaphoreWait);
        // 操作失败 阻塞当前线程 直到semaphore count 大于0
        if (semaphore != 0) {
            /*
             
             if (!runloopObserver) {
                timeout = 0;
                
             }
             
             */
            
            NSLog(@"wait 3 s");
            timeCount += 1;
            // beforeSourece & afterWaiting
            if (timeCount == 2) {
                // 不存在因为 P 操作而阻塞的线程，直接返回 0，semaphore.count 增加了 1
                // 存在因为 P 操作而阻塞的线程，唤醒该线程，然后返回非 0 值
                intptr_t signal = dispatch_semaphore_signal(semaphore);
                NSLog(@"sem %ld",signal);

                break;
            }
        }
    }
    
    
    NSLog(@"success");
}


/// Find the nearest super view for view and other view,T(O) = O()
/// @param oneView a view instance
/// @param otherView other view instance
- (UIView *)twoViewsofCommonSuperView:(UIView *)oneView otherView:(UIView *)otherView {
    
    NSArray *views1 = [self viewForSuperviews:oneView];
    NSArray *views2 = [self viewForSuperviews:otherView];
    NSSet *setViews1 = [NSSet setWithArray:views1];
    for (int i = 0; i < views2.count; i++) {
        if ([setViews1 containsObject:views2[i]]) {
            return views2[i];
        }
    }
    return nil;
}

- (NSArray *)viewForSuperviews:(UIView *)view {
    
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



- (void)testGCDTest {
    
    
    // a2s b 3s 异步并发
    
    // c
    
    int count = 10;
    CFTimeInterval stat3 = CACurrentMediaTime();

    void (^task1)(void) = ^{

        NSLog(@"task 1 beigin");
        sleep(2);
        NSLog(@"task 1 end");
    };

    void (^task2)(void) = ^{

        NSLog(@"task 2 begin");
        sleep(3);
        NSLog(@"task 2 end");

    };


    void (^task3)(void) = ^{

        NSLog(@"task 3");
        NSLog(@"barrier time %.2f",CACurrentMediaTime()-stat3);
        // barrier 3.00 3.01 3.01 3.01 3.00
     
    };

    void (^barrier)(void) = ^{
        NSLog(@"barrier 3");
        

    };
    
    
    // barrier
//    dispatch_queue_t queue = dispatch_queue_create("com.dd.ss", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue, task1);
//    dispatch_async(queue, task2);
//    dispatch_barrier_async(queue, barrier);
//    dispatch_async(queue, task3);
    
    
    
    // GCD group

    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.dd.concurrent", DISPATCH_QUEUE_CONCURRENT);
    
//    dispatch_group_enter(group);
    dispatch_group_async(group, concurrentQueue, task1);
//    dispatch_group_leave(group);
    
    
//    dispatch_group_enter(group);
    dispatch_group_async(group, concurrentQueue, task2);
//    dispatch_group_leave(group);

    dispatch_group_notify(group, concurrentQueue,task3);


    // nsblockoperation
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:task1];
    [operation addExecutionBlock:task2];
    

    NSBlockOperation *task3opertaion = [NSBlockOperation blockOperationWithBlock:task3];
    [task3opertaion addDependency:operation];

    [operation start];
    [task3opertaion start];

    

}




/// Return a array for three nums of sum
/// @param array a array instance
- (NSArray *)sumForZero:(NSArray *)array {
    
    // [-1,0,1,2,-1,-4]
    // safe param judge
    if (!array || array.count <= 0) {
        return nil;
    }
    
    // 任意三个数字相加为0
    // 转化为 两个sum和 数组相等
    // 并且 sum的对应的两个index 不能包含等值的index
    // 1.求sum
    // 2.和原始元素比较

    
    // key sum
    // value index
    NSDictionary *sumDict = [self twoSumForIndex2:array];
    //
    NSMutableArray *res = [NSMutableArray array];
    
    
    for (int i = 0; i < array.count; i++) {
        int value = [array[i] intValue];
        [sumDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {

            int sum = [obj intValue];
            NSArray *indexArray = (NSArray *)key;
            NSMutableArray *temp = [NSMutableArray arrayWithArray:indexArray];
            if (value == (-sum)) {// 三个数之和为0
                // 不能包含该index
                if (![indexArray containsObject:[NSNumber numberWithInt:i]]) {
                    [temp addObject:[NSNumber numberWithInt:i]];
                }
            }
            if (temp.count == 3) {
                // 排序
               NSArray *sortArray = [self sortArray:[temp copy]];
                
                // 去重
                if (![res containsObject:sortArray]) {
                    [res addObject:sortArray];
                }
            }
         
        }];
    }    
    return [res copy];
}


- (NSArray *)sortArray:(NSArray *)array {
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
    NSArray *sortedArray = [array sortedArrayUsingDescriptors:@[sort]];
//    NSLog(@"排序后:%@",sortedArray);
    return sortedArray;
}

- (NSDictionary *)twoSumForIndex2:(NSArray *)array {
    if (!array || array.count <= 0) {
        return nil;
    }
    int sum = 0;
//    NSMutableArray *resArray = [NSMutableArray array];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (int i = 0; i < array.count; i++) {
        for (int j = i+1; j < array.count; j++) {
            sum = [array[i] intValue] + [array[j] intValue];
//            NSLog(@"i--%d---%d",i,j);
            NSArray *tempArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:i],[NSNumber numberWithInt:j], nil];
            [dict setObject:[NSNumber numberWithInt:sum] forKey:tempArray];
        }
    }
//    NSLog(@"res---%@\n count---%d",resArray,resArray.count);

    return [dict copy];
}










@end
