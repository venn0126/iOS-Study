//
//  ViewController.m
//  TestWifiDemo
//
//  Created by Augus on 2020/8/31.
//  Copyright © 2020 Fosafer. All rights reserved.
//

#import "ViewController.h"
#import <NetworkExtension/NEHotspotConfigurationManager.h>
#import <SystemConfiguration/CaptiveNetwork.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *toWifi = @"fosafe.com";
    NEHotspotConfiguration* configuration = [[NEHotspotConfiguration alloc]initWithSSID:toWifi passphrase:@"fosafer_2018" isWEP:NO];
    [[NEHotspotConfigurationManager sharedManager] applyConfiguration:configuration completionHandler:^(NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"%@",error);
            return;
        }
        
        if([[self currentIphoneConnectedWifiName] isEqualToString:toWifi]) {
            NSLog(@"加入网络成功");
        }else {
            NSLog(@"目标wifi不存在");
        }
    }];

}


- (NSString *)currentIphoneConnectedWifiName{
    NSString *wifiName = nil;
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if (!wifiInterfaces)return nil;
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    for (NSString *interfaceName in interfaces){
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        if (dictRef){
            NSDictionary *networkInfoDic = (__bridge NSDictionary *)dictRef;
            wifiName = [networkInfoDic objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            CFRelease(dictRef);
        }
    }
    CFRelease(wifiInterfaces);
    NSLog(@"current wifi %@",wifiName);
    return wifiName;
}

@end
