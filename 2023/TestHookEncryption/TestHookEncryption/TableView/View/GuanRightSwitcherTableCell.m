//
//  GuanRightSwitcherTableCell.m
//  TestHookEncryption
//
//  Created by Augus on 2023/8/14.
//

#import "GuanRightSwitcherTableCell.h"
#import "GuanSwitch.h"
#import "GuanBaseModel.h"


@interface GuanRightSwitcherTableCell ()

@property (nonatomic, strong) GuanSwitch *gSwitch;


@end

@implementation GuanRightSwitcherTableCell

- (void)configureSubviews {
    [super configureSubviews];
    
    [self.contentView addSubview:self.gSwitch];
    
}


- (void)configureModel:(GuanCellModel *)model {
    [super configureModel:model];
    self.gSwitch.on = model.guanRigthOn;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat switchHeight = self.gSwitch.frame.size.height;
    CGFloat switchWidth = self.gSwitch.frame.size.width;
    CGFloat x = kGuanTableScreenWidth - switchWidth - kGuanTitleLeftMargin;
    CGFloat y = (self.frame.size.height - switchHeight) * 0.5;
    self.gSwitch.frame = CGRectMake(x, y, switchWidth, switchHeight);
}


#pragma mark - Private Methods

- (void)guanSwitchAction:(GuanSwitch *)sender {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(guanRigthSwitcherCell:actionForSwitcher:)]) {
        [self.delegate guanRigthSwitcherCell:self actionForSwitcher:sender];
    }
}

#pragma mark - Lazy Load

- (GuanSwitch *)gSwitch {
    if(!_gSwitch) {
        _gSwitch = [[GuanSwitch alloc] initWithFrame:CGRectZero];
        [_gSwitch addTarget:self action:@selector(guanSwitchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _gSwitch;
}

@end
