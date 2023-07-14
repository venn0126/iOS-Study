//
//  Md5ViewController.m
//  A0CrackMe
//
//  Created by andyhah on 2023/5/3.
//

//设备的宽高
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define KEY @"andyhah"
#define FLAG @"md5String"

#import <Foundation/Foundation.h>
#import "Md5ViewController.h"
#import "CrackArrayDefaults.h"
#import "Tools.h"

@interface Md5ViewController ()

@end

@implementation Md5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel* desc = [[UILabel alloc] initWithFrame:CGRectMake((SCREENWIDTH-400)/2, 100, 400, 50)];
    [desc setText:@"请输入md5字符串，并提交验证"];
    desc.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:desc];
    
    self.input = [[UITextField alloc] initWithFrame:CGRectMake((SCREENWIDTH-400)/2, 200, 400, 50)];
    self.input.borderStyle = UITextBorderStyleRoundedRect;
    self.input.placeholder = @"请输入...";
    self.input.clearsOnBeginEditing = YES;
    [self.view addSubview:self.input];

    
    
    UIButton* submit = [[UIButton alloc] initWithFrame:CGRectMake((SCREENWIDTH-100)/2, 300, 100, 40)];
    [submit setTitle:@"提交" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    submit.backgroundColor = [UIColor colorWithRed:255/255.0 green:239/255.0 blue:213/255.0 alpha:1];
    [self.view addSubview:submit];
    
    // 点击事件
    [submit addTarget:self action:@selector(check) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)check{
    
    NSString* secret = [Tools md5Encrypt:KEY];
    
    NSString* ipt_txt = self.input.text;
    ipt_txt = [ipt_txt stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    Boolean result = [ipt_txt isEqualToString:secret];
    if (result){
        // 改变值
        [[CrackArrayDefaults alloc] modifyCrackIsPass:nil flag:FLAG is_pass:true];
    }
    [Tools printTipAtResult:result View:self];
    
    
}


@end
