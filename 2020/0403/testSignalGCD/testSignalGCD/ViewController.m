//
//  ViewController.m
//  testSignalGCD
//
//  Created by Augus on 2020/4/3.
//  Copyright © 2020 fosafer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    for (int i = 0; i < 100000; i++) {
        
        [self testSignal];
    }

}


- (void)testSignal {
    
    dispatch_semaphore_t semaphore_video = dispatch_semaphore_create(0);

    
    dispatch_async(dispatch_get_global_queue(2, 0), ^{
        
        NSLog(@"1---%@",semaphore_video.debugDescription);
        dispatch_semaphore_wait(semaphore_video, DISPATCH_TIME_FOREVER);
        NSLog(@"2---%@",semaphore_video.debugDescription);

        
    });
    
    dispatch_async(dispatch_get_global_queue(2, 0), ^{
        NSLog(@"3---%@",semaphore_video.debugDescription);

        dispatch_semaphore_signal(semaphore_video);
        NSLog(@"4---%@",semaphore_video.debugDescription);

    });
    NSLog(@"5---%@",semaphore_video.debugDescription);
}


@end
