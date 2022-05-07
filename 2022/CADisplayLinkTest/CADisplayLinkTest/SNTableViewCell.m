//
//  SNTableViewCell.m
//  CADisplayLinkTest
//
//  Created by Augus on 2022/5/7.
//

#import "SNTableViewCell.h"

@interface SNTableViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation SNTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    self.contentView.layer.cornerRadius = 6.0;
    self.transform = CGAffineTransformMakeRotation(M_PI_2);
    [self setupUI];
    
    return self;
    
}


- (void)setupUI {
    
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.contentLabel];
    
    self.iconImageView.frame = CGRectMake(14, 14, 60, 60);
    self.contentLabel.text = @"测试数据红红火火";
    self.contentLabel.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10, self.iconImageView.frame.origin.y, 200, 60);
}


-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 10;//这里间距为10，可以根据自己的情况调整
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 2 * frame.origin.x;
    [super setFrame:frame];
}


- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_file1_v5"]];
        _iconImageView.layer.cornerRadius = 4.0f;
        _iconImageView.layer.masksToBounds = YES;
    }
    return _iconImageView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = UIColor.blackColor;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
