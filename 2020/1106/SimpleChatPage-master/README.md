# SimpleChatPage
iOS简易聊天页面以及容联云IM自定义聊天页面的实现思路

首先，楼主所在的公司只有楼主一个iOS开发，在代码规范上大神们也许会反感，请多包涵。我会不断改进。

一、关于UI页面实现
 1） 整体是UITableView，自定义Cell。气泡用的图片局部拉伸，代码如下
        
        //UIImageResizingModeStretch：拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
        //UIImageResizingModeTile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图
        UIImage *iconImage = [UIImage imageNamed:img];
        CGFloat w = iconImage.size.width;
        CGFloat h = iconImage.size.height;
        UIImage *newImage = [iconImage resizableImageWithCapInsets:UIEdgeInsetsMake(h * 0.5, w * 0.5, h * 0.5, w * 0.5) resizingMode:UIImageResizingModeStretch];

  2）输入框的键盘跟随实现思路
  
      //计算需要移动的距离
      NSDictionary *dict = notification.userInfo ;
      CGRect keyBoardFrame =  [[dict objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
      CGFloat keyboardY = keyBoardFrame.origin.y;
      CGFloat translationY = keyboardY - self.view.frame.size.height;
      //动画执行时间
      CGFloat time = [[dict objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
      
      //键盘弹出的节奏和view动画节奏一致:7 << 16
      [UIView animateKeyframesWithDuration:time delay:0.0 options:7 << 16 animations:^{
      self.view.transform = CGAffineTransformMakeTranslation(0, translationY);
      } completion:^(BOOL finished) {
  
      }];
        
二、关于容联云IM SDK（我只拿发送接收文字消息进行说明）
 为了节省成本我们没有用它消息存储的功能，自己在发送消息的同时调用我们的接口添加到自己的服务器，读取历史小时的时候倒序输出即可
 1）发送文字消息（不多说，容联云的开发文档有，这里仅提供关键部分）
      
      ECTextMessageBody *messageBody = [[ECTextMessageBody alloc] initWithText:strText];
       ECMessage *message = [[ECMessage alloc] initWithReceiver:strJoin body:messageBody];
       [[ECDevice sharedInstance].messageManager sendMessage:message progress:nil completion:^(ECError *error,ECMessage *amessage) {
     }];
     
  2）文字消息发送成功之后UI的变化
      因为容联云无论发送还是接收的消息都是只读型，所以我们需要包装，比如发送和接收文字的高度，从而确定Cell的高度，代码如下
      
      MessageFrameModel *mf = [[MessageFrameModel alloc] init];
      mf.strGetTimeFromService = strTime;
      mf.hiddenTime = isShowTime;
      NSString *strJoin = [NSString stringWithFormat:@"company_%@",[UserModel shareUserModel].userId];
      mf.messageFrom = strJoin;//确定是发送方还是接收方从而判断UI的显示类型
      mf.messgeType = @"1";
      mf.message = message;
      
      //计算文字的代码：
      //font 字体 maxSize容器的大小
      -(CGSize) sizeWithFont:(UIFont *) font maxSize:(CGSize) maxSize
      {
      NSDictionary *dict  = @{NSFontAttributeName: font};
      CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
      return  textSize;
      }
      
3）接收消息
     容联云提供一个单例，SDK配置好之后接收到的所有消息都会先到这个单例里DeviceDelegateHelper
     接收到消息的同时向正在聊天的页面发送通知，通知内容是消息体
     当正在聊天页接收到通知时再次进行消息包装，添加到数组刷新页面进行显示。
     
4）补充说明
    项目聊天的功能我只用两周的时间，也许有更简洁的方法，不过当时用容联云SDK自带的聊天页面实在太low，所以才会自己写聊天页面。聊天UI的代码已经上传GitHub请您自行下载，如果对您有微薄的帮助还希望您给个星星，鼓励一下楼主的处女作。
     
       


