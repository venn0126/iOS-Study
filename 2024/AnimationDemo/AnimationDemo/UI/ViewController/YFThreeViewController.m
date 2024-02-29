//
//  YFThreeViewController.m
//  AnimationDemo
//
//  Created by EnforLiu on 15/11/26.
//  Copyright © 2015年 EnforLiu. All rights reserved.
//

#import "YFThreeViewController.h"
#import "YFFiveViewController.h"
@interface YFThreeViewController ()

@end

@implementation YFThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];

    self.dataSource = @[@"define",@"翻页",@"翻页二",@"翻转",@"立方体",@"吸收",@"波纹",@"镜头",@"覆盖",@"淡入"];
    
    [self createUI];
}

- (void)createUI {
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WW, HH-113) style:UITableViewStylePlain];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    self.tableView.bounces =NO;
    self.tableView.backgroundColor =[UIColor lightGrayColor];
    [self.view addSubview:self.tableView];
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YFTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"YFTableCellTwo"];
    if (!cell) {
        cell =[[YFTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YFTableCellTwo"];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
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
    YFFiveViewController * five = [[YFFiveViewController alloc]init];
    switch (indexPath.row) {
        case 0:{    //defin
            [self.navigationController pushViewController:five withAnimated:YFPushAnimationDefine];
        } break;
        case 1:{    //翻页
            [self.navigationController pushViewController:five withAnimated:YFPushAnimationCurl];
        } break;
        case 2:{    //翻页2
            [self.navigationController pushViewController:five withAnimated:YFPushAnimationCurlTWo];
        } break;
        case 3:{    //翻转
            [self.navigationController pushViewController:five withAnimated:YFPushAnimationFlip];
        } break;
        case 4:{    //立方体
            [self.navigationController pushViewController:five withAnimated:YFPushAnimationCube];
        } break;
        case 5:{    //吸收
            [self.navigationController pushViewController:five withAnimated:YFPushAnimationSuckEffect];
        } break;
        case 6:{    //波纹
            [self.navigationController pushViewController:five withAnimated:YFPushAnimationRippleEffect];
        } break;
        case 7:{    //镜头
            [self.navigationController pushViewController:five withAnimated:YFPushAnimationCameraIris];
        } break;
        case 8:{    //覆盖
            [self.navigationController pushViewController:five withAnimated:YFPushAnimationReveal];
        } break;
        case 9:{    //淡入
            [self.navigationController pushViewController:five withAnimated:YFPushAnimationFade];
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
