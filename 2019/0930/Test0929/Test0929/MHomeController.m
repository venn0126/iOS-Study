//
//  MHomeController.m
//  Test0929
//
//  Created by 牛威 on 2019/9/30.
//  Copyright © 2019 fosafer. All rights reserved.
//

#import "MHomeController.h"

@interface MHomeController ()

@property (nonatomic, strong) UIButton *button;


@end

@implementation MHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
        self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"home"].CGImage);
    [self.view addSubview:self.button];
    self.button.frame = CGRectMake(0, 0, 50, 50);
    self.button.center = CGPointMake(self.view.center.x, self.view.center.y + 250);
    self.button.layer.cornerRadius = 25.0;

}

- (void)buttonAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor redColor];
        [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
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
