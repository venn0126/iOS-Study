//
//  ViewController.m
//  MonitoringLagForRunLoop
//
//  Created by Augus on 2021/1/29.
//

#import "ViewController.h"
#import "NWGreenController.h"
#import "NWYellowController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UIButton *buttonGreen;


@end

@implementation ViewController{
    
    UIViewController *_currentVC;
    UILabel *_showLabel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.view.backgroundColor = [UIColor blueColor];
//    });
//    [self.view addSubview:self.myTableView];
    
//    [self fosBlock];
    
//
    
    self.view.backgroundColor = UIColor.whiteColor;


    
//    __block UIView *tmpView = nil;
//    tmpView = [[UIView alloc] init];
//    tmpView.frame = CGRectMake(100, 100, 100, 100);
//    tmpView.backgroundColor = UIColor.redColor;


//    [self.view addSubview:tmpView];
    //  UI 对象的创建、设置属性和销毁。 main
    

    
    

    

    
    
    
//    int8_t i = 2;
//    bool b = false;

//    if (i == true)
//    if (i)
//    if (b == true)
//    if (b)
    
    // 16机制 15 * 16^1 + 15 * 16^0;
    NSInteger a = 0xFF;
    // 15 * 16^2 + 15 * 16^3 = 
    NSInteger b = 0xFF00;
    // 15 * 16^4 + 15 * 16^5
    NSInteger c = 0xFF0000;
    
    NSLog(@"---%ld--%ld",a,b);
    
//    OSat
    
    
//    [UIDevice currentDevice]
    

    
}


- (void)testReleaseBackQueue {
    
    _showLabel = [[UILabel alloc] init];
    _showLabel.backgroundColor  = UIColor.greenColor;
    _showLabel.frame = CGRectMake(0, 200, self.view.bounds.size.width, 100);
    _showLabel.numberOfLines = 0;
    [self.view addSubview:_showLabel];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    _showLabel.text = @"i love gao tian";
//    _showLabel = nil;
//    UILabel *tmpLabel = _showLabel;
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//        [tmpLabel class];
//    });
    
    
    NSString *text = @"i love tian";
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];

    NSAttributedString *string = [[NSAttributedString alloc]initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSParagraphStyleAttributeName:style}];

//    CGSize tmpSize = [string boundingRectWithSize:CGSizeMake(200.0, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    
    [string drawWithRect:CGRectMake(0, 200, self.view.bounds.size.width, 200.0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
//    NSLog(@" size =  %@", NSStringFromCGSize(tmpSize));
//    CGFloat height = ceil(tmpSize.height) + 1;
//    CGFloat width = ceil(tmpSize.width) + 1;
//
//    NSLog(@" ceil height =  %.2f", height);
//
//
//    CGRect labelFrame = _showLabel.frame;
//    labelFrame.size = CGSizeMake(width, height);
//    _showLabel.frame = labelFrame;
    
  
}


- (void)testLocalizable {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    label.text = NSLocalizedString(@"test_text", nil);
    [self.view addSubview:label];
}


- (void)testTransformAnimation {
    
    NWGreenController *green = [[NWGreenController alloc] init];
    NWYellowController *yellow = [[NWYellowController alloc] init];
    [self addChildViewController:green];
    [self addChildViewController:yellow];
    
    [self.view addSubview:yellow.view];
    _currentVC = yellow;
    
    [self buttonGreen];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}


- (void)fosBlock {

    void (^ablock)(void) = nil;
    if (!ablock) {
        // 赋值的时候会被copy到堆上
        ablock = ^(void){
            NSLog(@"ablock imp");
        };
    }
    ablock();
    
    
    BOOL flag = YES;
    BOOL exception = YES;
    NSInteger count = 3;
    
    /*
     
     1流程结束 1 有异常  抛异常
     1流程结束 0没有异常 ok
     0未完成 1有异常  抛异常
     0未完成 0无异常  抛异常
     
     
     
      flag      1  0
      exception 1  0
     
    
     */
    
    
    // 流程未结束
    if (!flag) {
       // 如果count > 2 且
        if (count > 2) {
            
        }
        
        return;
        
    }
    
    if (flag) {
        
    }
    
    if (flag && !exception) {
        NSLog(@"yes-%@---%@",@(flag),@(exception));

        return;
    }
    
    
    NSLog(@"no---%@---%@",@(flag),@(exception));
    
    
}

#pragma mark - Button Action

- (void)greenAction:(UIButton *)sender {
    
    NSLog(@"转场蓝");
    UIViewController *toVC = nil;
    UIViewController *oldVC= _currentVC;
    UIViewAnimationOptions options = UIViewAnimationOptionTransitionFlipFromRight;
    if ([_currentVC isKindOfClass:[NWYellowController class]]) {
        toVC = self.childViewControllers[0];
    }else if([_currentVC isKindOfClass:[NWGreenController class]]){
        toVC = self.childViewControllers[1];
        options = UIViewAnimationOptionTransitionFlipFromLeft;

    }
    [self transitionFromViewController:_currentVC toViewController:toVC duration:1 options:options animations:^{
        [self.view bringSubviewToFront:self.buttonGreen];

    } completion:^(BOOL finished) {
        if (finished) {
            _currentVC = toVC;
            
        }else {
            _currentVC = oldVC;
        }

    }];
    
    
//    CATransition *animation = [CATransition animation];
//    animation.type = kCATransitionReveal;
//    animation.subtype = kCATransitionFromBottom;
//    animation.duration = 0.5;    // 在window上执行CATransition, 即可在ViewController转场时执行动画
//    [self.view.window.layer addAnimation:animation forKey:@"kTransitionAnimation"];
//    [self presentViewController:green animated:NO completion:nil];
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify =@"cellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    if (indexPath.row % 10 == 0) {
        usleep(1 * 1000 * 1000); // 1秒
        cell.textLabel.text = @"卡拉卡";
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    }
    
    return cell;
}


#pragma mark - Lazy Load

- (UITableView *)myTableView
{
    if(!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

- (UIButton *)buttonGreen {
    if (!_buttonGreen) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"父视图" forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(greenAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(self.view.bounds.size.width - 100, 0, 80, 60);
        [self.view addSubview:btn];
        _buttonGreen = btn;
    }
    return _buttonGreen;
}

@end
