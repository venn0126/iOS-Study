//
//  ViewController.h
//  NWUITest
//
//  Created by Augus on 2021/4/22.
//

#import <UIKit/UIKit.h>

typedef void(^callBack) (id param);

extern NSString *const AppViewControllerRefreshNotificationName;


@interface ViewController : UIViewController

- (void)printName:(NSString *)name;
- (void)printName:(NSString *)name callBack:(callBack)callBack;


@end

