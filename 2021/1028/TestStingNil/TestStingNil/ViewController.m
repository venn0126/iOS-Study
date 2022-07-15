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
static NSInteger kNetworkErrorRetryCount = 0;

static NSString * const kTableViewCellAugus = @"UITableViewCellAugus";


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) SNPerson *person;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong) UITableView *augusTableView;

@property (nonatomic, copy) NSArray *historyDataArray;
@property (nonatomic, copy) NSArray *hotWordsDataArray;
@property (nonatomic, copy) NSArray *hotListDataArray;
@property (nonatomic, strong) UIButton *clearHistoryButton;
@property (nonatomic, strong) UIButton *clearHotWordsButton;
@property (nonatomic, strong) UIButton *clearHotListButton;
@property (nonatomic, assign) AugusCellType cellType;
@property (nonatomic, assign) NSInteger allSection;
@property (nonatomic, strong) UIButton *networkErrorButton;
@property (nonatomic, copy) NSArray *networkErrorTitles;
@property (nonatomic, strong) UITextField *augusTextField;
@property (nonatomic, strong) UILabel *augusLabel;




@end

@implementation ViewController{
    
    dispatch_queue_t _serialQueue;
}

// 外部函数的声明
int AugusTest(void);

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
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
    
    
    [self testLayoutSubviews];
    
//    [self testArrayNotLegal];
    
//    [self configureTableView];
    
//    [self testNetworkErrorRetry];
    
//    [self testTextField];
}


- (void)testTextField {
    
    [self.view addSubview:self.augusTextField];
    self.augusLabel = [[UILabel alloc] init];
    self.augusLabel.frame = CGRectMake(100, 100, 200,50);
    self.augusLabel.text = @"sohu is best";
    [self.view addSubview:self.augusLabel];
//    [self.augusTextField becomeFirstResponder];
    
//    self.augusTextField.inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//        self.augusTextField.inputView = nil;
//        self.augusTextField.inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 248)];
        self.augusLabel.text = @"xxxx";
    });
    
}


- (void)testNetworkErrorRetry {
    
    _networkErrorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _networkErrorButton.frame = CGRectMake(100, 100, 100, 100);
    [_networkErrorButton setTitle:@"Click Me" forState:UIControlStateNormal];
    [_networkErrorButton addTarget:self action:@selector(testNetworkErrorRetry:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_networkErrorButton];
}

- (void)testNetworkErrorRetry:(UIButton *)sender {
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//        dispatch_async(dispatch_get_main_queue(), ^{
            NSInteger index = arc4random() % self.networkErrorTitles.count;
            NSString *title = self.networkErrorTitles[index];
            if ([title isEqualToString:@"Click Me"]) {
                kNetworkErrorRetryCount += 1;
                NSLog(@"it is network error count %ld",kNetworkErrorRetryCount);
            } else {
                kNetworkErrorRetryCount = 0;
                NSLog(@"it is network success count %ld",kNetworkErrorRetryCount);
            }
//        });
//    });
    
}

- (void)configureTableView {
    
    
    
    _historyDataArray = @[@"history"];
    _hotWordsDataArray = @[@"hotWords"];
    _hotListDataArray = @[@"hotList"];
    
    [self.augusTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCellAugus];
    
    [self.view addSubview:self.augusTableView];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    /**
     
     //声明定义枚举变量
     MyOption option = MyOption1 | MyOption2;//0001 | 0010 = 0011,3

     //检查是否包含某选型
     if ( option & MyOption3 ){ //0011 & 0100 = 0000
          //包含MyOption3
     }else{
          //不包含MyOption3
     }

     //增加选项:
     option = option | MyOption4;//0011 | 1000 = 1011, 11
     //减少选项
     option = option & (~MyOption4);//1011 & (~1000) = 1011 & 0111 = 0011, 3
     */
    
    // 1 2 3
    
    AugusCellType tempType = AugusCellTypeNone;
    NSInteger section = 0;
    
    if (_historyDataArray.count) {
        tempType |= AugusCellTypeHistory;
        section += 1;
    }
    if (_hotWordsDataArray.count) {
        tempType |= AugusCellTypeHotWords;
        section += 1;

    }
    if (_hotListDataArray.count) {
        tempType |= AugusCellTypeHotList;
        section += 1;

    }
    
    _cellType = tempType;
    _allSection = section;
    return section;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _cellType == AugusCellTypeNone ? 0 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellAugus forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTableViewCellAugus];
    }
    
    
    if (_allSection == 1) {
        if (_cellType & AugusCellTypeHistory) {
            cell.textLabel.text = self.historyDataArray.firstObject;

        } else if(_cellType & AugusCellTypeHotWords) {
            cell.textLabel.text = self.hotWordsDataArray.firstObject;

        }else if(_cellType & AugusCellTypeHotList) {
            cell.textLabel.text = self.hotListDataArray.firstObject;

        }
    }
    
    
    // 0 1 2,01,12,02
    //
    if (_allSection == 2) {
        
        // 01
        if ((_cellType & AugusCellTypeHistory) && (_cellType & AugusCellTypeHotWords)) {
            if (indexPath.section == 0) {
                cell.textLabel.text = self.historyDataArray.firstObject;

            } else {
                cell.textLabel.text = self.hotWordsDataArray.firstObject;

            }
        }
        
        // 12
        if ((_cellType & AugusCellTypeHotWords) && (_cellType & AugusCellTypeHotList)) {
            if (indexPath.section == 0) {

                cell.textLabel.text = self.hotWordsDataArray.firstObject;
            } else {
                cell.textLabel.text = self.hotListDataArray.firstObject;

            }
        }
        
        // 02
        if ((_cellType & AugusCellTypeHistory) && (_cellType & AugusCellTypeHotList)) {
            if (indexPath.section == 0) {

                cell.textLabel.text = self.historyDataArray.firstObject;
            } else {
                cell.textLabel.text = self.hotListDataArray.firstObject;

            }
        }
        
        
    }
    
    if (_allSection == 3) {
        
        if (indexPath.section == 0) {
            cell.textLabel.text = self.historyDataArray.firstObject;

        }
        if(indexPath.section == 1) {
            cell.textLabel.text = self.hotWordsDataArray.firstObject;

        }
        if(indexPath.section == 2) {
            cell.textLabel.text = self.hotListDataArray.firstObject;

        }
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    UIView *view = [[UIView alloc] init];
    
    // 1
    // 2
    // 3
    
    
    
    if (_allSection == 1) {
        if (_cellType & AugusCellTypeHistory) {
            view.backgroundColor = UIColor.yellowColor;
            [view addSubview:self.clearHistoryButton];
        } else if(_cellType & AugusCellTypeHotWords) {
            view.backgroundColor = UIColor.lightGrayColor;
            [view addSubview:self.clearHotWordsButton];
        }else if(_cellType & AugusCellTypeHotList) {
            view.backgroundColor = UIColor.blueColor;
            [view addSubview:self.clearHotListButton];
        }
    }
    
    
    // 0 1 2,01,12,02
    //
    if (_allSection == 2) {
        
        // 01
        if ((_cellType & AugusCellTypeHistory) && (_cellType & AugusCellTypeHotWords)) {
            if (section == 0) {
                view.backgroundColor = UIColor.yellowColor;
                [view addSubview:self.clearHistoryButton];
            } else {
                view.backgroundColor = UIColor.lightGrayColor;
                [view addSubview:self.clearHotWordsButton];
            }
        }
        
        // 12
        if ((_cellType & AugusCellTypeHotWords) && (_cellType & AugusCellTypeHotList)) {
            if (section == 0) {

                view.backgroundColor = UIColor.lightGrayColor;
                [view addSubview:self.clearHotWordsButton];
                
            } else {
                view.backgroundColor = UIColor.blueColor;
                [view addSubview:self.clearHotListButton];
            }
        }
        
        // 02
        if ((_cellType & AugusCellTypeHistory) && (_cellType & AugusCellTypeHotList)) {
            if (section == 0) {

                view.backgroundColor = UIColor.yellowColor;
                [view addSubview:self.clearHistoryButton];
                
            } else {
                view.backgroundColor = UIColor.blueColor;
                [view addSubview:self.clearHotListButton];
            }
        }
        
        
    }
    
    if (_allSection == 3) {
        
        if (section == 0) {
            view.backgroundColor = UIColor.yellowColor;
            [view addSubview:self.clearHistoryButton];
        }
        if(section == 1) {
            view.backgroundColor = UIColor.lightGrayColor;
            [view addSubview:self.clearHotWordsButton];
        }
        if(section == 2) {
            view.backgroundColor = UIColor.blueColor;
            [view addSubview:self.clearHotListButton];
        }
    }
    

    return view;
}


- (void)clearButtonAction:(UIButton *)sender {
    
    if (sender.tag == 1000) {
        _historyDataArray = nil;
    }
    if (sender.tag == 1001) {
        _hotWordsDataArray = nil;
    }
    if (sender.tag == 1002) {
        _hotListDataArray = nil;
    }
    
    [self.augusTableView reloadData];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 38;
}

- (void)testArrayNotLegal {
    
    NSArray *testNilArray = nil;
    NSArray *testZeroArray = [[NSArray alloc] init];
    
    @synchronized (testNilArray) {
        if (testNilArray.count == 0) {
            NSLog(@"test nil arrry");
        }
        
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
    // safe area 47
    testView.frame = CGRectMake(0, 100, 100, 100);
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
//    [params setValue:cipherText forKey:@"ciphertext"];
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

- (UITableView *)augusTableView {
    if (!_augusTableView) {
        
        _augusTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, 350) style:UITableViewStyleGrouped];
        _augusTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _augusTableView.scrollEnabled = NO;
        _augusTableView.delegate = self;
        _augusTableView.dataSource = self;
    }
    return _augusTableView;
}

//- (NSArray *)historyDataArray {
//
//    if (!_historyDataArray) {
//        _historyDataArray = @[@"history"];
//    }
//    return _historyDataArray;
//}
//
//- (NSArray *)hotWordsDataArray {
//
//    if (!_hotWordsDataArray) {
//        _hotWordsDataArray = @[@"hotWords"];
//    }
//    return _hotWordsDataArray;
//}
//
//- (NSArray *)hotListDataArray {
//
//    if (!_hotListDataArray) {
//        _hotListDataArray = @[@"hotList"];
//    }
//    return _hotListDataArray;
//}

- (UIButton *)clearHistoryButton {
    if (!_clearHistoryButton) {
        _clearHistoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _clearHistoryButton.backgroundColor = UIColor.greenColor;
        _clearHistoryButton.tag = 1000;
        [_clearHistoryButton setTitle:@"清除历史记录" forState:UIControlStateNormal];
        [_clearHistoryButton addTarget:self action:@selector(clearButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_clearHistoryButton sizeToFit];
    }
    return _clearHistoryButton;
}

- (UIButton *)clearHotWordsButton {
    if (!_clearHotWordsButton) {
        _clearHotWordsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _clearHotWordsButton.backgroundColor = UIColor.greenColor;
        _clearHotWordsButton.tag = 1001;
        [_clearHotWordsButton setTitle:@"清除热词记录" forState:UIControlStateNormal];
        [_clearHotWordsButton addTarget:self action:@selector(clearButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_clearHotWordsButton sizeToFit];
    }
    return _clearHotWordsButton;
}

- (UIButton *)clearHotListButton {
    if (!_clearHotListButton) {
        _clearHotListButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _clearHotListButton.backgroundColor = UIColor.greenColor;
//        _clearHotListButton.frame = CGRectMake(0, 0, 100, 100);
        _clearHotListButton.tag = 1002;
        [_clearHotListButton setTitle:@"清除热榜记录" forState:UIControlStateNormal];
        [_clearHotListButton addTarget:self action:@selector(clearButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_clearHotListButton sizeToFit];
    }
    return _clearHotListButton;
}

- (NSArray *)networkErrorTitles {
    if (!_networkErrorTitles) {
        _networkErrorTitles = @[@"Click Me",@"Click Her",@"Click Me"];
    }
    return _networkErrorTitles;
}

- (UITextField *)augusTextField {
    if (!_augusTextField) {
        _augusTextField = [[UITextField alloc] init];
        _augusTextField.backgroundColor = UIColor.greenColor;
    }
    return _augusTextField;
}
@end
