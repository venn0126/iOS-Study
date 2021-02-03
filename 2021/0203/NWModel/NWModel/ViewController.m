//
//  ViewController.m
//  NWModel
//
//  Created by Augus on 2021/2/3.
//

#import "ViewController.h"
#import "NWClass.h"
#import <pthread.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.greenColor;

    
    

    
    


    
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
    
    NSInteger d1 = -5;
    NSInteger d2 = d1 | 8;/// < d1 = d1 | 8;
    NSLog(@"d1---%ld",d2);
    
    // 从all中去除bVoid
    NWEncodeType c1 = bVoid ^ all;
    NSLog(@"c1---%ld",c1);
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
