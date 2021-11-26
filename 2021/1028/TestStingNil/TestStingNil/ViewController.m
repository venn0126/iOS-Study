//
//  ViewController.m
//  TestStingNil
//
//  Created by Augus on 2021/11/11.
//

#import "ViewController.h"
#import "SNPerson.h"
#import "SNAppConfigABTest.h"
#import <pthread.h>

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) SNPerson *person;

@end

@implementation ViewController{
    
    int _testA;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.linkColor;
//    [self testStringNil];
//    [self testCrash];
    
    [self testGradientButton];
}


- (void)testGradientButton {
    
    UIButton *forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [forwardButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
//    forwardButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [forwardButton setTitle:@"立即转发" forState:UIControlStateNormal];
    forwardButton.frame = CGRectMake(100, 100, 100, 50);
    [self.view addSubview:forwardButton];
    
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.colors = @[(id)[UIColor yellowColor].CGColor,(id)[UIColor orangeColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    gradientLayer.endPoint = CGPointMake(1.0, 0.0);
    gradientLayer.frame = forwardButton.bounds;
//    gradientLayer.locations = @[@0.5,@1.0];
    gradientLayer.cornerRadius = 12.0;
    [forwardButton.layer insertSublayer:gradientLayer atIndex:0];

    
  
    
    
    
}


- (void)testCrash {
    
    // 0.55
    // 0.56
    // 0.54
    // 0.56
    // 0.58
    NSLock *lock = [[NSLock alloc] init];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    // 0.55
    // 0.56
    // 0.57
    // 0.57
    // 0.57
//    static pthread_mutex_t pLock;
//    pthread_mutex_init(&pLock,NULL);
    
    NSTimeInterval begin = CACurrentMediaTime();
    
    for(int i = 0; i < 100000; i++) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//            [lock lock];
//            pthread_mutex_lock(&pLock);
            
            SNAppConfigABTest *abTest = [SNPerson shared].configABTest;
            if (abTest.abTestExpose.length > 0) {
                [dict setValue:abTest.abTestExpose forKey:@"abtestExpose"];
                NSLog(@"read abtestExpose---%d",i);
            }
//            [lock unlock];
//            pthread_mutex_unlock(&pLock);


            
        });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [lock lock];
//            pthread_mutex_lock(&pLock);
        
            [[SNPerson shared] requestConfigAsync];
            NSLog(@"write abtestexpose --%d",i);

            
//            [lock unlock];
//            pthread_mutex_unlock(&pLock);


        });
        
    }
    
    NSLog(@"all time is %.2f",CACurrentMediaTime() - begin);
    // destory
//    pthread_mutex_destroy(&pLock);
  
}


- (void)testStringNil {
    
    NSString *str0 = nil;
//    NSString *str0 = [NSNull null];
    NSString *str1 = @"";
    NSString *str2 = @"test";
    
    if (!str0.length) {
        NSLog(@"str0 is nil");
    }
    
    if (!str1.length) {
        NSLog(@"str1 is nil");
    }
    
    if (!str2.length) {
        NSLog(@"str2 is nil");
    }
}

@end
