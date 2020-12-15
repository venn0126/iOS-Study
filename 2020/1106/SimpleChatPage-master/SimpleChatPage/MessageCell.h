//
//  MessageCell.h
//  QQPage
//
//  Created by 李海群 on 2017/7/4.
//  Copyright © 2017年 李海群. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
#import "MessageFrameModel.h"
#import "UIImage+HQExtension.h"


@interface MessageCell : UITableViewCell


@property (nonatomic, strong) MessageFrameModel *messageFrame;

+(instancetype) cellWithTableView:(UITableView *) tableview;

@end
