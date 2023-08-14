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
    
    [self.contentView addSubview:self.guanRightLabel];
    self.guanRightLabel.font = [UIFont systemFontOfSize:16];
    self.guanRightLabel.textColor = UIColor.lightGrayColor;
    
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
        _guanRightLabel.font = [UIFont systemFontOfSize:16.0];
        _guanRightLabel.textColor = UIColor.lightGrayColor;
        _guanRightLabel.textAlignment = NSTextAlignmentCenter;
    
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(guanRightLabelTapAction:)];
        [_guanRightLabel addGestureRecognizer:tap];
    }
    return _guanRightLabel;
}

@end
