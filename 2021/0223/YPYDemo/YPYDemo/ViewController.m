//
//  ViewController.m
//  YPYDemo
//
//  Created by Augus on 2021/3/5.
//

#import "ViewController.h"
#import "NWCacheIOP.h"
#import "SomeSDWebImage.h"
#import "NWPerson.h"
#import "UIImageView+NWBackground.h"

#import "NWCollectionViewCell.h"
#import "NWPerson+Extension.h"
#import "UIImage+CornerRadius.h"

static NSString *kCollectionCell = @"NWCollectionViewCell";
static const CGFloat kImageWidth = 100;

typedef int (^nwBlock) (int param1,int param2);

@interface ViewController ()<NSURLSessionDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSCache *cache;
@property (nonatomic, strong) NWCacheIOP *cacheIOP;
@property (nonatomic, strong) NSMutableDictionary *mutableDictionary;
@property (nonatomic, strong) UIProgressView *nwProgressView;

@property (nonatomic,copy) UIView* (^nwSetBackgroundColor)(UIColor* color);
@property (nonatomic, strong) UICollectionView *nwCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;


@property (nonatomic, strong) NSMutableArray *imageSource;
@property (nonatomic, strong) UIPageControl *nwPageControl;

@property (nonatomic, strong) NSTimer *nwTimer;

@property (nonatomic, strong) UITableView *nwTableView;

@property (assign)  NSInteger gtSource;




@end

@implementation ViewController{
    
    CFMutableDictionaryRef _cfMutableDict;
    CGFloat _totalLength;
    CGFloat _currentLength;
    NSMutableData *_fileData;
    
    NSFileHandle *_fileHandle;
    NSOutputStream *_outStream;
}

//- (void)loadView {
//
//    NSLog(@"111 ---%@----%@",@(__PRETTY_FUNCTION__),@(__LINE__));
    
//    self.view = [UIView new];
//    self.view.backgroundColor = UIColor.linkColor;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    
//    NSHashTable
    
    // NSCache & NSMutableDictionary

//    [self testCache];
//    [self testSDWebImage];
//    _mutableDictionary = [NSMutableDictionary dictionary];
//    _cfMutableDict = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
//
//    _nwProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(50, 100, 300, 30)];
//    _nwProgressView.tintColor = UIColor.greenColor;
//    [self.view addSubview:_nwProgressView];
    
//    _fileData = [NSMutableData new];
//    [self testNSURLSessionDownload];
    
    // test maptable
//    for (int i = 5; i < 10; i++) {
//        [self testNSCacheAccess:(NSUInteger)pow(10, i)];
//    }
    
//    [self testKVO];
    
//    [self testFuncProgramm];
    
//    self.nwSetBackgroundColor([UIColor yellowColor]);
    
//    [self.view addSubview:self.nwPageControl];
//    [self testCollectionPage];
//    [self nw_addTimer];
    
    
//    static int a = 2;
//    void (^myBlock)(void) = ^{
//
//        a *= 3;
//    };
//    myBlock(); a = 6
    // block捕获的值 == A对象的strong属性
    
//    NSError *error = nil;
//    NSLog(@"000---%p",error);
//    id res = [self testErrorParam:nil error:error];
//    if (error) {
//        NSLog(@"err---%@ res- %@",error,res);
//    }
//    [self testAttributeRect];
    
    
//    [self testCGImageSet];
    
    // gpu 管线化
    
    // 顶点着色器-曲面细分着色器-几何着色器-投影-剪裁-屏幕映射
    // 其中着色器是可以开发人员控制开发，曲面和几何是非必须的，投影和屏幕映射是GPU控制的
    // 剪裁是可以配置的，不允许自定义开发
    //
    // 光删化阶段
    // 图元组装-三角形操作-片元着色器-逐片元操作-frame buffer，
    // 图元组装和三角形操作是不可控制的，片元着色器是可以控制的，非必须的，逐片元操作是可以配置的
    
//    [self testMapAndHashTable];
    
//    [self testCateory];
    
//    [self testCornerRadius];
    
    
    [self testAtomic];
}

- (void)testAtomic {
    
    // atomic 指定编译器把读写方法设置为原子读写，并添加互斥锁进行保护
    dispatch_queue_t gtQueue = dispatch_queue_create("gtQueue1", NULL);
    dispatch_async(gtQueue, ^{
        for (int i = 0; i < 1000; i++) {
            
            self.gtSource += 1;
        }
        
        NSLog(@"gt source0 %ld",(long)self.gtSource);

    });
    
    dispatch_queue_t gtQueue2 = dispatch_queue_create("gtQueue2", NULL);
    dispatch_async(gtQueue2, ^{
        for (int i = 0; i < 1000; i++) {

            self.gtSource += 1;
        }
        NSLog(@"gt source2 %ld",(long)self.gtSource);

    });
    
    NSLog(@"gt source1 %ld",(long)self.gtSource);
    
}

- (void)testCornerRadius {
    
    // for tableview
    [self.view addSubview:self.nwTableView];
    [self.nwTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"nwTableViewCell"];
    
    
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [self.view addSubview:imgView];
//
//    UIImage *tmpImage = [UIImage imageNamed:@"icon_11"];
//    imgView.image = [tmpImage nw_imageAddRadius:50 withSize:CGSizeMake(100, 100)];
    
    
}

#pragma mark - UITabelView DataSource


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return kImageWidth;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nwTableViewCell"];
    
    if (indexPath.row % 2 == 0) {
//        cell.imageView.image = [UIImage imageNamed:@"icon_04"];
        
        cell.textLabel.text=  @"niu wei";
        UIImage *tmpImage = [UIImage imageNamed:@"icon_11"];
        cell.imageView.image = [tmpImage nw_imageAddRadius:5 withSize:CGSizeMake(kImageWidth, kImageWidth)];
    } else {
        // 中文也没有影响了
        cell.textLabel.text = @"高田";
        cell.imageView.image = [UIImage imageNamed:@"1"];

    }
    
    // 会手动触发离屏渲染
//    cell.imageView.layer.shouldRasterize = YES;
    
    // 解决color blended layers
    cell.textLabel.backgroundColor = UIColor.whiteColor;
    
    
//    cell.imageView.layer.cornerRadius = 4.0;
//    cell.imageView.layer.masksToBounds = YES;
//    cell.imageView.backgroundColor = UIColor.whiteColor;
    
//    cell.backgroundColor = UIColor.whiteColor;
    cell.contentView.backgroundColor = UIColor.whiteColor;
    
    return cell;
}

- (NSArray *)findAllImageView:(UIView *)aView {
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    if (!aView) {
        return nil;
    }
    for (UIView *subView in aView.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            [tmpArray addObject:subView];
        }
        NSArray *interArray = [self findAllImageView:subView];
        [tmpArray addObjectsFromArray:interArray];
    }
    
    if (tmpArray.count <= 0) {
        tmpArray = nil;
    }

    return tmpArray;
}





- (void)testCateory {
    
    NWPerson *p1 = [[NWPerson alloc] init];
    [p1 personPrint];
    
    
    
    
}

- (void)testMapAndHashTable {
    
    /*
     
     
     /// set value for key
     void CFDictionarySetValue(CFMutableDictionaryRef dict, const void *key, const void *value) {
         /// 假如字典中存在key，match返回keyHash的存储位置
         /// 假如字典中不存在key，nomatch存储插入key的存储位置
         CFIndex match, nomatch;
         __CFDictionaryFindBuckets2(dict, key, &match, &nomatch);
         ......
         
         if (kCFNotFound != match) {
         /// 字典中已经存在key，修改操作
             CF_OBJC_KVO_WILLCHANGE(dict, key);
             ......
             CF_WRITE_BARRIER_ASSIGN(valuesAllocator, dict->_values[match], newValue);
             CF_OBJC_KVO_DIDCHANGE(dict, key);
         } else {
         /// 字典中不存在key，新增操作
             ......
             CF_OBJC_KVO_WILLCHANGE(dict, key);
             CF_WRITE_BARRIER_ASSIGN(keysAllocator, dict->_keys[nomatch], newKey);
             CF_WRITE_BARRIER_ASSIGN(valuesAllocator, dict->_values[nomatch], newValue);
             dict->_count++;
             CF_OBJC_KVO_DIDCHANGE(dict, key);
         }
     }
      
     /// 查找key存储位置
     static void __CFDictionaryFindBuckets2(CFDictionaryRef dict, const void *key, CFIndex *match, CFIndex *nomatch) {
         /// 对key进行hash化，获取keyHash
         const CFDictionaryKeyCallBacks *cb = __CFDictionaryGetKeyCallBacks(dict);
         CFHashCode keyHash = cb->hash ? (CFHashCode)INVOKE_CALLBACK2(((CFHashCode (*)(const void *, void *))cb->hash), key, dict->_context) : (CFHashCode)key;
         const void **keys = dict->_keys;
         uintptr_t marker = dict->_marker;
         CFIndex probe = keyHash % dict->_bucketsNum;
         CFIndex probeskip = 1;
         CFIndex start = probe;
         *match = kCFNotFound;
         *nomatch = kCFNotFound;
         
         for (;;) {
             uintptr_t currKey = (uintptr_t)keys[probe];
             /// 如果keyHash对应的桶是空桶，那么标记nomatch，返回未匹配
             if (marker == currKey) {
                 if (nomatch) *nomatch = probe;
                 return;
             } else if (~marker == currKey) {
                 if (nomatch) {
                     *nomatch = probe;
                     nomatch = NULL;
                 }
             } else if (currKey == (uintptr_t)key || (cb->equal && INVOKE_CALLBACK3((Boolean (*)(const void *, const void *, void*))cb->equal, (void *)currKey, key, dict->_context))) {
                 *match = probe;
                 return;
             }
             /// 如果未匹配，说明发生了冲突，那么将桶下标向后移动，直到找到空桶位置
             probe = probe + probeskip;
         
             if (dict->_bucketsNum <= probe) {
                 probe -= dict->_bucketsNum;
             }
             if (start == probe) {
                 return;
             }
         }
     }
     ————————————————
     */
    
    
    /*
     1 更广泛意义的NSSet,区别在于NSSet和NSMutableSet
     特性：
     NSHashTable可变的
     NSHashTable可以持有weak类型的成员变量
     NSHashTable可以添加成员变量的时候复制成员
     NSHashTable可以随意的存储指针并利用指针唯一性来检查hash同一性检测和对比操作
     
     NSPointerFunctionsOptions：
     
     NSHashTableStrongMemory 等价于NSPointFunctionsStrongMemory 对成员变量进行强引用，默认值
     这样NSHashTable和NSSet和NSMutableSet就无区别了
     
     NSHashTableWeakMemory 对成员变量进行弱引用，使用NSPointerFunctionsWeakMemory object在最后释放的时候会被指向NULL
     
     NSHashTableZeroingWeakMemory 已被抛弃，使用NSHashTableWeakMemory代替
     
     NSHashTableCopyin 在对象被加入集合之前进行复制，等同于NSPointerFunctionsCopyin
     
     NSHashTableTableObjectPointerPersonality 用指针来等同代替实际的值，当打印这个指针的时候相当于调用description方法
     和NSPointerFunctionsObjectPointerPersonality等同
     
     
     */
    
    NSHashTable *hashTable = [NSHashTable hashTableWithOptions:NSPointerFunctionsCopyIn];
    [hashTable addObject:@"1"];
    [hashTable addObject:@"bar"];
    [hashTable addObject:@"func"];
    
    [hashTable removeObject:@"bar"];
    NSLog(@"hash table %@",hashTable.allObjects);
    
    
    /*
     NSMapTable 是对更广泛意义的NSDictionary和Dictionary 有以下特性
     NSDictionary和NSMutableDictionary会复制keys 并且通过强引用values实现存储
     NSMapTable是可变的
     NSMapTable是可以通过弱引用来持有keys和values，所以当key或者value被dealloc的时候，所存储的实体也会被移除
     NSMapTable可以在添加value的时候对value进行复制
     
    
     */
    
//    id __weak
    SomeSDWebImage *some = [[SomeSDWebImage alloc] initWithName:@"niu"];
    id __weak someWeak = some;
    
    NSMapTable *mapTable = [NSMapTable mapTableWithKeyOptions:NSMapTableStrongMemory valueOptions:NSMapTableWeakMemory];
    
    [mapTable setObject:someWeak forKey:@"sweak"];
    NSLog(@"keys--%@",[[mapTable keyEnumerator] allObjects]);
    
}

- (void)testCGImageSet {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imageView];
    
    [imageView nw_setImage];
}


- (void)testAttributeRect {
    
    
    UILabel *nwLabel = [UILabel new];
    nwLabel.frame = CGRectMake(100, 100, 200, 50);
    nwLabel.backgroundColor = UIColor.greenColor;
    nwLabel.text = @"就是ai123";
    [self.view addSubview:nwLabel];
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    UIFont *nwFont = [UIFont systemFontOfSize:19];
    
    // 获取size
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *tmpString = @"就是爱你112233sadsadasd";
        CGRect nwRect = [tmpString boundingRectWithSize:CGSizeMake(200, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:nwFont, NSParagraphStyleAttributeName:paragraphStyle} context:nil];
        NSLog(@"rect: %@",NSStringFromCGRect(nwRect));
        
        
//        [tmpString drawWithRect:nwRect options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:nwFont, NSParagraphStyleAttributeName:paragraphStyle} context:nil];
        
        
    });
    

    
}

- (id)testErrorParam:(NSDictionary *)param error:(NSError *)error {
    
    NSArray *res = nil;
    if (res) {
        return res;
    } else {
        NSLog(@"222---%p",error);
//        if (!error) {
//            return nil;
//        }
        error = [NSError errorWithDomain:@"1026" code:1029 userInfo:nil];
        NSLog(@"333---%p",error);

    }
    /**
     
     **
     2021-03-16 09:40:51.748175+0800 YPYDemo[2711:52106] 000---0x0
     2021-03-16 09:40:51.748285+0800 YPYDemo[2711:52106] 222---0x7ffeedf62148
     2021-03-16 09:40:51.748387+0800 YPYDemo[2711:52106] 333---0x7ffeedf62148
     
     *
     2021-03-16 09:44:24.463939+0800 YPYDemo[2816:55225] 000---0x0
     2021-03-16 09:44:24.464031+0800 YPYDemo[2816:55225] 222---0x0
     2021-03-16 09:44:24.464111+0800 YPYDemo[2816:55225] 333---0x60000181cc90
     */
    return nil;
}

- (void)testCollectionPage {
    
    [self.view addSubview:self.nwCollectionView];
    [self.nwCollectionView registerClass:[NWCollectionViewCell class] forCellWithReuseIdentifier:kCollectionCell];
}

- (void)nw_addTimer {
        
    self.nwTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(nw_nextImage) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.nwTimer forMode:NSRunLoopCommonModes];
}

- (void)nw_nextImage {
    
    
    // 获取当前可见cell section
    
    // cell + 1
     
    // 判断是否为index 4 如果是4 index为0 section +1
    
    // 跳转
    
    // 获取当前
    NSIndexPath *currentIndexPath = [[self.nwCollectionView indexPathsForVisibleItems] lastObject];

    NSLog(@"currentIndexPath--%ld--%ld",(long)currentIndexPath.item,currentIndexPath.section);
    // 设置下一个滚动的item
    NSInteger nextItem = currentIndexPath.item + 1;
    NSInteger nextSection = currentIndexPath.section;
    
    //
//    self.nwPageControl.currentPage = nextItem;
    if (nextItem == self.imageSource.count) {
        nextItem = 0;
        nextSection++;
    }
    
    NSLog(@"nextIndexPath--%ld",(long)nextItem);

    
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    // 解决iOS 14+ 不能进行主动跳转item
    if (@available(iOS 14.0, *)) {
        UICollectionViewLayoutAttributes *attributesNext = [self.flowLayout layoutAttributesForItemAtIndexPath:nextIndexPath];
        [self.nwCollectionView setContentOffset:attributesNext.frame.origin animated:YES];
    } else {
        [self.nwCollectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];

    }
}

//- (void)nw_removeTimer {
//    [self.nwTimer invalidate];
//    self.nwTimer = nil;
//}
//
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [self nw_removeTimer];
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//
//    [self nw_addTimer];
//}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.imageSource.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[NWCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
    }
    
    cell.iconName = self.imageSource[indexPath.row];
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int page = (int)(scrollView.contentOffset.x / self.view.bounds.size.width) % self.imageSource.count;
    self.nwPageControl.currentPage = page;
}


- (void)testFuncProgramm {
    
    // 返回的是实例对象
    
    // 需要操作的属性是block参数
    
    // 操作的结果保存在block的返回值
    
    
    NWPerson *nw = [[NWPerson alloc] init];
    BOOL isEqual = [[[nw caculator:^int(int result) {
        // 计算自定义数值的和
        NSLog(@"000---%@",@(result));
        // 一个值进行 2 * 5
        result += 2;
        result *= 6;
        
        return result;// 结果保存
    }] equal:^BOOL(int result) {
        
        NSLog(@"222result--%d",result);
        return result == 12;
    }] nwEqual];
    
    
    int res = [NWPerson makeCaculators:^(NWPerson * _Nonnull make) {
        
        make.add(1).add(2).muilt(3);
    }];
    
    NSLog(@"res---%d",res);
    
    
    //   BOOL isEqual = [[[nw caculator:^int(int result) {
    //
    //        result += 2;
    //        result *= 5;
    //        return result;
    //    }] equal:^BOOL(int result) {
    //
    //        return result == 10;
    //    }] nwEqual];
    
    NSLog(@"----%@",@(isEqual));
    
    
    //    nw.with.driveCar();
    //    nw.with.eatFood();
    //    nw.with.e
    
    
    //    int a = [self plus:^int(int param1, int param2) {
    //
    //        return param1 - param2;
    //    }];
    //
    //    NSLog(@"a---%d",a);
    
    
    //   int res = [NWPerson makeCaculators:^(NWPerson * _Nonnull make) {
    //
    //       return make.add(1).add(2).add(3).muilt(4);
    //
    //    }] ;
    
    //    NSLog(@"res---%d",res);
    
    
    
    
    
    
}

- (int)plus:(nwBlock)nw {
    return nw(10,4);
}

-(UIView *(^)(UIColor *))nwSetBackgroundColor {
    
    return ^(UIColor *color) {
        self.view.backgroundColor = color;
        return self.view;
    };
}

- (void)testKVO {
    
    SomeSDWebImage *some = [[SomeSDWebImage alloc] initWithName:@"niu"];
    [some setValue:@"niu" forKey:@"firstName"];
    NSString *value = [some valueForKey:@"firstName"];
    
    //    [some setValue:@"wei" forUndefinedKey:@"userName"];
    //    NSString *value = [some valueForUndefinedKey:@"firstName"];
    NSLog(@"value---%@",value);
    
}

- (void)testNSURLSessionDownload {
    
    // 创建url
    NSURL *url = [NSURL URLWithString:@"http://sony.it168.com/data/attachment/forum/201410/20/2154195j037033ujs7cio0.jpg"];
    
    
    //    NSURLSession *ssession = [NSURLSession sharedSession];
    
    // 创建请求session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    // 发送请求
    [[session dataTaskWithURL:url] resume];
    
    // session和代理之间循环引用 如果是全局 放在viewWillDisapper中去
    //    [session invalidateAndCancel];
    //    session = nil;
}

#pragma mark - NSURLSession Delegate


- (void)URLSession:(NSURLSession *)session dataTask:(nonnull NSURLSessionDataTask *)dataTask
didReceiveResponse:(nonnull NSURLResponse *)response
 completionHandler:(nonnull void (^)(NSURLSessionResponseDisposition))completionHandler {
    
    NSLog(@"接收到服务器响应的时候调用---%@",[NSThread currentThread]);
    
    
    // 得到请求文件的数据大小
    _totalLength = response.expectedContentLength;
    // 默认不接受数据
    // 必须告诉系统是否接受服务返回的数据
    completionHandler(NSURLSessionResponseAllow);
    
    //
    NSString *fileName = response.suggestedFilename;
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fullPath = [fileName stringByAppendingPathComponent:cachePath];
    
    // 沙盒中创建一个空文件
    //    [[NSFileManager defaultManager] createFileAtPath:fullPath contents:nil attributes:nil];
    // 创建文件句柄指向该文件
    //    _fileHandle = [NSFileHandle fileHandleForWritingAtPath:fullPath];
    if (_currentLength == 0) {
        _outStream = [[NSOutputStream alloc] initToFileAtPath:fullPath append:YES];
    }
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
    // 接受到服务器返回数据的时候调用，可能会被调用多次
    //    [_fileData appendData:data];
    
    // 文件句柄写数据
    //    [_fileHandle writeData:data];
    [_outStream write:data.bytes maxLength:data.length];
    _currentLength += data.length;
    
    // 计算文件下载进度
    //    _nwProgressView.progress = 1.0 * _fileData.length / _totalLenght;
    _nwProgressView.progress = _currentLength / (_totalLength);
    
    
    
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    
    // 保存数据到沙盒
    //    NSString *fileName = task.response.suggestedFilename;
    //    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //    NSString *fullPath = [fileName stringByAppendingPathComponent:cachePath];
    //    [_fileData writeToFile:fullPath atomically:YES];
    //    _fileData = nil;
    // 关闭文件句柄
    //    [_fileHandle closeFile];
    //关闭输出流
    [_outStream close];
    _currentLength = 0;
}



- (void)testNSCacheAccess:(NSUInteger)count {
    
    // 指数存取
    NSTimeInterval begin,end;
    begin = CACurrentMediaTime();
    // save
    for (NSUInteger i = 0; i < count; i++) {
        //        [_cache setObject:@(i) forKey:@(i)];
        //        [_mutableDictionary setObject:@(i) forKey:@(i)];
        //        _cfMutableDict
        
        CFDictionarySetValue(_cfMutableDict, (__bridge const void *)(@(i)), (__bridge const void *)(@(i)));
    }
    // read
    for (NSUInteger i = 0; i < count; i++) {
        //        [_cache objectForKey:@(i)];
        //        [_mutableDictionary objectForKey:@(i)];
        CFDictionaryGetValue(_cfMutableDict, (__bridge const void *)(@(i)));
        
    }
    end = CACurrentMediaTime() - begin;
    NSLog(@"count is %ld cost %.2f",count,end);
    
    /*
     NSCache:
     count is 100000 time is 0.00
     count is 1000000 time is 0.05
     count is 10000000 time is 0.47
     count is 100000000 time is 4.48
     count is 1000000000 time is 45.42
     question: 大量相似的 key (比如 “1”, “2”, “3”, …)，NSCache 的存取性能会下降得非常厉害
     大量的时间被消耗在 CFStringEqual() 上，不知道是不是设计缺陷
     
     Dictionary
     count is 100000 cost 0.04
     count is 1000000 cost 0.57
     count is 10000000 cost 6.28
     count is 100000000 cost 78.27
     
     
     cfmutabledict
     count is 100000 cost 0.03
     count is 1000000 cost 0.56
     count is 10000000 cost 6.18
     count is 100000000 cost 73.30
     */
}

- (void)testSDWebImage {
    
    //    SomeSDWebImage *some = [[SomeSDWebImage alloc] initWithName:nil];
    //    NSLog(@"some name--%@",[some firstName]);
    
    
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {
        //        block();
        
        NSLog(@"main thread");
    } else {
        //        dispatch_async(dispatch_get_main_queue(), block);
    }
    
    
    
}

- (void)testCache {
    
    
    _cacheIOP = [NWCacheIOP new];
    
    _cache = [NSCache new];
    _cache.countLimit = 5;
    _cache.delegate = _cacheIOP;
    
    // add obj to cache
    [self nwAddObjcToCache];
    
    // memory warn nofitication
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nw_didReceiveMemoryWarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    
}


- (void)nwAddObjcToCache {
    
    for (int i = 0; i < 5; i++) {
        [_cache setObject:[NSString stringWithFormat:@"nw_%d",i] forKey:[NSString stringWithFormat:@"nw_%d",i]];
    }
    
    // 淘汰最近最少使用的LRU
    //    [_cache objectForKey:@"nw_1"];
    //    [_cache objectForKey:@"nw_3"];
    //
    [_cache setObject:@"nw_5" forKey:@"nw_5"];
    //    [_cache setObject:@"nw_6" forKey:@"nw_6"];
    
    // LFU 最不经常使用的淘汰
    //    [_cache objectForKey:@"nw_1"];
    //    [_cache objectForKey:@"nw_1"];
    //    [_cache objectForKey:@"nw_3"];
    //    [_cache objectForKey:@"nw_3"];
    //    [_cache objectForKey:@"nw_2"];
    //
    //    [_cache setObject:@"nw_5" forKey:@"nw_5"];
    //    [_cache setObject:@"nw_6" forKey:@"nw_6"];
    
    //    [_cache removeAllObjects];
    
    // key
    
}

- (void)nw_getCacheObject {
    
    for (int i = 0; i < 10; i++) {
        NSLog(@"cache object:%@ at index:%d",[_cache objectForKey:[NSString stringWithFormat:@"nw_%d",i]],i);
    }
}


#pragma mark - Memory Warn

- (void)nw_didReceiveMemoryWarning:(NSNotification *)notification {
    
    NSLog(@"notitication---%@---%@ at line:%@",@(__PRETTY_FUNCTION__),notification,@(__LINE__));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 点击屏幕查看缓存中的内容
    [self nw_getCacheObject];
}


#pragma mark - Lazy load

- (UICollectionView *)nwCollectionView {
    if (!_nwCollectionView) {
        
        _nwCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200) collectionViewLayout:self.flowLayout];
        _nwCollectionView.dataSource = self;
        _nwCollectionView.delegate = self;
        
        _nwCollectionView.pagingEnabled = YES;
        _nwCollectionView.backgroundColor = UIColor.greenColor;
        _nwCollectionView.showsHorizontalScrollIndicator = NO;
    }
    return _nwCollectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, 200);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing = 1.0;
        _flowLayout.minimumInteritemSpacing = 5.0;
    }
    return _flowLayout;
}

- (NSMutableArray *)imageSource {
    if (!_imageSource) {
        _imageSource = [NSMutableArray array];
        for (int i = 0; i< 5; i++) {
            NSString *imageName = [NSString stringWithFormat:@"icon_%d",i];
            [_imageSource addObject:imageName];
        }
        
    }
    return _imageSource;
}

- (UIPageControl *)nwPageControl {
    if (!_nwPageControl) {
        _nwPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 420, self.view.bounds.size.width, 30)];
        _nwPageControl.center = self.view.center;
        _nwPageControl.numberOfPages = self.imageSource.count;
        _nwPageControl.backgroundColor = UIColor.redColor;
    }
    return _nwPageControl;
}

- (UITableView *)nwTableView {
    if (!_nwTableView) {
        _nwTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _nwTableView.delegate = self;
        _nwTableView.dataSource = self;
        
    }
    return _nwTableView;
}

@end
