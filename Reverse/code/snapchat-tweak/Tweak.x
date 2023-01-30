#import <Foundation/Foundation.h>


%hook SCOneTapLoginArchiveTokenManager


- (void)setWithNewToken:(id)arg1 userId:(id)arg2 {

    // 存储到本地路径
    // 形式是[{userId:token},{userId:token}...]
    // 

    NSLog(@"tian setWithNewToken %@ userId %@",arg1,arg2);
    %orig;
}
%end