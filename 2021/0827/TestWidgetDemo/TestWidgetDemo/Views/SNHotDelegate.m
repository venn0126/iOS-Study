//
//  SNHotDelegate.m
//  TestWidgetDemo
//
//  Created by Augus on 2021/8/28.
//

#import "SNHotDelegate.h"
#import "SNHotViewCell.h"
#import "SNHotDetailController.h"
#import "SNCastDetailController.h"

@implementation SNHotDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return  80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    SNHotViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    NSString *title = cell.mainTitle ?: @"unknown";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:title forKey:@"title"];
    
    
    if ([title containsString:@"Hot"]) {
        SNHotDetailController *detail  = [[SNHotDetailController alloc] init];
        detail.params = [dict copy];
        
        
        [[self topViewController].navigationController pushViewController:detail animated:YES];
        
    } else {
        
        SNCastDetailController *cast = [[SNCastDetailController alloc] init];
        cast.params = [dict copy];
  
        [[self topViewController].navigationController pushViewController:cast animated:YES];

    }

}


- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].windows[0] rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}


@end
