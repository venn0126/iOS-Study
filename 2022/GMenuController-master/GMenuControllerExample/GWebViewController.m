//
//  GWebViewController.m
//  GMenuControllerExample
//
//  Created by GIKI on 2017/10/19.
//  Copyright © 2017年 GIKI. All rights reserved.
//

#import "GWebViewController.h"
#import "GWKWebView.h"
#import <WebKit/WebKit.h>
#import "WKWebView+DeleteMenuItems.h"
#import "UIMenuController+Observse.h"


@interface GWebViewController () <WKNavigationDelegate, WKUIDelegate>
@property (nonatomic, strong) GWKWebView  *webView;
@property (nonatomic, assign) BOOL isDismiss;
@end

@implementation GWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    GWKWebView *webView = [[GWKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];

    webView.UIDelegate = self;
    webView.navigationDelegate = self;
//    webView.longPressDelegate = self;
//    [webView addLongPressGesture];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    self.webView = webView;

    
    
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
//    self.webView.frame = self.view.bounds;
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"didStartProvisionalNavigation");
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"didCommitNavigation");
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"didFinishNavigation");
}


//- (void)webView:(WKWebView*)webView decidePolicyForNavigationAction:(WKNavigationAction*)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//
//  // 如果为长按操作，中断页面加载
//    if (webView.isNotPushLink) { decisionHandler(WKNavigationActionPolicyCancel); return; }
//
//    decisionHandler(WKNavigationActionPolicyAllow);
//}


#pragma mark - WKLongPressDelegate

// 实现长按webview中的图片代理，当满足自定义条件后触发
- (void)webViewOnLongPressHandlerWithWebView:(WKWebView *)webView withImageUrl:(NSString *)imageUrl {
    
    // 处理长按图片业务代码， 如弹框展示 保存图片、识别二维码 等
    NSLog(@"处理长按图片业务代码， 如弹框展示 保存图片、识别二维码 等");
    
}



@end
