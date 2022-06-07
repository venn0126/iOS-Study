//
//  ViewController.m
//  TestMutableDictionary
//
//  Created by Augus on 2022/5/30.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self testMutableDictionary:nil];
    [self testLocationNofFound];
}


- (void)testLocationNofFound {
    
    
    NSString *testString = @"media.html?";
    if ([testString rangeOfString:@"media"].location != NSNotFound) {
        NSLog(@"it is found");
    } else {
        NSLog(@"it is not found");
    }
}


- (void)testMutableDictionary:(id)sender {
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
//    [dictionary setValue:[NSNull null] forKey:@"1"];
    
    NSUInteger index = (NSUInteger)pow(10, 1);
    
    for (NSUInteger i = 0; i < index; i++) {
        NSLog(@"it is %ld",i);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [dictionary setValue:nil forKey:@"isNil0"];
            [dictionary setValue:[self getSNONCE] forKey:@"snonce0"];
            
        });
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [dictionary setValue:nil forKey:@"isNil1"];
            [dictionary setValue:[self getSNONCE] forKey:@"snonce1"];
            
        });
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [dictionary setValue:nil forKey:@"isNil2"];
            [dictionary setValue:[self getSNONCE] forKey:@"snonce2"];
            
        });
    }
    
}

- (NSString*)getSNONCE{
     int num = (arc4random() % 100000000);
     NSString* randomNumber = [NSString stringWithFormat:@"%.8d", num];
     NSInteger int_ran = randomNumber.integerValue;
     NSString* str = [NSString stringWithFormat:@"%ld",int_ran];//按整数那 不支持0开头的
     return str;
 }


@end
