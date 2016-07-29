//
//  AppCell.h
//  9.3-应用管理
//
//  Created by J_jie on 16/7/28.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppCell;
@protocol AppCellDelegate <NSObject>
- (void)appCellDidCilckDownloadButton:(AppCell *)appCell;

@end

@class App;
@interface AppCell : UITableViewCell

@property (nonatomic, strong) App *app;

@property (nonatomic, weak) id<AppCellDelegate> delegate;

@end
