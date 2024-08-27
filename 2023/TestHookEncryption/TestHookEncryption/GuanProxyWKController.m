//
//  GuanProxyWKController.m
//  TestHookEncryption
//
//  Created by Augus on 2024/8/27.
//

#import "GuanProxyWKController.h"
#import "GuanWebViewProxy.h"

@interface GuanProxyWKController ()

@end

@implementation GuanProxyWKController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self testWebProxy];
}


- (void)testWebProxy {
    
    GuanWebViewProxy *proxy = [[GuanWebViewProxy alloc] init];
    [self.view addSubview:proxy.webView];
    proxy.webView.frame = self.view.bounds;
    [proxy loadRequestWithURL:@"https://steamcommunity.com/login/home/?goto=" proxy:@"http://119.12.164.74" certPath:[[NSBundle mainBundle] pathForResource:@"newproxy-ca-cert" ofType:@"cer"]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
