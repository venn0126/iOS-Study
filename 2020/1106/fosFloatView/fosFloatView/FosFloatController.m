//
//  FosFloatController.m
//  fosFloatView
//
//  Created by Augus on 2020/11/9.
//

#import "FosFloatController.h"
#import "FSBottomView.h"

@interface FosFloatController ()


@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) FSBottomView *bottomView;


@end

@implementation FosFloatController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"FloatVC";
    // 45 40 88
    self.view.backgroundColor =  RGB(45,40,88);
        
    [self initSubviews];

}


- (void)initSubviews {
    
    // close button
    [self.view addSubview:self.closeButton];
    self.closeButton.frame = CGRectMake(10, 30, 30, 30);
    
    [self bottomView];
    
    
}

- (void)leftButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];

}

#pragma mark - Lazy

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setTitle:@"X" forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _closeButton;
}


- (FSBottomView *)bottomView {
    if (!_bottomView) {
        CGFloat h = 60;
        FSBottomView *bottom = [[FSBottomView alloc] initWithFrame:CGRectMake(0, h, FOS_SCREEN_WIDTH, FOS_SCREEN_HEIGHT - h)];
        [self.view addSubview:bottom];
        _bottomView = bottom;
    }
    return _bottomView;
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
