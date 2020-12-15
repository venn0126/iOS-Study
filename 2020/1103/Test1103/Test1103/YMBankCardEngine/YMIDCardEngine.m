//
//  OCREngine.m
//  IDCardScanDemo
//
//  Created by  on 14-04-16.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "YMIDCardEngine.h"
#import "HCBCRTOPAPI.h"
#import "HCCommonAPI.h"
#import "HCDOCTOPAPI.h"
#import "HCCommonData.h"
#import "VedioRec.h"

int progress_func(int progress, int relative);

@implementation YMIDCardEngine
@synthesize ocrLanguage;

id callbackDelegate = nil;
id bcrResultDelegate = nil;
id bcrFreeDelegate = nil;

int progress_value = 0;
BOOL bcr_canceled = NO;

int progress_func(int progress, int relative)
{
    if (progress == 0)
		return 1;
	
	if (relative == 0)
		progress_value = progress;
	else
		progress_value += progress;
	
	return 0;
}

//- (void)initCodePage {
//	
//	switch (ocrLanguage) {
//		case OCR_LAN_ENGLISH:
//			codePage = 0x7;
//			break;
//		case OCR_LAN_CHINESE:
//			codePage = 0x80000632;//gb
//			HC_SetChineseCode(_bcrEngine, OCR_CODE_GB);
////			HC_SetChineseCode(_ocrEngine, OCR_CODE_GB);
//			break;
//		case kOcrLangTraditionalChinese:
//			codePage = 0x80000A06;//b5
//			HC_SetChineseCode(_bcrEngine, OCR_CODE_B5);
////			HC_SetChineseCode(_ocrEngine, OCR_CODE_GB2B5);
//			break;
//		case OCR_LAN_EUROPEAN:
//			codePage = 0x1;
//			break;
//		case OCR_LAN_JAPAN:
//			codePage = 0x80000a01;
//			break;
//		default:
//			codePage = 0x80000632;//gb
//			break;
//	}
//}

int BcrResult_func(int bcrResult)
{
    [bcrResultDelegate bcrResultCallbackWithValue:bcrResult];
    return 1;
}

int BcrFree_func(int bcrFree)
{
    [bcrFreeDelegate bcrFreeCallbackWithFreeValue:bcrFree];
    return 1;
}

-(int)doBcrRecognizeVedioWithBuffer:(UInt8 *)buffer andWidth:(int)width andHeight:(int)height andRect:(BRect)pRect andChannelNumberStr:(NSString *)channelNumberStr
{
    NSString *iOSFileDirectStr = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    char *channelNumber = (char*)[channelNumberStr cStringUsingEncoding:NSUTF8StringEncoding];
    char *iOSFileDirect = (char*)[iOSFileDirectStr cStringUsingEncoding:NSUTF8StringEncoding];
    int ret = YMVR_RecognizeVedio_BK(buffer, width, height, 0, &pRect, BcrResult_func,BcrFree_func,channelNumber,iOSFileDirect);
    return ret;
}

-(int)doBcrRecognizeVedioWithBufferVertical:(UInt8 *)buffer andWidth:(int)width andHeight:(int)height andRect:(BRect)pRect andChannelNumberStr:(NSString *)channelNumberStr
{
    NSString *iOSFileDirectStr = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    char *channelNumber = (char*)[channelNumberStr cStringUsingEncoding:NSUTF8StringEncoding];
    char *iOSFileDirect = (char*)[iOSFileDirectStr cStringUsingEncoding:NSUTF8StringEncoding];
    int ret = YMVR_RecognizeVedioVertical_BK(buffer, width, height, 0, &pRect, BcrResult_func,BcrFree_func,channelNumber,iOSFileDirect);
    return ret;
}

-(int)doBcrRecognizeVedioWith_ID:(UInt8 *)buffer andWidth:(int)width andHeight:(int)height andRect:(BRect)pRect andChannelNumberStr:(NSString *)channelNumberStr
{
    NSString *iOSFileDirectStr = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    char *channelNumber = (char*)[channelNumberStr cStringUsingEncoding:NSUTF8StringEncoding];
    char *iOSFileDirect = (char*)[iOSFileDirectStr cStringUsingEncoding:NSUTF8StringEncoding];
    int ret = HC_YMVR_RecognizeVedio_ID(buffer, width, height, 0, &pRect, BcrResult_func, BcrFree_func,channelNumber,iOSFileDirect,(Int)_version);
    return ret;
//    return 0;
}

#pragma mark-- 竖屏识别
-(int)doBcrRecognizeVedioWithVertical_ID:(UInt8 *)buffer andWidth:(int)width andHeight:(int)height andRect:(BRect)pRect andChannelNumberStr:(NSString *)channelNumberStr
{
    NSString *iOSFileDirectStr = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    char *channelNumber = (char*)[channelNumberStr cStringUsingEncoding:NSUTF8StringEncoding];
    char *iOSFileDirect = (char*)[iOSFileDirectStr cStringUsingEncoding:NSUTF8StringEncoding];
    int ret = HC_YMVR_RecognizeVedio_ID_Vertical(buffer, width, height, 0, &pRect, BcrResult_func, BcrFree_func,channelNumber,iOSFileDirect,(Int)_version);
    return ret;
//    return 0;
}

- (BOOL)allocDictEngine {
    
	return YES;
}

#pragma mark -
- (id)initWithLanguage:(NSInteger)language andIndex:(NSInteger)index andChannelNumber:(NSString*)channelNumberStr
{
    self = [super init];
    if (self)
    {
        _engInitRet = engInitFailed;
        switch (index) {
            case cardType_Bank:
            {
                cardIndex = cardType_Bank;
                self.chNumberStr = channelNumberStr;
                _engInitRet = engInitSuccess;
            }
                break;
            case cardType_ID:
            {
                cardIndex = cardType_ID;
                self.chNumberStr = channelNumberStr;
                _engInitRet = [self resetEngine_ID:language andChannelNumber:channelNumberStr];

            }
                break;
                
            default:
                break;
        }

    }
    return self;
}


- (EngInitRet)resetEngine_ID:(NSInteger)language andChannelNumber:(NSString*)channelNumberStr {
	
	language = 2;
	NSInteger ret;
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSMutableString *realPath = [NSMutableString string];
    [realPath appendFormat:@"%@/", path];
    
    char *p = (char*)[realPath cStringUsingEncoding:NSUTF8StringEncoding];
    char *channelNumber = (char*)[channelNumberStr cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSString *iOSFileDirectStr = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    char *iOSFileDirect = (char*)[iOSFileDirectStr cStringUsingEncoding:NSUTF8StringEncoding];

    ret = HC_StartBCR_ID(&_bcrEngine, p, "null",(int)language,channelNumber,iOSFileDirect);
    switch (ret) {
            [self closeEngine_ID];
            NSLog(@"HC_StartBCR_ID failed.=%ld",(long)ret);
        case 0:
            return engInitFailed;
            break;
        case 100:
            return engInitLocTimeExpired;
            break;
        case 101:
            return engInitRecTimeExpired;
            break;
        case 200:
            return engInitAuthoriFailed;
            break;
        case 300:
            return engInitTimesExceed;
            break;
        case 600:
            return engInitEncryptionFailed;
            break;
        case 900:
            return engInitTimesPermissionsFailed;
            break;
        case 901:
            return engInitTimePermissionsFailed;
            break;
            
        default:
            break;
    }
    return engInitSuccess;
}


-(void)setBcrResultCallbackDelegate:(id)delegate
{
    bcrResultDelegate = delegate;
    if (![bcrResultDelegate conformsToProtocol:@protocol(BcrResultCallbackDelegate)]) {
        bcrResultDelegate = nil;
    }
}

- (void)closeEngine_ID {
    if (_bcrEngine) {
        HC_CloseBCR_ID(&_bcrEngine);
        _bcrEngine = NULL;
    }
}


- (void)ymClearAll_ID
{
    YMClearAll_ID();
}


- (void)freeBImage {
    
	if(_bImage) {
		HC_freeImage_ID(_bcrEngine, &_bImage);
		_bImage = nil;
	}
}


- (BOOL)allocBImage:(UIImage *)image {
	[self freeBImage];
	
	int width = CGImageGetWidth(image.CGImage);
	int height = CGImageGetHeight(image.CGImage);
	
	NSInteger ret;
    if (!_bcrEngine) {
            [self resetEngine_ID:ocrLanguage andChannelNumber:self.chNumberStr];
    }
	ret = HC_allocImage_ID(_bcrEngine, &_bImage, width, height, -1);
	if (ret == 0) {
		NSLog(@"allocImage failed.");
		_bImage = nil;
		return NO;
	}
	
	if(![YMUtility GetYDataFromImage:image pixels:_bImage->pixels]) {
		NSLog(@"GetYDataFromImage failed.");
		[self freeBImage];
		return NO;
	}
	return YES;
}

//- (BOOL)allocBImageVideo:(UIImage *)image {
//    [self freeBImage];
//
//    int width = CGImageGetWidth(image.CGImage);
//    int height = CGImageGetHeight(image.CGImage);
//
//    NSInteger ret;
//    ret = HC_allocImage_ID(NULL, &_bImage, width, height, -1);
//    if (ret == 0) {
//        NSLog(@"allocImage failed.");
//        [self freeBImage];
//        return NO;
//    }
//
//    if(![YMUtility GetYDataFromImageVideo:image pixels:_bImage->pixels]) {
//        NSLog(@"GetYDataFromImageVideo failed.");
//        [self freeBImage];
//        return NO;
//    }
////    _bcrIndex = 1;
//    return YES;
//}

- (BOOL)rotateBImage {
	
	if (!_bImage)
		return NO;
	
	NSInteger width = _bImage->height;
	NSInteger height = _bImage->width;
	
	BImage *newBImage = NULL;
	
	NSInteger ret;
	ret = HC_allocImage_ID(_bcrEngine, &newBImage, width, height, -1);
	if(ret == 0) {
		NSLog(@"HC_allocImage failed.");
		return NO;
	}
	
	NSInteger h = _bImage->height - 1;
	
	for (NSInteger i = 0; i < _bImage->width; ++i)
		for (NSInteger j = h; j >= 0; --j)
			newBImage->pixels[i][h - j] = _bImage->pixels[j][i];
	
	[self freeBImage];
	_bImage = newBImage;
	return YES;
}


- (CGRect)charDetection:(CGPoint)firstPoint lastPoint:(CGPoint)lastPoint {
    CGRect rect;
    return rect;
}

- (NSArray *)makeArrayFromBField:(BField *)field {
    NSString *name, *cardno, *sex, *folk ,*birthday, *address, *ISSUE_AUTHORITY, *VALID_PERIOD, *MEMO;
    cardno = name = sex = folk = birthday = address = ISSUE_AUTHORITY = VALID_PERIOD = MEMO = @"";
    // 20121212
    BRect bRect = field->headImgRect;
    NSLog(@"左上(%d,%d)",bRect.lx,bRect.ly);
    NSLog(@"右下(%d,%d)",bRect.rx,bRect.ry);
    CGRect rect = CGRectMake(bRect.lx, bRect.ly, bRect.rx-bRect.lx, bRect.ry-bRect.ly);
    NSValue *rectValue = [NSValue valueWithCGRect:rect];
    //
    NSMutableArray *headArray = [NSMutableArray arrayWithCapacity:6];
    
    while (field) {
        NSString *encodedText = [NSString stringWithCString:field->text encoding:0x80000632];
        if([encodedText hasPrefix:@"%+"] == 1)
        {
            encodedText = [encodedText substringFromIndex:1];
        }
        if (encodedText == nil) {
            field = field->next;
            continue;
        }
        
        switch (field->fid) {
            case BIDC_NAME:name = [name stringByAppendingFormat:@"%@%@", [name length]?@" ":@"", encodedText];break;
            case BIDC_CARDNO:cardno = [cardno stringByAppendingFormat:@"%@%@", [cardno length]?@" ":@"", encodedText];break;
            case BIDC_SEX:sex = [sex stringByAppendingFormat:@"%@%@", [sex length]?@" ":@"", encodedText];break;
            case BIDC_FOLK:folk = [folk stringByAppendingFormat:@"%@%@", [folk length]?@" ":@"", encodedText];break;
            case BIDC_BIRTHDAY:birthday = [birthday stringByAppendingFormat:@"%@%@", [birthday length]?@" ":@"", encodedText];break;
                
            case BIDC_ADDRESS:address = [address stringByAppendingFormat:@"%@%@", [address length]?@" ":@"", encodedText];break;
            case BIDC_ISSUE_AUTHORITY:ISSUE_AUTHORITY = [ISSUE_AUTHORITY stringByAppendingFormat:@"%@%@", [ISSUE_AUTHORITY length]?@" ":@"", encodedText];break;
            case BIDC_VALID_PERIOD:VALID_PERIOD = [VALID_PERIOD stringByAppendingFormat:@"%@%@", [VALID_PERIOD length]?@" ":@"", encodedText];break;
            case BIDC_MEMO:MEMO = [MEMO stringByAppendingFormat:@"%@%@", [MEMO length]?@" ":@"", encodedText];break;
        }
        field = field->next;
    }
    
    
    [headArray addObject:name];
    [headArray addObject:cardno];
    [headArray addObject:sex];
    [headArray addObject:folk];
    [headArray addObject:birthday];
    
    [headArray addObject:address];
    [headArray addObject:ISSUE_AUTHORITY];
    [headArray addObject:VALID_PERIOD];
    [headArray addObject:MEMO];
    
    [headArray addObject:rectValue];
    return headArray;
}

- (NSDictionary *)doBCRJSON_ID {
    BField *bField = NULL;
    NSMutableDictionary *headDict = [NSMutableDictionary dictionaryWithCapacity:1];
    int ret;
    NSString *iOSFileDirectStr = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    char *iOSFileDirect = (char*)[iOSFileDirectStr cStringUsingEncoding:NSUTF8StringEncoding];
    _checkCopy = 0;
    bcr_canceled = NO;
    if (cardIndex == 1)
    {
        ret = HC_DoImageBCR_ID(_bcrEngine, _bImage, &bField,iOSFileDirect);
    }
    _checkCopy = HC_CheckingCopyID(_bImage);
    
    NSString *docs = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/idcard.jpg"] ;
    YM_SaveImage_BK(_bImage,(char*)[docs UTF8String]);
    idCardImage = [[UIImage alloc]initWithContentsOfFile:docs];
    
    [self freeBImage];
    
    if (bcr_canceled) {
        if (cardIndex == 1)
        {
            [self resetEngine_ID:ocrLanguage andChannelNumber:self.chNumberStr];
        }
        
        return nil;
    }
    
    if (ret != 1)
    {
        if (bField != NULL) {
            [self freeBField_ID:bField];
        }
        if (cardIndex == 1)
        {
            [self closeEngine_ID];
        }
        return nil;
    }
    
    NSString *result = @"";
    if (cardIndex == 1)
    {
        result = [self makeArrayFromBFieldJSON_ID:bField];
        NSLog(@"==%@",result);
    }
    
    [self freeBField_ID:bField];

    if (cardIndex == 1)
    {
        [self closeEngine_ID];
    }
    
    [self closeEngine_ID];
    NSDictionary *retHeadDic = [self dictionaryWithJsonString:result];
    
    if ([retHeadDic objectForKey:@"Name"]) {
        [headDict setObject:[retHeadDic objectForKey:@"Name"] forKey:RESID_NAME];
    }
    if ([retHeadDic objectForKey:@"Sex"]) {
        [headDict setObject:[retHeadDic objectForKey:@"Sex"] forKey:RESID_SEX];
    }
    if ([retHeadDic objectForKey:@"Folk"]) {
        [headDict setObject:[retHeadDic objectForKey:@"Folk"] forKey:RESID_FOLK];
    }
    if ([retHeadDic objectForKey:@"Birthday"]) {
        [headDict setObject:[retHeadDic objectForKey:@"Birthday"] forKey:RESID_BIRT];
    }
    if ([retHeadDic objectForKey:@"Address"]) {
        [headDict setObject:[retHeadDic objectForKey:@"Address"] forKey:RESID_ADDRESS];
    }
    if ([retHeadDic objectForKey:@"CardNo"]) {
        [headDict setObject:[retHeadDic objectForKey:@"CardNo"] forKey:RESID_NUM];
    }
    if ([retHeadDic objectForKey:@"IssueAuthority"]) {
        [headDict setObject:[retHeadDic objectForKey:@"IssueAuthority"] forKey:RESID_ISSUE];
    }
    if ([retHeadDic objectForKey:@"ValidPeriod"]) {
        [headDict setObject:[retHeadDic objectForKey:@"ValidPeriod"] forKey:RESID_VALID];
    }
    if ([retHeadDic objectForKey:@"Type"]) {
        [headDict setObject:[retHeadDic objectForKey:@"Type"] forKey:RESID_TYPE];
    }
    if (idCardImage != NULL) {
        [headDict setObject:idCardImage forKey:RESID_IMAGE];
    }
    if (headImage != NULL) {
        [headDict setObject:headImage forKey:RESID_HEADIMAGE];
    }
    [headDict setObject:[NSNumber numberWithInteger:_checkCopy] forKey:RESID_CHECKCOPY];
    return headDict;
}


- (void)freeBField_ID:(BField *)field {
    
    if (field)
        HC_freeBField_ID(_bcrEngine, field, 0);
}



- (NSString *)makeArrayFromBFieldJSON_ID:(BField *)field {
    char buf[8192]= {11};
    NSString *result = @"";
    int ret = HC_PrintFieldInfo_JSON_ID(_bcrEngine,field,buf,8192);
    NSLog(@"makeArrayFromBFieldJSON_ID=%d",ret);
    if (ret == 1) {
        result = [NSString stringWithCString:buf encoding:0x80000632];
    }
    return result;
}

// 身份证识别
- (NSDictionary *)doBCRWithRect_ID:(CGRect)rect
{
    int ret;
    char buf[1024]= {0};
    BRect headRect;
    headRect.lx = 0;
    headRect.ly = 0;
    headRect.rx = 0;
    headRect.ry = 0;
    bcr_canceled = NO;
    NSMutableDictionary *headDict = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString *result = @"";
    
    // ret = HC_YMVR_GetResult(buf,1024);
    ret = HC_YMVR_GetResult_ID(buf);
    
    //  _picImage = HC_YMVR_GetPicInfo();
    _picImage = HC_YMVR_GetPicInfo_ID();
    NSString *docs = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/idcard.jpg"] ;
    YM_SaveImage_BK(_picImage,(char*)[docs UTF8String]);
    idCardImage = [[UIImage alloc]initWithContentsOfFile:docs];
    
    _headBImage = HC_YMVR_GetHeadInfo_ID();
    NSString *docsHead = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/idhead.jpg"] ;
    YM_SaveImage_BK(_headBImage,(char*)[docsHead UTF8String]);
    headImage = [[UIImage alloc]initWithContentsOfFile:docsHead];
    
    HC_freeImage_ID(_bcrEngine, &_bImage);
    _bImage = NULL;
    
    if (_picImage)
    {
        HC_freeImage_ID(_bcrEngine, &_picImage);
        _picImage = NULL;
    }
    
    if (_headBImage)
    {
        HC_freeImage_ID(_bcrEngine, &_headBImage);
        _headBImage = NULL;
    }
    
    if (bcr_canceled) {
        [self resetEngine_ID:ocrLanguage andChannelNumber:self.chNumberStr];
        return nil;
    }
    
    if (ret != 1)
    {
        [self closeEngine_ID];
        return nil;
    }
    
    result = [NSString stringWithCString:buf encoding:0x80000632];
    NSLog(@"=======%@",result);
    NSDictionary *retHeadDic = [self dictionaryWithJsonString:result];
    
    if ([retHeadDic objectForKey:@"Name"]) {
        [headDict setObject:[retHeadDic objectForKey:@"Name"] forKey:RESID_NAME];
    }
    if ([retHeadDic objectForKey:@"Sex"]) {
        [headDict setObject:[retHeadDic objectForKey:@"Sex"] forKey:RESID_SEX];
    }
    if ([retHeadDic objectForKey:@"Folk"]) {
        [headDict setObject:[retHeadDic objectForKey:@"Folk"] forKey:RESID_FOLK];
    }
    if ([retHeadDic objectForKey:@"Birthday"]) {
        [headDict setObject:[retHeadDic objectForKey:@"Birthday"] forKey:RESID_BIRT];
    }
    if ([retHeadDic objectForKey:@"Address"]) {
        [headDict setObject:[retHeadDic objectForKey:@"Address"] forKey:RESID_ADDRESS];
    }
    if ([retHeadDic objectForKey:@"CardNo"]) {
        [headDict setObject:[retHeadDic objectForKey:@"CardNo"] forKey:RESID_NUM];
    }
    if ([retHeadDic objectForKey:@"IssueAuthority"]) {
        [headDict setObject:[retHeadDic objectForKey:@"IssueAuthority"] forKey:RESID_ISSUE];
    }
    if ([retHeadDic objectForKey:@"ValidPeriod"]) {
        [headDict setObject:[retHeadDic objectForKey:@"ValidPeriod"] forKey:RESID_VALID];
    }
    if ([retHeadDic objectForKey:@"Type"]) {
        [headDict setObject:[retHeadDic objectForKey:@"Type"] forKey:RESID_TYPE];
    }
    if ([retHeadDic objectForKey:@"Cover"]) {
        [headDict setObject:[retHeadDic objectForKey:@"Cover"] forKey:RESID_COVER];
    }

    if (idCardImage != NULL) {
        [headDict setObject:idCardImage forKey:RESID_IMAGE];
    }
    if (headImage != NULL) {
        [headDict setObject:headImage forKey:RESID_HEADIMAGE];
    }
    return headDict;
}


// 银行卡视频识别
- (NSDictionary *)doBCRWithRect:(CGRect)rect
{
    int ret;
    //    char buf[1024]= {0};
    
    BCR_RESULT pBcrResult;
    bcr_canceled = NO;
    NSMutableDictionary *headDict = [NSMutableDictionary dictionaryWithCapacity:4];
    NSString *cardNo, *bankName, *cardName, *cardType;
    cardNo = bankName = cardName = cardType = @"";
    
    ret = YMVR_GetResult_BK(&pBcrResult);
    BImage *dupBimage = YMVR_GetTrnImage_BK();
    
    NSString *docs = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/a.jpg"] ;
    YM_SaveImage_BK(dupBimage, (char*)[docs UTF8String]);
    idCardImage = [[UIImage alloc]initWithContentsOfFile:docs];
    
    if (dupBimage)
    {
        HC_freeImage_ID(NULL, &dupBimage);
        dupBimage = nil;
    }
    
    [self freeBImage];
    _bImage = NULL;
    
    if (ret != 1)
    {
        return nil;
    }
    
    cardNo = [NSString stringWithCString:pBcrResult.text encoding:0x80000632];
    bankName = [NSString stringWithCString:pBcrResult.bankname encoding:0x80000632];
    cardName = [NSString stringWithCString:pBcrResult.cardname encoding:0x80000632];
    cardType = [NSString stringWithCString:pBcrResult.cardtype encoding:0x80000632];
    if (cardNo.length) {
        [headDict setObject:cardNo forKey:[NSNumber numberWithInt:Bank_cardNo]];
    }
    if (bankName.length) {
        [headDict setObject:bankName forKey:[NSNumber numberWithInt:Bank_bankName]];
    }
    if (cardName.length) {
        [headDict setObject:cardName forKey:[NSNumber numberWithInt:Bank_cardName]];
    }
    if (cardType.length) {
        [headDict setObject:cardType forKey:[NSNumber numberWithInt:Bank_cardType]];
    }
    if (idCardImage != NULL) {
        [headDict setObject:idCardImage forKey:RESBANK_IDIMAGE];
    }
    return headDict;
    
    //    NSLog(@"=======%@",result);
    //    if (result.length)
    //    {
    //        [headDict setObject:result forKey:[NSNumber numberWithInt:ID_cardNo]];
    //    }
    //    return headDict;
}

/*!
 json格式字符串转字典：
 * @brief 把格式化的JSON格式的字符串转换成字典
 
 * @param jsonString JSON格式的字符串
 
 * @return 返回字典
 
 */

-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    NSLog(@"jsonString=%@",jsonString);
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    NSLog(@"dictionaryWithJsonString=%@",dic);
    return dic;
    
}

//- (void)freeBField:(BField *)field {
//	
//	if (field)
//		HC_freeBField(_bcrEngine, field, 0);
//}
- (BOOL)isChinese: (NSString *)Text {
	
	BOOL namechnChar = NO;
	const char *test = [Text UTF8String];
	int i;
	
	for (i = 0; i < strlen(test); i ++)
	{
		if (*(test+i) & 0x80)
		{
			namechnChar = YES;
		}
		
		if(namechnChar == YES)
			return YES;
	}
	return NO;
	
}

@end
