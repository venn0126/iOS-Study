//
//  IconController.m
//  TestBundle
//
//  Created by Augus on 2021/1/23.
//

#import "IconController.h"

@interface IconController ()

@end

@implementation IconController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.greenColor;    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageView.center = self.view.center;
    imageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:imageView];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"TestBundle.framework/kzq" ofType:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithPath:bundlePath];
    NSString *imagePath = [imageBundle pathForResource:@"icon1024" ofType:@"png"];
    NSLog(@"0123------");
    imageView.image = [UIImage imageWithContentsOfFile:imagePath];
    NSLog(@"0124------");

    
    
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
