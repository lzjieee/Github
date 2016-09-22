//
//  MidMenuCell.m
//  MeituanApp
//
//  Created by J_jie on 16/9/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MidMenuCell.h"
#import "Menu.h"

@implementation MidMenuCell

-(void)setMenus:(NSArray *)menus
{
    _menus = menus;
    [self setMidMenuUIData];
}

+ (instancetype)midMenuCellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"midmenu_cell";
    MidMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[MidMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    //先调一下父类的initWithStyle
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //创建自己的控件
    }
    return self;
}

- (void)setMidMenuUIData
{
    for (int i = 0; i < self.menus.count; i++)
    {
        Menu *midMenuData = [self.menus objectAtIndex:i];
        CGFloat posX = 5 + i % 2 * (180 + 7);
        CGFloat posY = 0 + i / 2 * 60;
//        
//        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(posX, posY, 180, 60)];
//        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 120, 20)];
//        titleLbl.text = midMenuData.name;
        UIImage *img = [UIImage imageNamed:midMenuData.icon];
//        UIImageView *imgVw = [[UIImageView alloc] initWithImage:img];
//        imgVw.frame = CGRectMake(130, 5, 50, 45);
//        
//        [bgView addSubview:imgVw];
//        [bgView addSubview:titleLbl];
//        [self.contentView addSubview:bgView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(posX, posY, 180, 60);
        [btn setTitle:midMenuData.name forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -190, 0, 0)];
        [btn setImage:img forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 75, 0, 0)];
        [self.contentView addSubview:btn];
    }
}

@end
