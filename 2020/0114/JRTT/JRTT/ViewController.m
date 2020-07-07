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

#import <objc/runtime.h>
#import <malloc/malloc.h>

#import <LoveTian/PrintGT.h>
#import "Masonry.h"

//#import "NSMutableArray+RemoveFirstObject.h"

#import <FosaferCollector/FosaferCollector.h>


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITableViewDataSourcePrefetching>

@property (nonatomic, copy) NSMutableArray *mutableArray;

@property (nonatomic, strong) NSArray *oneArray;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) dispatch_source_t gcdTimer;

@property (nonatomic, strong) CADisplayLink *link;

@property (nonatomic, strong) UITableView *fosTabelView;
@property (nonatomic, strong) NSArray *dataArray;





@end

@implementation ViewController

@synthesize name = myName;

//@synthesize foo = myFoo;

#pragma mark - Lazy loda

//- (NSArray *)dataArray {
//    if (!_dataArray) {
//        _dataArray = [[NSArray alloc] init];
//        NSMutableArray *tempArray = [NSMutableArray array];
//        for (int i = 0; i < 10000; i++) {
//            [tempArray addObject:[NSString stringWithFormat:@"love%dtian",i]];
//        }
//        _dataArray = [tempArray copy];
//    }
//    return _dataArray;
//}

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
    
//    FOSButton *fosButton = [[FOSButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    fosButton.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds)-200);
//    [fosButton fos_addTarget:self action:@selector(fosButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:fosButton];
    
    
    
//    [self test_GCDTimer];
    
//    [self test_proxy];
    
//    [self test_nsobjectMalloc];
    
//    PrintGT *gt = [[PrintGT alloc] init];
//    [gt printGT];
//    [gt inclusiveGT];
    
    
    // 静态图片的预加载
    
//    if (!_dataArray) {
//        _dataArray = [[NSArray alloc] init];
//        NSMutableArray *tempArray = [NSMutableArray array];
//        for (int i = 0; i < 10000; i++) {
//            [tempArray addObject:[NSString stringWithFormat:@"love%dtian",i]];
//        }
//        _dataArray = [tempArray copy];
//    }
//
//    [self test_fosTableView];
    
    
    FOSPrintGT *print = [[FOSPrintGT alloc] init];
    [print fos_printGT];
    
    
    NSMutableArray *mutalble = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    [mutalble removeFirstObject];
    
    NSLog(@"mutable-%@",mutalble);

}

















- (void)test_firstRemove {
    
        NSMutableArray *mutableArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4" ,nil];
        
    //    NSMutableArray *mutableArray = [NSMutableArray array];

        [mutableArray removeFirstObject];
        
    //    [mutableArray fos_removeFirstObject];
        
        NSLog(@"last array %@",mutableArray);
        
        BOOL isRemove = [mutableArray respondsToSelector:@selector(removeFirstObject)];
        NSLog(@"---%@",@(isRemove));
}

- (void)test_fosTableView {
    
    if (!_fosTabelView) {
        _fosTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
        _fosTabelView.backgroundColor = [UIColor redColor];
        _fosTabelView.delegate = self;
        _fosTabelView.dataSource = self;
        _fosTabelView.prefetchDataSource = self;
        
    }
    
    [self.view addSubview:_fosTabelView];
}

#pragma mark - UITableDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count > 0 ? _dataArray.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    if (!cell) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"tableViewCell"];
    }
    
//    cell.textLabel.text = [NSString stringWithFormat:@"love%utian",520];
    cell.textLabel.text = _dataArray[indexPath.row];
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"time for %u",1314];
    
    return cell;
}



#pragma mark - prefetchDataSource

- (void)tableView:(UITableView *)tableView prefetchRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    
    NSLog(@"prefetchRowsAtIndexPaths");
}

- (void)tableView:(UITableView *)tableView cancelPrefetchingForRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    
    NSLog(@"cancelPrefetchingForRowsAtIndexPaths");

}

- (void)test_nsobjectMalloc {
    
    
    NSObject *fos_obj = [[NSObject alloc] init];
    // 实例对象的大小
    // class_getInstanceSize 返回的是class ivar's size 类的成员变量的大小，因为NSObject对象只有一个isa成员变量，因为返回的是8个字节
    
    /*
     
     struct NSObject_IMPL {
         isa就是一个指向结构体的指针。那么既然isa是个指针，那么他在64位的环境下占8个字节，在32环境上占4个字节
         Class isa;
     };
     
     typedef struct objc_class *Class;
     
     alloc---allocWithZone---_objc_rootAllocWithZone---class_createInstance（cls，0）---instanceSize
     size_t instanceSize(size_t extraBytes) {
         size_t size = alignedInstanceSize() + extraBytes;
         // CF requires all objects be at least 16 bytes.
         if (size < 16) size = 16;
         return size;
     }
     **/
    NSLog(@"getinstance---%zd",class_getInstanceSize([NSObject class]));
    // 实例对象所占内存的大小
    NSLog(@"malloc-size---%zu",malloc_size((__bridge const void *)(fos_obj)));
    
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
