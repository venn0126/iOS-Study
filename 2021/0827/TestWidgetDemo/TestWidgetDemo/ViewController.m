//
//  ViewController.m
//  TestWidgetDemo
//
//  Created by Augus on 2021/8/27.
//

#import "ViewController.h"
#import "SNHotController.h"
#import "SNCastController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *hotButton;
@property (nonatomic, strong) UIButton *castButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"Sohu";
    [self setupSubviews];
    // bing viewmodel
    
    
}



- (void)setupSubviews {
    
    [self.view addSubview:self.hotButton];
    self.hotButton.frame = CGRectMake(100, 200, 100, 100);
    self.hotButton.center = CGPointMake(self.view.center.x, 300);
    
    
    [self.view addSubview:self.castButton];
    self.castButton.frame = CGRectMake(100, 300, 100, 100);
    self.castButton.center = CGPointMake(self.view.center.x, 500);
}

#pragma mark - Button Actions

- (void)hotButtonAction:(UIButton *)sender {
    
    NSLog(@"hot action");
    SNHotController *vc = [[SNHotController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)castButtonAction:(UIButton *)sender {
    
    NSLog(@"cast action");
    SNCastController *vc = [[SNCastController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Lazy load

- (UIButton *)hotButton {
    if (!_hotButton) {
        _hotButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hotButton setTitle:@"Hot" forState:UIControlStateNormal];
        _hotButton.backgroundColor = UIColor.linkColor;
        [_hotButton addTarget:self action:@selector(hotButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hotButton;
}

- (UIButton *)castButton {
    if (!_castButton) {
        _castButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_castButton setTitle:@"Cast" forState:UIControlStateNormal];
        _castButton.backgroundColor = UIColor.darkTextColor;
        [_castButton addTarget:self action:@selector(castButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _castButton;
}
@end
