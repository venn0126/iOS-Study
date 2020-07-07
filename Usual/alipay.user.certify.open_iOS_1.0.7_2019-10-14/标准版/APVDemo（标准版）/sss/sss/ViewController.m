//
//  ViewController.m
//  sss
//
//  Created by zhenjin on 2018/9/19.
//  Copyright © 2018年 zhenjin. All rights reserved.
//

#import "ViewController.h"
#import <AlipayVerifySDK/APVerifyService.h>

@interface ViewController ()

{
    UITextField* _textField;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"支付宝认证测试页";
    [self textField];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 180, self.view.frame.size.width, 50);
    button.backgroundColor = [UIColor colorWithRed:31/255.0f green:144/255.0f blue:230/255.0f alpha:1];
    [button setTitle:@"开始认证" forState:UIControlStateNormal];
    [button setTitle:@"开始认证" forState:UIControlStateHighlighted];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(customTest) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    testButton.frame = CGRectMake(0, 300, self.view.frame.size.width, 50);
    testButton.backgroundColor = [UIColor colorWithRed:31/255.0f green:144/255.0f blue:230/255.0f alpha:1];
    [testButton setTitle:@"内部测试页面" forState:UIControlStateNormal];
    [testButton setTitle:@"内部测试页面" forState:UIControlStateHighlighted];
    [self.view addSubview:testButton];
    [testButton addTarget:self action:@selector(defaultTest) forControlEvents:UIControlEventTouchUpInside];
}

- (void)customTest{
    NSString* url = _textField.text;
    url = @"https://openapi.alipay.com/gateway.do?biz_content=%7B%22certify_id%22%3A%22cce8648fe460d7ab359b8efab5dd8bb0%22%7D&sign=f2DOs6CZAk0OySW717Vy5yvtRQkcGKr6urr2iogSuDjpxAdH2cTSJGmXleXIL2W27czKPK8i2VtkLo78ZvKNB4t5B1Mxoz5XmN%2FicJFSb4ccAn33pXo4Ufu9BM63Sgns3bEKTGW%2F6K%2FDY2knoCc2KL%2F8kqmeGcFR%2BxaPAMB9nmbLFB0TE56gWi6IGWtf4Yw4EorPTwTokp6tRVdjDIRuuHnhNojmAdBmt%2BHtp7MZgQUlpQHr3xHjHW3mmQVa9socz0EwSh8WAUr8gr5Lp2IeInq9X0Izg99pTZw1zwCpMleEvnPXBgkjm9sLDt8Q3oCBTmE8tkOCzJlTtrKIxGWddw%3D%3D&timestamp=2019-10-14+11%3A33%3A19&sign_type=RSA2&charset=UTF-8&app_id=2019052965433001&method=alipay.user.certify.open.certify&version=1.0";
    [[APVerifyService sharedService] startVerifyService:@{@"url": url?:@"",
                                                          @"certifyId": @"test-certifyId",
                                                          @"ext": @"test-extInfo"
                                                          } target:self block:^(NSMutableDictionary * resultDic){
                                                              NSLog(@"%@", resultDic);
                                                          }];
}

- (void)defaultTest{
    [[APVerifyService sharedService] startVerifyService:@{@"url": @"https://fengdie.alipay.com/p/f/dev-jp17v2yi/pages/home/index.html",
                                                          @"certifyId": @"test-certifyId",
                                                          @"ext": @"test-extInfo"
                                                          } target:self block:^(NSMutableDictionary * resultDic){
                                                              NSLog(@"%@", resultDic);
                                                          }];
}

- (void)textField{
    int btnWidth = 300;
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - btnWidth/2,100 , btnWidth, 50)];
        _textField.layer.borderWidth = 1.0;
        _textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _textField.layer.cornerRadius = 4.0;
        _textField.placeholder = @"请输入url";
        [self.view addSubview:_textField];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
