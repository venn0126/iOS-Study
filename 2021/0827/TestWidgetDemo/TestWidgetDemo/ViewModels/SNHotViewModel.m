//
//  SNHotViewModel.m
//  TestWidgetDemo
//
//  Created by Augus on 2021/8/27.
//

#import "SNHotViewModel.h"
#import "SNHotItemModel.h"

@interface SNHotViewModel ()

@property (nonatomic, strong) NSMutableArray<SNHotItemModel *> *items;

@property (nonatomic, copy) success success;
@property (nonatomic, copy) fail fail;



@end

@implementation SNHotViewModel


- (instancetype)initWithSuccess:(success)success fail:(fail)fail {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _success = success;
    _fail = fail;
    _items = [NSMutableArray new];
    
    [self addObserver:self forKeyPath:@"selectName" options:NSKeyValueObservingOptionNew context:nil];
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    
    
    NSString *selectName = change[NSKeyValueChangeNewKey];
    @synchronized (self) {
        NSInteger index = [self.items indexOfObjectPassingTest:^BOOL(SNHotItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            return [obj.title isEqualToString:selectName];
        }];
        
        [self.items removeObjectAtIndex:index];
    }
    
    if (self.success) {
        self.success(self.items);
    }
}


- (void)refreshSNHotViewModel:(SNViewModelType)type {
    
    // simulate request of http
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        if (self.items.count > 0) {
            [self.items removeAllObjects];
        }
        
        for (int i = 0; i < 30; i++) {
            
            SNHotItemModel *model = [[SNHotItemModel alloc] init];
            
            if (type == SNViewModelTypeHot) {
                
                model.title = [NSString stringWithFormat:@"Hot-augus-%@",@(i)];
                model.imageName = [NSString stringWithFormat:@"%@",@"hot"];
                model.subTitle = [NSString stringWithFormat:@"hot-sub-%@",@(i)];
            } else {
                model.title = [NSString stringWithFormat:@"Cast-augus-%@",@(i)];
                model.imageName = [NSString stringWithFormat:@"%@",@"fever"];
                model.subTitle = [NSString stringWithFormat:@"Cast-sub-%@",@(i)];

            }
            
            [self.items addObject:model];
        }
        
        if (self.success) {
            self.success(self.items);
        }
    });
}


- (void)dealloc {
    [self removeObserver:self forKeyPath:@"selectName" context:nil];
}
@end
