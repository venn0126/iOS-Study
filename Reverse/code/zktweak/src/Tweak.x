#import "GTHomeAdClearController.h"


/// 去除zk助手的广告，只作为学习交流，请勿商用

%hook GDTMaskViewController

- (id)initWithNibName:(id)arg1 bundle:(id)arg2 {
	
	GTHomeAdClearController *vc = [[GTHomeAdClearController alloc] init];
	NSLog(@"Tian is my wife");
	return vc;
}
%end

