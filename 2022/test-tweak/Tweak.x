// 导入引用的相关库的头文件
#import <UIKit/UIKit.h>

// 前置声明，保证view属性可以被调用
@interface ViewController : UIViewController

@property(nonatomic, strong) UIView *view;

@end


%hook ViewController

- (void)testTweakClick {

	UIView *view = [[UIView alloc] init];
	view.frame = CGRectMake(100, 100, 100, 100);
	view.backgroundColor = UIColor.redColor;
	[self.view addSubview:view];
}


%end