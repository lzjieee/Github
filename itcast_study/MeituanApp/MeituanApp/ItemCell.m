//
//  ItemCell.m
//  MeituanApp
//
//  Created by J_jie on 16/9/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ItemCell.h"
#import "Item.h"

@interface ItemCell()

@property(nonatomic, weak) UIImageView *imgVw;
@property(nonatomic, weak) UILabel *nameLbl;
@property(nonatomic, weak) UILabel *descLbl;
@property(nonatomic, weak) UILabel *priceLbl;
@property(nonatomic, weak) UILabel *rackRateLbl;
@property(nonatomic, weak) UILabel *kmLbl;
@property(nonatomic, weak) UILabel *buyCountLbl;

@end

@implementation ItemCell

+(instancetype)itemCellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"item_cell";
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[ItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UIImageView *imgVw = [[UIImageView alloc] initWithFrame:CGRectMake(5, 7.5, 90, 75)];
        UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(105, 8, 100, 25)];
        UILabel *descLbl = [[UILabel alloc] initWithFrame:CGRectMake(105, 30, 50, 25)];
        UILabel *priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(105, 60, 80, 25)];
        UILabel *rackRateLbl = [[UILabel alloc] initWithFrame:CGRectMake(160, 60, 80, 25)];
        UILabel *kmLbl = [[UILabel alloc] initWithFrame:CGRectMake(300, 8, 60, 25)];
        UILabel *buyCountLbl = [[UILabel alloc] initWithFrame:CGRectMake(300, 60, 60, 25)];
        
        [self.contentView addSubview:imgVw];
        [self.contentView addSubview:nameLbl];
        [self.contentView addSubview:descLbl];
        [self.contentView addSubview:priceLbl];
        [self.contentView addSubview:rackRateLbl];
        [self.contentView addSubview:kmLbl];
        [self.contentView addSubview:buyCountLbl];
        self.imgVw = imgVw;
        self.nameLbl = nameLbl;
        self.descLbl = descLbl;
        self.priceLbl = priceLbl;
        self.rackRateLbl = rackRateLbl;
        self.kmLbl = kmLbl;
        self.buyCountLbl = buyCountLbl;
        
        self.buyCountLbl.textColor = [UIColor grayColor];
        self.kmLbl.textColor = [UIColor grayColor];
        self.rackRateLbl.textColor = [UIColor grayColor];
        self.descLbl.textColor = [UIColor grayColor];
        self.buyCountLbl.font = [UIFont systemFontOfSize:12];
        self.rackRateLbl.font = [UIFont systemFontOfSize:12];
        self.kmLbl.font = [UIFont systemFontOfSize:12];
        // 字体加粗 (labelname.font = [UIFont fontWithName:@"Helvetica-Bold" size:15]; 也可以)
        self.priceLbl.font = [UIFont boldSystemFontOfSize:22];
        self.priceLbl.textColor = [UIColor colorWithRed:32.0f/255 green:178.0/255 blue:170.0/255 alpha:1.0f];
        self.kmLbl.textAlignment = NSTextAlignmentRight;
        self.buyCountLbl.textAlignment = NSTextAlignmentRight;
    }
    return self;
}

-(void)setItem:(Item *)item
{
    _item = item;
    [self setUIDatas];
}

-(void)setUIDatas
{
    self.imgVw.image = [UIImage imageNamed:self.item.icon];
    self.nameLbl.text = self.item.name;
    self.descLbl.text = self.item.desc;
    self.priceLbl.text = [NSString stringWithFormat: @"¥%@", self.item.price];
    self.rackRateLbl.text = [NSString stringWithFormat: @"原价:%@", self.item.rackRate];
    self.kmLbl.text = self.item.distance;
    self.buyCountLbl.text = [NSString stringWithFormat:@"已售:%@", self.item.buyCount];
    
    // label自动换行相关
    UIFont *textFont = [UIFont systemFontOfSize:12.f];
    self.descLbl.font = textFont;
    // 折行
    self.descLbl.lineBreakMode = NSLineBreakByWordWrapping;
    // 必须写，否则只显示一行
    [self.descLbl setNumberOfLines:0];
    // 最大尺寸
    // MAXFLOAT 为可设置的最大高度
    CGSize size = CGSizeMake(180, MAXFLOAT);
    // 获取当前那本属性
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:textFont, NSFontAttributeName, nil];
    // 实际尺寸
    CGSize actualSize = [self.item.desc boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    // 重新设置label的frame
    self.descLbl.frame = CGRectMake(self.descLbl.frame.origin.x, self.descLbl.frame.origin.y
                                    , actualSize.width, actualSize.height);
    
    
}

@end
