//
//  SNHotController.m
//  TestWidgetDemo
//
//  Created by Augus on 2021/8/28.
//

#import "SNHotController.h"
#import "SNHotDetailController.h"
#import "SNHotViewCell.h"
#import "SNHotViewModel.h"
#import "SNHotDataSource.h"
#import "SNHotViewModel.h"



static NSString * const kHotCellIdentifier = @"kHotCellIdentifier";

@interface SNHotController ()<UITableViewDelegate>

@property (nonatomic, strong) UITableView *hotTableView;
@property (nonatomic, strong) SNHotDataSource *hotDataSource;
@property (nonatomic, strong) SNHotViewModel *hotViewModel;



@end

@implementation SNHotController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"Hot";
    [self bindModelData];
    [self setupSubviews];
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.hotViewModel refreshSNHotViewModel:SNViewModelTypeHot];
    });
    
}

- (void)bindModelData {
    
    __weak typeof(self)weakSelf = self;
    self.hotDataSource = [[SNHotDataSource alloc] initWithIdentifier:kHotCellIdentifier config:^(id  _Nonnull cell, id  _Nonnull model, NSIndexPath * _Nonnull indexPath) {
       
        [cell configCellData:model];
    }];
    
    self.hotViewModel = [[SNHotViewModel alloc] initWithSuccess:^(id  _Nonnull data) {
        weakSelf.hotDataSource.items = data;
        [weakSelf.hotTableView reloadData];
    } fail:^{
        
    }];
    
}
- (void)setupSubviews {

    [self.view addSubview:self.hotTableView];
    self.hotTableView.delegate = self;
    self.hotTableView.dataSource = self.hotDataSource;
    [self.hotTableView registerClass:[SNHotViewCell class] forCellReuseIdentifier:kHotCellIdentifier];
}


#pragma mark - DataSource

//- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    SNHotViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
//    if (!cell) {
//        cell = [[SNHotViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
//    }
//
////    cell.textLabel.textColor = UIColor.redColor;
////    cell.textLabel.text = [NSString stringWithFormat:@"Augus---%@",@(indexPath.row)];
//
////    cell configCellData:<#(nonnull SNHotItemModel *)#>
//
//    return cell;
//}
//
//- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return  20;
//}


#pragma mark - Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return  80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *title = cell.textLabel.text ?: @"unknown";
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:title forKey:@"title"];
    SNHotDetailController *detail = [[SNHotDetailController alloc] init];
    detail.params = [dict copy];
    
    [self.navigationController pushViewController:detail animated:YES];
}


#pragma mark - Lazy Load

- (UITableView *)hotTableView {
    if (!_hotTableView) {
        _hotTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 84, self.view.frame.size.width, self.view.frame.size.height - 84) style:UITableViewStylePlain];
        _hotTableView.backgroundColor = UIColor.whiteColor;
        
    }
    return _hotTableView;
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
