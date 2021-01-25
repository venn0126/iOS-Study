//
//  ViewController.m
//  testBlock
//
//  Created by Augus on 2021/1/25.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
}

- (void)testSendMsg {
    
    /*
     
     objc_msgSend的动作比较清晰：首先在Class中的缓存查找imp（没缓存则初始化缓存），如果没找到，则向父类的Class查找。如果一直查找到根类仍旧没有实现，则用_objc_msgForward函数指针代替imp。最后，执行这个imp。

     _objc_msgForward是用于消息转发的。这个函数的实现并没有在objc-runtime的开源代码里面，而是在Foundation框架里面实现的。加上断点启动程序后，会发现__CFInitialize这个方法会调用objc_setForwardHandler函数来注册一个实现。
     */
}


@end
