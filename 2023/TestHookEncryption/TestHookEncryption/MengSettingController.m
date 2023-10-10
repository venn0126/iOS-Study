//
//  MengSettingController.m
//  TestHookEncryption
//
//  Created by Augus on 2023/10/11.
//

#import "MengSettingController.h"
#import "MengTableView.h"
#import "GuanUITool.h"


@interface MengSettingController ()

@property (nonatomic, strong) MengTableView *tableView;


@end

@implementation MengSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Meng全局配置";
    self.view.backgroundColor = UIColor.whiteColor;
    [self addNavgationBar];
    [self.view addSubview:self.tableView];

}


- (void)addNavgationBar {
    // bottom view
    UIView *navgationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [GuanUITool guan_navigationViewHeight])];
    navgationView.backgroundColor = [GuanUITool guan_red:109 green:53 blue:186];
    
    UILabel *guanTitleLabel = [[UILabel alloc] init];
    guanTitleLabel.text = @"配置列表";
    guanTitleLabel.textColor = UIColor.whiteColor;
    guanTitleLabel.font = [UIFont boldSystemFontOfSize:20];
    [guanTitleLabel sizeToFit];
    guanTitleLabel.y = GuanStatusBarHeight();
    guanTitleLabel.centerX = navgationView.centerX;
    [navgationView addSubview:guanTitleLabel];
    
    
    // 70 44
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:18];
    backButton.size = CGSizeMake(70, 44);
    backButton.centerY = guanTitleLabel.centerY;
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [navgationView addSubview:backButton];
    
    [self.view addSubview:navgationView];
    
    
}

- (void)backButtonAction:(UIButton *)sender {
    

    [self dismissViewControllerAnimated:YES completion:nil];
}


- (MengTableView *)tableView {
    if(!_tableView) {
        
        CGFloat y = [GuanUITool guan_navigationViewHeight];
        _tableView = [[MengTableView alloc] initWithFrame:CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height - y) style:UITableViewStyleGrouped];
    }
    return _tableView;
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
