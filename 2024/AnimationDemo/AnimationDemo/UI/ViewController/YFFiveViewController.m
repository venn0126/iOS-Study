//
//  YFFiveViewController.m
//  AnimationDemo
//
//  Created by EnforLiu on 15/11/30.
//  Copyright © 2015年 EnforLiu. All rights reserved.
//

#import "YFFiveViewController.h"

@interface YFFiveViewController ()

@end

@implementation YFFiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"返回";
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor grayColor];
    
    self.dataSource = @[@"返回->define",@"返回->翻页",
                        @"返回->翻页二",@"返回->翻转",
                        @"返回->立方体",@"返回->吸收",@"返回->波纹",
                        @"返回->镜头",@"返回->覆盖",@"返回->淡出"];
    
    [self createUI];

}

- (void)createUI {
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(pushView)];
    self.navigationItem.leftBarButtonItem = item;
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WW, HH-113) style:UITableViewStylePlain];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    self.tableView.bounces =NO;
    self.tableView.backgroundColor =[UIColor lightGrayColor];
    [self.view addSubview:self.tableView];
    
}

- (void)pushView {
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YFTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"YFTableCellTwo"];
    if (!cell) {
        cell =[[YFTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:@"YFTableCellTwo"];
        
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
//        cell.backgroundColor = [UIColor lightTextColor];
    }
    cell.nameLabel.text =self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - didSelect

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:{    //defin
            [self.navigationController popViewControllerWithAnimated:YFPushAnimationDefine];
        } break;
        case 1:{    //翻页
            [self.navigationController popViewControllerWithAnimated:YFPushAnimationCurl];
        } break;
        case 2:{    //翻页二
            [self.navigationController popViewControllerWithAnimated:YFPushAnimationCurlTWo];
        } break;
        case 3:{    //翻转
            [self.navigationController popViewControllerWithAnimated:YFPushAnimationFlip];
        } break;
        case 4:{    //立方体
            [self.navigationController popViewControllerWithAnimated:YFPushAnimationCube];
        } break;
        case 5:{    //吸收
            [self.navigationController popViewControllerWithAnimated:YFPushAnimationSuckEffect];
        } break;
        case 6:{    //波纹
            [self.navigationController popViewControllerWithAnimated:YFPushAnimationRippleEffect];
        } break;
        case 7:{    //镜头
            [self.navigationController popViewControllerWithAnimated:YFPushAnimationCameraIris];
        } break;
        case 8:{    //覆盖
            [self.navigationController popViewControllerWithAnimated:YFPushAnimationReveal];
        } break;
        case 9:{    //覆盖
            [self.navigationController popViewControllerWithAnimated:YFPushAnimationFade];
        } break;

            
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
