//
//  QiLocationController.m
//  NWUITest
//
//  Created by Augus on 2021/6/2.
//

#import "QiLocationController.h"
#import <CoreLocation/CoreLocation.h>

@interface QiLocationController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end



@implementation QiLocationController

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    [_timer invalidate];
    _timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Location Service";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initLocation];
    [self setupTimer];
}


- (void)initLocation {
    
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    // [self.locationManager requestWhenInUseAuthorization];
    @try {
        // 后台定位依然可用
       self.locationManager.allowsBackgroundLocationUpdates = YES;
    } @catch (NSException *exception) {
        NSLog(@"异常：%@", exception);
    } @finally {
        
    }
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    NSLog(@"%s：位置信息：%@", __FUNCTION__, locations);
}

#pragma mark - 定时器
- (void)setupTimer {
    
    _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerEvent:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [_timer fire];
}

- (void)timerEvent:(id)sender {
    
    NSLog(@"定时器运行中");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
