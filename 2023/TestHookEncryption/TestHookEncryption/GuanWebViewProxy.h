//
//  GuanWebViewProxy.h
//  TestHookEncryption
//
//  Created by Augus on 2024/8/27.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GuanWebViewProxy : NSObject<WKNavigationDelegate, NSURLSessionDelegate>

@property(nonatomic, strong) WKWebView *webView;

- (void)loadRequestWithURL:(NSString *)urlString proxy:(NSString *)proxyURL certPath:(NSString *)certPath;

@end

NS_ASSUME_NONNULL_END
