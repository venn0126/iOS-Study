//
//  MCustomTransitionController.m
//  Test0929
//
//  Created by 牛威 on 2019/9/30.
//  Copyright © 2019 fosafer. All rights reserved.
//

#import "MCustomTransitionController.h"
#import "FadeTransition.h"

@interface MCustomTransitionController ()<UIViewControllerTransitioningDelegate>

@end

@implementation MCustomTransitionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.transitioningDelegate = self;
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    
    return [[FadeTransition alloc] initTransitionDuration:0.5 startingAlpha:0.8];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    return [[FadeTransition alloc] initTransitionDuration:0.5 startingAlpha:0.8];

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
