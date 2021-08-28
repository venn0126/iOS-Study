//
//  SNHotViewCell.m
//  TestWidgetDemo
//
//  Created by Augus on 2021/8/28.
//

#import "SNHotViewCell.h"
#import "SNHotItemModel.h"

@interface SNHotViewCell ()

@property (nonatomic, strong) UIImageView *hotImageView;
@property (nonatomic, strong) UILabel *hotLabel;


@end

@implementation SNHotViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    [self setupSubviews];
    // add subviews
    
    // layout
    
    // set attribute
    
    return self;
}

- (void)setupSubviews {
    
    // Add subview
    [self.contentView addSubview:self.hotLabel];
    [self.contentView addSubview:self.hotImageView];

    
    // layout
    self.hotImageView.frame = CGRectMake(0, 0, 60, 60);
    self.hotImageView.center = CGPointMake(self.center.x - 120, self.center.y + 20);
    self.hotLabel.frame = CGRectMake(80, 15, 150, 30);
    
}

#pragma mark - Private Methods

- (void)configCellData:(SNHotItemModel *)model {
    
    self.hotLabel.text = model.title;
    self.imageView.image = [UIImage imageNamed:model.imageName];
}


#pragma mark - Lazy load

- (UIImageView *)hotImageView {
    if (!_hotImageView) {
        _hotImageView = [[UIImageView alloc] init];
        _hotImageView.backgroundColor = UIColor.greenColor;
    }
    return _hotImageView;
}

- (UILabel *)hotLabel {
    if (!_hotLabel) {
        _hotLabel = [[UILabel alloc] init];
        _hotLabel.textColor = UIColor.linkColor;
        _hotLabel.backgroundColor = UIColor.redColor;
    }
    return _hotLabel;
}


#pragma mark - Default Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
