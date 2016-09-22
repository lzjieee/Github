//
//  TopMenuCell.h
//  MeituanApp
//
//  Created by J_jie on 16/9/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@class Menu;
@class ViewController;

@interface TopMenuCell : UITableViewCell<CustomPageControlDelegate>

@property(nonatomic, strong) NSArray *menus;
//@property(nonatomic, weak) ViewController *viewControl;
@property(nonatomic, weak) UIScrollView *scrollView;


/**
    +、 - 和c的静态、非静态类似
    1、类方法以+号开头，对象(实例)方法以-号开头
    2、类方法只能由类来调用，对象方法只能由方法来调用
        // 调用类方法
        [Test init];
        // 调用对象方法
        Test *t = [Test new];
        [t show];
    3、方法归类、对象所有。
 
    oc没有明确的私有公有之分，一般函数归文件所有。所以定义在.
    一般我们包含头文件h，所以当做写在.h的是公有(外面可以访问的)，写在.m的是私有
 */
+ (instancetype)topMenuCellWithTable:(UITableView *)tableView;

// 设置滚动以后PageControl的值（并且返回当前页数）
- (int)setPageControlValueAfterScroll;

@end
