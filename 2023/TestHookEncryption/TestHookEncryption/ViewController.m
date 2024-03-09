//
//  ViewController.m
//  TestHookEncryption
//
//  Created by Augus on 2023/7/14.
//

#import "ViewController.h"
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
    

static const NSInteger kAugusButtonTagOffset = 10000;

@interface ViewController ()<NSURLSessionDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (retain, nonatomic) SKPaymentTransaction *transaction;

@property (nonatomic, strong) UIImageView *testImageView;


@property (nonatomic, strong) UIAlertController *augusAlertController;


@property (nonatomic, copy) NSArray *pickerViewData;
@property(nonatomic, strong) UIView *firstPushView;
@property(nonatomic, strong) UIView *secondPushView;
@property(nonatomic, strong) UIView *themeView;



@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的";
    self.view.backgroundColor = UIColor.whiteColor;
    [self setupButtons];
        
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
    
    [self testCustomShowBigImage];
    
}


- (void)testCustomShowBigImage {
    
    UIImage *buttonImage = [UIImage imageNamed:@"gt_goods_list"];

    CGFloat padding = 5.0;
    CGFloat buttonWidth = (WW - 4 * padding) / 3.0;
    CGFloat buttonHeight = 40.0;
    GTCustomButton *button = [[GTCustomButton alloc] initWithTitle:@"就是爱你" image:buttonImage frame:CGRectZero];
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
    
    
    [self.view makeToast:@"野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置野马设置"];
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


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
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
    
}


- (void)testMengSettingController {
    
    MengSettingController *settings = [[MengSettingController alloc] init];
    settings.modalPresentationStyle = UIModalPresentationFullScreen;
    [[GTUtilies currentViewController] presentViewController:settings animated:YES completion:nil];
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



- (void)test_ssziparchive {
    
    
    // 获取文件路径
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"文件名"ofType:@"文件类型"];
    // 获取文件夹下的文件路径
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"文件名" ofType:@"文件类型" inDirectory:@"文件夹名"];

    
    
    NSString *directoryName =[GTFileTools createFilePathForRootPath:[GTFileTools gt_DocumentPath] directoryName:@"zip"];
    NSLog(@"directory name %@",directoryName);
    
    
    // 压缩后的路径
    NSString *afterZipPath = [directoryName stringByAppendingPathComponent:@"tong222.rbt"];
//    NSString *afterZipPath = @"/Users/augus/Desktop/testZip/tong.rbt";

    // 压缩前的文件夹
    // TODO: 只读/Library/Caches/
    // TODO: 写入只能是沙盒
    NSString *beforeDirectory = @"/Library/Caches/TestZip/Resources/";
//        NSString *beforeDirectory = @"/Users/augus/Desktop/testZip/Resources/";

    
    NSArray *fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:beforeDirectory error:nil];
    NSLog(@"fileList count %ld %@",fileList.count, fileList);
    if(fileList.count == 0) {
        return;
    }
    
//    BOOL isZip = [SSZipArchive createZipFileAtPath:afterZipPath withContentsOfDirectory:beforeDirectory];
    
    
    
//    BOOL isZip = [SSZipArchive createZipFileAtPath:afterZipPath withContentsOfDirectory:beforeDirectory keepParentDirectory:YES compressionLevel:8 password:nil AES:YES progressHandler:^(NSUInteger entryNumber, NSUInteger total) {
//
//    } keepSymlinks:YES];
    
    
    
    BOOL isZip = [SSZipArchive createZipFileAtPath:afterZipPath withContentsOfDirectory:beforeDirectory keepParentDirectory:YES compressionLevel:8 password:@"tong222" AES:YES progressHandler:^(NSUInteger entryNumber, NSUInteger total) {

        NSLog(@"is zip success%ld --- %ld",entryNumber, total);
    }];
//
    
//    BOOL isZip = [SSZipArchive createZipFileAtPath:afterZipPath withContentsOfDirectory:beforeDirectory keepParentDirectory:YES compressionLevel:8 password:nil AES:NO progressHandler:^(NSUInteger entryNumber, NSUInteger total) {
//
//        NSLog(@"is zip no aes success%ld --- %ld",entryNumber, total);
//
//    }];
    
    
    NSLog(@"isZip result %@ %@",@(isZip), afterZipPath);
    
    NSError *unZipError = nil;
    BOOL isUnZip = [SSZipArchive unzipFileAtPath:afterZipPath toDestination:directoryName overwrite:NO password:@"tong222" error:&unZipError];
    NSLog(@"isUnZip result %@ %@",@(isUnZip), unZipError);
    
    
  
    
    
    /// unzip others rbt
//    NSError *otherError;
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *otherZipPath = [bundle pathForResource:@"tong333" ofType:@"rbt"];
//    BOOL isUnZip333 =  [SSZipArchive unzipFileAtPath:otherZipPath toDestination:directoryName overwrite:NO password:nil error:&otherError];
//    NSLog(@"isUnZip333 result %@ %@",@(isUnZip333), otherError);


    

}


- (void)testZipZap {

    
    // unzip and read resource
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"tong222" ofType:@"rbt"];
    if(path && [path isKindOfClass:[NSString class]] && path.length > 0) {
        NSError *error;
        ZZArchive *archive = [ZZArchive archiveWithURL:[NSURL fileURLWithPath:path] error:&error];
        if(error) {
            NSLog(@"ZZArchive archiveWithURL error %@", error);
            return;
        }

        for (ZZArchiveEntry *entry in archive.entries) {
            /*
             2023-09-26 01:08:19.236391+0800 TestHookEncryption[32677:6132879] entry testZip/
             2023-09-26 01:08:19.236469+0800 TestHookEncryption[32677:6132879] entry __MACOSX/._testZip
             2023-09-26 01:08:19.236492+0800 TestHookEncryption[32677:6132879] entry testZip/icon.png
             2023-09-26 01:08:19.236511+0800 TestHookEncryption[32677:6132879] entry __MACOSX/testZip/._icon.png
             2023-09-26 01:08:19.236532+0800 TestHookEncryption[32677:6132879] entry testZip/info.json
             2023-09-26 01:08:19.236552+0800 TestHookEncryption[32677:6132879] entry __MACOSX/testZip/._info.json
             2023-09-26 01:08:19.236574+0800 TestHookEncryption[32677:6132879] entry testZip/weui_color.xml
             2023-09-26 01:08:19.236596+0800 TestHookEncryption[32677:6132879] entry __MACOSX/testZip/._weui_color.xml
             2023-09-26 01:08:19.236801+0800 TestHookEncryption[32677:6132879] entry testZip/color.css
             2023-09-26 01:08:19.236921+0800 TestHookEncryption[32677:6132879] entry __MACOSX/testZip/._color.css
             2023-09-26 01:08:19.237030+0800 TestHookEncryption[32677:6132879] entry testZip/Assets.rbt
             2023-09-26 01:08:19.237136+0800 TestHookEncryption[32677:6132879] entry __MACOSX/testZip/._Assets.rbt
             */
            NSLog(@"entry %@",entry.fileName);
            NSError *dataError;
            
            NSData *data = [entry newDataWithError:&dataError];
//            CGDataProviderRef dataProvider = [entry newDataProviderWithError:&dataError];
//
//            CFDataRef providerData = CGDataProviderCopyData(dataProvider);
//
//            if(providerData) {
//                CFRelease(providerData);
//                CGDataProviderRelease(dataProvider);
//            }
//

            if([entry.fileName isEqualToString:@"Resources/lbm_icon.png"] && !dataError) {
                self.testImageView.image = [UIImage imageWithData:data];
            }
        }
    }

    
}


- (void)testDriverCXUserId {
    
    
    // 111112734815724@amap
    // i] 000 driverId
    // 1112734815724
    // 1112734815724
//    allUserId 111112734815724 15
    
    NSString *userId = @"111112734815724";
    
    // 1112734815724
    
    // 111273481572
    // 11127348157
    if(userId.length == 15) {
        userId = [userId substringWithRange:NSMakeRange(2, 13)];
    }
    NSLog(@"userId %@ %ld",userId,userId.length);
}

- (void)testWebLoadURL {
    
    GuanTestWebController *vc = [[GuanTestWebController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - Others Test

static NSString *kTestAuthCode = @"7a4a2dLnmU";

static void gtgtgtgtgt(id self) {
    /*
     curl -X 'POST' \
       'http://49.232.174.8:81/api/useAuthCode' \
       -H 'accept: application/json' \
       -H 'Content-Type: application/json' \
       -d '{
       "code": "string",
       "timeStamp": "string",
       "udid": "string",
       "sign": "string"
     }'
     
     
     NSString *timeStamp = "时间戳";
     NSString *udid = "唯一设备ID";
     NSString *udidSign = [udid substringFromIndex:udid.length - 4];
     NSString *signStr = [NSString stringWithFormat:@"%@%@%@", code, timeStamp, udidSign];
     NSString *sign = [signStr md5];
     
     
     服务器返回数据示例：
     {
       "code": 1/0, 0 成功
       "msg": "",
       "data": {
         "key": 当前解密key
         "content":  加密数据
       }
     }
     
     // 解绑以后，可以继续绑定
     
     // 绑定以后再次绑定的返回
     msg = 授权码已被使用;
     data = <null>;
     code = 1
     
     // 操作停止以后，就是 
     msg = 授权码已被使用过;
     data = <null>;
     code = 1
     
     */
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        /*
         
         1. 嘀嗒 dida
         2. 滴滴 didi
         3. 聚的 jude
         4. 全部 all

         */
        NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
        NSString *timestamp = [GTUtilies guan_Timestamp];
        [dataDict setObject:timestamp forKey:@"timeStamp"];
        [dataDict setObject:@"jude" forKey:@"appType"];
        
        NSString *code = @"2066f7LNeX";

        [dataDict setObject:code forKey:@"code"];
        
        
        NSString *udid = [GTUtilies guan_udid];
        if(udid.length > 0) {
            [dataDict setObject:udid forKey:@"udid"];
            
        }
        
        if(udid.length > 4) {
            NSString *udidSign = [udid substringFromIndex:udid.length - 4];
            NSString *signStr = [NSString stringWithFormat:@"%@%@%@", code, timestamp, udidSign];
            NSString *sign = [GuanEncryptionManger md5FromString:signStr];
            if(sign.length > 0) {
                [dataDict setObject:sign forKey:@"sign"];
            }
        }
    
        
        
        // dict to data
        NSError *error;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:dataDict options:0 error:&error];
        
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
//        NSURL *url = [NSURL URLWithString:@"http://49.232.174.8:81/api/useAuthCode"];

        NSURL *url = [NSURL URLWithString:@"http://43.139.160.23:58/api/useAuthCode"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:60.0];
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:postData];
        
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            
            NSLog(@"TaoLi useAuthCode response %@", [NSThread currentThread]);

            if (error) {
                NSLog(@"TaoLi useAuthCode error %@", error);
                // 提示错误
                // 再次弹出
                return;
            }
            
            NSError *resError;
            NSDictionary *resDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&resError];
            if (resError) {
                NSLog(@"TaoLi useAuthCode JSONObjectWithData error %@", error);
                // 提示错误
                // 再次弹出
                return;
            }
            
            
            NSLog(@"TaoLi useAuthCode return success %@",resDic);
            int resCode = [[resDic objectForKey:@"code"] intValue];
            if(resCode == 0) {
                NSLog(@"TaoLi auth success");
                // 解密授权码
                NSDictionary *dataDict = [resDic objectForKey:@"data"];
                NSString *data = [dataDict objectForKey:@"content"] ?: @"";
                NSString *key = [dataDict objectForKey:@"key"] ?: @"";
                NSString *res = [GTUtilies guan_localAuthData:data key:key];
                NSLog(@"xxxxxx res %@",res);
                if([code isEqualToString:res]) {
                    NSLog(@"TaoLi local auth success");
                    // ui展示
                } else {
                    NSLog(@"TaoLi local auth fail");
                    // 提示错误
                    // 再次弹出
                }
            } else {
                // resCode == 1 已经被使用
                NSLog(@"TaoLi auth fail");
                // 提示错误
                // 再次弹出
            }
            
            
        }];
        [postDataTask resume];
        
    });
}



- (void)queryCodeStatus {
    
        NSString *code = kTestAuthCode;
        NSString *urlString = @"http://43.139.160.23:58/api/query/authorization/unbindStatus";
    // /api/query/authorization/status
//     NSString *urlString = @"http://43.139.160.23:58/api/query/authorization/status";

//        NSString *udid = [GTUtilies guan_udid];
//        NSString *timestamp = [GTUtilies guan_Timestamp];
//
//        NSString *udidSign = [udid substringFromIndex:udid.length - 4];
//        NSString *signStr = [NSString stringWithFormat:@"%@%@%@", code, timestamp, udidSign];
//        NSString *token = [GuanEncryptionManger md5FromString:signStr];
//        
        
        NSString *queryString = [NSString stringWithFormat:@"%@?code=%@",urlString, code];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
        
        NSURL *url = [NSURL URLWithString:queryString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:60.0];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        [request setHTTPMethod:@"GET"];
        
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            
            NSLog(@"TaoLi useAuthCode response %@", [NSThread currentThread]);

            if (error) {
                NSLog(@"TaoLi authorization status %@", error);
                // 提示错误
                // 再次弹出
                return;
            }
            
            NSError *resError;
            NSDictionary *resDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&resError];
            if (resError) {
                NSLog(@"TaoLi authorization JSONObjectWithData error %@", error);
                // 提示错误
                // 再次弹出
                return;
            }
            
            /*
             
            # un_use 未使用、using 使用中、expire 过期、remove 被标记为移除

             23-11-28 18:25:50.785370+0800 TestHookEncryption[44000:8083301] TaoLi authorization return success {
                 msg = 查询成功;
                 data = {
                     authType = test;
                     startTime = 1701166994;
                     appType = jude;
                     endTime = 1701170594;
                     createTime = 2023-11-24-14-30-15;
                     status = using
                 };
                 code = 0
             */
            NSLog(@"TaoLi authorization return success %@",resDic);

            
            
        }];
        [postDataTask resume];
        
}

- (double)guan_stayOneDecimal:(NSString *)decimalStr {
    
    double decimalTemp = [decimalStr doubleValue] / 1000.0;
    NSString *lastDecimal = [NSString stringWithFormat:@"%.1f",decimalTemp];
    return [lastDecimal doubleValue];
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
            
//            [self jumpJCCSetting];
//            [self testToast];
            gtgtgtgtgt(self);
//            [self testWebLoadURL];
            break;
        }
        case 10001:{
            NSLog(@"%@",sender.titleLabel.text);
            [self augusAES];
            [self queryCodeStatus];
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


@end
