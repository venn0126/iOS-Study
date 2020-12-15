//
//  ViewController.m
//  Testhh1010
//
//  Created by Augus on 2020/10/10.
//

#import "ViewController.h"

#import <ISIDReaderSDK/ISIDReaderSDK.h>
#import <ISOpenSDKFoundation/ISOpenSDKFoundation.h>


#define IS_AppKey @"e33f8d870aa211eb9fe90242"
#define IS_SubKey @""

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *infoArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSLog(@"last--%@",self.infoArray);
    
    
//    NSString *lastRes = [NSString stringWithFormat:@"识别成功-4，识别失败-5"];
//    [self wirteToFileResult:lastRes];
    
    
     
    // 1988113
    // 1988年1月13日
    NSString *birthday = @"1988年1月13日";
    
    birthday = [birthday stringByReplacingOccurrencesOfString:@"年" withString:@":"];
    birthday = [birthday stringByReplacingOccurrencesOfString:@"月" withString:@":"];
    birthday = [birthday stringByReplacingOccurrencesOfString:@"日" withString:@""];
    
    // 1988:1:13

    NSArray *tempArray = [birthday componentsSeparatedByString:@":"];
    if (tempArray.count == 3) {
        
    }

    
//    NSDate *date = [NSDate ]
//    NSString *subBirthday = [birthday substringFromIndex:4];
//    NSLog(@"%@",subBirthday);
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"YYYYMMdd";
//
//    NSDate *date = [formatter dateFromString:birthday];
//    NSLog(@"number--%@",date);
    
    
    
    // 把 月 日 换成 :
    
    
    
    
    
}

- (void)testImageData {
    
    NSString *appKey = @"e33f8d870aa211eb9fe90242";
    NSString *subAppkey = nil;//reserved for future use
    
    [[ISCardReaderController sharedController]
        constructResourcesWithAppKey:appKey subAppkey:subAppkey
        finishHandler:^(ISOpenSDKStatus status) {
        NSLog(@"11111");

        if (ISOpenSDKStatusSuccess != status) {
            NSLog(@"Auth failed!=%ld",(long)status);
         }
    }];
    
    
    UIImage *image = [self imageBundleForName:@"卜龙祥"];
    ISOpenSDKStatus status = [[ISCardReaderController sharedController] processCardImage:image returnCroppedImage:YES returnPortraitImage:YES withFinishHandler:^(NSDictionary *cardInfo){
    
//      [weakSelf
//    setupFormatCardInfo:cardInfo ocrImage:image];
//        NSLog(@"cardinfo---%@",cardInfo[@"kCardItemName"]);
        
  
        
        // 校验格式
        NSDictionary *infoDict = cardInfo[kOpenSDKCardResultTypeCardItemInfo];
        NSString *ocrName = cardInfo[kOpenSDKCardResultTypeCardName];
        if ([ocrName isEqualToString:@"第二代身份证背面"])
        {
//            self.ocrIDCardType = @"二代身份证 背面";
        }else
            {
//                self.ocrIDCardType = @"二代身份证 正面";

            }

        ISCardReaderResultItem *item_1 = infoDict[kCardItemName];
        ISCardReaderResultItem *item_2 = infoDict[kCardItemGender];
        ISCardReaderResultItem *item_3 = infoDict[kCardItemNation];
        ISCardReaderResultItem *item_4 = infoDict[kCardItemBirthday];
        ISCardReaderResultItem *item_5 = infoDict[kCardItemAddress];
        ISCardReaderResultItem *item_6 = infoDict[kCardItemIDNumber];
        ISCardReaderResultItem *item_7 = infoDict[kCardItemIssueAuthority];
        ISCardReaderResultItem *item_8 = infoDict[kCardItemValidity];

        NSString *name = item_1.itemValue;
        NSString *gender = item_2.itemValue;
        NSString *nation = item_3.itemValue;
        NSString *birthday = item_4.itemValue;
        NSString *address = item_5.itemValue;
        NSString *IDNumber = item_6.itemValue;
        NSString *authority = item_7.itemValue;
        NSString *validity = item_8.itemValue;
        
        /*
         蔡坚辉男汉19760203福建省清流县嵩溪镇新垦新村1号350423197602031057
         
         卜龙祥男汉1988年1月13日北京市海淀区学院路37号371524198801133356
         
         卜龙祥男汉1988年113北京市海淀区学院路37号371524198801133356
         **/
        
        // 格式化 birthday
        
        // 去除汉子
        birthday = [birthday stringByReplacingOccurrencesOfString:@"月" withString:@""];
        birthday = [birthday stringByReplacingOccurrencesOfString:@"日" withString:@""];
        birthday = [birthday stringByReplacingOccurrencesOfString:@"年" withString:@""];

        // 格式化月 日
        
        if (birthday.length != 8) {
            
            // 不是月就是日
            // 1988113
            NSString *subBirthday = [birthday substringFromIndex:3];
            NSLog(@"");
            
        }
        
        

        
        NSString *lastStr = [NSString stringWithFormat:@"%@%@%@%@%@%@",name,gender,nation,birthday,address,IDNumber];
        NSLog(@"last--%@",lastStr);
        
        
        

        
    
     }];
     if (status != ISOpenSDKStatusSuccess){

         NSLog(@"Can not process card image:%d", (int)status);
     }
}



- (NSMutableArray *)infoDataProcess {
    
    // 获取资源路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"baseInfo" ofType:@"bundle"];
    // 获取资源
//    NSBundle *gifBundle = [NSBundle bundleWithPath:path];
    NSArray *tempArr = [NSBundle pathsForResourcesOfType:@"txt" inDirectory:path];
    
    NSMutableArray *mulArray = [NSMutableArray array];
    
    for (NSString *infoPath in tempArr) {
        // 获取单个元素路径
//        NSString *infoPath = @"";
        NSError *error = nil;
        // 中文编码
        unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *content = [NSString stringWithContentsOfFile:infoPath encoding:encode error:&error];
        
        if (error) {
            NSLog(@"error-%@",error);
        }
            
        
        content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        content = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        
        NSArray *tempArray = [content componentsSeparatedByString:@".jpg"];
        NSMutableDictionary *tempMulDict = [NSMutableDictionary dictionary];
        
        // lastobject 取后18
        // nameidnumber
        
        NSString *tempStr = tempArray.lastObject;
        NSString *idNum = [tempStr substringFromIndex:tempStr.length - 18];
        
        [tempMulDict setObject:idNum forKey:tempArray.firstObject];
        [mulArray addObject:tempMulDict];
        
        
        // 进行单个识别结果的处理
        
        
    }
    
    /*
     
     {
         "蔡连锋" : "蔡连锋男汉19640120江苏省灌云县图河乡图河村六组20号320723196401203293"
     },
     
     **/
    
//    NSLog(@"last--%@",mulArray);
    
    return  mulArray;

}

- (UIImage *)imageBundleForName:(NSString *)name {
    
    // 获取图片路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"baseImage" ofType:@"bundle"];
    // 获取资源
    NSBundle *imageBundle = [NSBundle bundleWithPath:path];
    // 获取单个元素路径
    NSString *infoPath = [imageBundle pathForResource:name ofType:@"jpg"];
    NSData *imageData = [NSData dataWithContentsOfFile:infoPath];
    UIImage *img = [UIImage imageWithData:imageData];
    
//    NSLog(@"ima len-%ld",imageData.length);
    
    if (!img) {
        return  nil;
    }
    return  img;
    
}


- (void)wirteToFileResult:(NSString *)result{
    //将一段字符串写入documents文件夹中
    NSString* docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    //在上面的路径下创建一个文件路径，用来盛放文字 PathComponent不会加 /
    NSString* txtPath = [docPath stringByAppendingPathComponent:@"result.txt"];
    
    //将文字写入文件中,当文字写入文件的时候,如果文件不存在,系统会先创建,在写入;如果存在,直接写人。新的内容会将原有内存覆盖掉。
//    NSString* contentString = @"我是文本内容";
    //写入操作
    //第一个参数:文件路径
    //第二个参数:原子性 YES:在写入过程中会产生一个临时文件，当内容写入完整的时候，才会将内容移动到目标文件中; NO:直接在目标文件上操作，不会产生临时文件，有可能破坏目标文件。
    //encoding:字符串的编码格式
    //error:如果写入出问题，这里会产生一个错误日志，一般不需要错误日志，直接赋值为nil
    //error对象用来保存错误日志
    NSError* error = nil;
    BOOL isSuccess = [result writeToFile:txtPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    //只知道写入的结果,没有失败过程描述
    if (isSuccess) {
        NSLog(@"成功");
    }else{
        NSLog(@"失败");
    }
    //有写入失败的细节描述
    if (error) {
        NSLog(@"写入文件错误----%@",error.description);
    }else{
        NSLog(@"写入成功");
    }
}


#pragma mark - Lazy load

- (NSMutableArray *)infoArray {
    
    if (!_infoArray) {
        _infoArray = [[NSMutableArray alloc] init];
        _infoArray = [self infoDataProcess];
    }
    return _infoArray;
}

@end
