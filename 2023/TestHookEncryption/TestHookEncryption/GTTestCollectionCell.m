//
//  GTTestCollectionCell.m
//  TestHookEncryption
//
//  Created by Augus Venn on 2024/3/11.
//

#import "GTTestCollectionCell.h"
#import "GTCustomButton.h"


@interface GTTestCollectionCell ()

@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) GTCustomButton *gtButton;



@end

@implementation GTTestCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.greenColor;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.gtButton];
}

- (void)layoutSubviews {
    
    
    CGFloat nameLabelW = self.frame.size.width * 0.5;
    CGFloat nameLabelH = 100;
    CGFloat nameLabelY = (self.frame.size.height - nameLabelH) * 0.5;
    self.nameLabel.frame = CGRectMake(0, nameLabelY, nameLabelW, nameLabelH);
    
    
    CGFloat gtButtonH = 40.0;
    self.gtButton.frame = CGRectMake(nameLabelW, nameLabelY, 120, gtButtonH);
}

- (void)configureModel:(NSString *)model {
    self.nameLabel.text = model;
}

- (void)gt_collectionButtonAction:(UITapGestureRecognizer *)tap {
    NSLog(@"gt_collectionButtonAction %@",tap);
}


#pragma mark - Lazy Load

- (UILabel *)nameLabel {
    if(!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:18];
        _nameLabel.textColor = UIColor.blackColor;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.backgroundColor = UIColor.yellowColor;
    }
    return _nameLabel;
}

- (GTCustomButton *)gtButton {
    if(!_gtButton) {
        
        UIImage *buttonImage = [UIImage imageNamed:@"gt_goods_list"];
        _gtButton = [[GTCustomButton alloc] initWithTitle:@"就是爱你就是爱你就是爱你就是爱你就是爱你" image:buttonImage frame:CGRectZero];
        [_gtButton addTarget:self action:@selector(gt_collectionButtonAction:)];

    }
    return _gtButton;
}
@end
