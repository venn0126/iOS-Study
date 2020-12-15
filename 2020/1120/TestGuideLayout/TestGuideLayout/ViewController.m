//
//  ViewController.m
//  TestGuideLayout
//
//  Created by Augus on 2020/11/20.
//

#import "ViewController.h"
#import <objc/runtime.h>
#include <CommonCrypto/CommonHMAC.h>
#import <CoreText/CoreText.h>


@interface ViewController ()


@property (nonatomic, copy) NSString *ydj;
@property (nonatomic, strong) UILabel *showLabel;

@property (nonatomic, strong) NSTimer *fosTimer;

@property (nonatomic, strong) CALayer *myLayer;
@property (nonatomic, strong) UIView *myView;




@end

@implementation ViewController{
    
    NSInteger _count;
    BOOL _isPresent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
//    [self testLayoutGuide];
    
    
//    [self testCopy];
    
//    [self testGroupHttp];
    
//    NSInteger a = 8;
//    NSInteger b = 10;
//    
//    CGFloat tempB = [t float];
//    
//    CGFloat c = (CGFloat)(a / b);
//    NSLog(@"c--%f",c);
    
    
//    [self batchRequestConfig];
    
//    UILabel *labe  = [[UILabel alloc] init];
//    labe.text = @"";
    
    [self showLabel];
    _count = 0;
    [self.showLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.showLabel.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;

    
    NSLog(@"---%ld",LONG_MAX);
    
    NSString *test = @"left_right_shake";
    NSLog(@"len ---%ld",test.length);
    
    



    
    
//    self.myLayer = [CALayer layer];
//    self.myLayer.frame = CGRectMake(0, 0, 100, 100);
//    self.myLayer.position = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5);
//    self.myLayer.backgroundColor = UIColor.redColor.CGColor;
//    [self.view.layer addSublayer:self.myLayer];
    
    [self myView];
    
    
//    cttext
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [self batchRequestConfig];
    
    
//    [CATransaction begin];
//    [CATransaction setAnimationDuration:1.0];
//    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
//    self.myLayer.position = [[touches anyObject] locationInView:self.view];
//
//    [CATransaction commit];
    
    
    if (!_isPresent) {
        [self fos_showView];
    }else {
        [self fos_dismissView];
    }
}

- (void)fos_showView {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.myView.frame = CGRectMake(0, self.view.bounds.size.height - 200, self.view.bounds.size.width, 200);
        _isPresent = YES;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)fos_dismissView {
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.myView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 200);
        _isPresent = NO;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)test_md5 {
    
    
    NSString *sessionID = [[NSUUID UUID] UUIDString];
    NSLog(@"sessionid---%@",sessionID);

    // 14C98594-C9B7-493B-8223-E60133E45B21
    //
    
    NSString *bundlid = @"com.csii.madp.standard";
//    NSString *platformType = @"iPhone9,2_iOS13.6.1_1.0.0_iOS";
    NSString *sdkVersion = @"1.0.0";
    NSString *sdktype = @"bioauth";
    NSString *timeStr = @"1607323686529";
    NSString *license = @"3Q6QuP5FtZsPCYaD";
    NSString *letString = @"fosafer20180725";
    
    
//    FOSLogDebug(@"before1111 md5 %@-%@-%@-%@-%@-%@",bundleId,time,testKey,sdkType,sdkVersion,letString);

    
    NSString *beforeStr = [NSString stringWithFormat:@"%@%@%@%@%@%@",bundlid,timeStr,license,sdktype,sdkVersion,letString];
    
    NSLog(@"加密之前111---%@",beforeStr);
    NSString *sign = [self getMD5String:beforeStr];
    NSLog(@"sign---%@",sign);
}

- (NSString *)getMD5String:(NSString *)aString {
    
    NSData *dataString = [aString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutData = [[NSMutableData alloc] initWithData:dataString];
    const char * original_str = (const char *)[mutData bytes];
    unsigned char digist[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)mutData.length, digist);
    NSData    *data = [NSData dataWithBytes:(const void *)digist length:sizeof(unsigned char)*CC_MD5_DIGEST_LENGTH];
    return [self convertDataToHexStr:data];
}

- (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return [string uppercaseString];
}

- (void)dealloc {
    
    if (self.fosTimer) {
        [self.fosTimer invalidate];
        self.fosTimer = nil;
    }
}


//dispatch_group_t dispatch_group_create(void) {
    //申请内存空间
//    dispatch_group_t dg = (dispatch_group_t)_dispatch_alloc(DISPATCH_VTABLE(group), sizeof(struct dispatch_semaphore_s));
    
//    _dispatch_alloc(DISPATCH_VT)
    //使用LONG_MAX初始化信号量结构体
//    _dispatch_semaphore_init(LONG_MAX, dg);
//    return dg;
    
    
//}


//- (void)batchRequestConfig {
//    dispatch_group_t group = dispatch_group_create();
//    NSArray *list = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
//    [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        //标记开始本次请求
//        dispatch_group_enter(group);
////        [self fetchConfigurationWithCompletion:^(NSDictionary *dict) {
//            //标记本次请求完成
//            dispatch_group_leave(group);
//        }];
//    }];
    
//    __weak typeof(self)weakSelf = self;
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        //所有请求都完成了,执行刷新UI等操作
//
//
//        NSLog(@"finish refresh UI");
//        weakSelf.showLabel.text = [NSString stringWithFormat:@"等待完成%ld次",_count++];
//
//
//
//    });
//}
//- (void)fetchConfigurationWithCompletion:(void(^)(NSDictionary *dict))completion {
//    //AFNetworking或其他网络请求库
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //模拟网络请求
//        sleep(10);
//        !completion ? nil : completion(nil);
//    });
//}


- (void)testGroupHttp {
    
    dispatch_group_t fsGroup = dispatch_group_create();
    
    //模拟网络请求1
        dispatch_group_enter(fsGroup);
        //实际运用时，用网络请求的方法代替下面的内容，不要忘记leave异步
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            for (int i = 0; i < 5; i++) {
                [NSThread sleepForTimeInterval:1];
                NSLog(@"当前线程：%@，是否是主线程：%@...1111···%d",[NSThread currentThread],[NSThread isMainThread]?@"是":@"否",i);//当前线程：<NSThread: 0x60000027ef40>{number = 3, name = (null)}，是否是主线程：否...1111···0
            }
            dispatch_group_leave(fsGroup);
        });
        NSLog(@"当前线程：%@，是否是主线程：%@...4444···",[NSThread currentThread],[NSThread isMainThread]?@"是":@"否");
    
    
    //模拟网络请求2
       dispatch_group_enter(fsGroup);
       //实际运用时，用网络请求的方法代替下面的内容，不要忘记leave      异步
       dispatch_async(dispatch_get_global_queue(0, 0), ^{
           for (int i = 0; i < 5; i++) {
               [NSThread sleepForTimeInterval:1];
               NSLog(@"当前线程：%@，是否是主线程：%@...2222···%d",[NSThread currentThread],[NSThread isMainThread]?@"是":@"否",i);//当前线程：<NSThread: 0x604000272540>{number = 4, name = (null)}，是否是主线程：否...2222···0
           }
           dispatch_group_leave(fsGroup);
       });
       
       dispatch_group_notify(fsGroup, dispatch_get_main_queue(), ^{
           NSLog(@"当前线程：%@，是否是主线程：%@...3333···",[NSThread currentThread],[NSThread isMainThread]?@"是":@"否");//当前线程：<NSThread: 0x604000071d40>{number = 1, name = main}，是否是主线程：是...3333···
       });
}

- (void)set_gaoTian:(NSString *)_gaoTian {
    
    
}


- (void)testCopy {
    
    NSMutableString *mutStr = [NSMutableString stringWithString:@"123"];
    NSString *copyStr = mutStr;
    NSLog(@"mutStr--%p----copy---%p",mutStr,copyStr);
    
    
    
    [mutStr appendString:@"456"];
    NSLog(@"mul--%@---%@",mutStr,copyStr);
}

- (void)test_systemButton {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"i am a button" forState:UIControlStateNormal];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:btn];
    
    
    [btn.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    [btn.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100].active = YES;
}


- (void)testLayoutGuide {
    
    
    // 打印 attributes
//    unsigned int outCount = 0;
//    objc_property_t* propertys = class_copyPropertyList([ViewController class], &outCount);
//    for (unsigned i = 0; i < outCount; i++) {
//        objc_property_t property = propertys[i];
//        assert(property != nil);
//        const char* name = property_getName(property);
//        NSLog(@"name: %s", name);
//
//        NSString* attrs = @(property_getAttributes(property));
//        NSLog(@"code: %@", attrs);
//    }
    
    
    /**
     
     将 frame 布局 自动转化为约束布局，
     转化的结果是为这个视图自动添加所有需要的约束，如果我们这时给视图添加自己创建的约束就一定会约束冲突。

     为了避免上面说的约束冲突，我们在代码创建 约束布局 的控件时 直接指定这个视图不能用frame 布局（即translatesAutoresizingMaskIntoConstraints=NO），可以放心的去使用约束了。
     
     
     假设我们现在有这样的布局需求，两个view，一个红色的view，一个绿色的view，这两个view左右排列，撑满整个屏幕，但是离屏幕的边界（不是内容边距margin）都有20的间隙，两个view之间相隔8，并且绿色的view宽度是红色view的两倍。
     
     
     redView.translatesAutoresizingMaskIntoConstraints = false
     greenView.translatesAutoresizingMaskIntoConstraints = false

     //获取安全区域的layoutGudie
     let safeArea = self.view.safeAreaLayoutGuide

     //Y轴方向布局
     redView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20.0).isActive = true
     safeArea.bottomAnchor.constraint(equalTo:redView.bottomAnchor , constant: 20.0).isActive = true
     greenView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20.0).isActive = true
     safeArea.bottomAnchor.constraint(equalTo: greenView.bottomAnchor, constant: 20.0).isActive = true
     //X轴方向布局
     redView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20.0).isActive = true
     greenView.leadingAnchor.constraint(equalTo: redView.trailingAnchor, constant: 8.0).isActive = true
     safeArea.trailingAnchor.constraint(equalTo: greenView.trailingAnchor, constant:20.0).isActive = true
     //尺寸相关的布局
     greenView.widthAnchor.constraint(equalTo: redView.widthAnchor, multiplier: 2.0).isActive = true

     */
    
    
    // 三个视图 水平排布 等间距
    
    // 每个视图之间的距离是 30
    
    CGFloat offSet = 20.f;
//    CGFloat height = self.view.frame.size.height - 40;
//    CGFloat w = (self.view.frame.size.width - 4 * offSet) / 3;
    

    UIView *tempView0 = [[UIView alloc] init];
    tempView0.backgroundColor = [UIColor greenColor];
    tempView0.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:tempView0];
    
    UIView *tempView1 = [[UIView alloc] init];
    tempView1.backgroundColor = [UIColor redColor];
    tempView1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:tempView1];
    
//    UIView *tempView2 = [[UIView alloc] init];
//    tempView2.backgroundColor = [UIColor yellowColor];
//    tempView2.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addSubview:tempView2];
    
    
    // make layout
//    [tempView0.widthAnchor constraintEqualToConstant:w].active = YES;
//    [tempView0.heightAnchor constraintEqualToConstant:height].active = YES;
    UILayoutGuide *safeArea;
    if (@available(iOS 11.0, *)) {
        safeArea = self.view.safeAreaLayoutGuide;
    } else {
        // Fallback on earlier versions
        
//        safeArea = self.view;
    }
    
    
    
    [tempView0.topAnchor constraintEqualToAnchor:safeArea.topAnchor constant:20].active = YES;
    [tempView0.bottomAnchor constraintEqualToAnchor:safeArea.bottomAnchor constant:-20].active = YES;
    [tempView0.leadingAnchor constraintEqualToAnchor:safeArea.leadingAnchor constant:offSet].active = YES;
//    [tempView0.topAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.topAnchor constant:200].active = YES;
    

//    [tempView1.widthAnchor constraintEqualToAnchor:tempView0.widthAnchor].active = YES;
    
    [tempView1.widthAnchor constraintEqualToAnchor:tempView0.widthAnchor multiplier:2].active = YES;
    [tempView1.topAnchor constraintEqualToAnchor:tempView0.topAnchor].active = YES;
    [tempView1.bottomAnchor constraintEqualToAnchor:tempView0.bottomAnchor].active = YES;
//    [tempView1.centerYAnchor constraintEqualToAnchor:tempView0.centerYAnchor].active = YES;
    [tempView1.leadingAnchor constraintEqualToAnchor:tempView0.trailingAnchor constant:8].active = YES;
    [tempView1.trailingAnchor constraintEqualToAnchor:safeArea.trailingAnchor constant:-offSet].active = YES;
//
//    [tempView2.widthAnchor constraintEqualToAnchor:tempView0.widthAnchor].active = YES;
//    [tempView2.heightAnchor constraintEqualToAnchor:tempView0.heightAnchor].active = YES;
//    [tempView2.centerYAnchor constraintEqualToAnchor:tempView0.centerYAnchor].active = YES;
//    [tempView2.leadingAnchor constraintEqualToAnchor:tempView1.trailingAnchor constant:offSet].active = YES;
//
//    [tempView2.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-offSet].active = YES;
}

- (UILabel *)showLabel {
    if (!_showLabel) {
        UILabel *aLabel = [[UILabel alloc] init];
        aLabel.backgroundColor = [UIColor greenColor];
        aLabel.textColor = UIColor.redColor;
        aLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:aLabel];
        
        _showLabel = aLabel;
    
    }
    return _showLabel;
}

- (UIView *)myView {
    if (!_myView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 200)];
        view.backgroundColor = UIColor.redColor;
        [self.view addSubview:view];
        _myView = view;
    }
    return _myView;
}

@end
