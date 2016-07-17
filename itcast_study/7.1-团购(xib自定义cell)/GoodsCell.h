//
//  GoodsCell.h
//  7.1-团购(xib自定义cell)
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Goods;
@interface GoodsCell : UITableViewCell

@property (nonatomic, strong) Goods *goods;

//封装一个自定义cell的方法
+ (instancetype)goodsCellWithTableView:(UITableView *)tableView;

@end
