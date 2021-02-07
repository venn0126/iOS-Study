//
//  ViewController.m
//  NWModel
//
//  Created by Augus on 2021/2/3.
//

#import "ViewController.h"
#import "NWClassInfo.h"
#import <pthread.h>
#import "CALayer+NWLayer.h"
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.greenColor;


//    [self testBackQueueDeallocObject];
    
//    [self testCGBitmapCreateImage];
    
//    [self testEnumAndLocation];
    
//    [self testEncodingType];
    
    
    //
    
    [self testObjcMsgSend];
    
}


- (void)testObjcMsgSend {
    
    //    NWClassInfo *info = [[NWClassInfo alloc] init];
    // alloc
    NSObject *info = ((NSObject * (*)(id, SEL)) (void *)objc_msgSend)((id)[NSObject class],@selector(alloc));
    
    // init
    info = ((NSObject * (*)(id, SEL)) objc_msgSend)(info, @selector(init));
    // dynamic add method for info instance
    class_addMethod(info.class, NSSelectorFromString(@"cStyleFunc"), (IMP)cStyleFunc, "v@:");

    int value = ((int (*)(id, SEL, const char *, const char *))objc_msgSend)(info, NSSelectorFromString(@"cStyleFunc"),"参数1","参数2");
    NSLog(@"return value %d",value);
    
}

int cStyleFunc(const void *arg1,const void *arg2) {
    NSLog(@"%s is called, arg1 is %s and arg2 is %s",__func__,arg1,arg2);
    return 1;
}

typedef struct _struct {
    short a;
    long long b;
    unsigned long long c;
} Struct;


-(void)testEncodingType {
    
    int8_t i8 = pow(2, 7);
    int16_t i16 = pow(2, 15);
    NSLog(@"i8----%ld",(long)i8);
    NSLog(@"i16----%ld",(long)i16);
    
    
    NSUInteger m = 1 << 5;/// 1 * 2^5
    NSUInteger n = 2 << 3;/// 2 * 2^3
    NSLog(@"m--%ld---%ld",m,n);
    
    
    NSLog(@"char     : %s, %lu", @encode(char), sizeof(char));
    NSLog(@"short    : %s, %lu", @encode(short), sizeof(short));
    NSLog(@"int      : %s, %lu", @encode(int), sizeof(int));
    NSLog(@"long     : %s, %lu", @encode(long), sizeof(long));
    NSLog(@"long long: %s, %lu", @encode(long long), sizeof(long long));
    NSLog(@"float    : %s, %lu", @encode(float), sizeof(float));
    NSLog(@"double   : %s, %lu", @encode(double), sizeof(double));
    NSLog(@"NSInteger: %s, %lu", @encode(NSInteger), sizeof(NSInteger));
    NSLog(@"CGFloat  : %s, %lu", @encode(CGFloat), sizeof(CGFloat));
    NSLog(@"int32_t  : %s, %lu", @encode(int32_t), sizeof(int32_t));
    NSLog(@"int64_t  : %s, %lu", @encode(int64_t), sizeof(int64_t));
    
    
    NSLog(@"bool     : %s, %lu", @encode(bool), sizeof(bool));
    NSLog(@"_Bool    : %s, %lu", @encode(_Bool), sizeof(_Bool));
    NSLog(@"BOOL     : %s, %lu", @encode(BOOL), sizeof(BOOL));
    NSLog(@"Boolean  : %s, %lu", @encode(Boolean), sizeof(Boolean));
    NSLog(@"boolean_t: %s, %lu", @encode(boolean_t), sizeof(boolean_t));

    
    NSLog(@"void    : %s, %lu", @encode(void), sizeof(void));
    NSLog(@"char *  : %s, %lu", @encode(char *), sizeof(char *));
    NSLog(@"short * : %s, %lu", @encode(short *), sizeof(short *));
    NSLog(@"int *   : %s, %lu", @encode(int *), sizeof(int *));
    NSLog(@"char[3] : %s, %lu", @encode(char[3]), sizeof(char[3]));
    NSLog(@"short[3]: %s, %lu", @encode(short[3]), sizeof(short[3]));
    NSLog(@"int[3]  : %s, %lu", @encode(int[3]), sizeof(int[3]));
    
    
    NSLog(@"CGSize: %s, %lu", @encode(CGSize), sizeof(CGSize));
    
    
    NSLog(@"Class   : %s", @encode(Class));
    NSLog(@"NSObject: %s", @encode(NSObject));
    NSLog(@"NSString: %s", @encode(NSString));
    NSLog(@"id      : %s", @encode(id));
    NSLog(@"Selector: %s", @encode(SEL));
    

    NSLog(@"struct     : %s", @encode(typeof(Struct)));
    
    

    

    

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
    

}

- (void)testBackQueueDeallocObject {
    
//    _nw = [[NWClass alloc] initWithName:@"GT"];
//    NWClass *nwTemp = _nw;
//    _nw = nil;
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//        NSLog(@"queue class");
//        [nwTemp class];
//        [nwTemp logName];
//    });

    
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
    
    NSInteger d1 = 1;
    NSInteger d2 = d1 | 0;/// < d1 = d1 | 8;
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
