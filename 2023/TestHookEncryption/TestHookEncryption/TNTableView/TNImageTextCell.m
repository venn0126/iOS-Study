//
//  TNImageTextCell.m
//  TestHookEncryption
//
//  Created by Augus on 2025/5/7.
//

#import "TNImageTextCell.h"

@implementation TNImageTextCell{
    TNImageTextCellModel *_model;
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
    
    _customImageView = [[UIImageView alloc] init];
    _customImageView.contentMode = UIViewContentModeScaleAspectFill;
    _customImageView.clipsToBounds = YES;
    [self.contentView addSubview:_customImageView];
}

- (void)configureWithModel:(TNImageTextCellModel *)model {
    _model = model;
    
    _titleLabel.text = model.title;
    _titleLabel.font = model.titleFont;
    _titleLabel.textColor = model.titleColor;
    
    _contentLabel.text = model.content;
    _contentLabel.font = model.contentFont;
    _contentLabel.textColor = model.contentColor;
    
    if (model.image) {
        _customImageView.image = model.image;
    } else if (model.imageUrl.length > 0) {
        // 这里可以集成图片加载库，如SDWebImage
        // [_customImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
        
        // 简单实现，实际项目中应使用图片加载库
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.imageUrl]];
            UIImage *image = [UIImage imageWithData:imageData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([model.imageUrl isEqualToString:self->_model.imageUrl]) {
                    self->_customImageView.image = image;
                }
            });
        });
    } else {
        _customImageView.image = nil;
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 使用手动布局，根据预先计算好的尺寸
    TNImageTextCellModel *model = _model;
    if (!model) return;
    
    CGFloat padding = model.padding;
    CGFloat contentWidth = self.contentView.bounds.size.width - padding * 2;
    CGFloat textWidth = contentWidth;
    
    // 图片布局
    if (model.image || model.imageUrl.length > 0) {
        textWidth = contentWidth - model.imageSize.width - model.imageSpacing;
        
        if (model.imageOnLeft) {
            _customImageView.frame = CGRectMake(padding,
                                               (self.contentView.bounds.size.height - model.imageSize.height) / 2,
                                               model.imageSize.width,
                                               model.imageSize.height);
        } else {
            _customImageView.frame = CGRectMake(self.contentView.bounds.size.width - padding - model.imageSize.width,
                                               (self.contentView.bounds.size.height - model.imageSize.height) / 2,
                                               model.imageSize.width,
                                               model.imageSize.height);
        }
    } else {
        _customImageView.frame = CGRectZero;
    }
    
    // 文本起始位置
    CGFloat textX = padding;
    if (model.imageOnLeft && (model.image || model.imageUrl.length > 0)) {
        textX = padding + model.imageSize.width + model.imageSpacing;
    }
    
    // 文本垂直居中
    CGFloat textHeight = 0;
    
    // 计算标题高度
    CGSize titleSize = CGSizeZero;
    if (model.title.length > 0) {
        titleSize = [[TNTextCalculator sharedCalculator] sizeForText:model.title
                                                              font:model.titleFont
                                                          maxWidth:textWidth];
        textHeight += titleSize.height;
        if (model.content.length > 0) {
            textHeight += 8; // 标题和内容之间的间距
        }
    }
    
    // 计算内容高度
    CGSize contentSize = CGSizeZero;
    if (model.content.length > 0) {
        contentSize = [[TNTextCalculator sharedCalculator] sizeForText:model.content
                                                                font:model.contentFont
                                                            maxWidth:textWidth];
        textHeight += contentSize.height;
    }
    
    // 文本垂直居中的起始Y坐标
    CGFloat textY = (self.contentView.bounds.size.height - textHeight) / 2;
    
    // 标题布局
    if (model.title.length > 0) {
        _titleLabel.frame = CGRectMake(textX, textY, textWidth, titleSize.height);
        textY += titleSize.height + 8;
    } else {
        _titleLabel.frame = CGRectZero;
    }
    
    // 内容布局
    if (model.content.length > 0) {
        _contentLabel.frame = CGRectMake(textX, textY, textWidth, contentSize.height);
    } else {
        _contentLabel.frame = CGRectZero;
    }
}


@end
