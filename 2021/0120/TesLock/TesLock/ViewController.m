//
//  ViewController.m
//  TesLock
//
//  Created by Augus on 2021/1/20.
//

#import "ViewController.h"
#import <pthread.h>
#import <libkern/OSAtomic.h>
#import <QuartzCore/QuartzCore.h>
#import <os/lock.h>
#import <TestBundle/TestBundle.h>
//#import <FosaferAuth/FOSOut.h>
#import "responderView.h"


#define nw_inline __inline__ __attribute__((always_inline))

typedef NS_ENUM(NSInteger,LockType) {
    LockTypeOSSpinLock = 0,
    LockTypedispatch_semaphore,
    LockTypepthread_mutex,
    LockTypeNSCondition,
    LockTypeNSLock,
    LockTypepthread_mutex_recursive,
    LockTypeNSRecursiveLock,
    LockTypeNSConditionLock,
    LockTypesynchronized,
    LockTypeOSUnfairLock,
    LockTypeCount,
};

typedef NS_OPTIONS(NSUInteger, FOSControllerAbility) {
    FOSControllerAudio          = 1 << 0,//1 //2
    FOSControllerVideo          = 1 << 1,//2 //4
    FOSControllerAuth           = 1 << 2,//4 //8
    FOSControllerCompound           = 1 << 3,//8 //16
    
    // (2 * n)
    // pow(2,x) * n
    // 3 6 12 24
};

NSTimeInterval TimeCosts[LockTypeCount] = {0};
int TimeCount = 0;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.view.backgroundColor = UIColor.whiteColor;
        
//    int temparray[5] = {0};
//    for (int i = 0; i < 5; i++) {
//        temparray[i] += i;
//    }
//
//    printArray(temparray,0,5);
    
//    testB();
    
//    [self testResponder];

}


- (void)testResponder {
    
    responderView *responder = [[responderView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:responder];
    
}


- (void)testSomeLock {
    int buttonCount = 5;
    for (int i = 0; i < buttonCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 200, 50);
        button.center = CGPointMake(self.view.frame.size.width / 2, i * 60 + 160);
        button.tag = pow(10, i + 3);
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button setTitle:[NSString stringWithFormat:@"run (%d)",(int)button.tag] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)nwBlock {
    /*
     
     编译器会根据block捕获的变量，生成具体的结构体定义。
     block内部的代码将会提取出来，成为一个单独的C函数。
     创建block时，实际就是在方法中声明一个struct，并且初始化该struct的成员。而执行block时，就是调用那个单独的C函数，并把该struct指针传递过去。
     
     block中的isa指向的是该block的Class。在block runtime中，定义了6种类：

     _NSConcreteStackBlock     栈上创建的block
     _NSConcreteMallocBlock  堆上创建的block
     _NSConcreteGlobalBlock   作为全局变量的block
     _NSConcreteWeakBlockVariable
     _NSConcreteAutoBlock
     _NSConcreteFinalizingBlock
     
     上面代码可以看到，当struct第一次被创建时，它是存在于该函数的栈帧上的，其Class是固定的_NSConcreteStackBlock。其捕获的变量是会赋值到结构体的成员上，所以当block初始化完成后，捕获到的变量不能更改。

     当函数返回时，函数的栈帧被销毁，这个block的内存也会被清除。所以在函数结束后仍然需要这个block时，就必须用Block_copy()方法将它拷贝到堆上。这个方法的核心动作很简单：申请内存，将栈数据复制过去，将Class改一下，最后向捕获到的对象发送retain，增加block的引用计数。详细代码可以直接点这里查看。
     
     struct Block_layout *result = malloc(aBlock->descriptor->size);
     memmove(result, aBlock, aBlock->descriptor->size);
     result->isa = _NSConcreteMallocBlock;
     _Block_call_copy_helper(result, aBlock);
     return result;
     
     3.__block类型的变量
     
     
     
     */
    int i = 2;
    NSNumber *num = @3;
    
    long (^myBlock)(void) = ^long() {
        return i * num.intValue;
    };
    
    long r = myBlock();
    NSLog(@"rrr---%ld",r);
    
    // __block 修改外部值
    __block int j = 1;
    void(^nwBlock)(void) = ^{
        j *= 2;
    };
    nwBlock();
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    IconController *icon = [[IconController alloc] init];
//    [self presentViewController:icon animated:YES completion:^{
//
//    }];
}

nw_inline void testA(){
    printf("testA--0");
}

void testB(){
    testA();
}

- (void)tap:(UIButton *)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self test:(int)sender.tag];
    });
}

- (void)test:(int)count {
    NSTimeInterval begin, end;
    TimeCount += count;
    
    {
        OSSpinLock lock = OS_SPINLOCK_INIT;
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            OSSpinLockLock(&lock);
            OSSpinLockUnlock(&lock);
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypeOSSpinLock] += end - begin;
        printf("OSSpinLock:               %8.2f ms\n", (end - begin) * 1000);
    }
    
    
    {
        dispatch_semaphore_t lock =  dispatch_semaphore_create(1);
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
            dispatch_semaphore_signal(lock);
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypedispatch_semaphore] += end - begin;
        printf("dispatch_semaphore:       %8.2f ms\n", (end - begin) * 1000);
    }
    
    
    {
        pthread_mutex_t lock;
        pthread_mutex_init(&lock, NULL);
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            pthread_mutex_lock(&lock);
            pthread_mutex_unlock(&lock);
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypepthread_mutex] += end - begin;
        pthread_mutex_destroy(&lock);
        printf("pthread_mutex:            %8.2f ms\n", (end - begin) * 1000);
        
//        pthread_mutex_trylock(&lock); ==0 means try lock is success
        
    }
    
    
    {
        NSCondition *lock = [NSCondition new];
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            [lock lock];
            [lock unlock];
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypeNSCondition] += end - begin;
        printf("NSCondition:              %8.2f ms\n", (end - begin) * 1000);
    }
    
    
    {
        NSLock *lock = [NSLock new];
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            [lock lock];
            [lock unlock];
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypeNSLock] += end - begin;
        printf("NSLock:                   %8.2f ms\n", (end - begin) * 1000);
    }
    
    
    {
        pthread_mutex_t lock;
        pthread_mutexattr_t attr;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
        pthread_mutex_init(&lock, &attr);
        pthread_mutexattr_destroy(&attr);
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            pthread_mutex_lock(&lock);
            pthread_mutex_unlock(&lock);
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypepthread_mutex_recursive] += end - begin;
        pthread_mutex_destroy(&lock);
        printf("pthread_mutex(recursive): %8.2f ms\n", (end - begin) * 1000);
    }
    
    
    {
        NSRecursiveLock *lock = [NSRecursiveLock new];
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            [lock lock];
            [lock unlock];
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypeNSRecursiveLock] += end - begin;
        printf("NSRecursiveLock:          %8.2f ms\n", (end - begin) * 1000);
    }
    
    
    {
        NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:1];
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            [lock lock];
            [lock unlock];
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypeNSConditionLock] += end - begin;
        printf("NSConditionLock:          %8.2f ms\n", (end - begin) * 1000);
    }
    
    
    {
        NSObject *lock = [NSObject new];
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            @synchronized(lock) {}
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypesynchronized] += end - begin;
        printf("@synchronized:            %8.2f ms\n", (end - begin) * 1000);
    }
    
    {
        os_unfair_lock lock = OS_UNFAIR_LOCK_INIT;
        begin = CACurrentMediaTime();
        for(int i = 0;i < count;i++){
            // 会阻塞线程
            os_unfair_lock_lock(&lock);
            os_unfair_lock_unlock(&lock);

            // 不会阻塞线程
//          bool isLock =  os_unfair_lock_trylock(&lock);
//            if (isLock) {
//                os_unfair_lock_unlock(&lock);
//            }
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypeOSUnfairLock] += end - begin;
        printf("osUnfairLock:            %8.2f ms\n", (end - begin) * 1000);

        
    }
    
    printf("---- fin (%d) ----\n\n",count);
    /* 输出数组中每个元素的值 */
//    for (int i = 0; i < LockTypeCount; i++ )
//    {
//        printf("TimeCosts[%d] = %8.2f\n",i , TimeCosts[i]);
//    }
    
}
    
void printArray(int array[],int begin,int end)
{
    
    for (int i = begin; i < end; i++) {
        printf("array[%d] = %d\n",i , array[i]);

    }
}

@end
