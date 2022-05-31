#import <Foundation/Foundation.h>

%hook ViewController

- (void)testMutableDictionary:(id)sender {
	NSLog(@"it is hook here");
	%log;
	%orig;
}

%end