//
//  ChengReserverMgr.m
//  TestHookEncryption
//
//  Created by Augus on 2024/8/29.
//

#import "ChengReserverMgr.h"


@interface ChengReserverMgr ()

/// 抢单队列
@property (nonatomic, strong) NSOperationQueue *operationQueue;

/// 抢单任务是否进行中
@property(nonatomic, assign) BOOL isRunning;

@end

@implementation ChengReserverMgr


- (instancetype)init {
    self = [super init];
    if(!self)  return nil;
    
    _stopRequested = NO;
    _isRunning = NO;
    _operationQueue = [[NSOperationQueue alloc] init];
    _operationQueue.maxConcurrentOperationCount = 5; // 控制最大并发数
    return self;
}

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static ChengReserverMgr *mgr = nil;
    dispatch_once(&onceToken, ^{
        mgr = [[ChengReserverMgr alloc] init];
    });
    
    return mgr;
}


- (void)startReservingTickets {
    
    if(self.isRunning) return;
    self.stopRequested = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (!self.stopRequested) {
            self.isRunning = YES;
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                [self simulateClick];
            }];
            
            // 添加随机延时
            [NSThread sleepForTimeInterval:[self randomInterval]];
            
            [self.operationQueue addOperation:operation];
        }
    });
}

- (void)simulateClick {
    
    NSLog(@"simulateClick---%@",[NSThread currentThread]);
    // 模拟用户滑动或点击
    [self simulateUserInteraction];
    
    // 立即预约请求
    [self immediateReserve];
    
    // 模拟用户的后续操作，如返回上一页或点击其他地方
    [self simulateUserInteraction];
}

- (void)simulateUserInteraction {
    // 随机选择用户行为：滑动或点击
    int actionType = arc4random_uniform(2); // 0 - 点击, 1 - 滑动
    
    switch (actionType) {
        case 0:
            [self simulateUserInteractionInTableView:nil];
            break;
        case 1:
            [self simulateUserInteractionInTableView:nil];
            break;
        default:
            break;
    }
}


- (void)simulateUserInteractionInTableView:(UITableView *)tableView {
    // 随机选择用户行为：点击或滑动
    int actionType = arc4random_uniform(2); // 0 - 点击, 1 - 滑动
    
    switch (actionType) {
        case 0:
            [self simulateTapInTableView:tableView];
            break;
        case 1:
            [self simulateSwipeInTableView:tableView];
            break;
        default:
            break;
    }
}

- (void)simulateTapInTableView:(UITableView *)tableView {
    
    NSLog(@"cheng---模拟点击");
    
    if(!tableView || ![tableView isKindOfClass:[UITableView class]]) return;
    
    // 获取tableView中的行数和节数
    NSInteger numberOfSections = [tableView numberOfSections];
    
    if (numberOfSections == 0) return; // 没有节直接返回
    
    NSInteger section = arc4random_uniform((uint32_t)numberOfSections);
    NSInteger numberOfRows = [tableView numberOfRowsInSection:section];
    
    if (numberOfRows == 0) return; // 没有行直接返回
    
    NSInteger row = arc4random_uniform((uint32_t)numberOfRows);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    
    // 模拟用户点击某一行
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    [tableView.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    NSLog(@"模拟点击第%ld节，第%ld行", (long)section, (long)row);
}

- (void)simulateSwipeInTableView:(UITableView *)tableView {
    NSLog(@"cheng---模拟滑动");

    if(!tableView || ![tableView isKindOfClass:[UITableView class]]) return;

    // 获取当前contentOffset
    CGPoint currentOffset = tableView.contentOffset;
    
    // 随机生成滑动的偏移量（例如：向下或向上滑动）
    CGFloat randomYOffset = arc4random_uniform(100) + 50; // 50到150的偏移量
    BOOL scrollUp = arc4random_uniform(2); // 0 - 向下, 1 - 向上
    
    if (scrollUp) {
        randomYOffset = -randomYOffset;
    }
    
    CGPoint newOffset = CGPointMake(currentOffset.x, currentOffset.y + randomYOffset);
    
    // 确保新偏移量不超出contentSize的范围
    newOffset.y = MAX(0, MIN(tableView.contentSize.height - tableView.bounds.size.height, newOffset.y));
    
    // 设置新的contentOffset以模拟滑动
    [tableView setContentOffset:newOffset animated:YES];
    
    NSLog(@"模拟滑动到偏移量: %@", NSStringFromCGPoint(newOffset));
}

- (NSTimeInterval)randomInterval {
    return (arc4random_uniform(100) + 50) / 1000.0; // 0.05 到 0.15秒之间的随机延时
}

- (void)immediateReserve {
    NSLog(@"cheng---立即抢票...");
    // 实际上这里会发起请求
}


- (void)stopReservingTickets {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.stopRequested = YES;
        self.isRunning = NO;
        [self.operationQueue cancelAllOperations];
    });
}



@end
