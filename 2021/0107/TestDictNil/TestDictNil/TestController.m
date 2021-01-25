//
//  TestController.m
//  TestDictNil
//
//  Created by Augus on 2021/1/8.
//

#import "TestController.h"
#import "UINavigationBar+Extension.h"
#import "NWObj.h"
#import "TianO.h"

static const CGFloat nav_bar_change_point = 50.0;
static NSString *testViewCellId = @"testViewCellId";

typedef void(^tianBlock) (void);

@interface TestController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *nwTabelView;

@property (nonatomic, copy) tianBlock tian;


@end

@implementation TestController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"Greeeee";
    [self.navigationController.navigationBar nw_setBackgroundColor:[UIColor clearColor]];
    
//    [self initSubviews];
    
//    NWObj *obj = [NWObj new];
//    NWObj *obj = [[NWObj alloc] initWithRequestId:@"tian"];
//    [obj foo];
    
//    obj.requestId = @"sss";
//    NSLog(@"requestId--%@",obj.requestId);
    
//    TianO *tian = [[TianO alloc] init];
//    [tian foo];
    
    [self testBlock];
}

- (void)testBlock {
    
//    int a = 10;
//    void(^testBlock)(void) = ^(){
//
//        NSLog(@"inter test block--%d",a);
//    };
    
//    tianBlock tian = ^(){
//        NSLog(@"tian");
//    };
//
//    testBlock();
//    tian();
    
    
//    __weak typeof(self)weakSelf = self;
//    __strong typeof(self)strongSelf = self;
//    self.tian = ^{
//        [strongSelf initSubviews];
////        [weakSelf initSubviews];
//    };
    
    
//    dispatch_cancel
    
    // 死锁
//    NSLog(@"1");
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"2");
//    });
//
//    NSLog(@"3");
    
    
    NSRecursiveLock *lock = [[NSRecursiveLock alloc] init];

//    NSLock *lock = [[NSLock alloc] init];
     
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     
        static void (^RecursiveMethod)(int);
     
        RecursiveMethod = ^(int value) {
     
            [lock lock];
            if (value > 0) {
     
                NSLog(@"value = %d", value);
                sleep(2);
                RecursiveMethod(value - 1);
            }
            [lock unlock];
        };
     
        RecursiveMethod(5);
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self scrollViewDidScroll:self.nwTabelView];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.nwTabelView.delegate = nil;
    
    [self.navigationController.navigationBar nw_reset];
}

- (void)initSubviews {
    
    [self nwTabelView];
    
    
}


#pragma mark - UITableView DataSouce & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:testViewCellId forIndexPath:indexPath];
    cell.textLabel.text = @"love tian";
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    UIColor *color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
//    NSLog(@"yyy--%f",offsetY);
    if (offsetY > nav_bar_change_point) {
        CGFloat alpha = MIN(1, 1 - (nav_bar_change_point + 64 - offsetY) / 64);
        [self.navigationController.navigationBar nw_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    }else {
        [self.navigationController.navigationBar nw_setBackgroundColor:[color colorWithAlphaComponent:0]];

        self.navigationController.navigationBar.backIndicatorImage = [UIImage new];

    }
    
//    if (offsetY > 0) {
//        if (offsetY >= 44) {
//            [self setNavgationBarTransformProgress:1];
//        }else {
//            [self setNavgationBarTransformProgress:offsetY / 44];
//
//        }
//    }else {
//        [self setNavgationBarTransformProgress:0];
//        self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
//
//    }
}


- (void)setNavgationBarTransformProgress:(CGFloat)progress {
    
    [self.navigationController.navigationBar nw_setTranslationY:(-44 * progress)];
    [self.navigationController.navigationBar nw_setElementsAlpha:(1-progress)];

}

#pragma mark - Lazy laod

- (UITableView *)nwTabelView {
    if (!_nwTabelView) {
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        
        table.delegate = self;
        table.dataSource = self;
        [table registerClass:[UITableViewCell class] forCellReuseIdentifier:testViewCellId];
        
        [self.view addSubview:table];
        
        _nwTabelView = table;
    }
    return _nwTabelView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
