//
//  SNCastDetailController.m
//  TestWidgetDemo
//
//  Created by Augus on 2021/8/28.
//

#import "SNCastDetailController.h"

@interface SNCastDetailController ()

@end

@implementation SNCastDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    if ([self.params objectForKey:@"title"]) {
        self.title = [self.params objectForKey:@"title"] ?: @"unknown";
    }
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
