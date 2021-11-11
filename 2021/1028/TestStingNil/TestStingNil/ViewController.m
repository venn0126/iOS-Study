//
//  ViewController.m
//  TestStingNil
//
//  Created by Augus on 2021/11/11.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.linkColor;
    [self testStringNil];
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
