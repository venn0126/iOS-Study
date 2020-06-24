//
//  SecondController.m
//  JRTT
//
//  Created by Augus on 2020/6/22.
//  Copyright © 2020 fosafer. All rights reserved.
//

#import "SecondController.h"
#import "FOSProxy.h"

@interface SecondController ()

@property (nonatomic, strong) CADisplayLink *link;



@end

@implementation SecondController

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"---%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"second vc";
    self.view.backgroundColor = [UIColor greenColor];
    [self test_proxy];
}

- (void)test_proxy {
    
    self.link = [CADisplayLink displayLinkWithTarget:[FOSProxy proxyWithTarget:self] selector:@selector(linkTest)];
    
    
     // 内存泄漏
//    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkTest)];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}


- (void)linkTest {
    
    NSLog(@"sssss");
}

- (void)dealloc {
    
    NSLog(@"----%s",__func__);
    [self.link invalidate];
    self.link = nil;
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
