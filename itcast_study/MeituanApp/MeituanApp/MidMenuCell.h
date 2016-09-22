//
//  MidMenuCell.h
//  MeituanApp
//
//  Created by J_jie on 16/9/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MidMenuCell : UITableViewCell

@property(nonatomic, strong) NSArray *menus;

+ (instancetype)midMenuCellWithTable:(UITableView *) tableView;

@end
