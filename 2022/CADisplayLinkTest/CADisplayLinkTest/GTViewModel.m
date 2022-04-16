//
//  GTViewModel.m
//  CADisplayLinkTest
//
//  Created by Augus on 2022/4/16.
//

#import "GTViewModel.h"
#import "GTModel.h"

@interface GTViewModel ()

@property (nonatomic, copy) NSString *observerName;
@property (nonatomic, copy) viewModelBlock viewModelBlock;
@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation GTViewModel


- (instancetype)init {
    return [self initWithObserverName:@"GTViewModel"];
}

- (instancetype)initWithObserverName:(NSString *)observerName {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _observerName = observerName;
    if (_observerName.length == 0) {
        _observerName = @"GTViewModel";
    }
    if (_observerName) {
        [self addObserver:self forKeyPath:_observerName options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}


- (void)bindDataWithBlock:(viewModelBlock)viewModelBlock {
    
    if (viewModelBlock) {
        _viewModelBlock = viewModelBlock;
    }
}


- (void)loadData {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        GTModel *model = [[GTModel alloc] init];
        NSUInteger index = arc4random() % self.dataArray.count;
        model.newsTitle = self.dataArray[index];
        
        if (self->_viewModelBlock && model) {
            self->_viewModelBlock(model, nil);
        }
        
    });
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"%@ augus new change",change[NSKeyValueChangeNewKey]);
    id newValueResult = change[NSKeyValueChangeNewKey];
    if (_viewModelBlock) {
        if ([newValueResult isKindOfClass:[NSError class]]) {
            _viewModelBlock(nil, newValueResult);
        } else {
            _viewModelBlock(newValueResult, nil);
        }
    }
}


- (void)dealloc {
    if (_observerName) {
        [self removeObserver:self forKeyPath:_observerName];
    }
}


#pragma mark - Lazy Load

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"剑僧",@"建模",@"模型",@"北汽",@"雨果"];
    }
    return _dataArray;
}

@end
