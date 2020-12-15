//
//  FOSHeaderModel.h
//  offCompoundDemo
//
//  Created by Augus on 2020/2/11.
//  Copyright © 2020 fosafer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FOSHeaderModel : NSObject<NSCoding>

// 声纹合同编号
@property (nonatomic, copy) NSString *contractId;
// 声纹产品信息
@property (nonatomic, assign) NSInteger productInfo;


// 静默合同编号
@property (nonatomic, copy) NSString *slientContractId;
// 静默产品信息
@property (nonatomic, copy) NSString *slientProductInfo;

// sdk 返回的语音数据
@property (nonatomic, strong) NSData *speechData;
// sdk 返回的图像数据
@property (nonatomic, strong) NSData *imageData;
// sdk 返回的faceInfo string
@property (nonatomic, copy) NSString *faceInfo;

// oauth token
@property (nonatomic, copy) NSString *accessToken;



@end

NS_ASSUME_NONNULL_END
