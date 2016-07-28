//
//  FriendCell.m
//  9.2-好友列表
//
//  Created by J_jie on 16/7/27.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "FriendCell.h"
#import "Friend.h"

@implementation FriendCell

+ (instancetype)friendCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"friend_cell";
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[FriendCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (void)setFriendModel:(Friend *)friendModel
{
    _friendModel = friendModel;
    // 把模型中的数量设置个cell的子控件
    self.imageView.image = [UIImage imageNamed:friendModel.icon];
    self.textLabel.text = friendModel.name;
    self.detailTextLabel.text = friendModel.intro;
    
    //根据当前好友是不是vip
    self.textLabel.textColor = friendModel.isVip ? [UIColor redColor] : [UIColor blackColor];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
