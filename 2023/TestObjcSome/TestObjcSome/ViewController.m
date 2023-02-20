//
//  ViewController.m
//  TestObjcSome
//
//  Created by Augus on 2023/1/13.
//

#import "ViewController.h"
#import "GTPerson.h"
#import <objc/runtime.h>
#import "GTPerson+Test.h"


#import "GTFileTools.h"
#import "GTFloatButton.h"

#import "LYCache.h"
#import "GTCache.h"


#import "GTOneTapSentMessageManger.h"
#import "GTThread.h"

#import "GTSecondController.h"
#import "GTThirdController.h"
#import "GTFourController.h"



#define GTOneTapLoginPlistFile [NSString stringWithFormat:@"%@/gt_oneTapLogin.plist", [GTFileTools gt_DocumentPath]]

#define GTScreenWidth [UIApplication sharedApplication].keyWindow.bounds.size.width
#define GTScreenHeight [UIApplication sharedApplication].keyWindow.bounds.size.height



@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) GTPerson *person1;
@property (nonatomic, strong) GTPerson *person2;


@property (nonatomic, strong) NSMutableArray *tokenArray;
@property (nonatomic, strong) NSMutableDictionary *tokenDictionary;


@property (nonatomic, strong) UICollectionView *augusCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *augusFlowLayout;
@property (nonatomic, strong) NSCache *augusCache;


@property (nonatomic, strong) UITableView *augusTableView;
@property (nonatomic, copy) NSArray *augusTableViewSource;


@property (nonatomic, strong) GTThread *augusThread;
@property (nonatomic, strong) NSTimer *gtTimer;
@property (nonatomic, assign) BOOL isSending;

@end

@implementation ViewController


struct gt_objc_class {
    Class isa;
};

- (void)viewDidLoad {

    
    // objc_msgSendSuper2
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    


    
    
    
    self.title = @"One";
    [self testNotMainThead];

    
}


- (void)testNotMainThead {
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"jump second" forState:UIControlStateNormal];
    button.titleLabel.textColor = UIColor.blackColor;
    button.frame = CGRectMake(100, 200, 100, 50);
    [button sizeToFit];
    [button addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = UIColor.greenColor;
    button.layer.cornerRadius = 5.0;
    [self.view addSubview:button];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"jump third" forState:UIControlStateNormal];
    button1.titleLabel.textColor = UIColor.blackColor;
    button1.frame = CGRectMake(100, 300, 100, 50);
    [button1 sizeToFit];
    [button1 addTarget:self action:@selector(addButtonThirdAction) forControlEvents:UIControlEventTouchUpInside];
    button1.backgroundColor = UIColor.greenColor;
    button1.layer.cornerRadius = 5.0;
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"jump four" forState:UIControlStateNormal];
    button2.titleLabel.textColor = UIColor.blackColor;
    button2.frame = CGRectMake(100, 400, 100, 50);
    [button2 sizeToFit];
    [button2 addTarget:self action:@selector(addButtonFourAction) forControlEvents:UIControlEventTouchUpInside];
    button2.backgroundColor = UIColor.greenColor;
    button2.layer.cornerRadius = 5.0;
    [self.view addSubview:button2];
    
}


- (void)addButtonAction {
    
    GTSecondController *vc = [[GTSecondController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)addButtonThirdAction {
    
    GTThirdController *vc = [[GTThirdController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addButtonFourAction {
    
    GTFourController *vc = [[GTFourController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)testClassStruct {
    
    
    
    //    NSString *test = @"123";
        
    //    NSObject *obj1 = [[NSObject alloc] init];

        /*
         
         * 为什么会执行run方法
            * 首先cls是一个类对象，而obj存储了cls的内存地址，所以objc--->cls，也就相当于是对象的isa指针指向了类对象
            * 因为指针占用了8个字节，而且GTPerson的类实现是
         GTPerson_IMP {
            isa
            _name
         }
         在这里不管是哪个指针，因为充当了isa的指针角色，也就是间接实现了objc的消息传递机制，所以会执行GTPerson中的对象方法
         
         * 为什么会打印123 或者obj1
            * 根据上面的类的实现结构体，可以知道， 如果去寻找成员变量，会去找isa的下一个存储单元，因为也是一个NSString *指针
            * 所以最终会去取下一个从高-低地址的内存存储单元，举例：
          long long a = 4; // 0x24
          long long b = 5;//  0x16
          long long c = 6; // 0x8
         所以先声明的变量，被存储在了栈空间的高地址，我们的寻址是从高到低进行获取，所以会打印123 或者obj1，都是存储了8个字节的单位；
         
         
         * 为什么会打印viewController对象
         因为[super viewDidLoad];
         这句话的本质就是
         
         struct abc {
            self;
            [UIViewController class];
            
         }
         objc_msgSendSuper(
            abc,
            @selector(viewDidLoad)
         )
         
         根据上面的寻址方式，因为结构体的结构原因，所以self.name调用get方法，跳过8个字节，最终会拿到self，
         因为self是先于[UIViewController class];定义，先定义，地址先高，从高到低进行存储，读取也是
         所以最终会打印self，也就是ViewController对象
         
         
         */
    //    id cls = [GTPerson class];
    //
    //    void *obj = &cls;
    //
    //    [(__bridge id)obj run];
        
        /*
         
         super本质
         struct objc_super2 {
            id receiver
            Class current_class;
         }
         
         // 查看文件的汇编代码Product-Perform Action-Assemle xxx
         
         // 通过打印内存地址进行定位的存储在cls中的属性
         // obj也就是isa指针的作用，所以需要打印后面的三个8字节是什么
         // 第一个是
            * 断点在 [(__bridge id)obj run];上
            * 然后进行lldb调试
         
         (lldb) p/x obj //打印当前isa指针
         (GTPerson *) $4 = 0x000000016bb49af8
         // 打印$4以后的4个地址的东西
         (lldb) x/4g 0x000000016bb49af8
         0x16bb49af8: 0x00000001042ccdf0 0x000000010fd14ed0
         0x16bb49b08: 0x00000001042ccda0 0x00000001d27b686c
         
         // 打印第一个存储的参数就是GTPerson的Class类对象
         (lldb) p (Class)0x00000001042ccdf0
         (Class) $6 = GTPerson
         
         // 打印第二个存储的参数ViewController对象
         (lldb) p (id)0x000000010fd14ed0
         (ViewController *) $19 = 0x000000010fd14ed0
         
         // 打印第三个存储的参数就是ViewController类对象
         (lldb)po (Class)0x00000001042ccda0
         ViewController
         (lldb) p (Class)0x00000001042ccda0
         (Class) $22 = ViewController
         
         // 至于第四个参数是未知的，什么都有可能存储
         
         
         
         
         */
}



- (void)test0000 {
    
    
    
    // 分类间接添加属性
//    GTPerson *person = [[GTPerson alloc] init];
//    person.name = @"augus";
//    NSLog(@"person name is %@",person.name);
    
    
    
    
    
//    self.person1 = [[GTPerson alloc] init];
//
//    // 强制转换类型
//    Class personCls = [GTPerson class];
//    struct gt_objc_class *personCls1 = (__bridge struct gt_objc_class *)(personCls);
//
//
//    Class person1MetaCls = object_getClass(personCls);
//
//
//    self.person2 = [[GTPerson alloc] init];
    
    // 查看kvo监听前后类对象的改变
//    NSLog(@"kvo监听之前 %@ %@",object_getClass(self.person1) , object_getClass(self.person1));
    
    // 查看kvo监听之后的方法的改变
//    NSLog(@"kvo监听之前 %p %p", [self.person1 methodForSelector:@selector(setAge:)], [self.person2 methodForSelector:@selector(setAge:)]);
    
//    [self.person1 addObserver:self forKeyPath:@"age" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    
//    NSLog(@"kvo监听之后 %@ %@",object_getClass(self.person1) , object_getClass(self.person1));
//    NSLog(@"kvo监听之后 %p %p", [self.person1 methodForSelector:@selector(setAge:)], [self.person2 methodForSelector:@selector(setAge:)]);
    
    
//    [self printMethodNameOfClass:object_getClass(self.person1)];
    
    
//    [self testFileToos];
//    self.view.backgroundColor = UIColor.lightGrayColor;
    
//    [self.view addSubview:self.augusCollectionView];
//    [self.augusCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];

//    self.title = @"ssss";
//    self.view.backgroundColor = UIColor.greenColor;
//    [self setupFloatButton];
//
//    [self performSelector:@selector(setupFloatButton)];
    
//    [self addTableVIew];
    
    
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    [self.augusTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:13 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


#pragma mark -  Setup UI

// [#0x11b8395c0 _fetchConversationIdAndMetadataForSnapchatter:#0x285cb77b0 completion:^(_Bool isSuccess, NSString *conversationId, id data) { NSLog(@"success %@ conversationId %@",@(isSuccess),conversationId); }]



- (void)addTableVIew {
    
    [self.view addSubview:self.augusTableView];
    [self.augusTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"kUITableViewCell"];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.augusTableViewSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kUITableViewCell"];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kUITableViewCell"];
    }
    
    cell.textLabel.text = self.augusTableViewSource[indexPath.row];

    
    return cell;
}


- (void)cc_fetchConversationIdAndMetadataForSnapchatter:(id)arg1 completion:(void(^)(_Bool, NSString *, id))arg2 {
    
    
}

- (void)_fetchConversationIdAndMetadataForSnapchatter:(int)chatter completion:(void(^)(BOOL, NSString *, id))arg2 {
    
    
    void (^block)(NSNumber *, NSError *) = ^(NSNumber *arg1, NSError *error){
        
        NSLog(@"arg 1 %@",arg1);
        
    };
    block(@(1), nil);
    
    
    void(^block1)(long long) = ^(long long arg1) {
        
        NSLog(@"arg 1 %lld",arg1);
    };
    
    
    block1(12.0);
    NSLog(@"it is end");
    
//    NSLog(@"func encoder %@",@encode(block->_isa));
    
    [self _fetchConversationIdAndMetadataForSnapchatter:2 completion:^(BOOL re, NSString *conversationId, id SCMetaData) {
                
        
    }];

    
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        
        
    });
}

// [#0x11b8395c0 _fetchConversationIdAndMetadataForSnapchatter:#0x285cb77b0 completion:^(_Bool isSuccess, NSString *conversationId, id data) { NSLog(@"success %@ conversationId %@",@(isSuccess),conversationId); }]


- (void)setupFloatButton {
    
    
//    GTFloatButtonContent *btn = [GTFloatButtonContent alloc] 
    
    //最普通的显示
//    [GTFloatButton show];
//
//    //是否显示截图当天的日期
//    [[GTFloatButton sharedBtn] setBuildShowDate:YES];
//
//    NSDictionary *envMap = @{
//                             @"测试":@"testapi.miniLV.com",
//                             @"开发":@"devapi.miniLV.com",
//                             @"生产":@"api.miniLV.com"
//                             };
//
//    [GTFloatButton showDebugModeWithType:GTAssistiveTypeNone];
//
//#ifdef DEBUG
//    //如果要实现MNFloatBtn 的切换环境功能，必须这样设置
//    #define kAddress [[NSUserDefaults standardUserDefaults]objectForKey:@"MNBaseUrl"]
//#else
//    //正式环境地址
//    #define kAddress @"api.miniLV.com"
//#endif
//
//    NSString *baseUrl = @"www.sohu.com";
//    [GTFloatButton setEnvironmentMap:envMap currentEnv:baseUrl];
//
//    [GTFloatButton sharedBtn].btnClick = ^(UIButton *sender) {
//
//        NSLog(@"开始转发");
//    };
//
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"一键添加" forState:UIControlStateNormal];
//    button.titleLabel.textColor = UIColor.blackColor;
//    button.frame = CGRectMake(GTScreenWidth - 50, 24, 0, 0);
//    [button sizeToFit];
//    [button addTarget:self action:@selector(seupGTAcceptOrAddButton) forControlEvents:UIControlEventTouchUpInside];
//    button.backgroundColor = UIColor.greenColor;
//    button.layer.cornerRadius = 5.0;
//    [self.view addSubview:button];
    
    /*
     
     -[<SCAddFriendsComposerViewController: 0x1101f3a00> initWithNonSnapchattersDataFetcher:<SCLazy: 0x2803763a0> blockedSnapchattersDataFetcher:<SCLazy: 0x280376340> snapchattersDataFetcher:<SCLazy: 0x280376300> snapchattersDataMutator:<SCLazy: 0x2803762a0> snapchattersDataTracker:<SCLazy: 0x2803757a0> snapchattersDataSearcher:<SCLazy: 0x280376400> searchSuggestionStore:<SCLazy: 0x2807291c0> snapchattersFriendscoreCoordinator:<SCLazy: 0x280376320> snapchatterPublicInfoFetcher:<SCLazy: 0x280376460> friendmojiPresenter:<SCLazy: 0x280361000> viewedIncomingFriendsTracker:<SCLazy: 0x280375820> permissionInfoProvider:<SCLazy: 0x280370920> placement:2 currentPageTracker:<SCCurrentPageTracker: 0x282002800> seenAndAddEventLogger:<SCAddFriendsQuickAddLoggerImpl: 0x28370c000> addFriendsWorkflowDelegate:<SCOpenAddFriendsCardActionHandler: 0x280e74180> addFriendsRecentlyActionPageScopeExposer:<SCScopeContainer: 0x282692f40> composerRuntimeProvider:<SCLazy: 0x28032a520> composerPeopleBridgeContactServices:<SCComposerPeopleBridgeContactServices: 0x280728440> networkingClient:<SCComposerNetworkingClient: 0x280374140> composerPeopleUserInfoProvider:<SCComposerPeopleUserInfoProvider: 0x2823c7480> hiddenSuggestionCoordinator:<SCLazy: 0x280376200> hideSuggestionLogger:<SCLazy: 0x280729be0> circumstanceEngine:<SCCircumstanceEngine: 0x282719560> userPreferences:<SCDocPreferences: 0x2828021b0> bitmojiAvatarIdProvider:<SCLazy: 0x2803417c0> phoneNumberProvider:<SCLazy: 0x280341860> snapshotsOperaCurrentItemUpdate:<SCBehaviorSubject: 0x280e43bd0> usersInFriendCells:<SCBehaviorSubject: 0x280e43720> composerChatEligibilityProvider:<SCLazy: 0x28 suggestedFriendStoringFactory:<decode: missing data> activeStoryFetcher:<decode: missing data> performerProvider:<decode: missing data> clearBadgeFlagInViewDidDisappearEnabled:<decode: missing data> composerBlizzardLogger:<decode: missing data>]
     */
    
    [self addFriendWithRequest:nil completion:^(BOOL isAdded, NSArray *arary) {
            
    }];
    

    GTPerson *person = [[GTPerson alloc] init];
    person.name = @"133";
    
    [[GTCache shareInstance] gt_setObject:person forKey:@"123"];
        
    
//    GTPerson *p = [cache objectForKey:@"123"];
//    NSLog(@"p name %@",p.name);
    
}

- (void)addFriendWithRequest:(id)arg1 completion:(void (^)(BOOL, NSArray *))arg2 {
    
    
}




#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return CGSizeMake(100, 100);
    } else if(indexPath.row == 2) {
        return CGSizeMake(50, 100);
    }
    return CGSizeMake(100, 200);
}


- (void)testCFDictionaryStore {
    
    
    CFMutableDictionaryRef myDict = CFDictionaryCreateMutable(NULL, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    NSString *key = @"someKey";
    NSNumber *value = [NSNumber numberWithInt: 1];
    CFDictionarySetValue(myDict, (__bridge const void *)key, (__bridge const void *)value);
    
    
    // id dictValue = (__bridge id)CFDictionaryGetValue(myDict, (__bridge void *)key);

    Boolean isContainKey = CFDictionaryContainsKey(myDict, (__bridge const void *)(key));
    if (isContainKey) {
        CFDictionaryRemoveValue(myDict, (__bridge const void *)(key));
    }
    
}


- (void)testFileToos {
    
    
    NSString *token = @"eyJraWQiOiJzbmFwLXNlc3Npb24tcmVmcmVzaC10b2tlbi1hMTI4Z2NtLjAiLCJ0eXAiOiJKV1QiLCJlbmMiOiJBMTI4R0NNIiwiYWxnIjoiZGlyIn0..ek1Ra-0MhMxZ0jmS.LUDosXWzAIf6bSqNkBi5sCGUORumsfqlbOLu5VewImzS3pkjUAkedJsq0EXH9b2zWnw9O2TosNU4lASm5SYLwefxR9tZAIht3cX0gpdJ1S3Ce-cRKgU_rZJq6NkspnzGcmEiO3jpXjRlR0-SqsWt5dlasSTPNZcvUAamejN60ZIbGxhOr8CAj9ohtWM.7DCVJvLKGDRx2jf6xmzTyw";
    NSString *userId = @"458a8bb1-a832-4a29-9669-5cc98fd26498";
    
    
    // 先判断路径是否存在
    // 存在直接追加数据，否则进行直接写入
    NSMutableDictionary *hasStoreDict = [NSMutableDictionary dictionaryWithContentsOfFile:GTOneTapLoginPlistFile];
    if (!hasStoreDict || hasStoreDict.count == 0) {
        [hasStoreDict setValue:token forKey:userId];
        BOOL isSuccess =  [hasStoreDict writeToFile:GTOneTapLoginPlistFile atomically:YES];
        if (isSuccess) {
            NSLog(@"第一次数据存储成功");
        } else {
            NSLog(@"第一次数据存储失败");
        }
    } else {
        NSLog(@"文件已经存在 存储个数 %ld", hasStoreDict.count);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    NSData *data = [[LYCache shareInstance] ly_readForKey:@"123"];
//    GTPerson *p = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    
//    GTPerson *p = [[GTCache shareInstance] gt_objectForKey:@"123"];
    
//    GTPerson *p = [self.augusCache objectForKey:@"123"];
//    NSLog(@"p name %@",p.name);
    
    
    // 追加数据
//    NSString *userId = [NSString stringWithFormat:@"%u", arc4random() % 10000000];
//    NSString *token = @"eyJraWQiOiJzbmFwLXNlc3Npb24tcmVmcmVzaC10b2tlbi1hMTI4Z2NtLjAiLCJ0eXAiOiJKV1QiLCJlbmMiOiJBMTI4R0NNIiwiYWxnIjoiZGlyIn0..ek1Ra-0MhMxZ0jmS.LUDosXWzAIf6bSqNkBi5sCGUORumsfqlbOLu5VewImzS3pkjUAkedJsq0EXH9b2zWnw9O2TosNU4lASm5SYLwefxR9tZAIht3cX0gpdJ1S3Ce-cRKgU_rZJq6NkspnzGcmEiO3jpXjRlR0-SqsWt5dlasSTPNZcvUAamejN60ZIbGxhOr8CAj9ohtWM.7DCVJvLKGDRx2jf6xmzTyw";
//
//    NSMutableDictionary *hasStoreDict = [NSMutableDictionary dictionaryWithContentsOfFile:GTOneTapLoginPlistFile];
//    NSLog(@"已经存储了 %ld个 %@",hasStoreDict.count, hasStoreDict);
//
//    [hasStoreDict setValue:token forKey:userId];
//
//    BOOL isSeek = [hasStoreDict writeToFile:GTOneTapLoginPlistFile atomically:YES];
//    if (isSeek) {
//        NSLog(@"数据追加成功");
//    } else {
//        NSLog(@"数据追加失败");
//    }
//
//
//    // 删除数据
//    if(!token && token.length > 0) {
//        [hasStoreDict removeObjectForKey:@"1"];
//    }

    
    
    
//    [self.person1 setAge:18];
//    [self.person2 setAge:19];
//
//
//    [self.person1 willChangeValueForKey:@"age"];
//    [self.person1 didChangeValueForKey:@"age"];
    
//    self.person1->_age = 12;
    
    
    // 1的位置上strong，这个时候执行1之后，发现是强引用，会立即释放
    // 1的位置是weak，这个时候执行1之后，不会立即释放，因为发现还有强引用，所以大概等待3秒之后才会释放
    
//    GTPerson *person = [[GTPerson alloc] init];
//
//    __weak GTPerson *weakPerson = person;
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        NSLog(@"1---p is %p",person);
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSLog(@"2---p is %p",weakPerson);
//
//        });
//    });
//
//    NSLog(@"%@",@(__func__));
    
    
    
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"kvo 监听响应 %@",change);
}


#pragma mark - Private Methods

- (void)printMethodNameOfClass:(Class)cls {
    
    unsigned int count;
    
    NSMutableString *methodNames = [NSMutableString string];
    
    // 获取方法数组
    Method *methodList = class_copyMethodList(cls, &count);
    
    // 遍历方法数组
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        SEL sel =  method_getName(method);
        NSString *methodName = NSStringFromSelector(sel);
        [methodNames appendFormat:@"%@\n",methodName];
        
    }
    
    NSLog(@"%@类包含的所有方法\n%@",cls,methodNames);
    
    // c语言手动管理内存
    free(methodList);
    
    
}


#pragma mark - Lazy Load

- (NSMutableArray *)tokenArray {
    if (!_tokenArray) {
        _tokenArray = [[NSMutableArray alloc] init];
    }
    return _tokenArray;
}

- (UICollectionView *)augusCollectionView {
    
    if(!_augusCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        CGFloat itemW = 100;
//        CGFloat itemH = 50;
        
        layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(50, 200);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 1.0;
        layout.minimumInteritemSpacing = 5.0;
        

        
        _augusCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200) collectionViewLayout:layout];
        _augusCollectionView.dataSource = self;
        _augusCollectionView.delegate = self;
        
        _augusCollectionView.pagingEnabled = YES;
        _augusCollectionView.backgroundColor = UIColor.greenColor;
        _augusCollectionView.showsHorizontalScrollIndicator = NO;
        
    }
    return _augusCollectionView;
    
  
}


- (NSCache *)augusCache {
    if(!_augusCache) {
        _augusCache = [[NSCache alloc] init];
        _augusCache.countLimit = 300; // 限制个数，默认是0，无限空间
        _augusCache.totalCostLimit = 5*1024*1024; // 设置大小设置，默认是0，无限空间
        _augusCache.name = @"cache1";
    }
    return _augusCache;
}


- (UITableView *)augusTableView {
    if(!_augusTableView) {
        
        _augusTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _augusTableView.dataSource = self;
        _augusTableView.delegate = self;
        _augusTableView.backgroundColor = UIColor.greenColor;
    }
    return _augusTableView;
}

- (NSArray *)augusTableViewSource {
    if(!_augusTableViewSource) {
        _augusTableViewSource = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13", nil];
    }
    return _augusTableViewSource;
}

@end
