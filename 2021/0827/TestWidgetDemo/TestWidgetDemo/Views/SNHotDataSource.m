//
//  SNHotDataSource.m
//  TestWidgetDemo
//
//  Created by Augus on 2021/8/28.
//

#import "SNHotDataSource.h"
#import "SNHotViewCell.h"

@interface SNHotDataSource ()


@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) config config;

@end

@implementation SNHotDataSource

- (instancetype)initWithIdentifier:(NSString *)identifier config:(config)config {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    _identifier = identifier;
    _config = config;
    return self;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SNHotViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.identifier];
    if (!cell) {
        cell = [[SNHotViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.identifier];
    }
    
    if (self.config) {
        self.config(cell, self.items[indexPath.row], indexPath);
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.items.count;
}

@end
