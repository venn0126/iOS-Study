//
//  TNTextCell.m
//  TestHookEncryption
//
//  Created by Augus on 2025/5/7.
//

#import "TNTextCell.h"
#import "TNTextCalculator.h"

@implementation TNTextCell{
    TNTextCellModel *_model;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
}

- (void)configureWithModel:(TNTextCellModel *)model {
    _model = model;
    
    _titleLabel.text = model.title;
    _titleLabel.font = model.titleFont;
    _titleLabel.textColor = model.titleColor;
    
    _contentLabel.text = model.content;
    _contentLabel.font = model.contentFont;
    _contentLabel.textColor = model.contentColor;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 使用手动布局，根据预先计算好的尺寸
    TNTextCellModel *model = _model;
    if (!model) return;
    
    CGFloat padding = model.padding;
    CGFloat contentWidth = self.contentView.bounds.size.width - padding * 2;
    
    CGFloat y = padding;
    
    // 标题布局
    if (model.title.length > 0) {
        CGSize titleSize = [[TNTextCalculator sharedCalculator] sizeForText:model.title
                                                                      font:model.titleFont
                                                                  maxWidth:contentWidth];
        _titleLabel.frame = CGRectMake(padding, y, contentWidth, titleSize.height);
        y += titleSize.height + 8;
    } else {
        _titleLabel.frame = CGRectZero;
    }
    
    // 内容布局
    if (model.content.length > 0) {
        CGSize contentSize = [[TNTextCalculator sharedCalculator] sizeForText:model.content
                                                                        font:model.contentFont
                                                                    maxWidth:contentWidth];
        _contentLabel.frame = CGRectMake(padding, y, contentWidth, contentSize.height);
    } else {
        _contentLabel.frame = CGRectZero;
    }
}


@end
