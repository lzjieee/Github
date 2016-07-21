//
//  LJWeiboCell.m
//  7.2-微博
//
//  Created by J_jie on 16/7/20.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "LJWeiboCell.h"
#import "LJWeibo.h"
#import "LJWeiboFrame.h"
#define nameFont [UIFont systemFontOfSize:12]
#define textFont [UIFont systemFontOfSize:14]

@interface LJWeiboCell ()

@property (nonatomic, weak) UIImageView *imgViewIcon;
@property (nonatomic, weak) UILabel *lblNickName;
@property (nonatomic, weak) UIImageView *imgVip;
@property (nonatomic, weak) UILabel *lblText;
@property (nonatomic, weak) UIImageView *imgViewPicture;

@end

@implementation LJWeiboCell

+ (instancetype)weiboCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"weibo_cell";
    //这种UITableViewCell创建的cell局限性太大，而且每一行cell样式不一样（不能用xib），所以自己写一个类继承UITableViewCell重写initWithStyle方法，改造自己的cell
    LJWeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[LJWeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (void)setWeiboFrame:(LJWeiboFrame *)weiboFrame
{
    _weiboFrame = weiboFrame;
    
    //1.设置数据
    [self settingData];
    
    //2.设置cell中子控件的frame
    [self settingFrame];
}

- (void)settingData
{
    LJWeibo *model = self.weiboFrame.weibo;
    
    //1.头像
    self.imgViewIcon.image = [UIImage imageNamed:model.icon];
    
    //2.昵称
    self.lblNickName.text = model.name;
    
    //3.会员(创建子控件的时候已经设置了,这里只要设置是否显示这个控件就可以了)
    if (model.isVip)
    {
        self.lblNickName.textColor = [UIColor orangeColor];
        self.imgVip.hidden = NO;
    }
    else
    {
        self.lblNickName.textColor = [UIColor blackColor];
        self.imgVip.hidden = YES;
    }
    
    //4.正文
    self.lblText.text = model.text;
    
    //5.配图
    if(model.picture)
    {
        self.imgViewPicture.image = [UIImage imageNamed:model.picture];
        self.imgViewPicture.hidden = NO;
    }
    else
    {
        self.imgViewPicture.hidden = YES;
    }
    
}

- (void)settingFrame
{
    //1.头像
    self.imgViewIcon.frame = self.weiboFrame.iconFrame;
    
    //2.昵称
    self.lblNickName.frame = self.weiboFrame.nameFrame;
    
    //3.会员(创建子控件的时候已经设置了,这里只要设置是否显示这个控件就可以了)
    self.imgVip.frame = self.weiboFrame.vipFrame;
    
    //4.正文
    self.lblText.frame = self.weiboFrame.textFrame;
    
    //5.配图
    self.imgViewPicture.frame = self.weiboFrame.picFrame;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    //先调一下父类的initWithStyle
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //创建自己的控件
        //1.头像
        UIImageView *imgViewIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:imgViewIcon];
        self.imgViewIcon = imgViewIcon;
        //2.昵称
        UILabel *lblNickName = [[UILabel alloc] init];
        [self.contentView addSubview:lblNickName];
        //设置lbl的文字大小
        lblNickName.font = nameFont;
        self.lblNickName = lblNickName;
        //3.会员
        UIImageView *imgVip = [[UIImageView alloc] init];
        //由于vip都是一样的，所以创建的时候就赋值
        imgVip.image = [UIImage imageNamed:@"vip.png"];
        [self.contentView addSubview:imgVip];
        self.imgVip = imgVip;
        //4.正文
        UILabel *lblText = [[UILabel alloc] init];
        lblText.font = textFont;
        //设置自动换行
        lblText.numberOfLines = 0;
        [self.contentView addSubview:lblText];
        self.lblText = lblText;
        //5.配图
        UIImageView *imgViewPicture = [[UIImageView alloc] init];
        [self.contentView addSubview:imgViewPicture];
        self.imgViewPicture = imgViewPicture;
    }
    return self;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
