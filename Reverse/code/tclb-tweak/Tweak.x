#import <Foundation/Foundation.h>



%hook QAVPttConfigCenter


- (id)URLEncodedString:(id)arg1 {

	NSLog(@"tian1 URLEncodedString %@",arg1);

	return %orig;
}


%end


%hook MSManagerML


- (id)doHttpReqSignByUrl:(id)arg1 Body:(id)arg2 {


	NSLog(@"tian2 doHttpReqSignByUrl %@-body %@",arg1,arg2);

	return %orig;
}


%end


%hook ARDSignalingMessage


+ (id)messageFromJSONString:(id)arg1 {


	NSLog(@"tian3 messageFromJSONString %@",arg1);
	return %orig;
}


%end