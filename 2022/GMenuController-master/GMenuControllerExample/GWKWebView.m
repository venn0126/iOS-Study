//
//  GWKWebView.m
//  GMenuControllerExample
//
//  Created by GIKI on 2017/10/19.
//  Copyright © 2017年 GIKI. All rights reserved.
//

#import "GWKWebView.h"
#import <GMenuController/GMenuController.h>

@implementation GWKWebView

- (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration {
    self = [super initWithFrame:frame configuration:configuration];
    if (!self) {
        return nil;
    }
    
//    [self resetMenuController];
    [self disableMenuController];
    [self evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
//    [self  evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';"completionHandler:nil];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        [self p_commonInit];
        // 禁止长按弹出 UIMenuController
        [self disableMenuController];
        [self evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
//        [self  evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';"completionHandler:nil];
//        [self resetMenuController];
    }
    return self;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    

    NSLog(@"%@---%@",@(__func__),@(__LINE__));

//    [self evaluateJavaScript:[NSString stringWithFormat:@"window.getSelection().getRangeAt(0);"] completionHandler:^(id _Nullable response, NSError * _Nullable error) {
//
//        if (response) {
//            NSLog(@"evaluateJavaScript response-- %@",response);
//
//
//        }
//    }];
    
    
    if (action == @selector(sn_copy:) || action == @selector(sn_posterShare:) || action == @selector(sn_search:)) {
//        [self setupMenuController:sender];
        
        // reset system menun
        
        
//        GMenuItem *item1 = [[GMenuItem alloc] initWithTitle:@"选择a" target:self action:@selector(test)];
//        GMenuItem *item2 = [[GMenuItem alloc] initWithTitle:@"复制b" target:self action:@selector(test)];
//        GMenuItem *item3 = [[GMenuItem alloc] initWithTitle:@"全选c" target:self action:@selector(test)];
//        NSArray *arr1 = @[item1,item2,item3];
//        [[GMenuController sharedMenuController] setMenuItems:arr1];
//
//        if ([sender isKindOfClass:[UIMenuController class]]) {
//            UIMenuController *menu = (UIMenuController *)sender;
//            if (menu.isMenuVisible) {
//                [menu setMenuVisible:NO animated:NO];
//            }
////            [menu hideMenu];
//            [menu setMenuItems:nil];
//            [menu update];
//
//            [[GMenuController sharedMenuController] setTargetRect:menu.menuFrame inView:self];
//            [[GMenuController sharedMenuController] setMenuVisible:YES];
//        }
            
        return YES;
    }
    
//    if (action == @selector(copy:)) {
//        return YES;
//    }
    return NO;
//    return [super canPerformAction:action withSender:sender];
}

- (void)sn_copy:(id)sender {
    NSLog(@"%@---%@---share",@(__func__),@(__LINE__));
    NSLog(@"选中的文字为---%@",[UIPasteboard generalPasteboard].string);


}


- (void)sn_posterShare:(id)sender {

    [self evaluateJavaScript:@"window.getSelection().toString()" completionHandler:^(NSString * _Nullable str, NSError * _Nullable error) {

        UIPasteboard *board = [UIPasteboard generalPasteboard];
        board.string = str;
        NSLog(@"海报分享 ---%@",str);
    }];
}


- (void)sn_search:(id)sender{

    NSLog(@"self search");
    
    [self evaluateJavaScript:@"window.getSelection().toString()" completionHandler:^(NSString * _Nullable str, NSError * _Nullable error) {
        
        NSString *url = [NSString stringWithFormat:@"https://www.baidu.com/s?wd=%@",str];
        
        NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)url,(CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",NULL,kCFStringEncodingUTF8));
        NSLog(@"sss %@",encodedString);
//
//        SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:encodedString]];
//
//        safariVC.modalPresentationStyle = UIModalPresentationFormSheet;
//        [self presentViewController:safariVC animated:YES completion:nil];
    }];
}


//- (void)test {
//    [[GMenuController sharedMenuController] setMenuVisible:NO];
//    NSLog(@"hhhhh");
//}
//
//- (void)pressesBegan:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event NS_AVAILABLE_IOS(9_0)
//{NSLog(@"pressesBegan");}
//- (void)pressesChanged:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event NS_AVAILABLE_IOS(9_0){NSLog(@"pressesChanged");}
//- (void)pressesEnded:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event NS_AVAILABLE_IOS(9_0){NSLog(@"pressesEnded");}
//- (void)pressesCancelled:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event NS_AVAILABLE_IOS(9_0){NSLog(@"pressesCancelled");}
//
//- (void)motionBegan:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event NS_AVAILABLE_IOS(3_0){NSLog(@"motionBegan");}
//- (void)motionEnded:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event NS_AVAILABLE_IOS(3_0){NSLog(@"motionEnded");}
//- (void)motionCancelled:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event{
//
//    NSLog(@"motionCancelled");
//}


- (void)resetMenuController {
    
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController.menuVisible) {
        [menuController setMenuVisible:NO animated:YES];
        return;
    }
    
    [menuController setMenuItems:nil];
    
    UIMenuItem *selectAllItem = nil;
    if (@available(iOS 10.0, *)) {
        selectAllItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(sn_copy:)];
    }
    
    NSMutableArray *customItems = [NSMutableArray arrayWithObjects:selectAllItem, nil];
    [customItems addObject:[[UIMenuItem alloc] initWithTitle:@"海报分享" action:@selector(sn_posterShare:)]];
    [customItems addObject:[[UIMenuItem alloc] initWithTitle:@"搜索" action:@selector(sn_search:)]];
    
    [menuController setMenuItems:customItems];
    [menuController update];
}

- (void)disableMenuController {
    
    NSString*css = @"body{-webkit-user-select:none;-webkit-user-drag:none;}";
    NSMutableString*javascript = [NSMutableString string];
    [javascript appendString:@"var style = document.createElement('style');"];
    [javascript appendString:@"style.type = 'text/css';"];
    [javascript appendFormat:@"var cssContent = document.createTextNode('%@');", css];
    [javascript appendString:@"style.appendChild(cssContent);"];
    [javascript appendString:@"document.body.appendChild(style);"];
    [javascript appendString:@"document.documentElement.style.webkitUserSelect='none';"];
    [javascript appendString:@"document.documentElement.style.webkitTouchCallout='none';"];
    // javascript注入
    WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:javascript
                                                            injectionTime:WKUserScriptInjectionTimeAtDocumentEnd
                                                         forMainFrameOnly:YES];
    
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addUserScript:noneSelectScript];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    
    [self.configuration.userContentController addUserScript:noneSelectScript];
}
@end
