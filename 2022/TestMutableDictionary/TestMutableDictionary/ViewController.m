//
//  ViewController.m
//  TestMutableDictionary
//
//  Created by Augus on 2022/5/30.
//

#import "ViewController.h"
//#import "augusArm.h"

@interface ViewController ()

@end

@implementation ViewController

// 内部声明
void augusTest(void);
int augusAdd(int a, int b);
int augusSub(int a, int b);

void augusCompare(void);
void augusCompareInCondition(void);

void augusLDR(void);
void augusSTR(void);

NSInteger baseNumber = 12;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self testMutableDictionary:nil];
//    [self testLocationNofFound];
//    [self testStringNil];
    
//    [self compareNumberA:3 toNumberB:4];
//    func(1, 2);
//    [self testConditionStatementA:6 withB:4];
//    testArmCommand();
//    [self testArmFunc];
//    [self testArmDoWhile];
//    [self testArmWhile];
//    [self testArmFor];
//    [self testSwitchWayOne:2];
    [self testSwitchWayTwo:6];
    NSLog(@"view did load end");
    
    
}


- (void)testSwitchWayOne:(NSInteger)one {
    
    switch (one) {
        case 1:
            NSLog(@"111");
            break;
        case 2:
            NSLog(@"222");
            break;
        case 3:
            NSLog(@"333");
            break;
            
        default:
            NSLog(@"default one");
            break;
    }
    
//    switch (one) {
//        case 1:
//            NSLog(@"111");
//            break;
//        case 10:
//            NSLog(@"10");
//            break;
//        case 100:
//            NSLog(@"100");
//            break;
//        case 1000:
//            NSLog(@"1000");
//            break;
//        default:
//            NSLog(@"default one");
//            break;
//    }
}


- (void)testSwitchWayTwo:(NSInteger)two {
    
    switch (two) {
          case 1:
              NSLog(@"1");
              break;
          case 4:
              NSLog(@"4");
              break;
          case 3:
              NSLog(@"3");
              break;
          case 6:
              NSLog(@"6");
              break;
          default:
              NSLog(@"default one");
              break;
      }
    
}


- (void)testArmFor {
    
    NSInteger sum = 0;
    for (NSInteger i = 0; i < 100; i++) {
        sum += i;
    }
}


- (void)testArmWhile {
    
    NSInteger sum = 0;
    NSInteger i = 0;
    while (i < 100) {
        sum += 1;
        i++;
    }
}



- (void)testArmDoWhile {
    
    NSInteger sum = 0;
    NSInteger i = 0;
    do {
        sum += 1;
        i++;
    } while (i < 100);
}



- (void)testArmFunc {
    
    
//    NSLog(@"begin study arm64");
//    augusTest();
//    NSLog(@"add is %d",augusAdd(1, 23));
//    NSLog(@"sub is %d",augusSub(5, 10));
//    augusCompare();
//    augusCompareInCondition();
    
    // if else 反汇编
//    int a = 5;
//    int b = 2;
//    if (a > b) {
//        printf("a > b");
//    } else {
//        NSLog(@"a <= b");
//    }
    
//    int a = 9;
//    augusLDR();
    augusSTR();
}


int testArmCommand(void) {
    NSLog(@"%d %d %d %d %d",1, 2, 3, 4, 5);
    return 6;
}


- (void)testConditionStatementA:(NSInteger)a withB:(NSInteger)b {
    if (a > b) {
        baseNumber = a;
    } else {
        baseNumber = b;
    }
}


- (void)testStringNil {
    
    NSString *tempStr = @"1233";
    tempStr = nil;
    tempStr = @"";
    if (tempStr.length == 0) {
        NSLog(@"temp str is 1233");
    } else {
        NSLog(@"temp str is nil");

    }
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
