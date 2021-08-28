//
//  ViewController.m
//  TestWidgetDemo
//
//  Created by Augus on 2021/8/27.
//

#import "ViewController.h"
#import "SNHotController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *hotButton;
@property (nonatomic, strong) UIButton *humanButton;




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
}

#pragma mark - Button Actions

- (void)buttonAction:(UIButton *)sender {
    
    NSLog(@"hot action");
    SNHotController *vc = [[SNHotController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Lazy load

- (UIButton *)hotButton {
    if (!_hotButton) {
        _hotButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hotButton setTitle:@"Hot" forState:UIControlStateNormal];
        _hotButton.backgroundColor = UIColor.linkColor;
        [_hotButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hotButton;
}


@end
