//
//  GuanWebViewProxy.m
//  TestHookEncryption
//
//  Created by Augus on 2024/8/27.
//

#import "GuanWebViewProxy.h"
#import "GuanWeakWebViewDelegate.h"

@implementation GuanWebViewProxy {
    NSString *_certPath;
}


- (void)loadRequestWithURL:(NSString *)urlString proxy:(NSString *)proxyURL certPath:(NSString *)certPath {
    _certPath = certPath;
    
    // 配置代理
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    if (proxyURL) {
        config.connectionProxyDictionary = @{
            @"HTTPEnable"  : @YES,
            @"HTTPProxy"   : proxyURL,
            @"HTTPPort"    : @18080,
//            @"HTTPSEnable" : @YES,
//            @"HTTPSProxy"  : proxyURL,
//            @"HTTPSPort"   : @18080
        };
    }
    
    // 初始化 WKWebView 并加载请求
    WKWebViewConfiguration *webViewConfig = [[WKWebViewConfiguration alloc] init];
    
    // 加载页面
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 使用自定义配置的 session 进行请求，并且加载到 WebView
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Request error: %@", error.localizedDescription);
        } else {
            // 在主线程中加载网页内容
            dispatch_async(dispatch_get_main_queue(), ^{
//                NSString *mimeType = [self mimeTypeForURL:url];
//                NSString *textEncodingName = @"UTF-8"; // 根据实际内容调整
//                [self.webView loadData:data MIMEType:mimeType textEncodingName:textEncodingName baseURL:url];
                
                NSString *htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                [self.webView loadHTMLString:htmlString baseURL:url];
                

            });
        }
    }];
    [dataTask resume];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSData *certData = [NSData dataWithContentsOfFile:_certPath];
        if (!certData) {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
            return;
        }
        
        SecCertificateRef certRef = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)certData);
        if (!certRef) {
            NSLog(@"Failed to create certificate reference from certData. certData may be invalid.certData要求是DER 编码的 X.509 证书数据。certData 不是这种格式，或者数据被损坏");
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
            return;
        }
        
        NSArray *certArray = @[(__bridge id)certRef];
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        SecTrustRef serverTrust = challenge.protectionSpace.serverTrust;
        SecTrustSetAnchorCertificates(serverTrust, (__bridge CFArrayRef)certArray);
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        
        CFRelease(certRef); // 释放 SecCertificateRef
        
    } else {
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }
}


- (WKWebView *)webView {

        if(_webView == nil){
            
            //创建网页配置对象
            WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
            
            // 创建设置对象
            WKPreferences *preference = [[WKPreferences alloc]init];
            //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
            preference.minimumFontSize = 0;
            //设置是否支持javaScript 默认是支持的
            preference.javaScriptEnabled = YES;
            // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
            preference.javaScriptCanOpenWindowsAutomatically = YES;
            config.preferences = preference;
            
            // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
            config.allowsInlineMediaPlayback = YES;
            //设置视频是否需要用户手动播放  设置为NO则会允许自动播放
            config.mediaTypesRequiringUserActionForPlayback = YES;
            //设置是否允许画中画技术 在特定设备上有效
            config.allowsPictureInPictureMediaPlayback = YES;
            //设置请求的User-Agent信息中应用程序名称 iOS9后可用
            config.applicationNameForUserAgent = @"ChinaDailyForiPad";
            
            //自定义的WKScriptMessageHandler 是为了解决内存不释放的问题
            GuanWeakWebViewDelegate *weakScriptMessageDelegate = [[GuanWeakWebViewDelegate alloc] initWithDelegate:self];
            //这个类主要用来做native与JavaScript的交互管理
            WKUserContentController * wkUController = [[WKUserContentController alloc] init];
            //注册一个name为jsToOcNoPrams的js方法 设置处理接收JS方法的对象
            [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"jsToOcNoPrams"];
            [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"jsToOcWithPrams"];
            
            config.userContentController = wkUController;
            
            //以下代码适配文本大小
            NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
            //用于进行JavaScript注入
            WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
            [config.userContentController addUserScript:wkUScript];
            
            _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height-100) configuration:config];
            // UI代理
//            _webView.UIDelegate = self;
            // 导航代理
            _webView.navigationDelegate = self;
            // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
            _webView.allowsBackForwardNavigationGestures = YES;
            //可返回的页面列表, 存储已打开过的网页
//            WKBackForwardList * backForwardList = [_webView backForwardList];
            
            //        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.chinadaily.com.cn"]];
            //        [request addValue:[self readCurrentCookieWithDomain:@"http://www.chinadaily.com.cn"] forHTTPHeaderField:@"Cookie"];
            //        [_webView loadRequest:request];
            
            
    //        NSString *path = [[NSBundle mainBundle] pathForResource:@"JStoOC.html" ofType:nil];
    //        NSString *htmlString = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //        [_webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
            
//            [self setupCustomUserAgent:_webView];
            
        }
    return _webView;
}

@end
