//
//  SNCastController.m
//  TestWidgetDemo
//
//  Created by Augus on 2021/8/28.
//

#import "SNCastController.h"
#import "SNHotViewCell.h"
#import "SNHotViewModel.h"
#import "SNHotDataSource.h"
#import "SNHotViewModel.h"
#import "SNCastDetailController.h"

static NSString * const kCastCellIdentifier = @"kCastCellIdentifier";

@interface SNCastController ()<UITableViewDelegate>

@property (nonatomic, strong) UITableView *castTableView;
@property (nonatomic, strong) SNHotDataSource *castDataSource;
@property (nonatomic, strong) SNHotViewModel *castViewModel;

@end

@implementation SNCastController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"Cast";
    [self bindModelData];
    [self setupSubviews];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.castViewModel refreshSNHotViewModel:SNViewMddelTypeBroadcast];
    });
}

- (void)bindModelData {
    
    __weak typeof(self)weakSelf = self;
    self.castDataSource = [[SNHotDataSource alloc] initWithIdentifier:kCastCellIdentifier config:^(id  _Nonnull cell, id  _Nonnull model, NSIndexPath * _Nonnull indexPath) {
       
        [cell configCellData:model];
    }];
    
    self.castViewModel = [[SNHotViewModel alloc] initWithSuccess:^(id  _Nonnull data) {
        weakSelf.castDataSource.items = data;
        [weakSelf.castTableView reloadData];
    } fail:^{
        
    }];
    
}

- (void)setupSubviews {

    [self.view addSubview:self.castTableView];
    self.castTableView.delegate = self;
    self.castTableView.dataSource = self.castDataSource;
    [self.castTableView registerClass:[SNHotViewCell class] forCellReuseIdentifier:kCastCellIdentifier];
}

#pragma mark - Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return  80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    SNHotViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *title = cell.textLabel.text ?: @"unknown";
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:title forKey:@"title"];
    SNCastDetailController *cast = [[SNCastDetailController alloc] init];
    cast.params = [dict copy];
    
    [self.navigationController pushViewController:cast animated:YES];
}


#pragma mark - Lazy Load

- (UITableView *)castTableView {
    if (!_castTableView) {
        _castTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 84, self.view.frame.size.width, self.view.frame.size.height - 84) style:UITableViewStylePlain];
        _castTableView.backgroundColor = UIColor.whiteColor;
        
    }
    return _castTableView;
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
