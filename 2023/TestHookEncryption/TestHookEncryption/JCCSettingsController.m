//
//  JCCSettingsController.m
//  TestHookEncryption
//
//  Created by Augus on 2023/8/14.
//

#import "JCCSettingsController.h"
#import "GuanTableView.h"

@interface JCCSettingsController ()


@property (nonatomic, strong) GuanTableView *tableView;


@end

@implementation JCCSettingsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"JCC聚的助手";
    self.view.backgroundColor = UIColor.greenColor;
    
    [self.view addSubview:self.tableView];
    
    
}


- (GuanTableView *)tableView {
    if(!_tableView) {
        CGFloat y = 64;
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
