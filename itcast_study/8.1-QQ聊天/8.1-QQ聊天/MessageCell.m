//
//  MessageCell.m
//  8.1-QQ聊天
//
//  Created by J_jie on 16/7/25.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "MessageCell.h"
#import "Message.h"
#import "MessageFrame.h"

@interface MessageCell()

@property (nonatomic, weak) UILabel *lblTime;
@property (nonatomic, weak) UIImageView *imgViewIcon;
@property (nonatomic, weak) UIButton *btnText;

@end

@implementation MessageCell

#pragma mark - 重写父类initWithStyle
-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //创建子控件
        //时间label
        UILabel *lblTime = [[UILabel alloc] init];
        [self.contentView addSubview:lblTime];
        lblTime.font = [UIFont systemFontOfSize:12];
        lblTime.textAlignment = NSTextAlignmentCenter;
        self.lblTime = lblTime;
        
        //头像uiimageView
        UIImageView *imgViewIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:imgViewIcon];
        self.imgViewIcon = imgViewIcon;
        
        //消息正文的btn
        UIButton *btnText = [[UIButton alloc] init];
        [self.contentView addSubview:btnText];
        //设置正文字体大小
        btnText.titleLabel.font = textFont;
        //设置正文文字颜色（默认白色）
        [btnText setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设置文字换行
        btnText.titleLabel.numberOfLines = 0;
        self.btnText = btnText;
    }
    
    //设置cell的背景颜色
    //self.backgroundColor = [UIColor clearColor];
    
    return self;
}

#pragma mark - 重写messageFrame的set方法
- (void)setMessageFrame:(MessageFrame *)messageFrame
{
    _messageFrame = messageFrame;
    
    Message *message = messageFrame.message;
    
    //分别设置每个子控件的数据和frame
    self.lblTime.text = message.time;
    self.lblTime.frame = messageFrame.timeFrame;
    self.lblTime.hidden = message.hideTime;
    
    NSString *iconImg = message.type == MessageTypeMe ? @"me" : @"other";
    self.imgViewIcon.image = [UIImage imageNamed:iconImg];
    self.imgViewIcon.frame = messageFrame.iconFrame;
    
    [self.btnText setTitle:message.text forState:UIControlStateNormal];
    self.btnText.frame = messageFrame.textFrame;
    
}

#pragma mark - 创建自定义cell的类方法,返回自定义cell
+ (instancetype)messageCellWith:(UITableView *)tableView
{
    static NSString *ID = @"message_cell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
