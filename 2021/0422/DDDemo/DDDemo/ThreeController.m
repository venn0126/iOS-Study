//
//  ThreeController.m
//  DDDemo
//
//  Created by Augus on 2021/5/16.
//

#import "ThreeController.h"
#import "DDTabBarController.h"

#import "DDDemo-Swift.h"

#import "NWTimerCell.h"


static NSString *NWCellIdentifier = @"NWTimerCell";


@interface ThreeController ()<UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataSource;



@end

@implementation ThreeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Detail";
    self.view.backgroundColor = UIColor.whiteColor;
    [self someUI];
    

//    [self.tableView registerClass:[NWTimerCell class] forCellReuseIdentifier:NWCellIdentifier];
//
//    [self.view addSubview:self.tableView];

    
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // add observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dd_receiveNofitication:) name:@"DDEventName" object:nil];
}

- (void)dd_receiveNofitication:(NSNotification *)notification {
    
    
    sleep(3);
    NSLog(@"%@ : %@(%@)",@(__PRETTY_FUNCTION__),@(__LINE__),[NSThread currentThread]);
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NWTimerCell *cell = [tableView dequeueReusableCellWithIdentifier:NWCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[NWTimerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NWCellIdentifier];
    }
    
    cell.timeText = self.dataSource[indexPath.row];
    
    return cell;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@"10",@"11",@"12",@"12",@"14",@"15",@"17",@"19",@"21",@"28",@"26",@"30"];
    }
    return _dataSource;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height - 88) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (void)someUI {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"update" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [button setBackgroundColor:UIColor.redColor];
    [button addTarget:self action:@selector(updateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(100, 300, 100, 50);
    [self.view addSubview:button];
    
    
}

- (void)updateButtonAction:(UIButton *)sender {
    
    NSLog(@"update icon");
    
//    UIWindow *window = nil;
//    if (@available(iOS 13.0,*)) {
//        NSSet *scenes = [[UIApplication sharedApplication] connectedScenes];
//        for (UIWindowScene *scene in scenes) {
//            if (scene.activationState == UISceneActivationStateForegroundActive) {
//                for (UIWindow *w in scene.windows) {
//                    if (w.isKeyWindow) {
//                        window = w;
//                        break;
//                    }
//                }
//            }
//        }
//
//        DDTabBarController *vc = (DDTabBarController *)window.rootViewController;
//        [vc dd_updateTabBarIcon:^{
//
//            NSLog(@"update success");
//
//        }];
//
//    } else {
//
//        window = [[UIApplication sharedApplication] keyWindow];
//        DDTabBarController *vc = (DDTabBarController *)window.rootViewController;
//        [vc dd_updateTabBarIcon:^{
//
//            NSLog(@"update success");
//
//        }];
//    }
    
//    [self testOCCrash];
//    [self testPhotoCrash];
    
    
    // oc -> swift
    UIViewController *detailDog = [[SwiftDogDetail new] makePlayDogName:@"Tian Tian 🐻"];
    [self presentViewController:detailDog animated:YES completion:^{

        NSLog(@"present swift ui success");
    }];
    
    
    // test nsnotication sync or async
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"DDEventName" object:nil];
//        NSLog(@"%@ : %@(%@)",@(__PRETTY_FUNCTION__),@(__LINE__),[NSThread currentThread]);
//    });

    
//    [self testOCCrash];

}



- (void)testOCCrash {
    
    
    // 可捕获崩溃
    NSArray * arr = @[@(1), @(2), @(3),];
    NSLog(@"arr 4: %@", arr[4]);
    
    // 访问相册
    
//    UIImage *image = [UIImage imageNamed:@"gear_1"];
//    UIImageWriteToSavedPhotosAlbum(image, nil, NULL, NULL);
    
}


- (void)testPhotoCrash {
    
    UIImage *image = [UIImage imageNamed:@"gear_1"];
    UIImageWriteToSavedPhotosAlbum(image, nil, NULL, NULL);
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
