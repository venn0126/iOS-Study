//
//  JCCSettingsController.m
//  TestHookEncryption
//
//  Created by Augus on 2023/8/14.
//

#import "JCCSettingsController.h"
#import "GuanTableView.h"
#import "GuanUITool.h"

@interface JCCSettingsController ()


@property (nonatomic, strong) GuanTableView *tableView;


@end

@implementation JCCSettingsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"超跑助手";
    self.view.backgroundColor = UIColor.whiteColor;
    
    // 添加导航栏
    [self addNavgationBar];
    [self.view addSubview:self.tableView];
}


- (void)addNavgationBar {
    // bottom view
    UIView *navgationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [GuanUITool guan_navigationViewHeight])];
    navgationView.backgroundColor = [GuanUITool guan_red:37 green:185 blue:202];
    
    UILabel *guanTitleLabel = [[UILabel alloc] init];
    guanTitleLabel.text = @"超跑助手";
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


- (GuanTableView *)tableView {
    if(!_tableView) {
        
        CGFloat y = [GuanUITool guan_navigationViewHeight];
        _tableView = [[GuanTableView alloc] initWithFrame:CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height - y) style:UITableViewStyleGrouped];
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
