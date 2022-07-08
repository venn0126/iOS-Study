//
//  ViewController.m
//  TestMutableDictionary
//
//  Created by Augus on 2022/5/30.
//

#import "ViewController.h"
//#import "augusArm.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *showImageOne;
@property (nonatomic, strong) UIImageView *showImageTwo;

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
//    [self testSwitchWayTwo:6];
//    self.view.backgroundColor = UIColor.whiteColor;
//    [self testAssetsDifferentVersions];
//    NSLog(@"view did load end");
    
//    [self testEncryptWays];
}


- (void)testEncryptWays {
    
    /**
     typedef NS_OPTIONS(NSUInteger, NSDataBase64EncodingOptions) {
     // Use zero or one of the following to control the maximum line length after which a line ending is inserted. No line endings are inserted by default.
     
     // 每64个字符插入\r或\n
     NSDataBase64Encoding64CharacterLineLength = 1UL << 0,
     // 每76个字符插入\r或\n，标准中有要求是76个字符要换行，不过具体还是自己定
     NSDataBase64Encoding76CharacterLineLength = 1UL << 1,
     
     // Use zero or more of the following to specify which kind of line ending is inserted. The default line ending is CR LF.
     
     // 插入字符为\r
     NSDataBase64EncodingEndLineWithCarriageReturn = 1UL << 4,
     // 插入字符为\n
     NSDataBase64EncodingEndLineWithLineFeed = 1UL << 5,
     
     } API_AVAILABLE(macos(10.9), ios(7.0), watchos(2.0), tvos(9.0));
     */
    // TODO: Base64 encodings
    // string to base64 encoding
    NSString *testStr = @"123";
    NSData *testData = [testStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64Str = [testData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSLog(@"string to base64---%@",base64Str);
    
    // base64 to string
    NSData *testData1 = [[NSData alloc] initWithBase64EncodedString:base64Str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *testStr1 = [[NSString alloc] initWithData:testData1 encoding:NSUTF8StringEncoding];
    NSLog(@"base64 to string---%@",testStr1);
    
    
    // TODO: Hash func
    
    
    
    
    
    
    
    
}


- (void)testAssetsDifferentVersions {
    [self.view addSubview:self.showImageOne];
    [self.view addSubview:self.showImageTwo];

    if (@available(iOS 13.0, *)) {
        self.showImageOne.image = [UIImage imageNamed:@"Image0"];
        self.showImageTwo.image = [UIImage imageNamed:@"Image1"];

    } else {
        self.showImageOne.image = [UIImage imageNamed:@"ico_kongbaifx_v5"];

        self.showImageTwo.image = [self imageWithName:@"night_ico_file3_v5.png"];


    }
    
    
    
    // get current  user interfacestyle
//    if (@available(iOS 12.0, *)) {
//        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
//
//            // the style is dark
//            NSLog(@"UIUserInterfaceStyleDark");
//
//        } else if(self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight){
//            // the style is light
//            NSLog(@"UIUserInterfaceStyleLight");
//
//        } else {
//            // the style is unspecified
//            NSLog(@"UIUserInterfaceStyleUnspecified");
//
//        }
//    } else {
//        // Fallback on earlier versions
//        NSLog(@"UIUserInterfaceStyleUnspecified<12");
//
//    }
    
        
    // 在单个页面禁用深色模式
//    if (@available(iOS 13.0, *)) {
//        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
//    } else {
//        // Fallback on earlier versions
//    }
//
//    // 在单个页面禁用浅色模式
//    if (@available(iOS 13.0, *)) {
//        self.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
//    } else {
//        // Fallback on earlier versions
//    }
    
}


- (UIImage *)imageWithName:(NSString *)name {
    static NSBundle *resourceBundle = nil;
    if (!resourceBundle) {
        NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
        NSString *resourcePath = [mainBundle pathForResource:@"Profile1" ofType:@"bundle"];
        resourceBundle = [NSBundle bundleWithPath:resourcePath] ?: mainBundle;
    }
    UIImage *image = [UIImage imageNamed:name inBundle:resourceBundle compatibleWithTraitCollection:nil];
    return image;
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


#pragma mark - Lazy Load

- (UIImageView *)showImageOne {
    if (!_showImageOne) {
        _showImageOne = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//        _showImageOne.backgroundColor = UIColor.redColor;
    }
    return _showImageOne;
}


- (UIImageView *)showImageTwo {
    if (!_showImageTwo) {
        _showImageTwo = [[UIImageView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
//        _showImageOne.backgroundColor = UIColor.greenColor;
    }
    return _showImageTwo;
}


@end
