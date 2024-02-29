//
//  GTAppStorePay.h
//  TestHookEncryption
//
//  Created by Augus Venn on 2024/2/29.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>



NS_ASSUME_NONNULL_BEGIN

@class GTAppStorePay;
@protocol GTAppStorePayDelegate <NSObject>
/// 支付成功回调
- (void)gtAppStorePay:(GTAppStorePay *)appStorePay responseAppStorePaySuccess:(id)success error:(NSError * _Nullable)error;

/// 购买结果回调
- (void)gtAppStorePay:(GTAppStorePay *)appStorePay responseAppStorePayStatusshow:(id)statusShow error:(NSError * _Nullable)error;

@end

@interface GTAppStorePay : NSObject<SKPaymentTransactionObserver,SKProductsRequestDelegate>

- (void)starBuyToAppStore:(NSString *)goodsID;

@property(nonatomic, weak) id<GTAppStorePayDelegate> delegate;



@end

NS_ASSUME_NONNULL_END
