//
//  ViewController.m
//  NWModel
//
//  Created by Augus on 2021/2/3.
//

#import "ViewController.h"
#import "NWClass.h"
#import <pthread.h>
#import "CALayer+NWLayer.h"

@interface ViewController ()

@property (nonatomic, strong) NWClass *nw;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.greenColor;


//    [self testBackQueueDeallocObject];
    
//    [self testCGBitmapCreateImage];
    

    
}


- (void)testCGBitmapCreateImage {
    
    // liveness_layout_head_mask
    
//    size_t bytesPerRow = 4352;
//    // Get the pixel buffer width and height
//    size_t width = 1088; // w h bytesrow 1280  720 1280
//    size_t height = 1905; // 1088 1905 4352
//
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    // create context
//    CGContextRef ctx = CGBitmapContextCreate(<#void * _Nullable data#>, <#size_t width#>, <#size_t height#>, <#size_t bitsPerComponent#>, <#size_t bytesPerRow#>, <#CGColorSpaceRef  _Nullable space#>, <#uint32_t bitmapInfo#>)
    
    // draw in context
//    CGImageRef img = CGBitmapContextCreateImage(NULL);
    
    // release ctx
//    CFRelease(<#CFTypeRef cf#>)
    
    //
//    dispatch_async(dispatch_get_main_queue(), ^{
//       
//        self.view.layer.contents = (__bridge id _Nullable)(img);
//        CFRelease(img);
//    });
    
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"touch log0--%@",_nw);
    [_nw logName];
    NSLog(@"touch log1");

}

- (void)testBackQueueDeallocObject {
    
    _nw = [[NWClass alloc] initWithName:@"GT"];
    NWClass *nwTemp = _nw;
    _nw = nil;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        NSLog(@"queue class");
        [nwTemp class];
        [nwTemp logName];
    });

    
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
    
    NSLog(@"@\"");
    NSLog(@"\"<");
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
