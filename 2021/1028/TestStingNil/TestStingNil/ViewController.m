//
//  ViewController.m
//  TestStingNil
//
//  Created by Augus on 2021/11/11.
//

#import "ViewController.h"
#import "SNPerson.h"
#import "SNAppConfigABTest.h"
#import <pthread.h>
#import "SNSon.h"
#import "NSDictionary+Extend.h"
#import "UIDevice+Helper.h"
#import "TestLayouView.h"

/// mutex0
static pthread_mutex_t mutex_0 = PTHREAD_MUTEX_INITIALIZER;
static pthread_mutex_t mutex_1 = PTHREAD_MUTEX_INITIALIZER;


@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) SNPerson *person;
@property (nonatomic, copy) NSArray *dataArray;


@end

@implementation ViewController{
    
    dispatch_queue_t _serialQueue;
}

// 外部函数的声明
int AugusTest(void);

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.linkColor;
//    [self testStringNil];
//    [self testCrash];
//    [self testCrash0];
//    [self testPthreadRWLock];
    
    // 函数的调用
//    AugusTest();
//    NSLog(@"assembly finish");
//    _serialQueue = dispatch_queue_create("com.augus.snapi",
//                                                         DISPATCH_QUEUE_SERIAL);
//    [self testSNAPICrash];
    
//    [self testAttributedStringInitCrash];
//    [self testAttributedStringAddAttributeCrash];
//    [self testAttributedStringInitAttributesCrash];
    
    
//    [self testLayoutSubviews];
    
    [self testArrayNotLegal];
    
}

- (void)testArrayNotLegal {
    
    NSArray *testNilArray = nil;
    NSArray *testZeroArray = [[NSArray alloc] init];
    
    if (testNilArray.count == 0) {
        NSLog(@"test nil arrry");
    }
    
    if (!testZeroArray.count) {
        NSLog(@"test zero array");
    }
}


- (void)testLayoutSubviews {
    
    
//    UIButton *button = [[UIButton alloc] init];
//    [self.view addSubview:button];
    
//    TestLayouView *testView = [[TestLayouView alloc] initWithFrame:CGRectZero];
    TestLayouView *testView = [[TestLayouView alloc] init];
    testView.frame = CGRectMake(0, 0, 100, 100);
    [self.view addSubview:testView];
}

- (void)testAttributedStringInitCrash
{
    NSString *nilStr = nil;
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:nilStr];
    NSLog(@"attributedStr is %@",attributedStr);
}


- (void)testAttributedStringAddAttributeCrash
{
    NSString *nonnullStr = @"str";
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:nonnullStr];
    
    NSString *nilValue = nil;
    [attributedStr addAttribute:NSAttachmentAttributeName value:nilValue range:NSMakeRange(0, 1)];
}

- (void)testAttributedStringInitAttributesCrash {
    NSString *nilStr = nil;
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:nilStr attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}];
    NSLog(@"attributedStr is %@",attributedStr);
    
}


- (void)testSNAPICrash {
    

    for (int i = 0; i < 100000; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            dispatch_sync(self->_serialQueue, ^{
                
                [self starDotGifParamString];
                NSLog(@"read starDotGifParamString---%d",i);
            });
            
            
            
        });
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            dispatch_sync(self->_serialQueue, ^{
                
                [self starDotGifParamString];
                NSLog(@"write starDotGifParamString---%d",i);
                
            });
            
        });
    }
}


- (void)testGradientButton {
    
    UIButton *forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [forwardButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    forwardButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [forwardButton setTitle:@"立即转发" forState:UIControlStateNormal];
    forwardButton.frame = CGRectMake(100, 100, 72, 24);
    [self.view addSubview:forwardButton];
    
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.colors = @[(id)[UIColor yellowColor].CGColor,(id)[UIColor orangeColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    gradientLayer.endPoint = CGPointMake(1.0, 0.0);
    gradientLayer.frame = forwardButton.bounds;
//    gradientLayer.locations = @[@0.5,@1.0];
    gradientLayer.cornerRadius = 12.0;
    [forwardButton.layer insertSublayer:gradientLayer atIndex:0];

    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2].CGColor;
    maskLayer.frame = forwardButton.bounds;
    maskLayer.cornerRadius = 12.0;
    [forwardButton.layer addSublayer:maskLayer];
    
//    UIView *maskView = [[UIView alloc] init];
    

    
    
    
}



- (void)notNoatmoicSetter {
    
    /**
     
     // setter
     // not natomic
     // threadA:  99
     // threadB: 94
     // threadA: 100
     // threadB: 100 -> crash
     
     
     
     void objc_storeStrong(id *location, id obj)
     {
         id prev = *location;
         if (obj == prev) {
             return;
         }
         objc_retain(obj);
         *location = obj;
         objc_release(prev);
     }
     */
}


- (void)messageInstanceSentToDealloctatedCode {
    
    
//    UILabel *le = [;]
    
    
    // getter
    // -[CFString release]: message sent to deallocated instance 0x600002aaf3c0
    // Log("*** - [%s %s]: message sent to deallocated instance %p",)
    
    /**
    
    
    // get instance class
    Class cls = object_getClass(self);

    // get instance class name
    const char *clsName = class_getName(cls);

    // get zombie pointer instance class name
    const char *originalClsName = substring_from(clsName, 10);

    // get call method name
    const char *selectorName = sel_getName(_cmd);

    // log error message
    Log("*** - [%s %s]: message sent to deallocated instance %p",originalClsName,selectorName,self);

    // kill
    abort();
     
     */
}

- (void)testCrash0 {
    
    // error message: *** -[SNPerson release]: message sent to deallocated instance 0x600000eb3b70
    for (int i = 0; i < 10000; i++)
        {

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                self.person = [SNPerson new];
            });
           dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                self.person = [SNPerson new];
            });
        }
}


- (void)testCrash {
    
    // 0.55
    // 0.56
    // 0.54
    // 0.56
    // 0.58
    NSLock *lock = [[NSLock alloc] init];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    // 0.55
    // 0.56
    // 0.57
    // 0.57
    // 0.57
//    static pthread_mutex_t pLock;
//    pthread_mutex_init(&pLock,NULL);
//    NSMutableDictionary *dotGifParams = [NSMutableDictionary dictionary];
    
    NSTimeInterval begin = CACurrentMediaTime();
    
    for(int i = 0; i < 100000; i++) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//            [lock lock];
//            pthread_mutex_lock(&mutex_0);
            
//            SNAppConfigABTest *abTest = [SNPerson shared].configABTest;
//            if (abTest.abTestExpose.length > 0) {
//                [dict setValue:abTest.abTestExpose forKey:@"abtestExpose"];
//           NSDictionary *dict1 = [self addAESEncryptParams];
//            NSLog(@"dict1--%@",dict1);
//            }
            
//            NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
//            NSString *intervalString = [NSString stringWithFormat:@"%.0f", interval];
//            if (!intervalString.length) {
//                intervalString = @"";
//            }
//            [dotGifParams setValue:[SNSon timeString] forKey:@"t0"];
            
//            NSString *idfv = [SNSon deviceIDFV];//new param 2019.6.6
//            if (!idfv.length) {
//                idfv = @"";
//            }
//            [dotGifParams setValue:idfv forKey:@"ios_idfv0"];
            
//            NSString *version = [SNSon appVersion];
//            if (!version.length) {
//                version = @"other";
//            }
//            [dotGifParams setValue:version forKey:@"v0"];
//            NSMutableDictionary *dotGifParams0 = [NSMutableDictionary dictionary];
//
////            NSString *cid = [SNSon getCid];
//
//
//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            NSString *cid = [userDefaults objectForKey:@"clientId"];
//            NSString *nowTime = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
//            NSString *verifyToken = [NSString stringWithFormat:@"%@_%@", cid, nowTime];
//            [dotGifParams0 setValue:verifyToken forKey:@"v2"];
            
//            NSString *resultString = [self starDotGifParamString];
//            NSLog(@"read --%@",resultString);
            
//            [self testShouldUploadAgif:@"name=niu&age=17=height=167&v=1.2.1&t=4G"];
            
            
            [self starDotGifParamString];
            NSLog(@"read abtestExpose---%d",i);

//            [lock unlock];
//            pthread_mutex_unlock(&mutex_0);
            



            
        });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [lock lock];
//            pthread_mutex_lock(&mutex_1);
        
//            [[SNPerson shared] requestConfigAsync];
            
//            NSDictionary *dict1 = [self addAESEncryptParams];
//             NSLog(@"dict2--%@",dict1);
//            NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
//            NSString *intervalString = [NSString stringWithFormat:@"%.0f", interval];
//            if (!intervalString.length) {
//                intervalString = @"";
//            }
//            [dotGifParams setValue:[SNSon timeString] forKey:@"t1"];
//            NSString *idfv = [SNSon deviceIDFV];//new param 2019.6.6
//            if (!idfv.length) {
//                idfv = @"";
//            }
//            [dotGifParams setValue:idfv forKey:@"ios_idfv1"];
            
//            NSString *version = [SNSon appVersion];
//            if (!version.length) {
//                version = @"other";
//            }
//            [dotGifParams setValue:version forKey:@"v1"];
//            NSMutableDictionary *dotGifParams1 = [NSMutableDictionary dictionary];
//
////            NSString *cid = [SNSon getCid];
//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            NSString *cid = [userDefaults objectForKey:@"clientId"];
//
//            NSString *nowTime = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
//            NSString *verifyToken = [NSString stringWithFormat:@"%@_%@", cid, nowTime];
//            [dotGifParams1 setValue:verifyToken forKey:@"v1"];
            
//            NSString *resultString = [self starDotGifParamString];
//            NSLog(@"write --%@",resultString);
//            [self testShouldUploadAgif:@"name=niu&age=17=height=167&v=1.2.1&t=4G"];
            [self starDotGifParamString];
            NSLog(@"write abtestexpose --%d",i);

//            [lock unlock];
//            pthread_mutex_unlock(&mutex_1);


        });
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
           
            [self starDotGifParamString];
            NSLog(@"middle abtestexpose --%d",i);
        });
        
    }
    
    NSLog(@"all time is %.2f",CACurrentMediaTime() - begin);
    // destory
//    pthread_mutex_destroy(&pLock);
  
}

- (void)testShouldUploadAgif:(NSString *)params {
    
    NSMutableDictionary* map = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    NSArray* params_arr = [params componentsSeparatedByString:@"&"];
    if (params_arr.count>0) {
        for (int i=0; i<params_arr.count; i++) {
            NSString* params_each = [params_arr objectAtIndex:i];
            if (params_each.length>0) {
                NSArray* keyValue_arr = [params_each componentsSeparatedByString:@"="];
                if (keyValue_arr.count>1) {
                    NSString* key = [keyValue_arr objectAtIndex:0];
                    NSString* value = [keyValue_arr objectAtIndex:1];
                    if (key && value) {
                        [map setObject:value forKey:key];
                    }
                }
            }
        }
    }
}

- (NSDictionary *)addAESEncryptParams {
    
    NSString *cid = [SNSon getCid];
    NSString *nowTime = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    NSString *verifyToken = [NSString stringWithFormat:@"%@_%@", cid, nowTime];
    NSString *plainText = [[NSString alloc] initWithFormat:@"cid=%@&verifytoken=%@&v=%@&p=%@", cid, verifyToken, [SNSon appVersion], @"iOS"];//明文
    if (!plainText) {
//        cipherText = [[SNRedPacketManager sharedInstance] aesEncryptWithData:plainText];//密文
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:10];
    [params setValue:verifyToken forKey:@"verifytoken"];
    [params setValue:cipherText forKey:@"ciphertext"];
//    [params setValue:[[SNRedPacketManager sharedInstance] getKeyVersion] forKey:@"keyv"];
//    [params setValue:[[SNUserLocationManager sharedInstance] realLongitude] forKey:@"cdma_lng"];
    [params setValue:@"" forKey:@"cdma_lng"];

//    [params setValue:[[SNUserLocationManager sharedInstance] realLatitude] forKey:@"cdma_lat"];
    [params setValue:@"" forKey:@"cdma_lat"];
    return params;
}

- (NSString *)starDotGifParamString {
    
    NSMutableDictionary *dotGifParams = [NSMutableDictionary dictionary];

    
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"clientId"];
    if (!uid.length) {
        uid = @"";
    }
    NSString *cid = uid;
    [dotGifParams setValue:cid forKey:@"c"];
    
    NSString *abTestExpose = [SNPerson.shared configABTest].abTestExpose;
    if (abTestExpose.length > 0) {
        [dotGifParams setValue:abTestExpose forKey:@"abResult"];
    }
    
    SNAppConfigABTest *configABTest = [SNPerson.shared configABTest];
    NSLog(@"config ab test address is %p",configABTest);

    
    
    //移动端系统平台
    [dotGifParams setValue:@"ios" forKey:@"p"];
    
    
    
    //App版本号
    NSString *version = [SNSon appVersion];
    if (!version.length) {
        version = @"other";
    }
    [dotGifParams setValue:version forKey:@"v"];
    
    
    [dotGifParams setValue:nil forKey:@"123"];
    
    [dotGifParams setValue:@"" forKey:@""];
    
    [dotGifParams setValue:@(1) forKey:@"1"];
    
//    [dotGifParams setValue:[NSNumber numberWithBool:YES] forKey:@"true"];
//
//    [dotGifParams setValue:[NSNumber numberWithDouble:0.12] forKey:@"double"];
    
    NSString *timeStamp = [SNAppConfigABTest augus_timeString];
    [dotGifParams setValue:timeStamp forKey:@"t"];
    
    
    // IDFA
    NSString *idfa = [UIDevice deviceIDFV];
    if (idfa.length == 0) {
        idfa = @"";
    }
    [dotGifParams setValue:idfa forKey:@"ios_idfa"];

    
    return [dotGifParams toUrlString];;
}

- (void)testPthreadRWLock {
    
    static pthread_rwlock_t rwLock;
    pthread_rwlock_init(&rwLock, NULL);
    SNPerson *person = [SNPerson shared];
    person.name = @"Augus";
    
    // 2 pthread read properties
    for (int i = 0; i < 100000; i++) {
        
        // read
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            pthread_rwlock_rdlock(&rwLock);
            
            NSLog(@"1 thread read name %d: %@",i,person.name);
            
            pthread_rwlock_unlock(&rwLock);
        });
        
        // read
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            pthread_rwlock_rdlock(&rwLock);
            
            NSLog(@"2 thread read name %d: %@",i,person.name);
            
            pthread_rwlock_unlock(&rwLock);
        });
        
        // write
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            pthread_rwlock_wrlock(&rwLock);
            NSInteger index = arc4random() % self.dataArray.count;
            person.name = self.dataArray[index];
            NSLog(@"3 thread write name %d: %@",i,person.name);

            pthread_rwlock_unlock(&rwLock);
        });
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

#pragma mark - Lazy Load

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"Li",@"Tian",@"Xiong",@"Zhao",@"Xing",@"Wang",@"Yang",@"EnHao",@"Teng",@"Long",@"Xiao"];
    }
    return _dataArray;
}

@end
