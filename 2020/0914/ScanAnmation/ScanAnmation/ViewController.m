//
//  ViewController.m
//  ScanAnmation
//
//  Created by Augus on 2020/9/14.
//  Copyright © 2020 Fosafer. All rights reserved.
//

#import "ViewController.h"
#import "FOSScanView.h"

@interface ViewController ()

@end

@implementation ViewController{
    
    FOSScanView *_scanView;    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _scanView = [[FOSScanView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:_scanView];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if (!_scanView.fosAnmating) {
        [_scanView continueAnimation];
    } else {
        [_scanView pauseAnimation];
    }

}


@end
