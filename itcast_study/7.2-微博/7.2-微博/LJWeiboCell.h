//
//  LJWeiboCell.h
//  7.2-微博
//
//  Created by J_jie on 16/7/20.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJWeiboFrame;
@interface LJWeiboCell : UITableViewCell

@property (nonatomic, strong) LJWeiboFrame *weiboFrame;

+ (instancetype)weiboCellWithTableView:(UITableView *)tableView;

@end
