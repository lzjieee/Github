//
//  GroupHeaderView.h
//  9.2-好友列表
//
//  Created by J_jie on 16/7/28.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
    代理思路：
        因为这里GroupHeaderView想刷新tableview，但是他做不到，所以想到找代理。
        发现QQFriendsTableViewController可以，
        所以QQFriendsTableViewController成为GroupHeaderView的代理对象
    具体实现：
        1.GroupHeaderView定义代理GroupHeaderViewDelegate，
          定义代理方法groupHeaderViewDidClickTitleButton（GroupHeaderView把(那个对象的代理)自己传过去）
        2.GroupHeaderView类中增加一个代理属性@property (nonatomic, weak) id<GroupHeaderViewDelegate> delegate;
        3.在需要调用代理方法的地方调用代理方法
            //首先判断代理对象是否实现了代理方法
            if([self.delegate respondsToSelector:@selector(groupHeaderViewDidClickTitleButton:)])
            {
                //调用代理方法
                [self.delegate groupHeaderViewDidClickTitleButton:self];
            }
 
        4.QQFriendsTableViewController中遵守GroupHeaderViewDelegate协议
            设置代理对象headerVw.delegate = self;
            实现代理方法groupHeaderViewDidClickTitleButton

 
 */
@class GroupHeaderView;
@protocol  GroupHeaderViewDelegate <NSObject>

- (void)groupHeaderViewDidClickTitleButton:(GroupHeaderView *)groupHeaderView;

@end

@class Group;
@interface GroupHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) Group *group;

+ (instancetype)groupHeaderViewWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) id<GroupHeaderViewDelegate> delegate;

@end
