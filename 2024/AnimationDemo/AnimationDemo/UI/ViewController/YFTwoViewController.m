//
//  YFTwoViewController.m
//  AnimationDemo
//
//  Created by EnforLiu on 15/11/26.
//  Copyright © 2015年 EnforLiu. All rights reserved.
//

#import "YFTwoViewController.h"
#import "YFAnimationCostum.h"

@implementation YFTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //iconImage
        self.iconImageView =[[UIImageView alloc]initWithFrame:CGRectMake(15, 9.5, 25, 25)];
        self.iconImageView.image =[UIImage imageNamed:@"iconImage"];
        [self.contentView addSubview:self.iconImageView];
        
        //nameLabel
        self.nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(WW-200, 5, 180, 34)];
        self.nameLabel.font =[UIFont systemFontOfSize:15.0f];
        self.nameLabel.textAlignment =NSTextAlignmentRight;
        self.nameLabel.textColor =[UIColor blackColor];
        [self.contentView addSubview:self.nameLabel];
        
        self.backgroundColor =[UIColor whiteColor];
        
    }
    
    return self;
}

@end

@interface YFTwoViewController ()

@end

@implementation YFTwoViewController
{
    UIImageView *_imageView;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];    

    [self creatDataSource];
    [self creatUI];
}

#pragma mark - 数据

- (void)creatDataSource {
    
    self.dataSource =[[NSMutableArray alloc]init];
  
    NSArray *curlArray      =@[@"向上翻页",@"向下翻页",@"向左翻页",@"向右翻页"];
    NSArray *flipArray      =@[@"向左翻转",@"向右翻转",@"向上翻转",@"向下翻转"];
    NSArray *pushArray      =@[@"向右推出",@"向左返回"];
    NSArray *presentArray   =@[@"向上提出",@"向下消失"];
    NSArray *cubeArray      =@[@"立方体向上",@"立方体向下",@"立方体向左",@"立方体向右"];
    NSArray *revealArray    =@[@"覆盖向上",@"覆盖向下",@"覆盖向左",@"覆盖向右"];
    NSArray *fadeArray      =@[@"吸收",@"波纹",@"镜头开",@"镜头关",@"淡入"];
    
    [self.dataSource addObject:curlArray];
    [self.dataSource addObject:flipArray];
    [self.dataSource addObject:pushArray];
    [self.dataSource addObject:presentArray];
    [self.dataSource addObject:cubeArray];
    [self.dataSource addObject:revealArray];
    [self.dataSource addObject:fadeArray];

}

#pragma mark - UI

- (void)creatUI {
    
    _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WW, HH)];
    _imageView.image =[UIImage imageNamed:@"background"];
    _imageView.backgroundColor =[UIColor whiteColor];
    _imageView.userInteractionEnabled =YES;
    [self.view addSubview:_imageView];
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(0, 0, 100, 50);
    button.center =_imageView.center;
    [button addTarget:self action:@selector(exchangeView) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.backgroundColor =[UIColor whiteColor];
    button.layer.masksToBounds =YES;
    button.layer.cornerRadius =5;
    [button setTitleColor: [UIColor blackColor]forState:UIControlStateNormal];
    [_imageView addSubview:button];
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WW, HH-113) style:UITableViewStylePlain];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    self.tableView.bounces =NO;
    self.tableView.backgroundColor =[UIColor lightGrayColor];
    [self.view addSubview:self.tableView];

}

- (void)exchangeView {
    
    [self.view.layer removeAllAnimations];
    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.dataSource objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YFTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"YFTableCellTwo"];
    if (!cell) {
        cell =[[YFTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:@"YFTableCellTwo"];
        
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    
    cell.nameLabel.text =self.dataSource[indexPath.section][indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel * headerView =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, WW, 30)];
   
    switch (section) {
        case 0:
            headerView.text =@"    翻页";
            break;
        case 1:
            headerView.text =@"    翻转";
            break;
        case 2:
            headerView.text =@"    Push";
            break;
        case 3:
            headerView.text =@"    Present";
            break;
        case 4:
            headerView.text =@"    立方体";
            break;
        case 5:
            headerView.text =@"    覆盖";
            break;

        default:
            headerView.text =@"    其他";
            break;
            
    }
    headerView.textColor        =[UIColor grayColor];
    headerView.font             =[UIFont systemFontOfSize:17.0f];
    headerView.backgroundColor  =[UIColor lightGrayColor];
    return headerView;
}

#pragma mark - didSelect

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0: {   //翻页
            switch (indexPath.row) {
                case 0:{
                    [YFAnimationCostum animationCurlUp:self.view];
                }break;
                case 1:{
                    [YFAnimationCostum animationCurlDown:self.view];
                }break;
                case 2:{
                    [YFAnimationCostum animationCurlLeft:self.view];
                }break;
                case 3:{
                    [YFAnimationCostum animationCurlRight:self.view];
                }break;

                
            }
        }break;
            
        case 1: {   //翻转
            switch (indexPath.row) {
                case 0:{
                    [YFAnimationCostum animationFlipLeft:self.view];
                }break;
                case 1:{
                    [YFAnimationCostum animationFlipRight:self.view];
                }break;
                case 2:{
                    [YFAnimationCostum animationFlipUp:self.view];
                }break;
                case 3:{
                    [YFAnimationCostum animationFlipDown:self.view];
                }break;

            }

        }break;
            
        case 2: {   //Push
            switch (indexPath.row) {
                case 0:{
                    [YFAnimationCostum animationPushRight:self.view duration:1];
                }break;
                case 1:{
                    [YFAnimationCostum animationPushLeft:self.view duration:1];

                }break;
                    
            }

        }break;
            
        case 3: {   //Present
            switch (indexPath.row) {
                case 0:{
                    [YFAnimationCostum animationMoveUp:self.view duration:1];
                }break;
                case 1:{
                    [YFAnimationCostum animationMoveDown:self.view duration:1];
                }break;
                    
            }

        }break;
        case 4: {   //立方体
            switch (indexPath.row) {
                case 0:{
                    [YFAnimationCostum animationCubeUp:self.view duration:1];
                }break;
                case 1:{
                    [YFAnimationCostum animationCubeDown:self.view duration:1];
                }break;
                case 2:{
                    [YFAnimationCostum animationCubeLeft:self.view duration:1];
                }break;
                case 3:{
                    [YFAnimationCostum animationCubeRight:self.view duration:1];
                }break;

                    
            }
        }break;
        case 5:{    //翻转
            switch (indexPath.row) {
                case 0:{
                    [YFAnimationCostum animationRevealUp:self.view duration:1];
                }break;
                case 1:{
                    [YFAnimationCostum animationRevealDown:self.view duration:1];
                }break;
                case 2:{
                    [YFAnimationCostum animationRevealLeft:self.view duration:1];
                }break;
                case 3:{
                    [YFAnimationCostum animationRevealRight:self.view duration:1];
                }break;
            }
        }break;
        case 6: {   //其他
            switch (indexPath.row) {
                case 0:{
                    [YFAnimationCostum animationSuckEffect:self.view duration:1];
                }break;
                case 1:{
                    [YFAnimationCostum animationRippleEffect:self.view duration:1];
                }break;
                case 2:{
                    [YFAnimationCostum animationCameraOpen:self.view duration:1];
                }break;
                case 3:{
                    [YFAnimationCostum animationCameraClose:self.view duration:1];
                }break;
                case 4:{
                    [YFAnimationCostum animationFade:self.view duration:1];
                }break;


            }
            
        }break;

    }
    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];

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
