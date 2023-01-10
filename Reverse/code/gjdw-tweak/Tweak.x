// 相关头文件
#import <UIKit/UIKit.h>


// 相关前置声明


@interface GDTHomeViewController

@property(retain, nonatomic) UIButton *signInBtn;

@end



// hook逻辑代码

%hook GDTHomeViewController

- (void)viewDidAppear:(_Bool)arg1 {
	%orig;

	// 强制显示签到按钮
	self.signInBtn.hidden = NO;

	// clickButton
 	// dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
  //       // [self dismissViewControllerAnimated:NO completion:nil];
  //       NSLog(@"tian is before");
 	// 	if([self.signInBtn respondsToSelector:@selector(clickButton)]) {
 	// 		 NSLog(@"tian is after");
 	// 		[self.signInBtn performSelector:@selector(clickButton) withObject:nil];

 	// 	}

  //   });

}



%end