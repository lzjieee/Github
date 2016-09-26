//
//  ItemCell.h
//  MeituanApp
//
//  Created by J_jie on 16/9/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Menu;
@class Item;
@interface ItemCell : UITableViewCell

@property(nonatomic, strong)Item *item;

+(instancetype)itemCellWithTable:(UITableView *)tableView;

@end
