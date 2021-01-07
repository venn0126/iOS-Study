//
//  AppDelegate.m
//  TestGuideLayout
//
//  Created by Augus on 2020/11/20.
//

#import "AppDelegate.h"
#import <BaiduMapAPI_Base/BMKMapManager.h>


@interface AppDelegate ()<BMKGeneralDelegate>

@end

@implementation AppDelegate{
    
    BMKMapManager *_mapManager;

}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    

    
//    _mapManager = [[BMKMapManager alloc]init];
//        BOOL ret = [_mapManager start:@"gy6wOgAsH1jquojgKgfWd8OcYHRcaLiW" generalDelegate:self];
//    NSLog(@"ret---%@",@(ret));
    
    
    return YES;
}


#pragma mark - BMK

- (void)onGetNetworkState:(int)iError {
    
    /**
     
     enum BMKErrorCode {
         BMKErrorOk = 0,    ///< 正确，无错误
         BMKErrorConnect = 2,    ///< 网络连接错误
         BMKErrorData = 3,    ///< 数据错误
         BMKErrorRouteAddr = 4, ///<起点或终点选择(有歧义)
         BMKErrorResultNotFound = 100,    ///< 搜索结果未找到
         BMKErrorLocationFailed = 200,    ///< 定位失败
         BMKErrorPermissionCheckFailure = 300,    ///< 百度地图API授权Key验证失败
         BMKErrorParse = 310        ///< 数据解析失败
     };*/
    
    NSLog(@"onGetNetworkState---%d",iError);
}

- (void)onGetPermissionState:(int)iError {
    
    /**
     
     enum BMKPermissionCheckResultCode {
         E_PERMISSIONCHECK_OK = 0,    // 授权验证通过
         E_PERMISSIONCHECK_KEY_ERROR = -1,    // Key格式错误，无效Key
         E_PERMISSIONCHECK_PV_LIMITED = -2,    //该应用已到达最大日访问量
         E_PERMISSIONCHECK_KEY_LOCKED = -3,    //该Key被封禁
         E_PERMISSIONCHECK_SHOULD_PAY = -4,    //需要续费使用
         E_PERMISSIONCHECK_NONE = 1,    // 尚未进行验证
         E_PERMISSIONCHECK_CHECHING = 2,    // 正在验证⋯⋯
         E_PERMISSIONCHECK_SERVER_ERROR = 3,    // 服务端错误
         E_PERMISSIONCHECK_NETWORK_ERROR = 4,    // 服务端错日误
     };
     */
    
    NSLog(@"onGetPermissionState---%d",iError);

}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
