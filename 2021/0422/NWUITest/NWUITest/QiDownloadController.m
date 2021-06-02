//
//  QiDownloadController.m
//  NWUITest
//
//  Created by Augus on 2021/6/2.
//

#import "QiDownloadController.h"

@interface QiDownloadController ()<NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) NSURLSession *session;

@end

@implementation QiDownloadController

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.session invalidateAndCancel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Download Task";
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self initDownloadTask];
    [self setupButtons];
    
}

- (void)initDownloadTask {
    NSURLSessionConfiguration *sessionConfig;
    @try {
        sessionConfig = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.fosafer.download.task0"];
    } @catch (NSException *exception) {
        NSLog(@"%s: 异常信息 %@",__func__,exception);
    } @finally {
        
    }
    
    NSURL *url = [NSURL URLWithString:@"https://images.pexels.com/photos/3225517/pexels-photo-3225517.jpeg"];
    // 下载完成可得到通知
    sessionConfig.sessionSendsLaunchEvents = YES;
    // 允许后台下载 大文件 性能优化
    sessionConfig.discretionary = YES;
    //
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    self.session = session;
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url];
    [downloadTask resume];
    
}

- (void)setupButtons {
    
    CGFloat topMargin = 200.0;
    CGFloat leftMargin = 20.0;
    CGFloat verticalMargin = 30.0;
    CGFloat btnW = [UIScreen mainScreen].bounds.size.width - leftMargin * 2;
    CGFloat btnH = 44.0;
    UIColor *btnColor = [UIColor grayColor];
    
    UIButton *downloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftMargin, topMargin, btnW, btnH)];
    [downloadBtn setTitle:@"开始下载" forState:UIControlStateNormal];
    downloadBtn.backgroundColor = btnColor;
    [self.view addSubview:downloadBtn];
    [downloadBtn addTarget:self action:@selector(startDownloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *pauseBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftMargin, CGRectGetMaxY(downloadBtn.frame) + verticalMargin, btnW, btnH)];
    [pauseBtn setTitle:@"暂停下载" forState:UIControlStateNormal];
    pauseBtn.backgroundColor = btnColor;
    [self.view addSubview:pauseBtn];
    [pauseBtn addTarget:self action:@selector(pauseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Button Action
- (void)startDownloadButtonClicked:(UIButton *)sender {
    
    [self initDownloadTask];
}



#pragma mark - 暂停播放
- (void)pauseButtonClicked:(UIButton *)sender {
    
}


#pragma mark - Delegates
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    
    NSLog(@"下载结束%@", location.path);
    [self.session invalidateAndCancel];
    NSError *error = nil;
    NSString *documentPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    if ([[NSFileManager defaultManager] fileExistsAtPath:documentPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:documentPath error:nil];
    }
    [[NSFileManager defaultManager] moveItemAtPath:location.path toPath:documentPath error:&error];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSData *data = [[NSData alloc] initWithContentsOfFile:documentPath];
        self.backgroundImageView.image = [UIImage imageWithData:data];
    });
    if (error) {
        NSLog(@"错误信息:%@", error);
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
                                           didWriteData:(int64_t)bytesWritten
                                      totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    NSLog(@"下载进度%f", totalBytesWritten * 1.0 / totalBytesExpectedToWrite);
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes {
    
    NSLog(@"部分进度%f", fileOffset * 1.0 / expectedTotalBytes);
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
