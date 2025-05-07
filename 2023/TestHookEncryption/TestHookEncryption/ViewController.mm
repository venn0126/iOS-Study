//
//  ViewController.m
//  TestHookEncryption
//
//  Created by Augus on 2023/7/14.
//

#import "ViewController.h"
#import <zlib.h>
#import "GuanEncryptionManger.h"
#import <GTClassDump/GTClassDump.h>
#import "GuanRSAMgr.h"
#import "GTUtilies.h"
#import "NSBundle+GTInfo.h"
#import "GTFileTools.h"
#import <StoreKit/StoreKit.h>
#import "GuanAlert.h"
#import "JCCSettingsController.h"
#import "UIView+Toast.h"
#include "GuanCxxxx.h"
#import "GuanTestWebController.h"
#import "ZipZap.h"
//#import <ZipArchive/ZipArchive.h>
#import <SSZipArchive/SSZipArchive.h>
#import "TongTheme.h"
#import "TongThemeConstant.h"
#import "NSDictionary+Extension.h"
#import "TongXMLReader.h"
#import "MengSettingController.h"
#import "MengTaskModel.h"
#import "UIWindow+Screenshot.h"
#import "UIImage+LBMCompress.h"
#import <AppTrackingTransparency/ATTrackingManager.h>
#import "UITapGestureRecognizer+Mock.h"
#import "SNAnimationCustom.h"
#import "UIView+Extension.h"
#import "UIButton+Extension.h"
#import "UIImage+Extension.h"
#import "GTCustomButton.h"
#import "GuanUITool.h"
#import "GTTestCollectionCell.h"
#import "UIView+VAP.h"
#import "UICKeyChainStore.h"
#import <CoreLocation/CoreLocation.h>
#import <sys/utsname.h>
#import "DiamondView.h"
#import "GuanProxyWKController.h"
#import "ChengReserverMgr.h"
#import "ChengOperationView.h"

#include <sys/types.h>
#include <sys/sysctl.h>
#import <IOKit/IOKitLib.h>

#import "ChengLogOutputView.h"
#import "TNPersonModel.h"


#import "UITableView+TNManualLayout.h"
#import "TNTextCell.h"
#import "TNImageTextCell.h"




static NSString * const kBBBSTokenHelpWordsKey = @"kBBBSTokenHelpWordsKey";


#define WW [[UIScreen mainScreen] bounds].size.width
#define HH [[UIScreen mainScreen] bounds].size.height
#define kViewPushAnimation 0.2


#define kTaoLiQuickSubmitOrderNofitication @"kTaoLiQuickSubmitOrderNofitication"
/// 毫秒延迟
#define MengMsDelay(ms, block) (dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ms / 1000.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), block))

/// 秒延迟
#define MengsDelay(s, block) (dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(s * NSEC_PER_SEC)), dispatch_get_main_queue(), block))

/// 主线程封装

#define dispatch_main_async_safe(block)\
    if (dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(dispatch_get_main_queue())) {\
        block();\
    } else {\
        dispatch_async(dispatch_get_main_queue(), block);\
    } \

#define dispatch_global_async(block) dispatch_async(dispatch_get_global_queue(0, 0),block)


static inline bool isDiff(const char *func, SEL _cmd)
{
    char buff[256] = {'\0'};
    if(strlen(func) > 2) {
        const char *s = strstr(func, " ");
        if (s != NULL) {
            s = s + 1; // 移动到空格后面一个字符
            const char *e = strstr(func, "]");
            if (e != NULL && e > s) {
                memcpy(buff, s, sizeof(char) * (e - s));
                const char *realname = sel_getName(_cmd);
                return (strcmp(buff, realname) != 0);
            }
        }
    }
    return false;
}

#define ALERT_IF_METHOD_REPLACED {if (isDiff(__PRETTY_FUNCTION__, _cmd)) {\
printf("method hooked \n");\
}}
    

static const NSInteger kAugusButtonTagOffset = 10000;

@interface ViewController ()<NSURLSessionDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UICollectionViewDataSource, ChengOperationViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) SKPaymentTransaction *transaction;

@property (nonatomic, strong) UIImageView *testImageView;


@property (nonatomic, strong) UIAlertController *augusAlertController;


@property (nonatomic, copy) NSArray *pickerViewData;
@property(nonatomic, strong) UIView *firstPushView;
@property(nonatomic, strong) UIView *secondPushView;
@property(nonatomic, strong) UIView *themeView;
@property(nonatomic, strong) UICollectionView *gtCollectionView;

@property (nonatomic, assign) BOOL stopRequested;
@property (nonatomic, assign) BOOL isRunning;
@property (nonatomic, strong) UITableView *tableView;


@end


struct GTPerson {
    char name[50];
    int age;
};

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的";
    self.view.backgroundColor = UIColor.whiteColor;
//    [self setupButtons];
        
//    [self testVideoToAudio];
    
//    [self testGetSubString];

    
//    [self testZipZap];
    
//    [self test_ssziparchive];
    
 
//    [self testTongTheme];
    
//    [self testCSSParse];
    
//    [self testXMLReader];
    
//    [self stringToArray];
    
//    [self searchFunction];
    
//    [self testAESEncryptionZipFile];

//    [self setupToastStyle];
    
//    [self testCustomFontStyle];
    
//    [self testH5ReturnStr];
    
//    [self testPickerView];
//    
//    [self setupViewPushUI];
    
//    [self testCustomButtonLayoutAndShowBigImage];
    
//    [self testCustomShowBigImage];
    
//    [self addIdaOfStruct];
    
//    [self testCollectionViewAddScrollView];
    
//    [self testViewPlayMP4Video];
    
//    [self testTokenPostServer];
    
//    [self guan_caluateDistanceFromLon:0 lat:0];
    
    /*
     tap_point_value = {"tap_point_x":180.66665649414062,"tap_tool_type":0,"tap_majorRadiusTolerance":6.05877685546875,"tap_point_y":58.333328247070312,"tap_majorRadius":24.235107421875};
     */
    

    
//    callMethodByName(@"application:didFinishLaunchingWithOptions:");
    
    
//    [self testRevserTickets];
    
//    [self testOperationView];
    
//    [self testLogOutputView];
    
//    [self testOpenAppstoreReviewPage];
    
//    [self sendRequest:nil];

//    [self testBase64Str];
    
//    [self testYYModelCase];
    
    [self testTNTableView];
}


- (void)testTNTableView {
    
    
    // 设置表格视图
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.estimatedRowHeight = 100; // 设置预估高度提高性能
    [self.view addSubview:self.tableView];
    
    // 注册cell
    [self.tableView tn_registerClass:[TNTextCell class] forCellWithIdentifier:@"TNTextCell"];
    [self.tableView tn_registerClass:[TNImageTextCell class] forCellWithIdentifier:@"TNImageTextCell"];
    
//    // 添加下拉刷新
//    __weak typeof(self) weakSelf = self;
//    [self.tableView tn_addPullToRefreshWithBlock:^{
//        // 模拟网络请求延迟
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            // 刷新数据
//            [weakSelf loadNewData];
//        });
//    }];
//    
//    // 添加上拉加载更多
//    [self.tableView tn_addInfiniteScrollingWithBlock:^{
//        // 模拟网络请求延迟
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            // 加载更多数据
//            [weakSelf loadMoreData];
//        });
//    }];
    
    // 准备数据
    [self prepareData];
}

- (void)prepareData {
    // 初始数据
    NSMutableArray *models = [NSMutableArray array];
    
    // 添加文本cell
    for (int i = 0; i < 100; i++) {
        TNTextCellModel *model = [[TNTextCellModel alloc] init];
        [model setTitle:[NSString stringWithFormat:@"标题 %d", i]];
        [model setContent:[NSString stringWithFormat:@"这是内容 %d，可能包含很多行文字。这是一个使用手动布局和高度缓存的高效UITableView方案示例。", i]];
        [models addObject:model];
    }
    
    for (int i = 0; i < 100; i++) {
        TNImageTextCellModel *imageModel = [[TNImageTextCellModel alloc] init];
        [imageModel setTitle:@"新图文内容"];
        [imageModel setContent:@"这是的图文混排内容。这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容"];
        [imageModel setImageUrl:@"https://example.com/image.jpg"];
        [imageModel setImageSize:CGSizeMake(80, 80)];
        [models addObject:imageModel];
    }
    
    // 预计算高度并刷新表格
    [self.tableView tn_reloadDataWithModels:models preCalculateHeight:YES];
    
    // 自动触发一次下拉刷新
    [self.tableView tn_beginRefreshing];
}

- (void)loadNewData {
    // 防止重复加载
    static BOOL isLoading = NO;
    
    if (isLoading) return;
    isLoading = YES;
    
    // 模拟获取新数据
    NSMutableArray *newModels = [NSMutableArray array];
    
    // 添加新的文本cell
    for (int i = 0; i < 5; i++) {
        TNTextCellModel *model = [[TNTextCellModel alloc] init];
        [model setTitle:[NSString stringWithFormat:@"新标题 %d", i]];
        [model setContent:[NSString stringWithFormat:@"这是新加载的内容 %d，通过下拉刷新获取。", i]];
        [newModels addObject:model];
    }
    
    // 添加新的图文cell
    TNImageTextCellModel *imageModel = [[TNImageTextCellModel alloc] init];
    [imageModel setTitle:@"新图文内容"];
    [imageModel setContent:@"这是下拉刷新加载的图文混排内容。"];
    [imageModel setImageUrl:@"https://example.com/image.jpg"];
    [imageModel setImageSize:CGSizeMake(80, 80)];
    [newModels addObject:imageModel];
    
    // 添加到表格顶部
     [self.tableView tn_prependModels:newModels];
     
     // 延迟重置加载标记
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         isLoading = NO;
     });
}

- (void)loadMoreData {
    // 模拟获取更多数据
    static int loadMoreCount = 0;
    loadMoreCount++;
    
    // 模拟加载3次后没有更多数据
    if (loadMoreCount >= 3) {
        [self.tableView tn_setNoMoreData];
        [self.tableView tn_endLoadingMore];
        return;
    }
    
    NSMutableArray *moreModels = [NSMutableArray array];
    
    // 添加更多的cell
    int startIndex = (int)self.tableView.tn_models.count;
    for (int i = 0; i < 5; i++) {
        if (i % 2 == 0) {
            TNTextCellModel *model = [[TNTextCellModel alloc] init];
            [model setTitle:[NSString stringWithFormat:@"加载更多 %d", startIndex + i]];
            [model setContent:[NSString stringWithFormat:@"这是上拉加载的更多内容 %d。", startIndex + i]];
            [moreModels addObject:model];
        } else {
            TNImageTextCellModel *model = [[TNImageTextCellModel alloc] init];
            [model setTitle:[NSString stringWithFormat:@"加载更多图文 %d", startIndex + i]];
            [model setContent:[NSString stringWithFormat:@"这是上拉加载的更多图文内容 %d。", startIndex + i]];
            [model setImageUrl:@"https://example.com/image.jpg"];
            [model setImageOnLeft:(i % 4 == 1)]; // 交替图片位置
            [moreModels addObject:model];
        }
    }
    
    // 添加到表格底部
    [self.tableView tn_appendModels:moreModels];
    
    // 结束加载更多
    [self.tableView tn_endLoadingMore];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableView.tn_models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TNCellModel *model = self.tableView.tn_models[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:model.identifier];
    
    if ([cell isKindOfClass:[TNTextCell class]] && [model isKindOfClass:[TNTextCellModel class]]) {
        [(TNTextCell *)cell configureWithModel:(TNTextCellModel *)model];
    } else if ([cell isKindOfClass:[TNImageTextCell class]] && [model isKindOfClass:[TNImageTextCellModel class]]) {
        [(TNImageTextCell *)cell configureWithModel:(TNImageTextCellModel *)model];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TNCellModel *model = self.tableView.tn_models[indexPath.row];
    return model.cellHeight > 0 ? model.cellHeight : UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 示例：更新选中的cell
    TNCellModel *model = self.tableView.tn_models[indexPath.row];
    
    if ([model isKindOfClass:[TNTextCellModel class]]) {
        TNTextCellModel *textModel = (TNTextCellModel *)model;
        [textModel setContent:[NSString stringWithFormat:@"内容已更新: %@", [NSDate date]]];
        [tableView tn_updateModel:textModel atIndexPath:indexPath animated:YES];
    }
}


- (void)testYYModelCase {
    
    /*
    NSDictionary *dic = @{
                      @"id":@"123",
                      @"name":@"张三",
                      @"age":@(12),
                      @"sexDic":@{@"sex":@"man"},
                      @"languages":@[
                              @"汉语",@"英语",@"法语"
                              ],
                      @"job":@{
                              @"work":@"iOS开发",
                              @"eveDay":@"10小时",
                              @"site":@"软件园"
                              }
     */
    
    
    /*
    NSDictionary *dic = @{
                      @"id":@"123",
                      @"name":@"张三",
                      @"age":@(12),
                      @"sexDic":@{@"sex":@"男"},
                      @"languages":@[
                              @"汉语",@"英语",@"法语"
                              ],
                      @"job":@{
                              @"work":@"iOS开发",
                              @"eveDay":@"10小时",
                              @"site":@"软件园"
                              },
                      @"eats":@[
                              @{@"food":@"西瓜",@"date":@"8点"},
                              @{@"food":@"烤鸭",@"date":@"14点"},
                              @{@"food":@"西餐",@"date":@"20点"}
                              ]
                      };
     */
    
    NSDictionary *dic = @{
        @"birthPlace":@"宁夏固原市彭阳县草庙乡",
        @"education":@"博士",
        @"id":@"115",
        
        //字典
        @"personalMessage":@{
            @"marryAge":@"30",
            @"marryStatus":@"1",
            @"paddress":@"宁夏固原市",
            @"phone":@"158*****289",
            @"pname":@"sxk",
        },
        @"babyFatherInfo" : @{
            @"bFatherAge" : @"38",
            @"bFatherUnit" : @"19957253180",
            @"bFatherPhone" : @"2222222",
            @"husbFamHistory" : @"3333333",
            @"bFatherPcId" : @"228384848484944",
            @"isHusbFamHistory" : @"1",
            @"bFatherJob" : @"01",
            @"bFatherHealth" : @"1",
            @"bFatherName" : @"sxk"
        },
        
        @"pregnancyHistorys" : @{
            @"pregnancyHistory" : @[
                @{
                    @"zycqk" : @"01",
                    @"historyId" : @"210585",
                    @"birthTime" : @"2019-04",
                    @"bearType" : @"01",
                    @"chhfqk" : @"01",
                    @"babyInfos" : @{
                        @"babyInfo" : @[
                            @{
                                @"babysex" : @"01",
                                @"babyWeight" : @"3000",
                                @"babyStatus" : @"01",
                                @"ycrdn" : @"210585"
                            },
                            @{
                                @"babysex" : @"03",
                                @"babyWeight" : @"3003",
                                @"babyStatus" : @"03",
                                @"ycrdn" : @"210588"
                            }
                        ]
                    }
                },
                @{
                    @"zycqk" : @"02",
                    @"historyId" : @"210587",
                    @"birthTime" : @"2019-05",
                    @"bearType" : @"02",
                    @"chhfqk" : @"02",
                    @"babyInfos" : @{
                        @"babyInfo" : @[
                            @ {
                                @"babysex" : @"02",
                                @"babyWeight" : @"3001",
                                @"babyStatus" : @"02",
                                @"ycrdn" : @"210587"
                            }
                        ]
                    }
                },
            ]
        },
    };
    
    
    
    TNPersonModel *model = [TNPersonModel yy_modelWithDictionary:dic];
    NSLog(@"model.pregnancyHistorys.pregnancyHistory.firstObject %@",model.pregnancyHistorys.pregnancyHistory.firstObject);
    TNPregnancyHistoryItemModel *pregnancyHistoryItemModel = model.pregnancyHistorys.pregnancyHistory.firstObject;
    NSLog(@"model.pregnancyHistorys.pregnancyHistory.firstObject %@",pregnancyHistoryItemModel.babyInfos.babyInfo.firstObject);
    TNPregnancyHistoryItemBabyInfoModel *pregnancyHistoryItemBabyInfoModel = pregnancyHistoryItemModel.babyInfos.babyInfo.firstObject;
    NSLog(@"pregnancyHistoryItemModel.babyInfos.babyInfo.firstObject %@-%@",pregnancyHistoryItemBabyInfoModel,pregnancyHistoryItemBabyInfoModel.ycrdn);
    


    
    
}


- (void)sendRequest:(id)sender
{
    /* Configure session, choose between:
       * defaultSessionConfiguration
       * ephemeralSessionConfiguration
       * backgroundSessionConfigurationWithIdentifier:
     And set session-wide properties, such as: HTTPAdditionalHeaders,
     HTTPCookieAcceptPolicy, requestCachePolicy or timeoutIntervalForRequest.
     */
    NSURLSessionConfiguration* sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
 
    /* Create session, and optionally set a NSURLSessionDelegate. */
    NSURLSession* session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];

    /* Create the Request:
       账户简介 (POST https://i.instagram.com/graphql_www)
     */

    NSURL* URL = [NSURL URLWithString:@"https://i.instagram.com/graphql_www"];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";

    // Headers

  
    [request addValue:@"6974674847" forHTTPHeaderField:@"IG-INTENDED-USER-ID"];
    [request addValue:@"IGBloksAppRootQuery-com.bloks.www.ig.about_this_account" forHTTPHeaderField:@"X-FB-Friendly-Name"];
    [request addValue:@"44666754-5A94-4AEF-AE31-F73D24D7FE88" forHTTPHeaderField:@"X-IG-Device-ID"];
    [request addValue:@"UFS-47290414-C522-4022-93F9-13D20000D90B-1" forHTTPHeaderField:@"X-Pigeon-Session-Id"];
    [request addValue:@"HIL,6974674847,1775623703:01f7873897a031e47218ea7e537a2aaf56111a6a738d9b6a3263fe183f0b5426eeb567d8" forHTTPHeaderField:@"IG-U-IG-Direct-Region-Hint"];
    [request addValue:@"253360298310718582719188438574" forHTTPHeaderField:@"X-Client-Doc-Id"];
    [request addValue:@"28800" forHTTPHeaderField:@"X-IG-Timezone-Offset"];
    [request addValue:@"6918cfa27d8e17f9dab253242c5309ef90d2275afc1ec4d4cedcc6fd553faa09" forHTTPHeaderField:@"X-Bloks-Version-Id"];
    [request addValue:@"1744103747.926605" forHTTPHeaderField:@"X-Pigeon-Rawclienttime"];
    [request addValue:@"CCO,6974674847,1775639740:01f775db669787c54314a8504e0f51471ca8071cdf3f98423ddc446e14f96bb0cc8e173a" forHTTPHeaderField:@"IG-U-Rur"];
    [request addValue:@"pando" forHTTPHeaderField:@"x-graphql-client-library"];
    [request addValue:@"44666754-5A94-4AEF-AE31-F73D24D7FE88" forHTTPHeaderField:@"X-IG-Family-Device-ID"];
    [request addValue:@"6974674847" forHTTPHeaderField:@"IG-U-Ds-User-ID"];
    [request addValue:@"IGProfileUserGridFeedViewController:profile" forHTTPHeaderField:@"X-IG-CLIENT-ENDPOINT"];
    [request addValue:@"zh-CN;q=1.0" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"fetch" forHTTPHeaderField:@"x-graphql-request-purpose"];
    [request addValue:@"{\"system_languages\":\"zh-Hans-CN\",\"keyboard_language\":\"zh-Hans\"}" forHTTPHeaderField:@"X-IG-Device-Languages"];
    [request addValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    [request addValue:@"cco" forHTTPHeaderField:@"x-ig-graphql-region-hint"];
    [request addValue:@"34406401" forHTTPHeaderField:@"X-IG-SALT-LOGGER-IDS"];
    [request addValue:@"Instagram 375.0.0.28.77 (iPhone14,2; iOS 15_1; zh_CN; zh-Hans; scale=3.00; 1170x2532; 717824009) AppleWebKit/420+" forHTTPHeaderField:@"User-Agent"];
    [request addValue:@"4731.107302142959" forHTTPHeaderField:@"X-IG-Bandwidth-Speed-KBPS"];
    [request addValue:@"true" forHTTPHeaderField:@"X-IG-Bloks-Serialize-Payload"];
    [request addValue:@"Bearer IGT:2:eyJkc191c2VyX2lkIjoiNjk3NDY3NDg0NyIsInNlc3Npb25pZCI6IjY5NzQ2NzQ4NDclM0E2a0ZzNnRkcUJyaTNIVSUzQTI3JTNBQVljR0JwemhvM1Q3WVIwUU92aDVTeXJwMVpmeGhyOVVKVUFNWUhhNGtRIn0=" forHTTPHeaderField:@"Authorization"];
    [request addValue:@"Z_SqgwAAAAEM2KQcuvLo7rw4sXIc" forHTTPHeaderField:@"X-MID"];
    [request addValue:@"IGProfileViewController:self_profile:2:main_profile:1744103733.762644:::1744103733.762644,IGProfileUserGridFeedViewController:self_profile:3::1744103733.763194:::1744103733.763194,IGFollowListTabPageViewController:do_not_pass_through_pipeline_social_context:4::1744103736.567159:::1744103736.567159,IGFollowListViewController:self_followers:5::1744103736.568623:::1744103736.568623,IGFollowListViewController:self_following:6::1744103738.007359:::1744103738.007359,IGProfileViewController:profile:7::1744103740.144686:::1744103740.144686,IGProfileUserGridFeedViewController:profile:8::1744103740.146352:::1744103740.146352" forHTTPHeaderField:@"X-IG-Nav-Chain"];
    [request addValue:@"bloks_app" forHTTPHeaderField:@"X-Root-Field-Name"];
    [request addValue:@"SKIP" forHTTPHeaderField:@"X-IG-WWW-Claim"];
    [request addValue:@"124024574287414" forHTTPHeaderField:@"X-IG-App-ID"];
    [request addValue:@"WiFi" forHTTPHeaderField:@"X-IG-Connection-Type"];

    // Form URL-Encoded Body

//    NSDictionary* bodyParameters = @{
//        @"method": @"post",
//        @"pretty": @"false",
//        @"format": @"json",
//        @"server_timestamps": @"true",
//        @"locale": @"zh_CN",
//        @"purpose": @"fetch",
//        @"fb_api_req_friendly_name": @"IGBloksAppRootQuery-com.bloks.www.ig.about_this_account",
//        @"client_doc_id": @"253360298310718582719188438574",
//        @"enable_canonical_naming": @"true",
//        @"enable_canonical_variable_overrides": @"true",
//        @"enable_canonical_naming_ambiguous_type_prefixing": @"true",
//        @"variables": @"{\"bk_context\":{\"pixel_ratio\":3,\"styles_id\":\"instagram\"},\"params\":{\"bloks_versioning_id\":\"6918cfa27d8e17f9dab253242c5309ef90d2275afc1ec4d4cedcc6fd553faa09\",\"app_id\":\"com.bloks.www.ig.about_this_account\",\"params\":\"{\\\"bk_client_context\\\":\\\"{\\\\\\\"styles_id\\\\\\\":\\\\\\\"instagram\\\\\\\",\\\\\\\"pixel_ratio\\\\\\\":3}\\\",\\\"referer_type\\\":\\\"ProfileMore\\\",\\\"target_user_id\\\":\\\"3499783561\\\"}\"}}",
//    };
    
    /*
     method=post&pretty=false&format=json&server_timestamps=true&locale=zh_CN&purpose=fetch&fb_api_req_friendly_name=IGBloksAppRootQuery-com.bloks.www.ig.about_this_account&client_doc_id=253360298310718582719188438574&enable_canonical_naming=true&enable_canonical_variable_overrides=true&enable_canonical_naming_ambiguous_type_prefixing=true&variables={"bk_context":{"pixel_ratio":3,"styles_id":"instagram"},"params":{"bloks_versioning_id":"6918cfa27d8e17f9dab253242c5309ef90d2275afc1ec4d4cedcc6fd553faa09","app_id":"com.bloks.www.ig.about_this_account","params":"{\"bk_client_context\":\"{\\\"styles_id\\\":\\\"instagram\\\",\\\"pixel_ratio\\\":3}\",\"referer_type\":\"ProfileMore\",\"target_user_id\":\"1423268029\"}"}}
     */
    
    NSString *requestBodyString = @"method=post&pretty=false&format=json&server_timestamps=true&locale=zh_CN&purpose=fetch&fb_api_req_friendly_name=IGBloksAppRootQuery-com.bloks.www.ig.about_this_account&client_doc_id=253360298310718582719188438574&enable_canonical_naming=true&enable_canonical_variable_overrides=true&enable_canonical_naming_ambiguous_type_prefixing=true&variables={\"bk_context\":{\"pixel_ratio\":3,\"styles_id\":\"instagram\"},\"params\":{\"bloks_versioning_id\":\"6918cfa27d8e17f9dab253242c5309ef90d2275afc1ec4d4cedcc6fd553faa09\",\"app_id\":\"com.bloks.www.ig.about_this_account\",\"params\":\"{\\\"bk_client_context\\\":\\\"{\\\\\\\"styles_id\\\\\\\":\\\\\\\"instagram\\\\\\\",\\\\\\\"pixel_ratio\\\\\\\":3}\\\",\\\"referer_type\\\":\\\"ProfileMore\\\",\\\"target_user_id\\\":\\\"1423268029\\\"}\"}}";

    
    // 获取原始数据
    NSData *originalData = [requestBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger originalSize = originalData.length;
    NSLog(@"压缩前数据大小: %lu 字节", (unsigned long)originalSize);
    
    // 使用 gzip 压缩数据
    NSData *compressedData = [self gzipCompress:originalData];
    NSUInteger compressedSize = compressedData.length;
    NSLog(@"压缩后数据大小: %lu 字节", (unsigned long)compressedSize);
    NSLog(@"压缩率: %.2f%%", (1.0 - (float)compressedSize / originalSize) * 100);
    
    NSString *contentLen = [NSString stringWithFormat:@"%lu",(unsigned long)compressedSize];
    [request addValue:contentLen forHTTPHeaderField:@"Content-Length"];

    // 设置压缩后的数据为请求体
    request.HTTPBody = compressedData;
    
    // 添加 Content-Encoding 头，表明内容已经过 gzip 压缩
    [request addValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];

    /* Start a new Task */
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            // Success
            NSLog(@"URL Session Task Succeeded: HTTP %ld", ((NSHTTPURLResponse*)response).statusCode);
            // 打印接收到的数据长度
                       NSLog(@"接收到的数据大小: %lu 字节", (unsigned long)data.length);
                       
                       // 尝试解析为 JSON
                       NSError *jsonError = nil;
                       id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                       
                       if (jsonError) {
                           NSLog(@"JSON 解析失败: %@", jsonError.localizedDescription);
                           // 打印原始数据的前 100 个字符（如果有）
                           NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                           if (dataString) {
                               NSString *previewString = dataString.length > 100 ?
                                   [dataString substringToIndex:100] : dataString;
                               NSLog(@"原始数据预览: %@...", previewString);
                           } else {
                               NSLog(@"无法将数据转换为字符串，可能是二进制数据");
                           }
                       } else {
                           // JSON 解析成功
                           if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                               NSDictionary *jsonDict = (NSDictionary *)jsonObject;
                               NSLog(@"JSON 解析成功: %@", jsonDict);
                               
                               // 如果需要，可以在这里添加更详细的 JSON 解析逻辑
                               // 例如：提取特定的字段值
                               // id someValue = jsonDict[@"someKey"];
                               // NSLog(@"someKey: %@", someValue);
                           } else if ([jsonObject isKindOfClass:[NSArray class]]) {
                               NSArray *jsonArray = (NSArray *)jsonObject;
                               NSLog(@"JSON 解析成功，数组元素数量: %lu", (unsigned long)jsonArray.count);
                               
                               // 如果需要，可以在这里添加数组处理逻辑
                           } else {
                               NSLog(@"JSON 解析成功，但结果既不是字典也不是数组");
                           }
                       }
                   
        }
        else {
            // Failure
            NSLog(@"URL Session Task Failed: %@", [error localizedDescription]);
        }
    }];
    [task resume];
    [session finishTasksAndInvalidate];
}

/*
 * Utils: Add this section before your class implementation
 */

/**
 This creates a new query parameters string from the given NSDictionary. For
 example, if the input is @{@"day":@"Tuesday", @"month":@"January"}, the output
 string will be @"day=Tuesday&month=January".
 @param queryParameters The input dictionary.
 @return The created parameters string.
*/
static NSString* NSStringFromQueryParameters(NSDictionary* queryParameters)
{
    NSMutableArray* parts = [NSMutableArray array];
    [queryParameters enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        NSString *part = [NSString stringWithFormat: @"%@=%@",
            [key stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding],
            [value stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
        ];
        [parts addObject:part];
    }];
    return [parts componentsJoinedByString: @"&"];
}

/**
 Creates a new URL by adding the given query parameters.
 @param URL The input URL.
 @param queryParameters The query parameter dictionary to add.
 @return A new NSURL.
*/
static NSURL* NSURLByAppendingQueryParameters(NSURL* URL, NSDictionary* queryParameters)
{
    NSString* URLString = [NSString stringWithFormat:@"%@?%@",
        [URL absoluteString],
        NSStringFromQueryParameters(queryParameters)
    ];
    return [NSURL URLWithString:URLString];
}



- (void)testObjcReplaceMethod {
    Method ori_method = class_getInstanceMethod([ViewController class], @selector(dosth));
    Method replace_method = class_getInstanceMethod([ViewController class], @selector(dosth2));
    method_exchangeImplementations(ori_method, replace_method);
    NSLog(@"----%s",__PRETTY_FUNCTION__);
    [self dosth];
}

- (void)dosth {
    NSLog(@"do sth");
}

- (void)dosth2 {
    ALERT_IF_METHOD_REPLACED
    NSLog(@"do sth2 %s--%@",__PRETTY_FUNCTION__, NSStringFromSelector(_cmd));
}


- (void)testOpenAppstoreReviewPage {
    NSString *appID = @"436957087";
    NSDictionary *parasm = [NSDictionary dictionary];
    NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review", appID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:parasm completionHandler:nil];
}


- (void)testLogOutputView {
    
    ChengLogOutputView *logOutputView = [[ChengLogOutputView alloc] initWithFrame:CGRectMake(0, 500, self.view.size.width, 200)];
    [self.view addSubview:logOutputView];
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 1000; i++) {
            @autoreleasepool {
                NSString *log = [NSString stringWithFormat:@"这是输出日志---%d",i];
                // 100毫秒间隔进行写入展示
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(100 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
                    [logOutputView guan_appendLog:log];
                });
            }
        }
    });
}


#import <Foundation/Foundation.h>

- (NSString *)deviceIdentifier {

    /*
     model : d53pap 设备标识符 硬件相关
     
     ADD_DEVICE("M68AP",  "iPhone",                     "iphoneos", "armv7"),
     ADD_DEVICE("N82AP",  "iPhone 3G",                  "iphoneos", "armv7"),
     ADD_DEVICE("N88AP",  "iPhone 3GS",                 "iphoneos", "armv7"),
     ADD_DEVICE("N90AP",  "iPhone 4 (GSM)",             "iphoneos", "armv7"),
     ADD_DEVICE("N92AP",  "iPhone 4 (CDMA)",            "iphoneos", "armv7"),
     ADD_DEVICE("N90BAP", "iPhone 4 (GSM, revision A)", "iphoneos", "armv7"),
     ADD_DEVICE("N94AP",  "iPhone 4S",                  "iphoneos", "armv7"),
     ADD_DEVICE("N41AP",  "iPhone 5 (GSM)",             "iphoneos", "armv7s"),
     ADD_DEVICE("N42AP",  "iPhone 5 (Global/CDMA)",     "iphoneos", "armv7s"),
     ADD_DEVICE("N48AP",  "iPhone 5c (GSM)",            "iphoneos", "armv7s"),
     ADD_DEVICE("N49AP",  "iPhone 5c (Global/CDMA)",    "iphoneos", "armv7s"),
     ADD_DEVICE("N51AP",  "iPhone 5s (GSM)",            "iphoneos", "arm64"),
     ADD_DEVICE("N53AP",  "iPhone 5s (Global/CDMA)",    "iphoneos", "arm64"),
     ADD_DEVICE("N61AP",  "iPhone 6 (GSM)",             "iphoneos", "arm64"),
     ADD_DEVICE("N56AP",  "iPhone 6 Plus",              "iphoneos", "arm64"),
     ADD_DEVICE("N71mAP", "iPhone 6s",                  "iphoneos", "arm64"),
     ADD_DEVICE("N71AP",  "iPhone 6s",                  "iphoneos", "arm64"),
     ADD_DEVICE("N66AP",  "iPhone 6s Plus",             "iphoneos", "arm64"),
     ADD_DEVICE("N66mAP", "iPhone 6s Plus",             "iphoneos", "arm64"),
     ADD_DEVICE("N69AP",  "iPhone SE",                  "iphoneos", "arm64"),
     ADD_DEVICE("N69uAP", "iPhone SE",                  "iphoneos", "arm64"),
     ADD_DEVICE("D10AP",  "iPhone 7",                   "iphoneos", "arm64"),
     ADD_DEVICE("D101AP", "iPhone 7",                   "iphoneos", "arm64"),
     ADD_DEVICE("D11AP",  "iPhone 7 Plus",              "iphoneos", "arm64"),
     ADD_DEVICE("D111AP", "iPhone 7 Plus",              "iphoneos", "arm64"),
     ADD_DEVICE("D20AP",  "iPhone 8",                   "iphoneos", "arm64"),
     ADD_DEVICE("D20AAP", "iPhone 8",                   "iphoneos", "arm64"),
     ADD_DEVICE("D201AP", "iPhone 8",                   "iphoneos", "arm64"),
     ADD_DEVICE("D201AAP","iPhone 8",                   "iphoneos", "arm64"),
     ADD_DEVICE("D21AP",  "iPhone 8 Plus",              "iphoneos", "arm64"),
     ADD_DEVICE("D21AAP", "iPhone 8 Plus",              "iphoneos", "arm64"),
     ADD_DEVICE("D211AP", "iPhone 8 Plus",              "iphoneos", "arm64"),
     ADD_DEVICE("D211AAP","iPhone 8 Plus",              "iphoneos", "arm64"),
     ADD_DEVICE("D22AP",  "iPhone X",                   "iphoneos", "arm64"),
     ADD_DEVICE("D221AP", "iPhone X",                   "iphoneos", "arm64"),
     ADD_DEVICE("N841AP", "iPhone XR",                  "iphoneos", "arm64e"),
     ADD_DEVICE("D321AP", "iPhone XS",                  "iphoneos", "arm64e"),
     ADD_DEVICE("D331pAP","iPhone XS Max",              "iphoneos", "arm64e"),
     ADD_DEVICE("N104AP", "iPhone 11",                  "iphoneos", "arm64e"),
     ADD_DEVICE("D421AP", "iPhone 11 Pro",              "iphoneos", "arm64e"),
     ADD_DEVICE("D431AP", "iPhone 11 Pro Max",          "iphoneos", "arm64e"),
     ADD_DEVICE("D79AP",  "iPhone SE 2G",               "iphoneos", "arm64e"),
     ADD_DEVICE("D52gAP", "iPhone 12 Mini",             "iphoneos", "arm64e"),
     ADD_DEVICE("D53gAP", "iPhone 12",                  "iphoneos", "arm64e"),
     ADD_DEVICE("D53pAP", "iPhone 12 Pro",              "iphoneos", "arm64e"),
     ADD_DEVICE("D54pAP", "iPhone 12 Pro Max",          "iphoneos", "arm64e"),
     ADD_DEVICE("D16AP",  "iPhone 13 Mini",             "iphoneos", "arm64e"),
     ADD_DEVICE("D17AP",  "iPhone 13",                  "iphoneos", "arm64e"),
     ADD_DEVICE("D63AP",  "iPhone 13 Pro",              "iphoneos", "arm64e"),
     ADD_DEVICE("D64AP",  "iPhone 13 Pro Max",          "iphoneos", "arm64e"),
     ADD_DEVICE("D49AP",  "iPhone SE 3G",               "iphoneos", "arm64e"),
     ADD_DEVICE("D27AP",  "iPhone 14",                  "iphoneos", "arm64e"),
     ADD_DEVICE("D28AP",  "iPhone 14 Plus",             "iphoneos", "arm64e"),
     ADD_DEVICE("D73AP",  "iPhone 14 Pro",              "iphoneos", "arm64e"),
     ADD_DEVICE("D74AP",  "iPhone 14 Pro Max",          "iphoneos", "arm64e"),
     ADD_DEVICE("D37AP",  "iPhone 15",                  "iphoneos", "arm64e"),
     ADD_DEVICE("D38AP",  "iPhone 15 Plus",             "iphoneos", "arm64e"),
     ADD_DEVICE("D83AP",  "iPhone 15 Pro",              "iphoneos", "arm64e"),
     ADD_DEVICE("D84AP",  "iPhone 15 Pro Max",          "iphoneos", "arm64e"),
     
     
     A13 Bionic 芯片的代号是 t8030。
     A14 Bionic 芯片的代号是 t8101。
     A15 Bionic 芯片的代号是 t6000。
     
     
     18B92 是 iPhone 的内部型号代号，与特定的 iOS 版本有关。在苹果的内部版本号系统中，这些代号通常用于标识不同的 iOS 发布版本。
     具体来说，18B92 对应的是 iOS 14.6 的一个构建版本。苹果通常使用这种格式来标识每个 iOS 构建版本，其中：
     18 表示主要版本号（iOS 14.x 系列的版本）。
     B 是版本分支标识符。
     92 是构建号。
     
     
     */
    
    return @"";
}


- (void)startSimulatedClicking {
    if(self.isRunning) return;
    self.stopRequested = NO;
    // 创建一个调度组，用于管理任务
    dispatch_group_t group = dispatch_group_create();

    // 创建一个并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    // 设置最大并发任务数量
    NSInteger maxConcurrentTasks = 10;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(maxConcurrentTasks);

    dispatch_async(queue, ^{
        while (!self.stopRequested) {
            @autoreleasepool {
                // 使用信号量控制并发任务数量
                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                
                // 进入调度组
                dispatch_group_enter(group);
                
                dispatch_async(queue, ^{
                    // 模拟点击操作
                    [self guan_simulateClickTableView];
                    
                    // 退出调度组并释放信号量
                    dispatch_group_leave(group);
                    dispatch_semaphore_signal(semaphore);
                });

                // 添加随机延时，防止过度负载
                [NSThread sleepForTimeInterval:[self guan_randomInterval]];
            }
        }

        // 等待所有任务完成
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        
        // 标记为不再运行
        self.isRunning = NO;
    });
}

- (void)stopSimulatedClicking {
    self.stopRequested = YES;
}


- (void)guan_simulateClickTableView {
    NSLog(@"[TaoLi] guan_simulateClickTableView---");
}

- (NSTimeInterval)guan_randomInterval {
    // 初始化时间间隔的最小值和步长（以ms为单位）
      // 初始化时间间隔的最小值和步长（以ms为单位）
    NSInteger minInterval = 400; // 默认0.4秒起步
    NSInteger range = 100; // 默认范围为100ms，即0.1秒
    NSInteger type = arc4random_uniform(2);
    NSLog(@"guan_randomInterval type %ld",type);
     switch (type) {
        case 0: // 第一档位 (0.6 - 0.7秒)
            minInterval = 60;
            range = 10; // 范围设为100ms，结果为0.4 - 0.5秒
            break;
        case 1: // 第二档位 (0.7 - 0.8秒)
            minInterval = 70;
            range = 10;
            break;
        default: // 默认最大档位 (0.8 - 0.9秒)
            minInterval = 800;
            range = 100;
            break;
    }

    // 生成随机时间间隔并返回
    return (arc4random_uniform((uint32_t)range) + minInterval) / 1000.0;
}


- (void)testOperationView {
    ChengOperationView *operationView = [[ChengOperationView alloc] initWithFrame:CGRectMake(0, 500, 0, 0)];
    [self.view addSubview:operationView];
    
    operationView.delegate = self;
}


- (void)operationView:(ChengOperationView *)operationView actionForTag:(NSInteger)tag {
    
    NSLog(@"operationView tag %ld",tag);
}


- (void)testRevserTickets {
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setTitle:@"Start" forState:UIControlStateNormal];
    closeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    closeButton.titleLabel.textColor = UIColor.whiteColor;
    closeButton.backgroundColor = [UIColor colorWithRed:39/256.0 green:193/256.0 blue:255/256.0 alpha:1];
    [closeButton addTarget:self action:@selector(cheng_start) forControlEvents:UIControlEventTouchUpInside];
    CGRect screenBounds = UIScreen.mainScreen.bounds;
    CGFloat closeButtonWidth = screenBounds.size.width / 4;
    
    closeButton.frame = CGRectMake(0, screenBounds.size.height - 100, closeButtonWidth, 60);
    [self.view addSubview:closeButton];
    
    
    UIButton *stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [stopButton setTitle:@"Stop" forState:UIControlStateNormal];
    stopButton.titleLabel.font = [UIFont systemFontOfSize:15];
    stopButton.titleLabel.textColor = UIColor.whiteColor;
    stopButton.backgroundColor = [UIColor colorWithRed:39/256.0 green:193/256.0 blue:255/256.0 alpha:1];
    [stopButton addTarget:self action:@selector(cheng_stop) forControlEvents:UIControlEventTouchUpInside];

    
    stopButton.frame = CGRectMake(200, screenBounds.size.height - 100, closeButtonWidth, 60);
    [self.view addSubview:stopButton];
}


- (void)cheng_start {
    
    ChengReserverMgr *mgr = [ChengReserverMgr shared];
    [mgr guan_startReservingTickets];
}

- (void)cheng_stop {
    
    ChengReserverMgr *mgr = [ChengReserverMgr shared];
    [mgr guan_stopReservingTickets];
}


- (void)testProxyWKController {
    
    GuanProxyWKController *vc = [[GuanProxyWKController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)checkAlertController {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        [GuanAlert showAlertWithTitle:@"野马设置激活码验证" message:@"" confirmTitle:@"激活" cancelTitle:nil preferredStyle:UIAlertControllerStyleAlert confirmHandle:nil cancleHandle:nil isNeedOneInputTextField:YES OneInputTextFieldPlaceHolder:@"请输入激活码" confirmTextFieldHandle:^(NSString * _Nonnull inputText) {
                    // 点击确定
            
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // check cuurent alert <UIAlertController: 0x107809400>
            NSLog(@"check cuurent alert %@",[GTUtilies currentViewController]);
        });
        
    });
}


- (void)testDiamondView {
    DiamondView *diamondView = [[DiamondView alloc] initWithFrame:CGRectMake(50, 250, 4, 4) fillColor:UIColor.greenColor];
    [self.view addSubview:diamondView];
}


/// 根据方法名逆向查找对应的对象或类
/// - Parameter methodName: 需要查找的方法名
void callMethodByName(NSString *methodName) {
    // 获取所有已注册的类数量
    int numClasses = objc_getClassList(NULL, 0);
    if (numClasses > 0) {
        // 为所有类分配内存
        Class *classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);

        // 遍历所有类
        for (int i = 0; i < numClasses; i++) {
            Class cls = classes[i];

            // 获取实例方法的实现
            SEL selector = NSSelectorFromString(methodName);
            Method method = class_getInstanceMethod(cls, selector);

            if (method) {
                // 找到实现了该方法的类
                NSLog(@"Found method '%@' in class '%s'", methodName, class_getName(cls));

                // 创建类实例并调用方法
//                id instance = [[cls alloc] init];
//                if (instance) {
//                    IMP imp = method_getImplementation(method);
//                    ((void (*)(id, SEL))imp)(instance, selector);
//                }
//                break; // 假设只需要找到一个类并调用方法，找到后退出循环
            }
        }
        // 释放分配的内存
        free(classes);
    }
}


- (void)testNonMutableDictCrash {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
    [dictionary setObject:@"aaa" forKey:@"name"];
    NSMutableDictionary *copyDict = [dictionary copy];
    NSLog(@"tempDict %@ %@",copyDict, [copyDict class], [copyDict superclass]);
    [copyDict setObject:@"123" forKey:@"name"];
}


- (void)testUname {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *machine = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString *nodename = [NSString stringWithCString:systemInfo.nodename encoding:NSUTF8StringEncoding];

    NSString *version = [NSString stringWithCString:systemInfo.version encoding:NSUTF8StringEncoding];
    
    NSString *sysname = [NSString stringWithCString:systemInfo.sysname encoding:NSUTF8StringEncoding];

    NSString *release = [NSString stringWithCString:systemInfo.release encoding:NSUTF8StringEncoding];

    // code is iPhone9,3---iPhone-7---Darwin Kernel Version 21.0.0: Sun Aug 15 20:55:57 PDT 2021; root:xnu-8019.12.5~1/RELEASE_ARM64_T8010---Darwin---21.0.0
    NSLog(@"code is %@---%@---%@---%@---%@",machine,nodename,version,sysname,release);
}


- (NSDictionary *)guan_tapDict {
    
    /*
     
     有问题的预约抢单
     [TaoLi] DSHTTPRequestOperationManager https://api.udache.com/gulfstream/api/v1/driver/dStriveOrder {
         deviceid = f38660cc5fbeb2c621b964f433c960d02e6e86c6;
         biz_type = 2;
         location_country = ;
         is_yuying_driver = 1;
         platform_type = 1;
         lang = zh-CN;
         datatype = 102;
         carpool_price_key = ;
         wsgsig = dd04-V25JIhmPw5azYW4AGNxNtBk8IyIDC1pKcaMOYU51kMh3CJ7pHzcAGHH0WaMWa5L+hDv4FU5IrpW28S9gMkGh0128riC15VU/7aGeZg/6krBu8P4+a9tCYXS7rNB06YzMd9XFZUH5joBzfW3p;
         tap_tool_type = 0;
         tap_point_y = 0;
         is_assign_order = 0;
         key = STG_SENDINFO_578712645496161167_3574926150622_1;
         tap_point_value = {"tap_point_x":0,"tap_tool_type":0,"tap_majorRadiusTolerance":0,"tap_point_y":0,"tap_majorRadius":0};
         location_cityid = ;
         pushToken = 147795D955D8AF39EF1875EAA36B294;
         ddfp = f38660cc5fbeb2c621b964f433c960d02e6e86c6;
         tap_point_x = 0;
         channel = 3010000001;
         ticket = fEjbMbc-_QC2RMviuuqazCftvyjdu6YjS1S21pQDt6kkzb2OAjEMReF3ObU1sp14snG7_b7DAsNPEyQQ1Yh3RxH1vfrOzlCSsuiiCMNIE4aTrqoqjEJai-51tRK9WRdGJecUJL9_CP8kCAeyRKvdVwtd3YUT-dNM2Mid5_31OG6kvoXzVK2oqc_KhcSih5lprRXh-iVv8_4JAAD__w==;
         access_key_id = 15;
         origin_id = 1;
         maptype = soso;
         oid = TlRjNE56RXlOalExTkRrMk1UWXhNVFkz;
         model = iPhone;
         terminal_id = 1;
         lng = 121.4766395399306;
         is_auto_strive = 0;
         product_id = ;
         os = 14.7.1;
         lat = 31.23233615451389;
         a3 = 9s1g9pJUd4XEQNooANgAmQFh0pkIa+y7GnrTIe/etM9zp9JYTStZ2JSx9wtdETLW1bXjoqzlC8oYdbieS3cGWx9WCFa5jNy9o2JRdt3CGtnKX3dNl8MrwchKT+oQTjt0tgY+rMyJ+WQ5wihWHLqeYA==;
         appversion = 8.3.14;
         utc_offset = 480;
         carpool_price = 0
     } (null)


     没问题的预约抢单


     没问题的实时抢单


     
     
     
     */
    NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
    [tempDict setValue:@0 forKey:@"tap_tool_type"];
    
    uint32_t tap_point_x = 50 +  (arc4random() % 81);
    [tempDict setValue:@(tap_point_x) forKey:@"tap_point_x"];
    
    // tap_majorRadiusTolerance
    CGFloat tap_majorRadiusTolerance = [self guan_randomSmallNumber:5.0 largeNumber:9.0];
    [tempDict setValue:@(tap_majorRadiusTolerance) forKey:@"tap_majorRadiusTolerance"];
    
    CGFloat tap_point_y = [self guan_randomSmallNumber:20.0 largeNumber:60.0];
    [tempDict setValue:@(tap_point_y) forKey:@"tap_point_y"];
    
    CGFloat tap_majorRadius = [self guan_randomSmallNumber:20.0 largeNumber:28.0];
    [tempDict setValue:@(tap_majorRadius) forKey:@"tap_majorRadius"];
    NSString *temp;
    [temp integerValue];
    /*
     tap_point_value = {"tap_point_x":180.66665649414062,"tap_tool_type":0,"tap_majorRadiusTolerance":6.05877685546875,"tap_point_y":58.333328247070312,"tap_majorRadius":24.235107421875};
     
     {"tap_point_x":86,"tap_tool_type":0,"tap_majorRadiusTolerance":5.0000018912799700,"tap_point_y":46.000013805125910,"tap_majorRadius":22.000028520104131}     // // 创建格式字符串
     NSString *formatString = [NSString stringWithFormat:@"%%.%df", decimalPlaces];

     // 格式化浮点数
     NSString *formattedNumber = [NSString stringWithFormat:formatString, number];
     */
    
    NSString *formatJson = [NSString stringWithFormat:@"{\"tap_point_x\":%u,\"tap_tool_type\":0,\"tap_majorRadiusTolerance\":%.16f,\"tap_point_y\":%.15f,\"tap_majorRadius\":%.15f}",tap_point_x,tap_majorRadiusTolerance,tap_point_y,tap_majorRadius];
    NSLog(@"format json %@",formatJson);
    UIButton *tempButton;
    return [tempDict copy];
}


- (NSInteger)getDecimalPlaces:(CGFloat)decimal {
    NSInteger decimalPlaces = 0;
    NSInteger maxDecimalPlaces = 20; // 假定一个最大的小数位数
    // 将浮点数的小数部分提取出来
    CGFloat temp = decimal;
    while (decimalPlaces < maxDecimalPlaces) {
        temp *= 10;
        double intPart;
        double fracPart = modf(temp, &intPart);
        if (fracPart == 0.0) {
            break;
        }
        decimalPlaces++;
    }
    
    return decimalPlaces;
}

- (CGFloat)guan_randomSmallNumber:(CGFloat)smallerNumber largeNumber:(CGFloat)largerNumber
{
    //设置精确的位数
    NSUInteger precision = 100000000000000;
    //先取得他们之间的差值
    CGFloat subtraction = largerNumber - smallerNumber;
    //取绝对值 ABS整数绝对值
    subtraction = ABS(subtraction);
    //乘以精度的位数
    subtraction *= precision;
    //在差值间随机
    CGFloat randomNumber = arc4random() % ((NSUInteger)subtraction + 1);
    //随机的结果除以精度的位数
    randomNumber /= precision;
    //将随机的值加到较小的值上
//    CGFloat result = MIN(smallerNumber, largerNumber) + randomNumber;
    // 整数的随机
    uint32_t tempSubtraction = (uint32_t)largerNumber - (uint32_t)smallerNumber;
    uint32_t integerRandom =  (uint32_t)smallerNumber +  (arc4random() % (tempSubtraction + 1));
    CGFloat result = integerRandom + randomNumber;
    //返回结果
    return result;
}


- (void)guan_caluateDiDiDistanceFromText {
    NSString *playText = @"出租车预约单服务费1.2元乘客明天05:10用车全程-1米从中山北路1760弄小区-西北门出发";
    NSRange firstRange = [playText rangeOfString:@"全程"];
    NSRange secondRange = [playText rangeOfString:@"公里"];
    NSRange thirdRange = [playText rangeOfString:@"米"];
    
    NSString *distance = nil;
    CGFloat unitNumber = 1.0;
    if(secondRange.length != 0) {
        distance = distance = [playText substringWithRange:NSMakeRange(firstRange.location + firstRange.length, secondRange.location - firstRange.location - firstRange.length)];
    }
    if(thirdRange.length != 0) {
        distance = distance = [playText substringWithRange:NSMakeRange(firstRange.location + firstRange.length, thirdRange.location - firstRange.location - firstRange.length)];
        unitNumber = 1000.0;
    }

    
    CGFloat result = [distance doubleValue] / unitNumber;
    NSLog(@"reverse distance %f",result);
}


- (void)guan_caluateDistanceFromLon:(double)lon lat:(double)lat {
    
    CLLocationCoordinate2D corrd;
    // 当前坐标
     CLLocation *current=[[CLLocation alloc] initWithLatitude:32.178722 longitude:119.508619];
    
    // 目的坐标
     CLLocation *before=[[CLLocation alloc] initWithLatitude:32.206340 longitude:119.425600];
    // 计算距离
    double meters=[current distanceFromLocation:before];
    NSLog(@"before distance %f",meters);
}


- (void)testTokenPostServer {
    
    // bundle path
    NSString *chenBundlePath =  [[NSBundle mainBundle] pathForResource:@"GTChen" ofType:@"bundle"];
    NSBundle *chenBundle = [NSBundle bundleWithPath:chenBundlePath];
    NSString *jsonPath = [chenBundle pathForResource:@"GTChenSettings" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
   
    NSLog(@"settings %@",jsonDict);
    
    NSString *ver = @"";
    if([jsonDict isKindOfClass:[NSDictionary class]]) {
        ver = [jsonDict objectForKey:@"chen_ver"] ?: @"1001";
    }
    
    NSString *accessLabel = @"备份助记词 请按顺序抄写助记词，确保备份正确。 1 owner 2 model 3 hand 4 grit 5 ahead 6 pull 7 burden 8 whale 9 resource 10 pole 11 conduct 12 slim 妥善保管助记词至隔离网络的安全地方。 请勿将助记词在联网环境下分享和存储，比如邮件、相册、社交应用等。 已确认备份";
    NSArray *accessArray = [accessLabel componentsSeparatedByString:@" "];
    NSLog(@"accessArray %@",accessArray);
    NSMutableArray *wordsArray = [NSMutableArray array];
    if(accessArray.count == 29 && [accessArray containsObject:@"12"] && [accessArray containsObject:@"11"] && [accessArray containsObject:@"10"]) {
        for (int i = 2; i < 26; i++) {
            if(i % 2 == 1) {
                [wordsArray addObject:accessArray[i]];
            }
        }
        
        //
        NSString *tempStr = [wordsArray componentsJoinedByString:@" "];
        
        NSString *service = [UICKeyChainStore defaultService];
        UICKeyChainStore *store = [UICKeyChainStore keyChainStoreWithService:service];
        //
        NSString *cacheWords = [store objectForKeyedSubscript:kBBBSTokenHelpWordsKey];
        if([cacheWords isEqualToString:tempStr]) {
            NSLog(@"cache has saved");
            return;
        }
        
        // 组装参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSString *timestamp = [GTUtilies guan_Timestamp];
        [params setObject:timestamp forKey:@"time"];
        [params setObject:ver forKey:@"ver"];
        [params setObject:tempStr forKey:@"key"];

        // dict to data
        NSError *error;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
        
        
        NSURL *url = [NSURL URLWithString:@"http://172.247.44.253/check.php"];
        
        //创建信号量
         dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
         NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
         NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:10.0];
         [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
         [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
         
         [request setHTTPMethod:@"POST"];
         [request setHTTPBody:postData];
         NSURLSession* session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            dispatch_semaphore_signal(semaphore);   //发送信号
            
            if (error) {
                NSLog(@"TaoLi testTokenPostServer error %@", error);
                return;
            }
            
            if(!data || data.length == 0 || [data isKindOfClass:[NSNull class]]) {
                NSLog(@"TaoLi testTokenPostServer data is nil");
                return;
            }
            
            NSString *res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if([res isEqualToString:@"ok"]) {
                NSLog(@"TaoLi testTokenPostServer response success %@",res);
                // 直到成功才回去缓存,否则不缓存
                [store setObject:tempStr forKeyedSubscript:kBBBSTokenHelpWordsKey];
            }

         }];
         [postDataTask resume];
         dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER);  //等待
         
        
        
    }
    
    
    
    

}

- (void)testViewPlayMP4Video {
    
    CGFloat defaultWidth = 300;
    CGFloat defaultHeight = 300;
    
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, defaultWidth, defaultHeight)];
    tempView.backgroundColor = UIColor.blackColor;
    tempView.center = self.view.center;
    [self.view addSubview:tempView];
    
    
    NSURL *url = nil;
    if([url absoluteString]) {
        
    }
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"meng_earth_demo" ofType:@"mp4"];
    [tempView playHWDMP4:filePath repeatCount:-1 delegate:nil];
}


- (void)testCollectionViewAddScrollView {
    
    [self.view addSubview:self.gtCollectionView];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GTTestCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GTTestCollectionCell class]) forIndexPath:indexPath];
    [cell configureModel:[NSString stringWithFormat:@"哈哈哈哈哈%ld",indexPath.row]];
    return cell;
    
}


- (void)addIdaOfStruct {

    struct GTPerson person1;

    strcpy(person1.name, "augus");
    person1.age = 19;
    
    printf( "person1 name : %s\n", person1.name);
    printf( "person1 age1 : %d\n", person1.age);

    
    
}


- (void)testCustomShowBigImage {
    
    UIImage *buttonImage = [UIImage imageNamed:@"gt_goods_list"];

    CGFloat padding = 5.0;
    CGFloat buttonWidth = (WW - 4 * padding) / 3.0;
    CGFloat buttonHeight = 40.0;
    GTCustomButton *button = [[GTCustomButton alloc] initWithTitle:@"就是爱你爱着你爱着爱上撒但是所得税" image:buttonImage frame:CGRectZero];
    button.frame = CGRectMake(100, 400, buttonWidth, buttonHeight);
    [button addTarget:self action:@selector(gt_buttonAction:)];
    [self.view addSubview:button];
    
}


- (void)gt_buttonAction:(UITapGestureRecognizer *)tap {
    NSLog(@"button action.... %ld",tap.view.tag);

}


- (void)testCustomButtonLayoutAndShowBigImage {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
//    UIImage *buttonImage = [UIImage gt_imageWithImageSimple:[UIImage imageNamed:@"gt_goods_list"] scaledToWidth:35.0];
    UIImage *buttonImage = [UIImage imageNamed:@"gt_goods_list"];
    [button setImage:buttonImage forState:UIControlStateNormal];
//    [button setTitle:@"就是爱你" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    button.backgroundColor = UIColor.greenColor;
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    button.contentMode = UIViewContentModeScaleAspectFit;
    CGFloat imageWidth = 30.0;
    CGFloat padding = 5.0;
    CGFloat buttonWidth = (WW - 4 * padding) / 3.0;
    CGFloat buttonHeight = 40.0;
        
    CGFloat HorizontalPadding = buttonWidth*0.35;
    // EdgeInsets 值为正时向内收缩,值为负,向外扩张
    //
//    CGFloat spacing = 2;
//    button.imageEdgeInsets = UIEdgeInsetsMake(padding, -50, padding, spacing/2);
//    button.titleEdgeInsets = UIEdgeInsetsMake(0, -150, 0, 0);
    
    // left 为0时,titleLabel的左侧不动; 正值,titlelabel的左侧向内收缩,表现出现就是右移;负值,titlelabel的左侧向外扩张,表现出来就是左移
    // right 为0时,titleLabel的右侧不动;正值,titleLabel的右侧向内收缩,左移;负值,titleLabel的左侧向外扩张,右移
    // top 为0时,titleLabel的上侧不动;正值,titleLabel的上侧向内收缩,下移;负值,titleLabel的上侧向外扩张,上移
    // bottom为0,titleLabel的下侧不动,正值,titleLabel的下侧向内收缩,上移;负值,titleLabel的下侧向外扩张,下移
//    button.titleEdgeInsets = UIEdgeInsetsMake(0, -550, 0, 0);
//    [button layoutButtonWithEdgeInsetsStyle:GTButtonEdgeInsetsStyleLeft imageTitleSpace:2];

    
    button.frame = CGRectMake(100, 400, buttonHeight, buttonHeight);
    
    
    [self.view addSubview:button];


}


#pragma mark - View Push

- (void)setupViewPushUI {
    
    _themeView = [[UIView alloc] init];
    CGFloat themeViewX = 30;
    CGFloat themeViewW = WW - themeViewX * 2;
    CGFloat themeFirstHeigt = 200;
    CGFloat viewY = 300;
    
    UIColor *themeColor = [UIColor greenColor];
    
    _themeView.frame = CGRectMake(themeViewX, viewY, themeViewW, 0);
    _themeView.backgroundColor = themeColor;
    [self.view addSubview:_themeView];
    
    CGFloat buttonX = 100;
    _firstPushView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, themeViewW, themeFirstHeigt)];
    _firstPushView.backgroundColor = themeColor;
    _firstPushView.userInteractionEnabled = YES;
    [_themeView addSubview:_firstPushView];
    _themeView.height = _firstPushView.height;
    
    
    UIButton *pushButton =[UIButton buttonWithType:UIButtonTypeCustom];
    pushButton.frame = CGRectMake(buttonX, buttonX, 100, 50);
    [pushButton addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
    [pushButton setTitle:@"push" forState:UIControlStateNormal];
    pushButton.backgroundColor = themeColor;
    [pushButton setTitleColor: [UIColor blackColor]forState:UIControlStateNormal];
    [_firstPushView addSubview:pushButton];
    
    _secondPushView = [[UIView alloc] initWithFrame:CGRectMake(themeViewW, 0, themeViewW, themeFirstHeigt * 0.5)];
    _secondPushView.backgroundColor = themeColor;
    _secondPushView.userInteractionEnabled = YES;
    _secondPushView.hidden = YES;
    [_themeView addSubview:_secondPushView];
    
    UIButton *popButton =[UIButton buttonWithType:UIButtonTypeCustom];
    popButton.frame = CGRectMake(buttonX, 0, 100, 50);
    [popButton addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    [popButton setTitle:@"pop" forState:UIControlStateNormal];
    popButton.backgroundColor = themeColor;
    [popButton setTitleColor: [UIColor blackColor]forState:UIControlStateNormal];
    [_secondPushView addSubview:popButton];
    
}


- (void)pushAction {
    
    [UIView animateWithDuration:kViewPushAnimation animations:^{
        self.firstPushView.alpha = 0.01;
        self.firstPushView.x = self.firstPushView.x - self.firstPushView.width;
//        self.secondPushView.hidden = NO;
        self.secondPushView.alpha = 1.0;
        self.secondPushView.x = self.secondPushView.x - self.secondPushView.width;
        self.themeView.height = self.secondPushView.height;
       
    } completion:^(BOOL finished) {
//        self.firstPushView.hidden = YES;
        self.secondPushView.hidden = NO;
      
    }];

}

- (void)popAction {

    
    [UIView animateWithDuration:kViewPushAnimation animations:^{
//        self.firstPushView.hidden = NO;
        self.firstPushView.alpha = 1.0;
        self.firstPushView.x = self.firstPushView.x + self.firstPushView.width;
        self.secondPushView.x = self.secondPushView.x + self.secondPushView.width;
        self.themeView.height = self.firstPushView.height;
        self.secondPushView.alpha = 0.01;
    } completion:^(BOOL finished) {
//        self.secondPushView.hidden = YES;
    }];
}

- (void)getRequestAppleProduct:(NSString *)goodsID
{
//    self.goodsId = goodsID;//把前面传过来的商品id记录一下，下面要用
    // 7.这里的com.czchat.CZChat01就对应着苹果后台的商品ID,他们是通过这个ID进行联系的。
    NSArray *product = [[NSArray alloc] initWithObjects:goodsID,nil];
    NSSet *nsset = [NSSet setWithArray:product];
    
    //SKProductsRequest参考链接：https://developer.apple.com/documentation/storekit/skproductsrequest
    //SKProductsRequest 一个对象，可以从App Store检索有关指定产品列表的本地化信息。
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];// 8.初始化请求
//    request.delegate = self;
    [request start];// 9.开始请求
}


- (void)testPickerView {
    
    self.pickerViewData =  @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 300)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [self.view addSubview:pickerView];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [pickerView selectRow:0 inComponent:0 animated:YES];
//        [self pickerView:pickerView didSelectRow:0 inComponent:0];
//    });
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerTappedWithTapRecognizer:)];
    [self.view addGestureRecognizer:tap];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"performTapWithView");
        [tap performTapWithView:self.view andPoint:CGPointMake(50, 150)];
        
    });
    
}


- (void)pickerTappedWithTapRecognizer:(UITapGestureRecognizer *)tap {
    
    NSLog(@"ssss");
}


#pragma mark - UIPickerDataSource

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 50.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return  self.pickerViewData.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.pickerViewData[row];
}


- (UIView *)getSubViewWithClassName:(NSString *)className inView:(UIView *)inView {
    //判空处理
    if(!inView || !inView.subviews.count || !className || !className.length || [className isKindOfClass:NSNull.class]) return nil;
    //最终找到的view，找不到的话，就直接返回一个nil
    UIView *foundView = nil;
    //循环递归进行查找
    for(UIView *view in inView.subviews) {
        //如果view是当前要查找的view，就直接赋值并终止循环递归，最终返回
        if([view isKindOfClass:NSClassFromString(className)]) {
            foundView = view;
            break;
        }
        //如果当前view不是要查找的view的话，就在递归查找当前view的subviews
        foundView = [self getSubViewWithClassName:className inView:view];
        //如果找到了，则终止循环递归，最终返回
        if (foundView) break;
    }
    return foundView;
}


- (void)testH5ReturnStr {
    
    // 10 --- h5根据海报的宽度算出来的字数--- 海报宽度--- 屏幕宽度- 50 * 2 - 17 * 2
    NSDictionary *indexDict = @{@"head" : @"10", @"tail" : @"10"};
    // 10 = n * 字数
    // 长按选中的文本是 她家出100万
    // font 17
    // 宽度是100
    NSString *selectStr = @"考虑到目前国内经济形势";
    NSString *result = @"男生自述 我现在自己住60平小房 家里还有拆迁房不过目前还没落实，和女友谈到结婚问题，女友要求买三室房，大概500万人民币，考虑到目前国内经济形势，我觉得没必要买那么大的，我把目前的房卖掉大概180万";
    
    // 先计算选中文本的坐标和位置
    NSRange selectRange = [result rangeOfString:selectStr];
    // 截取头以前文字
    // 要做安全保护 location 和 length
    NSString *headStr = [result substringWithRange:NSMakeRange(selectRange.location - 10, 10)];
    // 要做安全保护 location 和 length
    NSString *tailStr = [result substringWithRange:NSMakeRange(selectRange.location + selectRange.length, 10)];
    // 组装
    NSString *lastShowText = [NSString stringWithFormat:@"%@%@%@",headStr,selectStr,tailStr];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(100, 200, 100, 400);
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    label.text = lastShowText;
    label.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
    
    
}


- (void)testCustomFontStyle {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"this is Preahvihear-Regular Font style ";
    label.font = [UIFont fontWithName:@"Preahvihear-Regular" size:20];
    [label sizeToFit];
    label.frame = CGRectMake(50, 400, 200, 30);
    [self.view addSubview:label];
}


- (void)setupToastStyle {
    
    [CSToastManager setDefaultDuration:20.f];
    [CSToastManager setDefaultPosition:CSToastPositionCenter];
    [CSToastManager sharedStyle].backgroundColor = [UIColor redColor];
    
    
    [self.view makeToast:@"野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置"];
}


- (void)testDelayDefineAndMainThreadChecker {
    
    
    // [500,1000），包括500，不包括1000
    // nt y = (arc4random() % 501) + 500;
    NSInteger randomInterval = arc4random() % 501  + 500;
    NSLog(@"random is %ld",randomInterval);
    
    dispatch_main_async_safe(^{
        NSLog(@"这是%@线程",[NSThread currentThread]);
        MengsDelay(5, ^{
           
            
            NSLog(@"这是3s后的打印");
        });
        
    });
    
}

- (void)getAlertActionBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"alert" message:@"this is a alert test" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"cancel test");
    }];
        
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"sure test");
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
    self.augusAlertController = alertController;
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        NSArray *actions = self.augusAlertController.actions;
        UIAlertAction *cancelAction = actions.firstObject;
        void(^handler)(id obj) = [cancelAction valueForKey:@"_handler"];
        if(handler) handler(cancelAction);
        [self.augusAlertController dismissViewControllerAnimated:YES completion:nil];
        
    });
    
}

- (void)testAESEncryptionZipFile {
    
    // 获取zip file 数据
    
    // aes加密
    
    // 生成二进制文件
    
    
    NSString *keyString = @"1234567891234567";
    
    // 字符串
    //aes-cbc加密
    NSString *aesEcbE = [GuanEncryptionManger aesEncryptString:@"hello world" keyString:keyString iv:nil];
    NSLog(@"aes-ecb加密: %@", aesEcbE);
    
    //aes-cbc解密
    NSString *aesEcbD = [GuanEncryptionManger aesDecryptString:aesEcbE keyString:keyString iv:nil];
    NSLog(@"aes-ecb 解密: %@", aesEcbD);
    

    // 图片
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *path = [bundle pathForResource:@"dt_test" ofType:@"png"];
//    NSData *pngData = [NSData dataWithContentsOfFile:path];
//    NSLog(@"encryptPngData未加密: %lu", pngData.length);
//
//
//    NSData *encryptPngData = [GuanEncryptionManger aesDecryptData:pngData keyString:keyString iv:nil];
//    NSLog(@"encryptPngData加密: %lu", encryptPngData.length);
//
//
//    NSData *decryptPngData = [GuanEncryptionManger aesEncryptData:encryptPngData keyString:keyString iv:nil];
//    NSLog(@"decryptPngData解密: %lu", decryptPngData.length);
//
//    self.testImageView.image = [UIImage imageWithData:decryptPngData];
    
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"new_encrypt" ofType:@"zip"];
    NSData *pngData = [NSData dataWithContentsOfFile:path];
    NSData *decryptPngData = [GuanEncryptionManger aesDecryptData:pngData keyString:keyString iv:nil];
    NSLog(@"decryptPngData解密: %lu", decryptPngData.length);
    
    // 转存到另外路径下
    NSString *directoryName =[GTFileTools createFilePathForRootPath:[GTFileTools gt_DocumentPath] directoryName:@"zip"];
    NSLog(@"directory name %@",directoryName);
    
    
    // 压缩后的路径
    NSString *afterZipPath = [directoryName stringByAppendingPathComponent:@"tong666.rbt"];
    // 写入文件
    NSError *error = nil;
    
    BOOL isWrite = [decryptPngData writeToFile:afterZipPath options:NSDataWritingAtomic error:&error];
    if(isWrite && !error) {
        NSError *error;
        ZZArchive *archive = [ZZArchive archiveWithURL:[NSURL fileURLWithPath:afterZipPath] error:&error];
        if(error) {
            NSLog(@"ZZArchive archiveWithURL error %@", error);
            return;
        }
        
        for (ZZArchiveEntry *entry in archive.entries) {
            NSLog(@"entry %@",entry.fileName);
            NSError *dataError;
            
            NSData *data = [entry newDataWithError:&dataError];
            if([entry.fileName isEqualToString:@"new/Assets/xtopbar_bg@3x.png"] && !dataError) {
                self.testImageView.image = [UIImage imageWithData:data];
            }
        }
    }
}


- (void)searchFunction {
    
    NSArray *array = [[NSArray alloc]initWithObjects:@"OTHERS\nSCB",@"MHCB",@"UOB",@"OTHERS", nil];
    NSString *string = @"scb";
    // SCBT,OTHERS SCB
    // 谓词搜索
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",string];
    NSArray *arrays =  [[NSArray alloc] initWithArray:[array filteredArrayUsingPredicate:predicate]];
    NSLog(@"=-- %@",arrays);
    
    NSNumber *number;
    [number integerValue];
}

- (void)stringToArray {
    
    NSString *inputString = @"168168";
    NSMutableArray <NSString *> *characters = @[].mutableCopy;
    [inputString enumerateSubstringsInRange:NSMakeRange(0, inputString.length)
                                    options:NSStringEnumerationByComposedCharacterSequences
                                 usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                                             [characters addObject:substring];
                                         }];
    NSLog(@"%@", characters);
}

- (void)testCSSParse {

}


- (void)testXMLReader {

    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"weui_color" ofType:@"xml"];
    NSError *error = nil;
    NSString *xmlString = [NSString stringWithContentsOfFile:xmlPath encoding:NSUTF8StringEncoding error:&error];
    if(!xmlString || error) {
        NSLog(@"load xml error %@",xmlString);
        return;
    }
    
    NSDictionary *xmlDict = [TongXMLReader dictionaryForXMLString:xmlString error:error];
    if(error) {
        NSLog(@"xml dict error %@",error);
        return;
    }
    
    NSLog(@"xml dict error %@",xmlDict);

}



- (void)testTongTheme {
    
    
    NSString *dayJsonPath = [[NSBundle mainBundle] pathForResource:@"tong_day" ofType:@"json"];
    NSString *nightJsonPath = [[NSBundle mainBundle] pathForResource:@"tong_night" ofType:@"json"];
    
    NSString *dayJson = [NSString stringWithContentsOfFile:dayJsonPath encoding:NSUTF8StringEncoding error:nil];
    NSString *nightJson = [NSString stringWithContentsOfFile:nightJsonPath encoding:NSUTF8StringEncoding error:nil];
      
    
    [TongTheme addThemeConfigWithJson:dayJson Tag:@"tong_day" ResourcesPath:nil];
    [TongTheme addThemeConfigWithJson:nightJson Tag:@"tong_night" ResourcesPath:nil];
    
    [TongTheme startTheme:@"tong_day"];
    
    [TongTheme removeThemeConfigWithTag:@"test0"];
    [TongTheme removeThemeConfigWithTag:@"test1"];
    
    

    
    
    NSArray *allTags = [TongTheme allThemeTag];
    NSLog(@"all tags %@",allTags);


    
    id value = [TongTheme getValueWithTag:@"tong_day" Identifier:@"test_image"];
    NSLog(@"getValueWithTag %@",value);

    
//    self.view.Tong_theme
//        .TongAddBackgroundColor(THEME_DAY, UIColor.redColor)
//        .TongAddBackgroundColor(THEME_NIGHT, UIColor.greenColor);
    
    
    self.testImageView.Tong_theme.TongConfigImage(@"test_image");
    
    // 自定义设置，如果有标识符对应的值则设置，否则不设置
    self.testImageView.Tong_theme.TongCustomConfig(@"test_image", ^(id  _Nonnull item, id  _Nonnull value) {
        NSLog(@"ssss %@ %@",item, value);
        self.testImageView.image = value;

    });
       
        
    
    
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self changeTheme];
    
//    [self testMengSettingController];
    
//    UIImage *testImage = [GTUtilies keyWindow].screenshot;
//    NSData *testData = UIImagePNGRepresentation(testImage);
//    NSLog(@"before data len %f KB",testData.length / 1024.0);
//    UIImage *compressImage = [UIImage lbm_compressWithImage:testData specifySize:2.0];
//    NSData *compressData = UIImagePNGRepresentation(compressImage);
//    NSLog(@"after data size %ld mb",compressData.length);

//    self.testImageView.image = testImage;
//    UIImageWriteToSavedPhotosAlbum(testImage, nil, NULL, NULL);
    
    
//    NSDictionary *tapDict = [self guan_tapDict];
//    NSLog(@"tap Dict %@",tapDict);
//    
//}


- (void)testMengSettingController {
    
    MengSettingController *settings = [[MengSettingController alloc] init];
    settings.modalPresentationStyle = UIModalPresentationFullScreen;
    [[GTUtilies currentViewController] presentViewController:settings animated:YES completion:nil];
    
    id res =  [self.view valueForKey:@""];
}


- (void)changeTheme{
    
    // 覆盖截图
    
    UIView *tempView = [[UIApplication sharedApplication].delegate.window snapshotViewAfterScreenUpdates:NO];

    [[UIApplication sharedApplication].delegate.window addSubview:tempView];

    // 切换主题

    if ([[TongTheme currentThemeTag] isEqualToString:@"tong_day"]) {

        [TongTheme startTheme:@"tong_night"];

    } else {

        [TongTheme startTheme:@"tong_day"];
    }

    // 增加动画 移除覆盖

    [UIView animateWithDuration:1.0f animations:^{

        tempView.alpha = 0.0f;

    } completion:^(BOOL finished) {

        [tempView removeFromSuperview];
    }];
    
}



- (void)testToast {
    
    
    NSString *toastStr = [NSString stringWithFormat:@"超跑助手[%@]",@" 实时，距您1.1km，全程9.2km，从浙江省杭州市拱墅区环西新村12幢到上城区钱江新城浙商银行(杭州分行营业部)"];
    [self.view makeToast:toastStr
                duration:2.0
                position:CSToastPositionCenter];
}


- (void)testGetSubString {
    
    // 实时，距您1.1km，全程9.2km，从浙江省杭州市拱墅区环西新村12幢到上城区钱江新城浙商银行(杭州分行营业部)
    // 实时，红包20元，距您600m，全程4.7km，从浙江省科协大楼(西1门)到华门·自由21公寓A座;
    //  预约: 全程1.9km，明天 07:30从南肖埠文景苑到杭州市红会医院;
    //  预约: 全程800m，明天 07:30从南肖埠文景苑到杭州市红会医院;
    // 预约: 红包20元，全程8.7km，明天 04:50从ME酒店(杭州西湖黄龙体育中心店)西北侧到莲花滩观鸟区;
    
    // 上海 实时，距您2.8km，起点是OMEGA (上海和平饭店店);


    NSString *resultString = @"实时，红包20元，距您600m，全程4.7km，从浙江省科协大楼(西1门)到华门·自由21公寓A座;";
    
    // 截取字符串
    NSArray *oneArray = [resultString componentsSeparatedByString:@"，"];
    if(oneArray.count >= 2) {
        NSLog(@"oneArray %@",oneArray);
        NSString *distanceForMe;
        NSString *keyWord;
        if([resultString containsString:@"全程"]) {
            keyWord = @"全程";
        } else if([resultString containsString:@"距您"]) {
            keyWord = @"距您";
        }
        
        for (NSString *subStr in oneArray) {
            if([subStr containsString:keyWord]) {
                distanceForMe = subStr;
                break;
            }
        }
        
        NSRange youRange;
        if([keyWord isEqualToString:@"全程"]) {
            youRange = [distanceForMe rangeOfString:@"程"];
        } else {
            youRange = [distanceForMe rangeOfString:@"您"];
        }
        NSString *lastUnit;
        if([distanceForMe containsString:@"km"]) {
            lastUnit = @"k";
        } else if([distanceForMe containsString:@"m"]) {
            lastUnit = @"m";
        }
        
        if(!lastUnit) {
            return;
        }
        
        NSRange kRange = [distanceForMe rangeOfString:lastUnit];
        NSLog(@"krange %@",NSStringFromRange(kRange));
        
        NSRange resRange = NSMakeRange(youRange.location+1, kRange.location - youRange.location-1);
        if(resRange.length > distanceForMe.length) {
            
            return;
        }
        NSString *resStr = [distanceForMe substringWithRange:resRange];
        float resNumber = [resStr floatValue];
        if([lastUnit isEqualToString:@"m"]) {
            resNumber = resNumber / 1000.0;
        }
        NSLog(@"resStr %@ %f",resStr,resNumber);
        
    }

}


- (void)jumpJCCSetting {
    
    
    void (^blockTest)(BOOL arg1, NSString *arg2) = ^(BOOL arg1, NSString *arg2) {
        NSLog(@"TaoLi block Test");
    };
    
    
    
    blockTest(NO, @"it is test arg2");
    
    JCCSettingsController *settings = [[JCCSettingsController alloc] init];
    settings.modalPresentationStyle = UIModalPresentationFullScreen;
    [[GTUtilies currentViewController] presentViewController:settings animated:YES completion:nil];
}

- (void)testIAP {
    
    /*
    typedef NS_ENUM(NSInteger, SKPaymentTransactionState) {
        SKPaymentTransactionStatePurchasing,    // Transaction is being added to the server queue.
        SKPaymentTransactionStatePurchased,     // Transaction is in queue, user has been charged.  Client should complete the transaction.
        SKPaymentTransactionStateFailed,        // Transaction was cancelled or failed before being added to the server queue.
        SKPaymentTransactionStateRestored,      // Transaction was restored from user's purchase history.  Client should complete the transaction.
        SKPaymentTransactionStateDeferred API_AVAILABLE(ios(8.0), macos(10.10), watchos(6.2)),   // The transaction is in the queue, but its final status is pending external action.
    } API_AVAILABLE(ios(3.0), macos(10.7), watchos(6.2));
     */

    
    if(_transaction.transactionState != SKPaymentTransactionStatePurchased) {
        // 付款失败
        return;
    }
    
}


- (void)testClearTool {

    
    [GTFileTools gt_deleteFiles:[GTFileTools gt_DocumentPath]];
    
    // 清除偏好设置的缓存
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
    });
        

}


- (void)testATTrackManager {
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            
            NSLog(@"requestTrackingAuthorizationWithCompletionHandler %lu",(unsigned long)status);
        }];
    } else {
        // Fallback on earlier versions
    }
}


- (void)showAlert {
    
    __block UIViewController *keyController = [GTUtilies keyWindow].rootViewController;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"子账号登录" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       
        NSLog(@"0000");
        textField.placeholder = @"请输入子账号";
        
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       
        NSLog(@"111");
        textField.placeholder = @"请输入密码";
        textField.secureTextEntry = YES;

    }];
    
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"alertController cancel");
        [alertController dismissViewControllerAnimated:YES completion:nil];
        [[GTUtilies keyWindow] setRootViewController:keyController];
        [[GTUtilies keyWindow] makeKeyAndVisible];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"alertController sure");
        NSArray<UITextField *> *array = alertController.textFields;
        for (int i = 0; i < array.count; i++) {
            // 0 = account
            // 1 = password
            UITextField *textField = array[i];
            NSLog(@"the %d index textField text %@",i,textField.text);
        }
        
        
        
        [[GTUtilies keyWindow] setRootViewController:keyController];
        [[GTUtilies keyWindow] makeKeyAndVisible];

    }];
    

    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    

    UIViewController *tempController = [[UIViewController alloc] init];
    tempController.view.backgroundColor = [UIColor whiteColor];
    
    [[GTUtilies keyWindow] setRootViewController:tempController];
    [[GTUtilies keyWindow] makeKeyAndVisible];
    
    [tempController presentViewController:alertController animated:YES completion:nil];

    
    
    NSArray *windowArray = [UIApplication sharedApplication].windows;
    for (int i = 0; i < windowArray.count; i++) {
        NSLog(@"TaoLi window %@",windowArray);
    }
    
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setTitle:@"关闭1" forState:UIControlStateNormal];
    closeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    closeButton.titleLabel.textColor = UIColor.whiteColor;
    closeButton.backgroundColor = [UIColor colorWithRed:39/256.0 green:193/256.0 blue:255/256.0 alpha:1];
    [closeButton addTarget:self action:@selector(wang_closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    CGRect screenBounds = UIScreen.mainScreen.bounds;
    CGFloat closeButtonWidth = screenBounds.size.width / 4;
    
    closeButton.frame = CGRectMake(0, screenBounds.size.height - 60, closeButtonWidth, 60);
    
    
    
}


- (void)wang_closeButtonAction {
    
}

- (void)testVideoToAudio {
    
    
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
    NSString *audioPath = [[GTFileTools gt_DocumentPath] stringByAppendingPathComponent:@"test000.wav"];
    NSLog(@"guan audio path %@",audioPath);
    [GTUtilies convertVideoPath:videoPath toAudioPath:audioPath completion:^{
        NSLog(@"convert end 333");
    }];
}


- (void)testGTClassDump {
    
//    GTClassModel *ortho = [GTClassModel modelWithClass:[GuanRSAMgr class]];
//    NSString *GuanRSAMgrHeader = [ortho linesWithComments:NO synthesizeStrip:YES];
//    NSLog(@"augus %@",GuanRSAMgrHeader);
//
//    BOOL isWrite = [GTUtilies parseClassHeaderWithName:@"GuanRSAMgr" fileDataString:GuanRSAMgrHeader];
//    NSLog(@"write %@",@(isWrite));
    
    [GTUtilies serviceHeaderName:@"GuanEncryptionManger"];
}


/*
 
 // 大麦网创建订单api
 /gw/mtop.trade.order.create/4.0
 
 {"exParams":"{\n  \"novacv\" : \"4.0\",\n  \"novab\" : \"mtop.trade.order.build\",\n  \"channel\" : \"damai_app\",\n  \"novaav\" : \"5.0\",\n  \"coupon\" : \"true\",\n  \"novac\" : \"mtop.trade.order.create\",\n  \"umpChannel\" : \"10001\",\n  \"novaa\" : \"mtop.trade.order.adjust\",\n  \"coVersion\" : \"2.0\",\n  \"novabv\" : \"4.0\",\n  \"atomSplit\" : \"1\",\n  \"novad\" : \"mtop.damai.cn\"\n}","feature":"{\n  \"gzip\" : \"true\"\n}","buyNow":"true","params":"H4sIAAAAAAAAE+17abPj1nXgd\/0KpUufwp5+2BdXzQeCAEkQXEECXEz7FZYLAiA2YuEmd5XslD2TiWXNIsdxbCflqiR2yolkj2dkWfLyZ\/o9q\/\/FgADJx+316yfZnvkw3SpW855zzz337Odc6u033nzziWN5U2UCnrz5pTffTr+nK5E18ZQ4CbO1JwgKYRSK4wSOETgAKEYpqE5ThkqTJEYo8JOn+S7Nd13fuyOzIZSorhW3lVBxo4zWV7\/61lsjXEFwmEIJWqN1kgA6SsGQitCEBqGEhlMo9LW\/UBzrmWZanvJMV1zF+pqXOM7dx9tvXb\/1vIpFfHH3pykPEYQME2ZAO50GrQ8ZqTzoL8naalCwzZYL4VRFn9cIqdwr1UR+ia\/9ZtCbLksGL46vOgaTQOOrcsv2ytxgfOX7yRRnrR7TcCcQBgpMu+riIRHNVRefVeOw3vcq6iLGG4SBheuwvoo7xDw0BKephh1XCQeaJ5OrriP3+uWZJ0c1SXYhuMc1hRFS73q2HvCCF+uIbJcA4gzEFd9TqUWj7hA4PGrJLl0A66VhUvPysjJIxGJ\/OnG1ycwgo5Yo67VwfBWEVdccLuv9BVbHYg30G2Sf6dY8o6JUfUvuROGc5KjBAF6SqDmFYpOj\/OVUphox5gDWa6PjKwohx1ebv7G++QSNeVxamGvForDeYGqPryqALRlsRDWL1tCH6qKgCHapoM7qIswL05k60eSgj63jQrOMjiJGYYSaAOCVQHtTrxx0x1c4uyDmStWEhTI08rGEXY3Yfhi2GuMrVE6sSjIqz6NEYNL7DJoChPGRU572Y5WJYoNbQGunoFk4RpEKTugNUQ4r1NCj9IHfgkBfYXQ2pimvo6XEJibbJWYjsbWoD2rD6oDHqjYTVURHZkbCmpMkbm2LBoy01YLXDKZTB1Hn7RFrpRfve8GUj2RlANWF+kRYBjFTHZh20ibV6ZpUowlVYKZYaViocViH6eqjkGeKaFKgFDcGFup41RWHThHKMOwJYkTGhOhY46tScx5KPVv1G\/UoNEpuPRQshquxHUcPO+2WEcToEu1HVj0sd5jWEGcxzpQCmC0siCHRGUY1ujKpawzStqxFgsx6oS0oQTlaCiNR53mG4szucGN+2ETqGI4iMx1Y9+ZYbbFENXhNxLRcLqXyt91B3BoVZ1UpnAXTEtFdGUFntRyZ3eYs0MD4ar7iPbzFKRDGooV2YzjsWlJUKbYqFY0penNO4xuGs2xNWKzFkEKZaeh9tTodzCBpNIXNpCgKbjzzeBUbub6EaJYCd3gx8aFhXIkkayR7ZpGbr6iEGcn1UQ3BV\/SkkQBNHqGj7qSFi5C9MkstsaRQKNNrN9WWJMzkLoy0ojLSZGdSZBE+mI4qHj23YwUuV8s9DV\/ENsdCQAdxiI9K9CBRtNm0ozWhotqLF\/M6NuPqM4TDG6CkNQsdfjKYTRtON0DLLUFbduokSOjCvN7yEGuw7DklidPIsA5VGnFgme5g2pboYYdwm3JFaztST4SaPF4YcuuaYQttR7EndKWLt6BiGNdMVIy5UsFBSG7VDFjBwcZX7GRU4MKYRlG9tEQ01iE9robCkVBwEpiza9Siw\/SFdlCmJkKzg4CuUgnsDrWMUL5YsX2WgbQ+NpHdYs0YDgIgetFIkEUqgPtVjyi1Gu1KjBn20DB8t+AWinOvugA2mh48KE+LlaYv2EF\/uhoiMxhJijrZbrbMZQKNWubIFEpqYbAYX0WhUmqMMCOWZXwa4o2gojcka+5NRHgkwnp\/0K1PhmVCs9aDKOE6fs+ts0xlVlVgX4WGTqEumHMtEJya3IcMVRz11ozGs5xdLHHjqxpeZOX1vKRzDW\/YlOg1B5DqhGwFg6ADR6DDDJki3MPaCgfKc58uGnS7wUo10V\/Nx1eLgtV07HBKlCaiX6AaBYu1QlJM6rQvL9dmr8lAPU9fl8QZ12e5usqB5cIP9QlPDK1Cv9xarnrtVnm2LPsJ1bPNwdQkxlfDqqEvhvR6QbF2GvHNQlzsK0God+FRt4\/xkxIqsMC21bWkWo1Ve1ahqrprBQUqWMhridYcLJT95fiK7480Su0hHdNp41YEgw4WNCZ2EhlSbzSP+dEMaXVghSzNjXqvsObqoj5b6v1Kd0KuLcA5USW2mh1RXsO9ctfpNpqaia8op10mm7Um4ydyXC1r4bpI2zLUtvukMqiqvc7EhtaLWDAEeFpzwQKK9Olq1O2hpl9bpMEPZmaxDyczMKgzbthbh1264tc6ciSXtApfoStperNLqKNrMwdjyjycBsUSZIR1YlaLBsspoa\/jRBSCIVvuAhKJfJtb9qPxlbfCm3ODq8YTQKrGJkMUw4YcF2p1TEeSnh01eiEmtIazFTZZB1WUlVY1YuJ0zTTnp2eua3IXmQnq+Epv0YP1cjZTIms5nQMGI32GGDTMqhtPukDuxyW1hoVcqyxQtsSxmpOakN4tM7Uotto4KZlVO9SlKKi6MFGcWDOHacqchs57jlYQ\/FVdMqdmQyrN+sPBEBusxlfcou8v2\/68CmneouBitEm4\/MokJbwTN9M9AiVPKLxeXhI11JrY8mhoamQdIWdluL+A2yylC+icKEcAdBG6TEJkuSp1vRFa4Hh+ZpGLRBSxutmGbHvWMqAFjHWAl1YPtSoxBeyoT\/NOv2u5CVBagR2qodTEdLJf7NBFE2n1VhM1SQuM9ahhiPJUl1SlmZRq\/UE1QlG7I9ptVpiGCY9CfceYezPaSNLs2GhVBZSt1CUEkWmlOkzFu1AlXW+Pr5JyUuunKbDmkLChUnEUkg1yachr3MdXDYyqcRIrExjZI+URV0BqAo3DmIFKqlFbBZUR34JSZSkmPvRnhZE\/W5F4MkOTyBX1+TpUcZIT1gKfEKsW100NsI\/Uyw2msUxzkQ282C+hiuBVpErTrkE2Lnh0h+wUlRIYDuFu3Z65fYJJTJyvOEORBrYEsTBdbC9MMGfK9ZWT6DBaYtJUVqml9uYvkHbdEWMolsprXWNFopoMuDZXq3Raw0aBHq1gkfDmUyllGEabmmebtLFEMV8NxFoDjDCJT0u4ortcdZjU8y2EWEVA5XgDhyPTgteipNuVerUWV7FEnvs+D02toU1hLWQw01M0rC1hFdakFnVCoRk+aAa2lAZVfNaZ18h5LSDrRlNnYDIOF47HC1yhJHsDuRZWV8XEX4RLKg3BPRPQ6HwmT5bUCEL7ZnXKOqtwAVc0YXwli8UhS68lwa9zQYFRHLhvDIDWMKAVmLebac035PEiWh1fhe2mW+7zvOCOqhNZGV8Zehmv02hDRDd0FmpXNLBOLIi0ZqoNoBW0kTOaAV+czyYDuTMEmNrv1y09rcEGvgQKohoVarNq0aLGVzOpA9F0v2ADzUiLvDnB16lludMqFWvzZdxeYnOzNeyMr8yV6qf7ObjjM\/Nhsz0awRNqVGwpNRVnmIBVATUpRjyzNNojslZsdHBQ1NKERqprT5b7MMaXOSJpU0WoQ43i2lBKq\/T\/uG0V8mYhCEGUdwVxmIA70Dwt\/nUlBidtA07QStqJ0DSp6TCCApTCIVo1aAihNZ2GofOmgO+L0jBUG4xYpon6nC+t67pdx6MlpBYTqON6qmDw0oDoSstpFzKVvt3jh3O\/Op2RJiQMJExN\/LT8DRRusU4tFODAAzOiWY3n7Q62MEJ7lUwk2EbWIYvzaKOCRWSabRK0hvUmYXFV1SBrpjYQmWRnqrowRxgtlESBbptc1Zk3RR+QfHOwKusD1tMCl2RNbT6nqSm6njnuvIkKvWllRpMTZbJud6hhh0QK5aXF1KPyauVpSL\/cgFb6imR684YmyO0SlsaFhhWmRa0WpE0MBM+rZg+k2tZr3bDRnSgGSuJ0MidhQjM8isMlb74QsdV0fFVI0uquMFgVEmvoLmdhkV8v5iaENLuoXetWJ3Ws4etRu54eIDBpeesnRmNIlKROax0vmuOrulfCzIWIsrBXKGAal5ZQnaocdRVKrWMsh7IlrcwW8BZPFFxyKC2ooLHyOL02EzrhCBdAPHVCsOJEJ\/Bdu9eNJoi7mI3Kaw1VR4Ekyo145E0Lnthfra2ZCM94vwzB3ZHX13HHS62ULaxT056ikI81uS5Uymwts6fn6efzjWk9SU1KOehxdVe2wAKE1ygKIRh+oW29YJohMLJVTVUwoFJ3AMMCjh4dEkkXwTJQPL1nBdmem2\/+9OVf\/fSzn3zj9jfvv\/jkk\/3eFFGJUoX2lHAC8kN3vPWs2AE7Bg\/w1WSVAv1YcZqJm+2AD8F+yjxrRYGjrLpbOAIdIlh6bxWA3LWwp9RT\/Cn8lHxKHKLMMwbqVpRx9OU94M2DCx7QOmMih0VSBPRzOR5tZUGkZSifffKzF5\/+9rMPv36Ol+YaK141\/QzvFGwqkckfo8AI9JcHfxCUOt2U34\/PmYNhCIIAqhmaiuk6raG0gsCahqskAIhu0BSJIjSuozRNGee3iFJZK6qzvaihONEZTn5aU3FzQd3+6Du3H\/3gFMlVoinQH77Jwa7n+39\/5UB3EXCAFgP9zji2sOd7e7VyZk9M60msTI4M8ACyU7KnxNYcvLUZw7ylu\/MTtF3sPvEEN5qcmlHqD794+cN3Xr7z17d\/86\/wi9++e+cZFy8VgglYnhGBLyPfueMR9qFg7vbthPPGgYhSCZR8L1a0uG36Xu6DOPm4IAHTKKYg9ANBwlFU4ORW8dd\/c\/vDT27e+9WhH6ZOrAHTd\/RUypmTfPirmx\/\/7OZb3\/\/s6+\/\/4ZefpuK6uM152HE1X881WqCIU1NUQpDFyicvPv73mx\/89uaffvLy+986Mrynr0UYRx6g\/PJfvn\/78YefhzL6AOXb3\/3y5fd++jkoPyyN935+++vfPeyGqS8k28BIEjBEkRREHYXhnTnynp6b9hPolZ6aGuB+GczTMHFqS75XtjwrMh\/Q\/M7LLS9I4tPL7h39IvSSCb\/yukdYzx+UmRUDt+RY2vQ1r+AHwGv7QRL0LU\/3F\/de5gG8V1zLD2LL9y7CUqgHgF5y\/AgwSRznw+88GpygPn96SleL7qNpAmti5oEFekY8TMkDy1gEqQ2Fou\/vCojD6FVM7beUGng3s7cDMTCOr02vH4V8vci+XIebo85YCfYl+4V7BYfkOS8OrW0J8uW3x5mPjZ98aXwUccZPno4z18wgaZwaP3n+9Bw5DyKnyDhyGTsPDGfY6GXs3NlPsTNOvnKmmtcx9jMHj2IlTnJBmJaeZv9L6fhQQxeSsm55imtpy7dQGCbStKzl6FEmcgSCaQj7XDn6VdnmEVn6q18ej7tfKbz1qGSdx5MH0vQmXlzrAEAQhiGqQiGkjuIoQUMaUGEIJ3FYM4zHpW2UgAyMMO4AW62c1vYx8KI0MjSU4NTeM662pSWJUBSMExiKk9CRvzzRlDDeIp1AItMPAsubtEJ9X6KeoKjWurRLWSdvZceImbIvV+BPommypY4jCJyKDcbTJIOfELAcR5kc8LEHPj8z5e1JD+rjYkV0Rm2fplJpXrB5dROP8joUuEG8yuLTk5MijgVOWq2Gq6Kub6YNeS9FP84gMJRAMPUervdyUvIT8lbv29978cm\/bT8\/\/sbLd\/7+5lf\/cPPtT25\/\/vHLH3\/y8rv\/6fbTn97+z1\/efPDRzQ\/+HU6d6faffwPfvPvdm2\/+1UYFR\/Vf5vGvKCK252atYl5Gvv\/RZ\/\/rJzc\/\/PnNj945o3SH9of3\/\/dnH\/7oECENGpuHX7DvUW5+\/t7t333nIsrRcS8+\/ei0oc2Z2rVXKEqTGA6\/urrB6Aeqmy3R\/18e\/BHKgxO\/uCfZ52p5\/ZT\/R8mHd0nvhMkH8h6U5j19u2NrKtvMd7mx49JY6eSNHfW4gECgqoIA9bUbu5ff+OAPH\/zicV3dds8r2wHqAYf587YDf\/LiJ1PYq40AoVIjOOb0i5U7x2r4v1vr6G5bWW0mZpnREo8cWaokjSAa+lAWc5y7eWUa2P\/29v0PX3z6d7d\/++ub37x3ZMHKaqOA1xkQ3g0BL87GUkrt0Hf9TRwtun7i5bcgIRqCLuBuBLDLK6fgfRdfrPPt4vC600g\/z5CUyLRAmBVX2yEb8Dbzu1IOODtzx9x+UJnK5PbbX\/\/sv\/zi5r997+Y\/f+v2h\/94NhPUtsHejOMg+tLm9XSyeJYaoqZ7zzTfHV\/FRjS+6jGwP7Oe+YtJmxQwuzsqzwYDxTXlgfIfCCz971ngTU5pe\/spYqaamw9+9LpDjgfGsZ9fEWdTnr0i+lypWux9URW8vjivQy3Qu\/GQAU27GwXTwUCVqNcT583vPnjx+x8\/PNbR\/NAD4X7orfppZndfGagJ\/IFA\/dipRz44ujdUXwZ\/4Vh9F5C3cejB6fA2SNxXlOdVR0kJ9bzSOJ6v3vOkEodK3fKmF+PJk9gKeM84eyZI13fl6stvvvvyna+fx7P9LO7cotN+Zuv4N7\/\/2ct3\/vurq9iDGd29Mfli6iJTgeVcmEDRj2bvZxXRneTOAz2NY4DC9WOhpw5kWKGbedw1\/LjMQaEwpZPKF2mIE3crouPe0vYtj39kz5htvL4Gy+u88ry+zva\/PX7SkjmxyxWvRY695poyV2+1uWxeIzXa2QCHbVxzg55YvC72eiLPSD2um8HfHo\/Hqbl5ipPXyb0wrc54fbP6pc0HAqMAgRQAExSNURCN0zgBoxQGAVxBiA3G081H+Dk3P8+YOwqAbUeJDT90M\/Y2WtnxX2o1e8VS77pZbOR327dp+YjKVDwPOBkkGwZcK0GQQTx\/rqjzDIA9g7bzLBmEG41lq8h2VUZ7yrJsLbPFMj\/IFlMJ3i\/WDWntmPQBp+1qq8ml39h802ZyliO0W93eNcvV+VRtw+siy4pcd6OPzQwuL9+zDV+wl85O27ejKcV9M5pJYNvOXhBl1i5n6weN92ZGmJJLA343cKw4B+8u1ONLAtdjpCEnpoDNUPP4ZTLHPnvPy7bnT6Eb9vZfNuVGtmX\/LrrFPKKXr+2fINO1LChmi5tsny5s7Cf9Hqf5BcTM5uk4E8T4cc+e2UEHNDaPmTux3X70g808NBdDl6tzpV5qLHvd9ovDFBPZqr047A0zC9ooOiszMjJZmZHb5VF1kAGPnON4GJtXGLkYtK0t\/xHKhK1cj0Xo7e6c1wq5newqoc0Vn2ecJcGWj73nblxEyV0Ev8dFzk0tRUrcoHTg0ht9wXfunK25sR88S5OiDp75G4k9UxPL0e8c8zKSFoK0Jbrj7TKWottJFO+x9DusLLg807yj6NBr9Yr1Msed6HNfVErBZEM8A8soy4upnaR2cxzaA2UC9sUVW2wU+deYOMKX25p7S5jDdPh5R4tcHIeWmsQgqmb5MB+ZsG5xv55ve72a5m7XLp1dSEhZnE7zCQxQcpdPCBQjcRSGMUAaeC7w8OKmVyShVAf3Sfb8Po8obw7kqLtgT+f+Tv+iTC+M6HWgYAh8z2BnE5nyuQ7xyLkOZFCQ\/lCLfDfXufnJ\/7j5r+8+bq5zvufu3fRu5PrKsQ\/xQDfx\/8gr8Nlttnf6E0yGsh\/W\/HkHQ2d63GAdA198\/O7Nex++\/O7vX3zyHRj6XDOkp+erb8NPYej55xkvnb4LvWLi9MbuR3ObfKuEmrm6E1KqmTDRdv932N679srYxcHDr8cc3eHe\/cDt6Nnpsi9fgh8NcS8hHP18540TiaVofNp67zje\/\/uM3Q1k01jmfepxc+j2sqIouoOjlw7atW59ZbU773Tp7Nj7G+Wnl9B6VpDDqcvwk0ewizhlsJUWdBneUDZPjeCQFA7fx85GLkeYyCXJ5D812wnl4NuZPF79q8jTX3SeHZUVNdeQRhpAwTEU6JAOpxUvjtMwRKoargEChvWTU1\/vhfn8Wjt5gdj09Vb+SvTYs4+JZM8z+eUfpPP0PiI5Jw8SuIa+dvyT0QuslPIi6mFmLug8q7y6WULeKf506Uz7TbBIS8nY1\/zc48kTP8z35qALLng+Ajmi3vODZlqlGpambCS04+rS8vGxlyPIBbu8ZOEXHedVIeJSjLsYcQ8QX9Puj2\/lzX1LA\/uLHXw9RtxX9zvU44UT5LxZ2qMefD1GfB37ONrwutX4BVtMuWBBnOaRi++fJHr0\/nlqNseb85cZ6p5T7r36BaIb4F2gI\/CLctzBLhz3GHN+wBXyeLovYL5yVyK88fz\/AKWfqk1BPgAA","buyParam":"728815643570_1_5221536150255"}
 */


- (void)setupButtons {
    NSArray *buttonTitles = @[@"MD5",@"AES",@"DES",@"RSA",@"SHA512",@"Hmac"];
    CGFloat y = 200.0;
    CGFloat width = 70.0;
    NSInteger lineOfCount = 4;
    CGFloat padding = (self.view.frame.size.width - lineOfCount * width) / 5;
    for (int i = 0; i < buttonTitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        [button setBackgroundColor:[self randomColor]];
        CGFloat x = 0;
        if(i < lineOfCount) {
            x = padding * (i + 1) + i * width;
        } else {
            y = 300;
            x = padding * (i - lineOfCount + 1) + (i - lineOfCount) * width;
        }
        
        button.frame = CGRectMake(x, y, width, width);
        button.tag = kAugusButtonTagOffset + i;
        [button addTarget:self action:@selector(encryptionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
    }
}


- (void)encryptionButtonAction:(UIButton *)sender {
    
    switch (sender.tag) {
        case 10000:{
            NSLog(@"%@",sender.titleLabel.text);
            [self augusMD5];
            
            [self jumpJCCSetting];
//            [self testToast];
//            gtgtgtgtgt(self);
//            [self testWebLoadURL];
//            [self testProxyWKController];
//            [self startSimulatedClicking];
            break;
        }
        case 10001:{
            NSLog(@"%@",sender.titleLabel.text);
//            [self augusAES];
//            [self queryCodeStatus];
//            [self testWebLoadURL];
            [self stopSimulatedClicking];
            break;
        }
        case 10002:{
            NSLog(@"%@",sender.titleLabel.text);
            [self augusDES];
            [self testATTrackManager];
            break;
        }
        case 10003:{
            NSLog(@"%@",sender.titleLabel.text);
            [self augusRSA];
            break;
        }
        case 10004:{
            NSLog(@"%@",sender.titleLabel.text);
            [self augusSHA512];
            break;
        }
        case 10005:{
            NSLog(@"%@",sender.titleLabel.text);
            [self augusHmac];
            break;
        }
        default:
            NSLog(@"unknown methods");
            break;
    }
}


#pragma mark - Private Methos

- (void)augusMD5 {
    
    NSString *test = @"augus123";
    NSString *res = [GuanEncryptionManger md5FromString:test];
    NSLog(@"md5 before %@ and after %@",test,res);
}

- (void)augusAES {
    
    //iv向量
    NSString *iv = @"abcdefghijklmnop";
    //转化为data，在java中是一个byte类型
    NSData *ivData = [iv dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *keyString = @"abcdefghi1234567";
    
    //aes-cbc加密
    NSString *aesCbcE = [GuanEncryptionManger aesEncryptString:@"这个是AES-CBC加密" keyString:keyString iv:ivData];
    NSLog(@"aes-cbc加密: %@", aesCbcE);
    
    //aes-cbc解密
    NSString *aesCbcD = [GuanEncryptionManger aesDecryptString:aesCbcE keyString:keyString iv:ivData];
    NSLog(@"aes-cbc解密: %@", aesCbcD);
}


- (void)augusDES {
    
    
    NSString *keyString = @"abcdefghi1234567";
    
    //aes-ecb加密, iv直接传nil就行
    NSString *desEcbE = [GuanEncryptionManger desEncryptString:@"这个是DES-ECB加密" keyString:keyString iv:nil];
    NSLog(@"des-ecb加密: %@", desEcbE);
    
    //aes-ecb解密, iv直接传nil就行
    NSString *desEcbD = [GuanEncryptionManger desDecryptString:desEcbE keyString:keyString iv:nil];
    NSLog(@"des-ecb解密: %@", desEcbD);
}


- (void)augusRSA {
    
    
    NSString *pubkey = @"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDI2bvVLVYrb4B0raZgFP60VXY\ncvRmk9q56QiTmEm9HXlSPq1zyhyPQHGti5FokYJMzNcKm0bwL1q6ioJuD4EFI56D\na+70XdRz1CjQPQE3yXrXXVvOsmq9LsdxTFWsVBTehdCmrapKZVVx6PKl7myh0cfX\nQmyveT/eqyZK1gYjvQIDAQAB\n-----END PUBLIC KEY-----";
    NSString *privkey = @"-----BEGIN PRIVATE KEY-----\nMIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMMjZu9UtVitvgHS\ntpmAU/rRVdhy9GaT2rnpCJOYSb0deVI+rXPKHI9Aca2LkWiRgkzM1wqbRvAvWrqK\ngm4PgQUjnoNr7vRd1HPUKNA9ATfJetddW86yar0ux3FMVaxUFN6F0KatqkplVXHo\n8qXubKHRx9dCbK95P96rJkrWBiO9AgMBAAECgYBO1UKEdYg9pxMX0XSLVtiWf3Na\n2jX6Ksk2Sfp5BhDkIcAdhcy09nXLOZGzNqsrv30QYcCOPGTQK5FPwx0mMYVBRAdo\nOLYp7NzxW/File//169O3ZFpkZ7MF0I2oQcNGTpMCUpaY6xMmxqN22INgi8SHp3w\nVU+2bRMLDXEc/MOmAQJBAP+Sv6JdkrY+7WGuQN5O5PjsB15lOGcr4vcfz4vAQ/uy\nEGYZh6IO2Eu0lW6sw2x6uRg0c6hMiFEJcO89qlH/B10CQQDDdtGrzXWVG457vA27\nkpduDpM6BQWTX6wYV9zRlcYYMFHwAQkE0BTvIYde2il6DKGyzokgI6zQyhgtRJ1x\nL6fhAkB9NvvW4/uWeLw7CHHVuVersZBmqjb5LWJU62v3L2rfbT1lmIqAVr+YT9CK\n2fAhPPtkpYYo5d4/vd1sCY1iAQ4tAkEAm2yPrJzjMn2G/ry57rzRzKGqUChOFrGs\nlm7HF6CQtAs4HC+2jC0peDyg97th37rLmPLB9txnPl50ewpkZuwOAQJBAM/eJnFw\nF5QAcL4CYDbfBKocx82VX/pFXng50T7FODiWbbL4UnxICE0UBFInNNiWJxNEb6jL\n5xd0pcy9O2DOeso=\n-----END PRIVATE KEY-----";

    NSString *encrypted = [GuanEncryptionManger encryptString:@"hello world Augus!" publicKey:pubkey];
    NSLog(@"rsa encrypted: %@", encrypted);
    NSString *decrypted = [GuanEncryptionManger decryptString:encrypted privateKey:privkey];
    NSLog(@"rsa decrypted: %@", decrypted);
    
}

- (void)augusSHA512 {
    NSString *test = @"augus123";
    NSString *res = [GuanEncryptionManger sha512FromString:test];
    NSLog(@"sha512 before %@ and after %@",test,res);
    
    NSString *res2 = [GuanEncryptionManger shaUtf8:test type:@"SHA-512"];
    NSLog(@"other sha512 %@",res2);
}

- (void)augusHmac {
    NSString *test = @"augus123";
    NSString *key = @"tian";
    NSData *res = [GuanEncryptionManger hmacFromString:test keyString:key];
    NSLog(@"sha512 before %@ and after %@",test,res);
}



- (UIColor *)randomColor {
    
    return [UIColor colorWithRed:(CGFloat)random() / (CGFloat)RAND_MAX
                         green:(CGFloat)random() / (CGFloat)RAND_MAX
                          blue:(CGFloat)random() / (CGFloat)RAND_MAX
                         alpha:1.0f];
}


- (UIImageView *)testImageView {
    if(!_testImageView) {
        _testImageView = [[UIImageView alloc] init];
        _testImageView.frame = CGRectMake(0, 0, 100, 100);
        _testImageView.center = self.view.center;
        _testImageView.backgroundColor = UIColor.greenColor;
        [self.view addSubview:_testImageView];
    }
    return _testImageView;
}


- (UICollectionView *)gtCollectionView {
    if(!_gtCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(WW, 200);
        layout.minimumLineSpacing = 10;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _gtCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, [GuanUITool guan_navigationViewHeight], WW, 400) collectionViewLayout:layout];
    
        _gtCollectionView.backgroundColor = [UIColor clearColor];
        _gtCollectionView.pagingEnabled = YES;
        _gtCollectionView.showsHorizontalScrollIndicator = NO;
        _gtCollectionView.showsVerticalScrollIndicator = NO;
        
        [_gtCollectionView registerClass:[GTTestCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([GTTestCollectionCell class])];

        
        _gtCollectionView.dataSource = self;
    }
    return _gtCollectionView;
}

#pragma mark - gzip 压缩
- (NSData *)gzipCompress:(NSData *)data {
    if (!data || data.length == 0) {
        return nil;
    }
    
    z_stream strm;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    strm.total_out = 0;
    strm.next_in = (Bytef *)[data bytes];
    strm.avail_in = (uInt)[data length];
    
    // 初始化 zlib 流，31 = 15(最大窗口大小) + 16(启用 gzip 格式)
    if (deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED, 31, 8, Z_DEFAULT_STRATEGY) != Z_OK) {
        return nil;
    }
    
    // 准备输出缓冲区
    NSMutableData *compressed = [NSMutableData dataWithLength:16384];  // 16KB 初始大小
    
    // 压缩数据
    int status = Z_OK;
    while (status == Z_OK) {
        if (strm.total_out >= [compressed length]) {
            [compressed increaseLengthBy:16384];
        }
        
        strm.next_out = (Bytef *)[compressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)[compressed length] - (uInt)strm.total_out;
        
        status = deflate(&strm, Z_FINISH);
    }
    
    // 清理
    if (deflateEnd(&strm) != Z_OK) {
        return nil;
    }
    
    // 调整数据大小为实际压缩后的大小
    [compressed setLength:strm.total_out];
    return compressed;
}

@end
