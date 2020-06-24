//
//  ViewController.m
//  JRTT
//
//  Created by Augus on 2020/1/14.
//  Copyright © 2020 fosafer. All rights reserved.
//

#import "ViewController.h"
#import "FOSButton.h"
#import "FOSProxy.h"
#import "SecondController.h"


@interface ViewController ()

@property (nonatomic, copy) NSMutableArray *mutableArray;

@property (nonatomic, strong) NSArray *oneArray;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) dispatch_source_t gcdTimer;

@property (nonatomic, strong) CADisplayLink *link;



@end

@implementation ViewController

@synthesize name = myName;

//@synthesize foo = myFoo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSMutableArray *mutableArray0 = [NSMutableArray arrayWithObjects:@0,@1,@2,nil];
//    self.mutableArray = mutableArray0;
//
//    NSLog(@"this array class %@",NSStringFromClass([self.mutableArray class]));
//    NSLog(@"this array res %@",self.mutableArray);
    
    // -[__NSArrayI removeAllObjects]: unrecognized selector sent to instance 0x600000dbffc0
//    [self.mutableArray removeAllObjects];
    
    
//    NSArray *array = [NSArray arrayWithObjects:@1,@2,@3, nil];
//    NSMutableArray *mutableArray = [NSMutableArray arrayWithObjects:@4,@5,@6, nil];
//
//
//    self.oneArray = mutableArray;
//    [mutableArray removeAllObjects];
//    NSLog(@"the oneArray is %@",self.oneArray);
//
//    [mutableArray addObjectsFromArray:array];
//    self.oneArray = [mutableArray copy];
//    [mutableArray removeAllObjects];
//    NSLog(@"two array is %@",self.oneArray);
    
//    NSMutableString *string = [NSMutableString stringWithString:@"origin"];//copy
//    NSString *stringCopy = [string copy];
//
//    NSLog(@"1%p----2%p",string,stringCopy);
    
    
//    NSArray *array = @[@[@"a", @"b"], @[@"c", @"d"]];
//    NSArray *copyArray = [array copy];
//    NSMutableArray *mCopyArray = [array mutableCopy];
//
//    NSLog(@"array%p---copy--%p----m--%p",array,copyArray,mCopyArray);
    
    
//    self.name = @"niu";
//    NSLog(@"myname is %@",myName);
//
//
//    NSString *path = @"http://10.10.11.45:91&num=1";
//    path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    NSURL *purl = [NSURL URLWithString:path];
//    id result = [NSString stringWithContentsOfURL:purl encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"result--%@",result);
//
    
//
//    UIView *overlay = [[UIView alloc] init];
//    overlay.backgroundColor = [UIColor lightGrayColor];
//    overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [self.view addSubview:overlay];
    
    FOSButton *fosButton = [[FOSButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    fosButton.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds)-200);    
    [fosButton fos_addTarget:self action:@selector(fosButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//
    [self.view addSubview:fosButton];
    
    
//    [self test_GCDTimer];
    
//    [self test_proxy];
}

- (void)test_proxy {
    

    
    self.link = [CADisplayLink displayLinkWithTarget:[FOSProxy proxyWithTarget:self] selector:@selector(linkTest)];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}


- (void)linkTest {
    
    NSLog(@"sssss");
}

- (void)test_GCDTimer {
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    self.gcdTimer =  dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    
    dispatch_source_set_timer(_gcdTimer, DISPATCH_TIME_NOW,  2 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_gcdTimer, ^{
       
        static int gcdIdx = 0;
           NSLog(@"GCD Method: %d", gcdIdx++);
           NSLog(@"%@", [NSThread currentThread]);
           
           if(gcdIdx == 5) {
               // 刮起定时器
               dispatch_suspend(_gcdTimer);
               // 取消 防止进一步调用
               //dispatch_source_cancel(_gcdTimer);
           }
        
        
    });
    
    // 启动任务，GCD计时器创建后需要手动启动
    dispatch_resume(_gcdTimer);
    
    
}

- (void)fosButtonAction:(FOSButton *)sender {
    
//    UIAlertController *alert =
    
    NSLog(@"fos button press");
    
//    SecondController *vc = [[SecondController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    
}


@end
