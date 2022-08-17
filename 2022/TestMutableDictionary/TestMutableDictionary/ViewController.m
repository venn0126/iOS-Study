//
//  ViewController.m
//  TestMutableDictionary
//
//  Created by Augus on 2022/5/30.
//

#import "ViewController.h"
//#import "augusArm.h"
#import "Person.h"
#import "TestTransformCG.h"
#import "SNAugusFadeImageView.h"

#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)

@interface ViewController ()

@property (nonatomic, strong) UIImageView *showImageOne;
@property (nonatomic, strong) UIImageView *showImageTwo;
@property (nonatomic, strong) UIButton *weChatButton;
@property (nonatomic, copy) NSString *tian;
@property (nonatomic, strong) SNAugusFadeImageView *fadeImageView;



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
    
//    [self testArrayCrash];
    
//    NSLog(@"start");
//
//    [Person say:@"nihao" callback:^(NSString * _Nonnull text, int x, NSString * _Nonnull y, double z, BOOL m) {
//       
//        NSLog(@"end");
//    }];
    
//    [self testWeChatAnimation];
//    [self testCoreTextFrame];
    

//    [self gradientAnimation];
    
//    self.view.backgroundColor = UIColor.whiteColor;
    
//    [self testFadeImageView];
//    [self testRadiusCircle];
    self.view.backgroundColor = UIColor.whiteColor;
//    [self testUpdateAnchorPointChangeFrame];
    
    [self testTextFieldClearButtonBackground];
}


- (void)testTextFieldClearButtonBackground {
    
    
    UITextField *testField = [[UITextField alloc] init];
    testField.borderStyle = UITextBorderStyleLine;
    testField.clearButtonMode = UITextFieldViewModeWhileEditing;
    UIButton *clearButton = [testField valueForKey:@"_clearButton"];
    // 自定义clearButton 有风险 在不同的iOS版本中
    if (clearButton && [clearButton isKindOfClass:[UIButton class]]) {
        [clearButton setImage:[UIImage imageNamed:@"icochannel_close_v5"] forState:UIControlStateNormal];
        //[clearButton setImage:[UIImage imageNamed:@"icochannel_closepress_v5"] forState:UIControlStateHighlighted];
    }
    testField.frame = CGRectMake(100, 100, 100, 30);
    
    [self.view addSubview:testField];
    
    
    
}



- (void)testUpdateAnchorPointChangeFrame {
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    redView.backgroundColor = UIColor.redColor;
    [self.view addSubview:redView];
    
    
    UIView *greeenView = [[UIView alloc] initWithFrame:CGRectMake(50, 300, 100, 100)];
    greeenView.backgroundColor = UIColor.greenColor;
    [self.view addSubview:greeenView];
    
    
    UIView *yellowView = [[UIView alloc] initWithFrame:CGRectMake(50, 300, 50, 50)];
    yellowView.backgroundColor = UIColor.yellowColor;
    [self.view addSubview:yellowView];
    
    
    [self fixFrameForView:greeenView anchorPoint:CGPointMake(0.9, 0.8)];
    
    
}


- (void)fixFrameForView:(UIView *)aView anchorPoint:(CGPoint)anchorPoint {
    
    CGPoint oldOrigin = aView.frame.origin;
    aView.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = aView.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    aView.center = CGPointMake(aView.center.x - transition.x, aView.center.y - transition.y);
    
//    aView.frame.origin = CGPointMake(aView.center.x - transition.x, aView.center.y - transition.y);
    
//    aView.frame = CGRectMake(aView.center.x - transition.x, aView.center.y - transition.y, aView.frame.size.width, aView.frame.size.height);
}





- (void)printAllFonts {
    
    NSArray *familyNames = [UIFont familyNames];
    NSMutableArray *fontsArray = [NSMutableArray array];
    
    for (int i = 0; i < familyNames.count; i++) {
        NSString *familyName = familyNames[i];
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        if (fontNames) {
            NSDictionary *dict = @{
                @"familyName" : familyName,
                @"fontNames" : fontNames,
            };
            [fontsArray addObject:dict];
        }
    }
    
    NSLog(@"fontsArray is %@",fontsArray);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (!self.fadeImageView.isAnimationing) {
        [self.fadeImageView startAnimation];
    } else {
        [self.fadeImageView stopAnimation];
    }
    
    [self.view endEditing:YES];

}

- (void)testFadeImageView {
    
    self.fadeImageView = [[SNAugusFadeImageView alloc] initWithFrame:CGRectMake(0, 0, 174, 42)];
//    self.fadeImageView.imageName = @"night_sohu_loading_1";
    self.fadeImageView.center = self.view.center;
    [self.view addSubview:self.fadeImageView];
    
}

- (void)gradientAnimation {
    
    self.view.backgroundColor = UIColor.darkGrayColor;
        

    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 174, 42)];
    [self.view addSubview:maskView];
    maskView.center = self.view.center;
    
    
    self.showImageOne.image = [UIImage imageNamed:@"sohu_loading_1"];
    self.showImageOne.frame = CGRectMake(0, 0, 174, 42);
    [maskView addSubview:self.showImageOne];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    /**
     日间：
     字色#dadada，渐变色#c4c4c4（高斯模糊2.8PX，不透明度80%）
     夜间：
     字色#343434，渐变色#454545（高斯模糊2.8PX，不透明度80%）
     
     */
    // 设置渐变色
    gradient.colors = @[(id)(UIColor.orangeColor.CGColor),(id)UIColor.redColor.CGColor,(id)UIColor.blackColor.CGColor];
    // 设置影响的位置
    gradient.locations = @[@0, @0, @0.25];
    
    // 横向渐变
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);
    
    // 设置渐变尺寸
    gradient.frame = self.showImageOne.bounds;
    [maskView.layer insertSublayer:gradient atIndex:0];
    
    // 添加移动动画
    CABasicAnimation *gradientAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
    gradientAnimation.fromValue = @[@0, @0, @0.2];
    gradientAnimation.toValue = @[@0.8, @1, @1];
    gradientAnimation.duration = 10.0;
    
    //
    gradientAnimation.repeatCount = MAXFLOAT;
    [gradient addAnimation:gradientAnimation forKey:nil];
    
    maskView.maskView = self.showImageOne;
    
}


- (void)testCoreTextFrame {
    
    TestTransformCG *transform = [[TestTransformCG alloc] initWithFrame:CGRectMake(40, 100, 300, 200)];
    [self.view addSubview:transform];
}


- (void)testWeChatAnimation {
    
    [self.view addSubview:self.weChatButton];
//    self.weChatButton.transform = CGAffineTransformMakeScale(0.01,0.01);

//    [UIView animateWithDuration:1.0 animations:^{
//        self.weChatButton.transform = CGAffineTransformMakeScale(1.0,1.0);
//        self->_weChatButton.frame = CGRectMake(80, 100, 88, 72);
//    } completion:^(BOOL finished) {
//        [self scaleAnimationForView:self.weChatButton];
//
//    }];
    
    [self scaleAnimationForView:self.weChatButton];
//
}

- (void)scaleAnimationForView:(UIView *)targetView {
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@1.f, @1.3f, @0.8, @1.f];
    animation.keyTimes = @[@0.f, @0.4f, @0.7, @1.f];
    animation.duration = 0.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.removedOnCompletion = NO;
    animation.repeatCount = 2;
    animation.fillMode = kCAFillModeForwards;

    [targetView.layer addAnimation:animation forKey:nil];
}


- (void)testArrayCrash {
    
    
    
    /*
     *** -[__NSArrayM removeObjectsInRange:]: range {5, 1} extends beyond bounds [0 .. 2]
     数字5是removeObjectAtIndex的下标，[0 .. 2]是数组里有从0到2一共3个元素。
    解决：判断删除的index是否小于当前数组的count
     if (array.count > index) {
        [array removeObjectAtIndex:index];
     }
     */
//    NSMutableArray *array = [NSMutableArray array];
//    [array addObject:@" "];
//    [array addObject:@" "];
//    [array addObject:@" "];
//    [array removeObjectAtIndex:5];
    
    
    /*
     *** Collection <__NSArrayM: 0x600001ad2a00> was mutated while being enumerated.
     用for in 进行遍历其间如果修改了数组（增加或删除元素）会引起闪退
     
     解决办法：
     for (NSString *str in array.copy) {
         NSLog(@"%@",str);
     }
     for (int i = 0; i < array.count; i++) {
      NSLog(@"%@",array[i]);
      }
     [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      NSLog(@"%@",obj);
      }];
    
     */
    NSMutableArray *array = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 1000; i++) {
            [array addObject:@"1"];
            NSLog(@"%d",i);
        }
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 100; i++) {
            for (NSString *str in array) {
                NSLog(@"%@",str);
            }

        }
    });
    
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


- (UIButton *)weChatButton {
    if (!_weChatButton) {
        _weChatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _weChatButton.frame = CGRectMake(100, 100, 88, 72);
        [_weChatButton setImage:[UIImage imageNamed:@"icotcshare_wx_v5"] forState:UIControlStateNormal];
//        _weChatButton.hidden = YES;
    }
    return _weChatButton;
}


@end
