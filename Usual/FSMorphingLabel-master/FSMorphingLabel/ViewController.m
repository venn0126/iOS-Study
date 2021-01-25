//
//  ViewController.m
//  FSMorphingLabel
//
//  Created by 翁志方 on 2017/12/19.
//  Copyright © 2017年 wzf. All rights reserved.
//

#import "ViewController.h"
#import "TestMorphingLabelViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnClked:(id)sender {
    
    TestMorphingLabelViewController *vc = [TestMorphingLabelViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
