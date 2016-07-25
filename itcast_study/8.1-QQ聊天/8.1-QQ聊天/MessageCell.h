//
//  MessageCell.h
//  8.1-QQ聊天
//
//  Created by J_jie on 16/7/25.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageFrame;
@interface MessageCell : UITableViewCell

//为自定义cell增加一个messageFrame属性
@property (nonatomic, strong) MessageFrame *messageFrame;

+ (instancetype)messageCellWith:(UITableView *)tableView;

@end
