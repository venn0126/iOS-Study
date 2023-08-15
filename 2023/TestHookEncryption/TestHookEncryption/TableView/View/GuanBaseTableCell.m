//
//  GuanBaseTableCell.m
//  TestHookEncryption
//
//  Created by Augus on 2023/8/14.
//

#import "GuanBaseTableCell.h"
#import "GuanBaseModel.h"



@interface GuanBaseTableCell ()




@end

@implementation GuanBaseTableCell

#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(!self) return nil;
    
//    self.contentView.backgroundColor = [GuanUITool guan_red:229 green:229 blue:299];
    self.contentView.backgroundColor = UIColor.whiteColor;
    [self configureSubviews];
    
    return self;
}


- (void)configureSubviews {
    
    
    [self.contentView addSubview:self.guanTitleLabel];
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.guanTitleLabel.frame = CGRectMake(kGuanTitleLeftMargin, 0, self.frame.size.width - kGuanTitleLeftMargin, self.frame.size.height);
    
}


#pragma mark - Public Methods


- (void)configureModel:(GuanCellModel *)model {
    NSLog(@"%@ %@",@(__func__),@(__LINE__));
    self.guanTitleLabel.text = model.guanTitleText;
}


#pragma mark - Lazy Load

- (UILabel *)guanTitleLabel {
    if(!_guanTitleLabel) {
        _guanTitleLabel = [[UILabel alloc] init];
        _guanTitleLabel.font = [UIFont systemFontOfSize:GuanOneTitleFont];
        _guanTitleLabel.textColor = UIColor.blackColor;
        _guanTitleLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _guanTitleLabel;
}

@end
