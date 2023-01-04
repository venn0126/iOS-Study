//
//  GTHomeAdClearController.m
//  CADisplayLinkTest
//
//  Created by Augus on 2023/1/3.
//

#import "GTHomeAdClearController.h"

@interface GTHomeAdClearController ()

@end

@implementation GTHomeAdClearController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self dismissViewControllerAnimated:NO completion:nil];

    });
    
}


- (void)viewWillAppear:(BOOL)arg1 {
    [super viewWillAppear:arg1];
}


- (void)setBlankViewClickedCallback:(id)arg1 {
    
}


- (long long)preferredInterfaceOrientationForPresentation {
    return 0;
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
