//
//  ViewController.m
//  NWModel
//
//  Created by Augus on 2021/2/3.
//

#import "ViewController.h"
#import "NWClassInfo.h"
#import "NSObject+NWModel.h"

#import <pthread.h>
#import "CALayer+NWLayer.h"
#import <objc/message.h>
#import <objc/runtime.h>

#import "NWUser.h"
#import <WebKit/WebKit.h>

#import "NWFPSLabel.h"

#import "NWTestLabel.h"
#import "NWTableCell.h"

#import "NSObject+GTModel.h"
#import "GTMovie.h"

#define onExit\
    __strong void(^block)(void) __attribute__((cleanup(blockCleanUp), unused)) = ^


#define DISPATCH_NW_DECL(name) typedef struct name##_s *name##_t
typedef void (^nwBlock) (void);

@interface ViewController ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, copy) NSArray *tableData;
@property (nonatomic, strong) UITableView *nwTableView;
/* 存计算Cell高度的实例变量 */
@property (nonatomic, strong) NWTableCell *nwCell;

@property (nonatomic, strong) UIButton *nwButton;

@property (nonatomic, copy) nwBlock wBlock;

@property (nonatomic, strong) id observer;



@end

@implementation ViewController{
    
    CADisplayLink *_displayLink;
    NSInteger _count;
    CFTimeInterval _timeStamp;
    UITableView *_table;
    
    NWFPSLabel *_fpsLable;
    UIView *_testView;
    
}


- (void)dealloc {
    
    NSLog(@"类与方法:%@ (在第(%@)行)，描述%@",@(__PRETTY_FUNCTION__),@(__LINE__),self);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self nw_removeObserver];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.greenColor;
    
//    NWUser *user = [[NWUser alloc] init];
//    NSLog(@"%@",user);


//    [self testBackQueueDeallocObject];
    
//    [self testCGBitmapCreateImage];
    
//    [self testEnumAndLocation];
    
//    [self testEncodingType];
    
    
    //
    
//    [self testObjcMsgSend];
    
//    [self testNSCharacterSet];
    
    
//    NSMutableString *tmp = [NSMutableString stringWithString:@"gao"];
//    [tmp appendString:@"tian"];
//    NSLog(@"tmp0---%@",tmp);
//
//    NSString *tmp1 = [tmp stringByAppendingString:@"love"];
//    NSLog(@"tmp1---%@",tmp1);
//
//    NSString *tmp2 = [tmp stringByAppendingFormat:@"%@",@"hao"];
//    NSLog(@"tmp2---%@",tmp2);
    
    
    /*
     // JSON:
     {
         "uid":123456,
         "name":"Harry",
         "created":"1965-07-31T00:00:00+0000"
     }
     */
    
//    NSString *jsonString = @"{\"uid\":123456,\"name\":\"Tian\"}";
//    NWUser *user = [NWUser nw_modelWithJSON:jsonString];
//    NSLog(@"%@---%ld---%f",user.name,user.uid);
    
        
//   int res =  [self blockForButtonId:3];
//    NSLog(@"res %d",res);
    
//    int (*funcptr)(int,float) = &func;
//    int res = (*funcptr)(10,10.6);
//    printf("res  %d\n",res);
    
    
//    __strong NSString *string __attribute__((cleanup(stringCleanUp))) = @"sunnyxx";
//
//    onExit {
//        NSLog(@"onExit");
//    };
    
//    __attribute__((cleanup(...)));
    
//    int r = square(2);
//    NSLog(@"c---%d",r);
    
    
//    die("sss");
    
//    my_printf("ccc", "aaa");
    
    
//    [self testForInvacationOperation];
    
//    [self testBlockOperation];
//    [self testBlockForVar];
    
//    [self testIsa];
//    [self testUIWebView];
//    [self testWBKit];
    
//    [self testInvcoation];
    
//    [self testButtonSource];
    
//    [self testDisplayLink];
    
    // test yyfps label
//    [self testYYLabel];
//    [self  testFPSLable];
    
//    [self testCopyArray];
    
//    [self testGCDApi];
    
//    [self testImageNamed];
    
    
//    [self testHookAMethod];
    
//    [self testSetNeedLayout];
    
//    [self testEqual];
    
//    [self nwLabelForTest];
    
    // 初始化tableview & 数据
    
    // 注册cell
    
    // 实现数据源
    
    // 实现代理方法
    
    // 自定义cell 左侧头像 右侧文本or textview
//    self.tableData = @[@"1\n2\n3\n4\n5", @"1234567890123456789012345678901111111", @"1\n2", @"1\n2\n3", @"1"];
//
//    [self testThatFits];
    
//    [self testTouchAndAnimation];
    
//    [self testThatFits];
    

    
    [self testDictToModel];
    
}

- (void)testDictToModel {
    
    NSDictionary *user = @{@"name": @"gao tian",
                           @"age": @(18),
                           @"sex": @"man"
    };
    
    
    
    
    
    NSDictionary *dict2 = @{@"movieId" : @"28901",
                            @"movieName" : @"my heart will go on",
                            @"pic_url" : @"http://www.time.com",
                            @"user" : user
    };
    
    GTMovie *gtModel = [GTMovie gt_modelWithDictionary:dict2];
    NSLog(@"%@",gtModel);
    
    
//    NSLog(@"dataArray0---%@",dataArray);
    
    NSMutableArray *dataArray = [NSMutableArray array];
    

    

    
    NSDictionary *nw0 = @{
        @"name" : @"niu",
        @"sex" : @"woman",
        @"uid" : @(109)
        
    };
    
    NSDictionary *nw1 = @{
        @"name" : @"wei",
        @"sex" : @"man",
        @"uid" : @(901)
        
    };
    
    
    
    
    
    NSArray *nws = @[nw0,nw1];
    NSDictionary *dict3 = @{@"movieId" : @"28901",
                            @"movieName" : @"my heart will go on",
                            @"pic_url" : @"http://www.time.com",
                            @"userArray" : nws
    };


//    [dataArray removeAllObjects];
//    NSArray *array3 = @[dict3,dict3,dict3];
//    for (NSDictionary *item in array3) {
        GTMovie *movie = [GTMovie gt_modelWithDictionary:dict3];
//        [dataArray addObject:movie];
//    }

    NSLog(@"dataArray3---%@",movie);



    
}

- (void)testTouchAndAnimation {
    
//    self.nwButton = [UIButton new];
//    self.nwButton.frame = CGRectMake(100, 100, 100, 50);
//    self.nwButton.backgroundColor = UIColor.blueColor;
//    [self.nwButton addTarget:self action:@selector(nwBttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.nwButton.userInteractionEnabled = NO;
//    [self.view addSubview:self.nwButton];
    
    
    
//    [UIView animateWithDuration:2 animations:^{
////        NSLog(@"block run now");
//        //TODO:即然block对内部的对象强引用，那为什么此处的block不需考虑引用循环
////        self.nwButton.center = CGPointMake(self.nwButton.center.x, self.nwButton.center.y +100);
//
//        self.view.backgroundColor = UIColor.redColor;
//    }];
    
    
//    self.wBlock = ^{
//        self.view.backgroundColor = UIColor.redColor;
//    };
//
//    self.wBlock();
    
//    [UIView animateWithDuration:10 animations:^{
//        self.nwButton.center = CGPointMake(self.nwButton.center.x, self.nwButton.center.y +100);
//    } completion:^(BOOL finished) {
//        NSLog (@"动画结束了");
//    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"someNotification"
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification * notification) {
        self.nwCell = nil;

    }];
    
    
//    self.observer = [[NSNotificationCenter defaultCenter] addObserverForName:@"testKey"
//                                                                  object:nil
//                                                                   queue:nil
//                                                              usingBlock:^(NSNotification *note) {
//
//        NSLog(@"类名与方法名: %@(在第%@行)，描述：%@",@(__PRETTY_FUNCTION__),@(__LINE__),self);
//    }];
    
}

- (void)nw_removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self.observer];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 获取点击到位置
//    NSLog(@"touches---%@---%lu",touches,(unsigned long)touches.count);
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    CGRect animationFrame = [self.nwButton.layer presentationLayer].frame;
    if (CGRectContainsPoint(animationFrame, point)) {
        NSLog(@"tap can response");
    }
}
- (void)nwBttonAction:(UIButton *)sender {
    
    NSLog(@"ssss--%@",NSStringFromSelector(_cmd));
}



- (void)testThatFits {
        
    self.nwTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 88, self.view.bounds.size.width, self.view.bounds.size.height - 88) style:UITableViewStylePlain];
    [self.view addSubview:self.nwTableView];
    
    [self.nwTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NWTableCell"];
    self.nwTableView.delegate = self;
    self.nwTableView.dataSource = self;
    
    self.nwCell = [self.nwTableView dequeueReusableCellWithIdentifier:@"NWTableCell"];
}

#pragma mark - Tabele View Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 190;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NWTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NWTableCell"];
//    if (!cell) {
//        cell = [[NWTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NWTableCell"];
//    }
//    cell.nwText = self.tableData[indexPath.row];
    
    NSLog(@"%@---%@---%@",@(__PRETTY_FUNCTION__),@(__LINE__),indexPath);

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NWTableCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NWTableCell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",@(indexPath.section),@(indexPath.row)];
    return cell;
}
#pragma mark - Tabele View Delegate


- (BOOL)isInScreen:(CGRect)cellFrame {
    
    CGFloat offSetY = self.nwTableView.contentOffset.y;
    // 内容向上滑 && 内容向下滑
    return  CGRectGetMaxY(cellFrame) > offSetY && cellFrame.origin.y < offSetY + self.view.bounds.size.height - 88;
    
    
}

// 不需要调用调用n次这个方法就可以预估cell的高度，n为cell的个数
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    NSLog(@"");
//    NWTableCell *cell = self.nwCell;
//    cell.nwText = self.tableData[indexPath.row];
//    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    NSLog(@"h=%f", size.height + 1);
//    return 1 + size.height;
//    NSLog(@"%@---%@---%@",@(__PRETTY_FUNCTION__),@(__LINE__),indexPath);
    return 100;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    /*
//     tableview heightForRowIndexPath方法会调用最多18次，小于18就去调用小于18的次数
//     */
//    NSLog(@"%@---%@---%@",@(__PRETTY_FUNCTION__),@(__LINE__),indexPath);
//    return 100;
//}

- (void)nwLabelForTest {
    
    NWTestLabel *test = [NWTestLabel new];
    test.translatesAutoresizingMaskIntoConstraints = NO;
    test.font = [UIFont systemFontOfSize:20];
    test.textColor = UIColor.redColor;
    test.backgroundColor = UIColor.whiteColor;
    
    test.numberOfLines = 0;
    test.preferredMaxLayoutWidth = 100;
    
    [self.view addSubview:test];
    
    test.text = @"我会对高田始终如一 天涯海角";
    
    [test.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100].active = YES;
    [test.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    
//    double s =  pow(2, 5);
//    NSLog(@"sss---%f",s);
    
}


- (void)testEqual {
    
//    NWUser *nw = [NWUser new];
//
//    [nw addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:NULL];
//
//    nw.name = @"augus";
//
//    [nw removeObserver:self forKeyPath:@"name"];
//    nw.name = @"gao";
    
    // 忽略未使用的变量或者对象
//#pragma unused (nw)
    
//    NSMutableDictionary *dict = [NSMutableDictionary new];
//    [dict setObject:nw forKey:@"Tian"];
    
//    if ([nw isEqual:@"123"]) {
//        NSLog(@"equal");
//    }
    
//    unsigned int outCount;
//    objc_property_t *properties = class_copyPropertyList(nw.class, &outCount);
//    for (int i = 0; i < outCount; i++) {
//        objc_property_t property = properties[i];
//        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
//
////        objc_property_attribute_t
//        NSString *propertyAttr = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
//        NSLog(@"pro---%@---%@",propertyName,propertyAttr);
//    }
    
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    
    
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
//    if ([object isKindOfClass:[NWUser class]] && [keyPath isEqualToString:@"name"]) {
//        NSLog(@"new value:%@",change[NSKeyValueChangeNewKey]);
//    }
}


- (void)testSetNeedLayout {
    
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(50, 50, 100, 60);
    [btn setTitle:@"adjust offset" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(adjustOffset:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    _testView = [UIView new];
    _testView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_testView];

    [_testView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [_testView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [_testView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [_testView.heightAnchor constraintEqualToConstant:30].active = YES;
    _testView.backgroundColor = UIColor.redColor;
}

- (void)adjustOffset:(UIButton *)sender {
    
    [self.view layoutIfNeeded];
    if (_testView.bounds.size.height == 30) {
        NSLog(@"10000");
//        _testView.frame = CGRectMake(0, self.view.bounds.size.height - 200, self.view.bounds.size.width,200);
//        [_testView layoutIfNeeded];
        
        [_testView.heightAnchor constraintEqualToConstant:200].active = YES;
    } else {
//        _testView.frame = CGRectMake(0, self.view.bounds.size.height - 30, self.view.bounds.size.width,30);
        [_testView.heightAnchor constraintEqualToConstant:30].active = YES;

    }
    
    [UIView animateWithDuration:2.0 animations:^{
//
            [self.view layoutIfNeeded];
//        [self.view setNeedsLayout];

    }];
    
}

- (void)testHookAMethod {
    
//    UILabel *lable = [UILabel new];
//    lable.text = @"gao tian";
//    [lable sizeToFit];
//    lable.textColor = UIColor.redColor;
//    [self.view addSubview:lable];
//
//    lable.font = [UIFont systemFontOfSize:19];
    
    [self testBigImage];
    
}

- (void)testImageNamed {
    
    // liveness_layout_head_mask
    
    UIImage *img = [UIImage imageNamed:@"liveness_layout_head_mask"];
    
    UIImageView *imgView = [UIImageView new];
    imgView.frame = CGRectMake(100, 100, 200, 200);
    if (img) {
        imgView.image = img;
    } else {
        NSLog(@"not found image name");
    }
    
    [self.view addSubview:imgView];

}

- (void)testBigImage {
    
//    CATiledLayer
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imgView.image = [UIImage imageNamed:@"china_big_img"];
    [self.view addSubview:imgView];
    
}

- (void)testGCDApi {
    
//    dispatch_queue_t queue = dispatch_queue_create("com.bestswifter.queue", DISPATCH_QUEUE_SERIAL);
//    NSLog(@"0000");
//    dispatch_sync(queue, ^{
//        NSLog(@"current thread = %@", [NSThread currentThread]);
////        dispatch_sync(dispatch_get_main_queue(), ^{
////            NSLog(@"current thread = %@", [NSThread currentThread]);
////        });
//
//    });
//
//    NSLog(@"1111");
    
    
    dispatch_semaphore_t nw_sema = dispatch_semaphore_create(0);
    
    NSLog(@"wait before");

    dispatch_semaphore_wait(nw_sema, dispatch_time(DISPATCH_TIME_NOW, 10));
    NSLog(@"wait after");

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"signal before");
        dispatch_semaphore_signal(nw_sema);
        NSLog(@"signal after");
    });
    

//    CGBitmapContextCreate(<#void * _Nullable data#>, <#size_t width#>, <#size_t height#>, <#size_t bitsPerComponent#>, <#size_t bytesPerRow#>, <#CGColorSpaceRef  _Nullable space#>, <#uint32_t bitmapInfo#>)
    
//    cgbitmapcreateim
    
//    self.view.layer.contents
    
}

- (void)testCopyArray {
    
//    NSMutableArray *arrayA = [NSMutableArray arrayWithObjects:@"A",@"B",@"C", nil];
//    self.array = arrayA;
//
//    [arrayA removeAllObjects];
//    NSLog(@"self.array %@",self.array);
    
    
//    NSArray *arrayA = @[@[@2,@4],@1,@3];
//    NSMutableArray *mutArray = [NSMutableArray arrayWithArray:arrayA];
//
//    self.array = mutArray;
//    [mutArray removeAllObjects];
//    NSLog(@"arr0---%@",self.array);
//
//    [mutArray addObjectsFromArray:arrayA];
//    self.array = [mutArray mutableCopy];
//    NSLog(@"arr1---%@",self.array);
    
//    NSArray *arrayB = [arrayA mutableCopy];
//    // copy 是指针拷贝
//    // mutable 进行了内容拷贝，此处的内容拷贝仅仅是指拷贝了array这个对象，array集合内部仍然是指针拷贝
//    NSArray *arrayC = [arrayA copy];
//
//    NSLog(@"%p---%p---%p",arrayA,arrayB,arrayC);
    
    
    // immutable obj
    
    NSString *aString = [NSString stringWithFormat:@"%@",@"gao"];
    NSString *bString = [aString copy];// 浅复制
    NSString *cString = [aString mutableCopy];// 深复制
    
    NSLog(@"%p---%p---%p",aString,bString,cString);
    
    // mutable obj
    
    NSMutableString *mutableString = [NSMutableString stringWithString:@"tian"];
    NSString *dString = [mutableString copy];
    NSString *eString = [mutableString mutableCopy];
    NSLog(@"%p---%p---%p",aString,dString,eString);
    
    
//    [[NSMutableSet alloc] initWithSet:_friends
//                                                copyItems:YES];
    
    
//   NSMutableSet *deepSet = [[NSMutableSet alloc] initWithSet:@[@"1",@"1"] copyItems:YES];
//    NSMutableArray *deepArray = [NSMutableArray alloc] initWithArray:<#(nonnull NSArray *)#> copyItems:<#(BOOL)#>
    
    
    
}

- (void)testYYLabel {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    _table = tableView;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    
}

#pragma mark - UITableView DataSource

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 100;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    [NSThread sleepForTimeInterval:0.01];
//    cell.textLabel.text = @"高田高";
//    return cell;
//}

- (void)testFPSLable {
    
    _fpsLable = [[NWFPSLabel alloc] initWithFrame:CGRectMake(200, 200, 50, 30)];
    [_fpsLable sizeToFit];
    
    [self.view addSubview:_fpsLable];
}

- (void)testDisplayLink {
    
    // init link
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(nwLink:)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)nwLink:(CADisplayLink *)link {
    
    _count++;
    // 当前时间戳
    if (_timeStamp == 0) {
        _timeStamp = link.timestamp;
    }
    CFTimeInterval timePassed = link.timestamp - _timeStamp;
    if (_timeStamp >= 1.0) {
        //fps
        CGFloat fps = _count / timePassed;
        NSLog(@"fps-%.2f,timepass-%.2f",fps,timePassed);
        // reset
        _timeStamp = link.timestamp;
        _count = 0;
    }
    

}

- (void)testButtonSource {
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    btn.backgroundColor = UIColor.redColor;
    [btn addTarget:self action:@selector(testInvcoation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)testInvcoation {
    
    SEL sel = @selector(nwPlusNum:num1:);
    NSMethodSignature *sig = [self methodSignatureForSelector:sel];
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
    [invocation setTarget:self];
    [invocation setSelector:sel];
    
    NSInteger num1 = 7,num2 = 3;
    [invocation setArgument:(void *)&num1 atIndex:3];
    [invocation setArgument:(void *)&num2 atIndex:2];
    
    [invocation invoke];
    
    NSInteger res;
    [invocation getReturnValue:&res];
    NSLog(@"res---%ld",res);

}

//- (int)nwPlusNum:()

- (NSInteger)nwPlusNum:(NSInteger)num1 num1:(NSInteger)num2 {
    return num1 + num2;
}


- (void)testWBKit {
    WKWebView *wkView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    
    [wkView loadRequest:request];
    [self.view addSubview:wkView];
    
    

}

- (void)testUIWebView {
    
    // init web view
    UIWebView *wbView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 20)];
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    
    [wbView loadRequest:request];
    wbView.delegate = self;
    
    [self.view addSubview:wbView];
}

/// 是否允许加载网页，也可以截取js要打开的url，通过截取此url与js交互
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlString = [[request URL] absoluteString];
    urlString = [urlString stringByRemovingPercentEncoding];
    
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    NSLog(@"url string --%@---%@",urlString,urlComps);
    
    return YES;
}
/// 开始加载网页
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSURLRequest *request = webView.request;
    NSLog(@"开始-request url-%@---HTTP body---%@",request.URL.absoluteString,request.HTTPBody);
    
}
/// 页面加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    // 获取网页title >> document.title
    NSLog(@"加载完成-%@",[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"]);
    
    
    // 网页定位
    NSString *jsStr = [NSString stringWithFormat:@"window.location.href = '#%@'",@"123"];
    // webview 执行代码
    [webView stringByEvaluatingJavaScriptFromString:jsStr];
    

}
/// 网页加载错误
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    NSLog(@"加载错误---%@",error);
}

- (void)testIsa {
    
    NWClassInfo *obj = [NWClassInfo alloc];
    NSLog(@"obj---%@",obj);
    
}

int global_i = 1;
static int static_global_j = 2;

- (void)testBlockForVar {
    
    static int static_k = 3;
    
    void (^myBlock)(void) = ^{
//        k++;
        static_k++;
        NSLog(@"Block中 变量 = %d %d %d",static_global_j ,static_k, global_i);
    };
    
    NSLog(@"%@",myBlock);
    myBlock();
    
}

/// for a selector of thread
+ (void)networkRequestThreadEntryPoint:(id)__unused object {
    
    @autoreleasepool {
        
        [[NSThread currentThread] setName:@"nwNet"];
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        [runloop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runloop run];
    }
    
//    self performSelector:<#(nonnull SEL)#> onThread:<#(nonnull NSThread *)#> withObject:<#(nullable id)#> waitUntilDone:<#(BOOL)#> modes:<#(nullable NSArray<NSString *> *)#>
    
}
/// init a pthread

- (NSThread *)nw_networkRequestThread {
    static NSThread *_nwThread = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _nwThread = [[NSThread alloc] initWithTarget:self selector:@selector(networkRequestThreadEntryPoint:) object:nil];
    });
    return _nwThread;
}

- (void)testBlockOperation {
    
    
    // max concurrent count
    NSOperationQueue *opQueue = [NSOperationQueue new];
    NSBlockOperation *op0 = [NSBlockOperation blockOperationWithBlock:^{
       
        NSLog(@"op0---begin");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"op0---end");

    }];
    
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
       
        NSLog(@"op1---begin");
        [NSThread sleepForTimeInterval:4];
        NSLog(@"op1---end");

    }];
    
    opQueue.maxConcurrentOperationCount = 1;
    [op0 addDependency:op1];
//    op0.queuePriority = NSOperationQueuePriorityHigh;
//    op0.qualityOfService = NSQualityOfServiceUserInteractive;
    
    [opQueue addOperation:op1];
    [opQueue addOperation:op0];
    
    
//    NSOperationQueue *opQueue = [NSOperationQueue new];
//    NSBlockOperation *op0 = [NSBlockOperation blockOperationWithBlock:^{
//
//        NSLog(@"op0 begin");
//        // need waste time
//        [NSThread sleepForTimeInterval:2];
//
//    }];
//
//    op0.completionBlock = ^{
//
//        NSLog(@"op0 finish");
//    };
//
//    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
//
//        NSLog(@"op1 begin");
//        [op0 waitUntilFinished];
//        NSLog(@"op1 end");
//    }];
//
//    [opQueue addOperation:op0];
//    [opQueue addOperation:op1];
    
    
//    NSOperationQueue *opQueue = [[NSOperationQueue alloc] init];
//    NSInvocationOperation *op0 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(testGao) object:nil];
//    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(testNiu) object:nil];
//
//    [op0 addDependency:op1];
//
//    [opQueue addOperation:op0];
//    [opQueue addOperation:op1];
    
    
    
//    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"op1---begin");
//        NSLog(@"op1---thread(%@)",[NSThread currentThread]);
//        NSLog(@"op1---end");
//
//
//    }];
//
//    [opQueue addOperation:op1];
    
    
//    NSBlockOperation *op0 = [[NSBlockOperation alloc] init];
//    [op0 addExecutionBlock:^{
//
//        NSLog(@"op0---begin");
//        NSLog(@"op0---thread(%@)",[NSThread currentThread]);
//        NSLog(@"op0---end");
//
//    }];
//
//    [op0 addExecutionBlock:^{
//
//        NSLog(@"op1---begin");
//        NSLog(@"op1---thread(%@)",[NSThread currentThread]);
//        NSLog(@"op1---end");
//
//    }];
//    [op0 start];

    
//    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"op1---begin");
//        NSLog(@"op1---thread(%@)",[NSThread currentThread]);
//        NSLog(@"op1---end");
//
//
//    }];
//
//
//    [op1 addExecutionBlock:^{
//
//        NSLog(@"op2---begin");
//        NSLog(@"op2---thread(%@)",[NSThread currentThread]);
//        NSLog(@"op2---end");
//    }];
//
//
//    [op1 start];
}

- (void)testForInvacationOperation {
        
//    NSMethodSignature *sig = [[self class] instanceMethodSignatureForSelector:@selector(testGao)];
//    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sig];
//    NSString *info = @"gao tian";
//    inv.target = self;
//    inv.selector = @selector(testGao);
//    [inv setArgument:(__bridge void *)info atIndex:2];
//    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithInvocation:inv];
//    [op start];
    
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(testGao) object:@"gao"];
    [op start];
}

- (void)testGao {
    
    NSLog(@"test gao");
}

- (void)testNiu {
    NSLog(@"test niu");

}

extern void *
my_memcpy (void *dest, const void *src, size_t len)
  __attribute__((nonnull (1, 2)));

extern int
my_printf (void *my_object, const char *my_format, ...)
  __attribute__((format(printf, 2, 3)));

extern void die(const char *format, ...)
  __attribute__((noreturn, format(printf, 1, 2)));

void f(void)
  __attribute__((availability(macosx,introduced=10.4,deprecated=10.6)));


int square(int n) __attribute__((const)) {
    
    return n * n;
}


// void(^block)(void)的指针是void(^*block)(void)
static void blockCleanUp(__strong void(^*block)(void)) {
    (*block)();
}

// 指定一个cleanup方法，注意入参是所修饰变量的地址，类型要一样
// 对于指向objc对象的指针(id *)，如果不强制声明__strong默认是__autoreleasing，造成类型不匹配
static void stringCleanUp(__strong NSString **string) {
    NSLog(@"%@", *string);
}

int func(int count,float height)
{
    return height + 1;
}

- (int)blockForButtonId:(int)buttonId {
    
//    typedef NSDate* (^NWNSDateParseBlock)(NSString *string);
    typedef int (^buttonCallBack)(int buttonId);
    buttonCallBack blocks[3] = {0};
    {
        blocks[0] = ^(int buttonId){
          
            if (buttonId == 0) {
                return 100;
            }else {
                return -1;
            }        };
        
        
        blocks[1] = ^(int buttonId){
          
            if (buttonId == 1) {
                return 1;
            }else {
                return -2;
            }
            
        };
        
        blocks[2] = ^(int buttonId){
            if (buttonId == 2) {
                return 2;
            }else {
                return -3;
            }
        };
    }
    
    

    buttonCallBack callBack = blocks[buttonId];
    if (!callBack) return -10;
    return callBack(buttonId);
    
}

- (void)testNSCharacterSet {
    
    NSString *str = @"    this     is a    test    .   ";
    // 去除两端空格
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    // 进行字符串特殊符号化
    NSString *tmp = [str stringByTrimmingCharactersInSet:set];
    NSLog(@"tmp-%@",tmp);
}


- (void)testObjcMsgSend {
    
    //    NWClassInfo *info = [[NWClassInfo alloc] init];
    // alloc
    NSObject *info = ((NSObject * (*)(id, SEL)) (void *)objc_msgSend)((id)[NSObject class],@selector(alloc));
    
    // init
    info = ((NSObject * (*)(id, SEL)) objc_msgSend)(info, @selector(init));
    // dynamic add method for info instance
    class_addMethod(info.class, NSSelectorFromString(@"cStyleFunc"), (IMP)cStyleFunc, "v@:");

    int value = ((int (*)(id, SEL, const char *, const char *))objc_msgSend)(info, NSSelectorFromString(@"cStyleFunc"),"参数1","参数2");
    NSLog(@"return value %d",value);
    
}

int cStyleFunc(const void *arg1,const void *arg2) {
    NSLog(@"%s is called, arg1 is %s and arg2 is %s",__func__,arg1,arg2);
    return 1;
}

typedef struct _struct {
    short a;
    long long b;
    unsigned long long c;
} Struct;


-(void)testEncodingType {
    
    int8_t i8 = pow(2, 7);
    int16_t i16 = pow(2, 15);
    NSLog(@"i8----%ld",(long)i8);
    NSLog(@"i16----%ld",(long)i16);
    
    
    NSUInteger m = 1 << 5;/// 1 * 2^5
    NSUInteger n = 2 << 3;/// 2 * 2^3
    NSLog(@"m--%ld---%ld",m,n);
    
    
    NSLog(@"char     : %s, %lu", @encode(char), sizeof(char));
    NSLog(@"short    : %s, %lu", @encode(short), sizeof(short));
    NSLog(@"int      : %s, %lu", @encode(int), sizeof(int));
    NSLog(@"long     : %s, %lu", @encode(long), sizeof(long));
    NSLog(@"long long: %s, %lu", @encode(long long), sizeof(long long));
    NSLog(@"float    : %s, %lu", @encode(float), sizeof(float));
    NSLog(@"double   : %s, %lu", @encode(double), sizeof(double));
    NSLog(@"NSInteger: %s, %lu", @encode(NSInteger), sizeof(NSInteger));
    NSLog(@"CGFloat  : %s, %lu", @encode(CGFloat), sizeof(CGFloat));
    NSLog(@"int32_t  : %s, %lu", @encode(int32_t), sizeof(int32_t));
    NSLog(@"int64_t  : %s, %lu", @encode(int64_t), sizeof(int64_t));
    
    
    NSLog(@"bool     : %s, %lu", @encode(bool), sizeof(bool));
    NSLog(@"_Bool    : %s, %lu", @encode(_Bool), sizeof(_Bool));
    NSLog(@"BOOL     : %s, %lu", @encode(BOOL), sizeof(BOOL));
    NSLog(@"Boolean  : %s, %lu", @encode(Boolean), sizeof(Boolean));
    NSLog(@"boolean_t: %s, %lu", @encode(boolean_t), sizeof(boolean_t));

    
    NSLog(@"void    : %s, %lu", @encode(void), sizeof(void));
    NSLog(@"char *  : %s, %lu", @encode(char *), sizeof(char *));
    NSLog(@"short * : %s, %lu", @encode(short *), sizeof(short *));
    NSLog(@"int *   : %s, %lu", @encode(int *), sizeof(int *));
    NSLog(@"char[3] : %s, %lu", @encode(char[3]), sizeof(char[3]));
    NSLog(@"short[3]: %s, %lu", @encode(short[3]), sizeof(short[3]));
    NSLog(@"int[3]  : %s, %lu", @encode(int[3]), sizeof(int[3]));
    
    
    NSLog(@"CGSize: %s, %lu", @encode(CGSize), sizeof(CGSize));
    
    
    NSLog(@"Class   : %s", @encode(Class));
    NSLog(@"NSObject: %s", @encode(NSObject));
    NSLog(@"NSString: %s", @encode(NSString));
    NSLog(@"id      : %s", @encode(id));
    NSLog(@"Selector: %s", @encode(SEL));
    

    NSLog(@"struct     : %s", @encode(typeof(Struct)));
    
    

    

    

}


- (void)testCGBitmapCreateImage {
    
    // liveness_layout_head_mask
    
//    size_t bytesPerRow = 4352;
//    // Get the pixel buffer width and height
//    size_t width = 1088; // w h bytesrow 1280  720 1280
//    size_t height = 1905; // 1088 1905 4352
//
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    // create context
//    CGContextRef ctx = CGBitmapContextCreate(<#void * _Nullable data#>, <#size_t width#>, <#size_t height#>, <#size_t bitsPerComponent#>, <#size_t bytesPerRow#>, <#CGColorSpaceRef  _Nullable space#>, <#uint32_t bitmapInfo#>)
    
    // draw in context
//    CGImageRef img = CGBitmapContextCreateImage(NULL);
    
    // release ctx
//    CFRelease(<#CFTypeRef cf#>)
    
    //
//    dispatch_async(dispatch_get_main_queue(), ^{
//       
//        self.view.layer.contents = (__bridge id _Nullable)(img);
//        CFRelease(img);
//    });
    
    
    
}

- (void)testBackQueueDeallocObject {
    
//    _nw = [[NWClass alloc] initWithName:@"GT"];
//    NWClass *nwTemp = _nw;
//    _nw = nil;
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//        NSLog(@"queue class");
//        [nwTemp class];
//        [nwTemp logName];
//    });

    
}


- (void)testEnumAndLocation {
    
    NWEncodeType all = NWEncodeTypeMask;
    NWEncodeType bVoid = NWEncodeTypeVoid;
    
    
    // 用来判断all是否包含a1 如果 >0 含有，否则不含有，只返回1 0
    NWEncodeType a1 = 12 & NWEncodeTypeVoid;
    NSLog(@"a1---%ld",a1);// 2
    
    // 按位或
    // 两者不相等，结果则为相加
    // 两者相等，结果为其中一个值
    
    NSInteger d1 = 1;
    NSInteger d2 = d1 | 0;/// < d1 = d1 | 8;
    NSLog(@"d1---%ld",d2);
    
    // 从all中去除bVoid
    NWEncodeType c1 = bVoid ^ all;
    NSLog(@"c1---%ld",c1);
    
    NSLog(@"@\"");
    NSLog(@"\"<");
}

- (void)testNSScanner {
    
    NSString *str = @"你好123745世界";
    NSScanner *scanner = [NSScanner scannerWithString:str];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    int number;
    [scanner scanInt:&number];
    NSLog(@"new str %d",number);

    
    
    NSString *bananas = @"137 small cases of bananas";
    NSString *separatorString = @" of";
    NSScanner *aScanner = [NSScanner scannerWithString:bananas];
    NSInteger anInteger;
    [aScanner scanInteger:&anInteger];
    NSString *container;
    [aScanner scanUpToString:separatorString intoString:&container];

    NSLog(@"container %@ %ld",container,anInteger);
}

@end
