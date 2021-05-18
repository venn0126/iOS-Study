//
//  ViewController.m
//  DDDemo
//
//  Created by Augus on 2021/5/14.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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
    
    
    [self testGCDTest];
    
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
//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:task1];
//    [operation addExecutionBlock:task2];
//
//    NSBlockOperation *task3opertaion = [NSBlockOperation blockOperationWithBlock:task3];
//    [task3opertaion addDependency:operation];
//
//    [operation start];
//    [task3opertaion start];

    

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
