//
//  ViewController.m
//  Test1103
//
//  Created by Augus on 2020/11/3.
//

#import "ViewController.h"
#import "Common.h"
#import "SlientAuthController.h"
#import "FOSHeaderModel.h"
#import "FOSTool.h"

@interface ViewController ()


@property (nonatomic, strong) UIButton *slientButton;
@property (nonatomic, strong) UIButton *saveDataButton;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSubviews];
    
}


- (void)initSubviews {
    
    self.slientButton.frame = CGRectMake(50, 100, self.view.frame.size.width - 50 * 2, 50);
    [self.view addSubview:self.slientButton];
    
    
    self.saveDataButton.frame = CGRectMake(50, 200, self.view.frame.size.width - 50 * 2, 50);
    [self.view addSubview:self.saveDataButton];
    
    
}


- (void)buttonAction:(UIButton *)sender {
    SlientAuthController *slient = [[SlientAuthController alloc] init];
    slient.userName = @"wwr";
    
    [self.navigationController pushViewController:slient animated:YES];
}


- (void)saveDataAction:(UIButton *)sender {
    FOSHeaderModel *model = [FOSTool unArchivedModel];
    if (!model) {
        model = [[FOSHeaderModel alloc] init];
    }
    
    model.slientContractId = @"D202008064889";
    model.slientProductInfo = @"111111";
    
    [FOSTool saveModel:model];
    [FOSTool fos_authToken:model tokenFinish:^(id  _Nullable result) {

        if ([result isKindOfClass:[NSError class]]) {
            // [self alert:@"保存header信息失败，请重试" finish:^{}];
            NSLog(@"error %@",result);
            return;
        }

        NSLog(@"token--%@",result);
        NSDictionary *dict = (NSDictionary *)result;
        NSInteger code = [[dict objectForKey:@"code"] integerValue];
        if (code != 0) {
            NSLog(@"auth token error--%@",[dict objectForKey:@"msg"]);
            //[self alert:@"保存header信息失败，请重试" finish:^{}];
            return;
        }

        model.accessToken = [dict objectForKey:@"access_token"];
        [FOSTool saveModel:model];
        NSLog(@"保存header信息成功");
    }];
    
}

- (UIButton *)slientButton {
   if (!_slientButton) {
           _slientButton = [UIButton buttonWithType:UIButtonTypeCustom];
           [_slientButton setTitle:@"静默识别" forState:UIControlStateNormal];
           [_slientButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
           [_slientButton setBackgroundColor:[UIColor redColor]];
           _slientButton.layer.cornerRadius = 5.0f;
           [_slientButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
       }
       return _slientButton;
}




- (UIButton *)saveDataButton {
    if (!_saveDataButton) {
        _saveDataButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveDataButton setTitle:@"保存数据" forState:UIControlStateNormal];
        [_saveDataButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveDataButton setBackgroundColor:[UIColor greenColor]];
        _saveDataButton.layer.cornerRadius = 5.0f;
        [_saveDataButton addTarget:self action:@selector(saveDataAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveDataButton;
}
@end
