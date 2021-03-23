//
//  NWCollectionViewCell.m
//  YPYDemo
//
//  Created by Augus on 2021/3/15.
//

#import "NWCollectionViewCell.h"

@interface NWCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;


@end

@implementation NWCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    self.imageView = imageView;
    
    return self;
    
}


- (void)setIconName:(NSString *)iconName {
    self.imageView.image = [UIImage imageNamed:iconName];
}

- (void)layoutSubviews {
    self.imageView.frame = self.bounds;
}
@end
