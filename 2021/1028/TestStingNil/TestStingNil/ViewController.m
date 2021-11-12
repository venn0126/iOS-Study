//
//  ViewController.m
//  TestStingNil
//
//  Created by Augus on 2021/11/11.
//

#import "ViewController.h"
#import "SNPerson.h"

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
    [self testCrash];
}


- (void)testCrash {
    
//    NSLock *lock = [[NSLock alloc] init];
    
    for(int i = 0; i < 10000; i++) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [lock lock];
            self.person = [[SNPerson alloc] init];
//            [lock unlock];
        });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//            [lock lock];
            self.person = [[SNPerson alloc] init];
//            [lock unlock];
        });
        
        NSLog(@"asyc idx %d",i);
    }
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
