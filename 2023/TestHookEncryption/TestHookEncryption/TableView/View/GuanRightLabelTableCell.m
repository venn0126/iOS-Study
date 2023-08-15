//
//  GuanRightTextTableCell.m
//  TestHookEncryption
//
//  Created by Augus on 2023/8/14.
//

#import "GuanRightLabelTableCell.h"
#import "GuanBaseModel.h"



@interface GuanRightLabelTableCell ()

@property (nonatomic, strong) UILabel *guanRightLabel;


@end

@implementation GuanRightLabelTableCell


- (void)configureSubviews {
    [super configureSubviews];
    
    self.guanTitleLabel.textColor = UIColor.lightGrayColor;
    self.guanTitleLabel.font = [UIFont systemFontOfSize:GuanThreeTitleFont];
    
    [self.contentView addSubview:self.guanRightLabel];
    self.guanRightLabel.textColor = UIColor.lightGrayColor;
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.guanTitleLabel.width = self.width * 0.5 - kGuanTitleLeftMargin;
    self.guanRightLabel.frame = CGRectMake(self.width * 0.5, 0, self.width * 0.5 - kGuanTitleLeftMargin, self.height);
}


- (void)configureModel:(GuanCellModel *)model {

    [super configureModel:model];
    self.guanRightLabel.text = model.guanRightText;
    
}


- (void)guanRightLabelTapAction:(UITapGestureRecognizer *)tap {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(guanRigthLabelCell:actionForTap:)]) {
        [self.delegate guanRigthLabelCell:self actionForTap:tap];
    }
    
}


#pragma mark - Lazy Load

- (UILabel *)guanRightLabel {
    if(!_guanRightLabel) {
        _guanRightLabel = [[UILabel alloc] init];
        _guanRightLabel.font = [UIFont systemFontOfSize:GuanThreeTitleFont];
        _guanRightLabel.textColor = UIColor.lightGrayColor;
        _guanRightLabel.textAlignment = NSTextAlignmentRight;
        // if set property userInteractionEnabled is yes, tap is no working
        _guanRightLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(guanRightLabelTapAction:)];
        [_guanRightLabel addGestureRecognizer:tap];
    }
    return _guanRightLabel;
}

@end
