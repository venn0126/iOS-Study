//
//  MLoginController.m
//  Test0929
//
//  Created by 牛威 on 2019/9/30.
//  Copyright © 2019 fosafer. All rights reserved.
//

#import "MLoginController.h"
#import "MTransitionButton.h"
#import "MHomeController.h"

@interface MLoginController ()

@property (nonatomic, strong) MTransitionButton *mbutton;

@end

@implementation MLoginController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"login"].CGImage);
    
    [self setup];
}

- (void)setup {
    
    [self.view addSubview:self.mbutton];
    self.mbutton.frame = CGRectMake(0, 0, 320, 50);
    self.mbutton.center = CGPointMake(self.view.center.x, self.view.center.y + 250);
}

- (void)mbuttonAction:(MTransitionButton *)sender {
    
    [sender startAnimation];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3)), dispatch_get_main_queue(), ^{
        
        [sender stopAnimation:MTransitionButtonExpand delay:5 completion:^{
            
                MHomeController *home = [[MHomeController alloc] init];
                [self presentViewController:home animated:YES completion:nil];
        }];
        
    });

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (MTransitionButton *)mbutton {
    if (!_mbutton) {
        _mbutton = [[MTransitionButton alloc] init];
        _mbutton.backgroundColor = [UIColor redColor];
        [_mbutton setTitle:@"submit" forState:UIControlStateNormal];
        _mbutton.titleLabel.textColor = [UIColor whiteColor];
        _mbutton.layer.cornerRadius = 25.0;
        [_mbutton addTarget:self action:@selector(mbuttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mbutton;
}

@end
