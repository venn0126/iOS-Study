//
//  FSMessageCell.m
//  fosFloatView
//
//  Created by Augus on 2020/11/11.
//

#import "FSMessageCell.h"
#import "UIImage+Extension.h"

@interface FSMessageCell ()

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

@implementation FSMessageCell

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
        contentBtn.titleLabel.font = FSTextFont;
        contentBtn.titleLabel.numberOfLines = 0;
        [contentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.contentBtn = contentBtn;
        
        UIImageView *iconView =[[UIImageView alloc] init];
        
        [self.contentView addSubview:iconView];
         self.iconView = iconView;
        
        //清空cell的背景颜色
        self.backgroundColor = RGB(45,40,88);
        //
        //设置按钮的内边距
        self.contentBtn.contentEdgeInsets = UIEdgeInsetsMake(FSEdgeInsets, FSEdgeInsets, FSEdgeInsets, FSEdgeInsets);
        
    }
    return self;
}


+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *identifier = @"message";
    FSMessageCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[FSMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(void)setMessageFrame:(FSMessageFrameModel *)messageFrame
{
    _messageFrame = messageFrame;
    FSMessageModel *message = _messageFrame.message;
    //1,设置时间
    self.timeLabel.frame = messageFrame.timeF;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.text = message.time;
    //2,设置头像
    if (FSMessageModelTypeMe == message.type) {
        self.iconView.image = [UIImage imageNamed:@"me"];
        [self.contentBtn setBackgroundImage:[UIImage resizableImageWith:@"chat_send_nor"] forState:UIControlStateNormal];
    }else if(message.type == FSMessageModelTypeOther) {
        [self.contentBtn setBackgroundImage:[UIImage resizableImageWith:@"chat_recive_nor"]  forState:UIControlStateNormal];
        self.iconView.image = [UIImage imageNamed:@"other"];
    } else if(message.type == FSMessageModelTypeSpace){
        [self.contentBtn setBackgroundImage:[UIImage resizableImageWith:@""]  forState:UIControlStateNormal];
        self.iconView.image = [UIImage imageNamed:@""];
    }
    self.iconView.frame = _messageFrame.iconF;
    
    //3,设置正文
    [self.contentBtn setTitle:message.text forState:UIControlStateNormal];
    self.contentBtn.frame = _messageFrame.textF;
    
}

@end
