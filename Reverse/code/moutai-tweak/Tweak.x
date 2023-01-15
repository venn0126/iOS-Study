#import <Foundation/Foundation.h>


%hook MTLoginViewController

- (void)viewDidLoad {

	%orig;
	NSLog(@"tian is my life");
}

%end