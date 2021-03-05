//
//  NWTableCell.m
//  NWModel
//
//  Created by Augus on 2021/3/4.
//

#import "NWTableCell.h"

@interface NWTableCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nwLable;
@property (nonatomic, strong) UITextView *nwTextView;



@end

@implementation NWTableCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    // 布局
    [self setupSubviews];
    
    return self;
}

- (void)setupSubviews {
    
    // add subview
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.nwLable];
    
    
    // layout
    [self.iconImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10].active = YES;
    [self.iconImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:10].active = YES;
    [self.iconImageView.widthAnchor constraintEqualToConstant:50].active = YES;
    [self.iconImageView.heightAnchor constraintEqualToConstant:50].active = YES;
    
    [self.nwLable.leadingAnchor constraintEqualToAnchor:self.iconImageView.trailingAnchor constant:10].active = YES;
    [self.nwLable.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:10].active = YES;
    [self.nwLable.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:10].active = YES;
    [self.nwLable.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-10].active = YES;

}

- (void)setNwText:(NSString *)nwText {
    self.nwLable.text = nwText;
}

- (NSString *)nwText {
    return self.nwLable.text;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Lazy load

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _iconImageView.backgroundColor = UIColor.blueColor;
    }
    return _iconImageView;
}

- (UILabel *)nwLable {
    if (!_nwLable) {
        _nwLable = [UILabel new];
        _nwLable.translatesAutoresizingMaskIntoConstraints = NO;
        _nwLable.backgroundColor = UIColor.yellowColor;
        _nwLable.numberOfLines = 0;
    }
    return _nwLable;
}

- (UITextView *)nwTextView {
    if (!_nwTextView) {
        _nwTextView = [UITextView new];
        _nwTextView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _nwTextView;
}

@end
