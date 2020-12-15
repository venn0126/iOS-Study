//
//  MessageCell.m
//  QQPage
//
//  Created by 李海群 on 2017/7/4.
//  Copyright © 2017年 李海群. All rights reserved.
//

#import "MessageCell.h"

@interface MessageCell ()

/**
时间
 */
@property (nonatomic, weak) UILabel *timeLabel;

/**
 内容
 */
@property (nonatomic, weak) UIButton *contentBtn;

/**
 头像
 */
@property (nonatomic, weak) UIImageView *iconView;


@end

@implementation MessageCell


/**
 重写init方法
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UIButton *contentBtn = [[UIButton alloc] init];
        [self.contentView addSubview:contentBtn];
        contentBtn.titleLabel.font = HQTextFont;
        contentBtn.titleLabel.numberOfLines = 0;
        [contentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.contentBtn = contentBtn;
        
        UIImageView *iconView =[[UIImageView alloc] init];
        
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        //清空cell的背景颜色
        self.backgroundColor = [UIColor clearColor];
       
        /*
        CGFloat top =
        CGFloat left,
        CGFloat bottom,
        CGFloat right
         */
        //设置按钮的内边距
        self.contentBtn.contentEdgeInsets = UIEdgeInsetsMake(HQEdgeInsets, HQEdgeInsets, HQEdgeInsets, HQEdgeInsets);
        
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *identifier = @"message";
    MessageCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(void)setMessageFrame:(MessageFrameModel *)messageFrame
{
    _messageFrame = messageFrame;
    MessageModel *message = _messageFrame.message;
    //1,设置时间
    self.timeLabel.frame = messageFrame.timeF;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.text = message.time;
    //2,设置头像
    if (MessageModelTypeMe == message.type) {
        self.iconView.image = [UIImage imageNamed:@"me"];
        [self.contentBtn setBackgroundImage:[UIImage resizableImageWith:@"chat_send_nor"] forState:UIControlStateNormal];
    }
    else
    {
        [self.contentBtn setBackgroundImage:[UIImage resizableImageWith:@"chat_recive_nor"]  forState:UIControlStateNormal];
        self.iconView.image = [UIImage imageNamed:@"other"];
    }
    self.iconView.frame = _messageFrame.iconF;
    
    //3,设置正文
    [self.contentBtn setTitle:message.text forState:UIControlStateNormal];
    self.contentBtn.frame = _messageFrame.textF;
    
}

//- (UIImage *) resizableImageWith:(NSString *) img
//{
//    UIImage *iconImage = [UIImage imageNamed:img];
//    CGFloat w = iconImage.size.width;
//    CGFloat h = iconImage.size.height;
//    UIImage *newImage = [iconImage resizableImageWithCapInsets:UIEdgeInsetsMake(h * 0.5, w * 0.5, h * 0.5, w * 0.5) resizingMode:UIImageResizingModeStretch];
//    return newImage;
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
