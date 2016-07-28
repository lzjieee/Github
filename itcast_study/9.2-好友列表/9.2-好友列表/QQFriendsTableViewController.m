//
//  QQFriendsTableViewController.m
//  9.2-好友列表
//
//  Created by J_jie on 16/7/27.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "QQFriendsTableViewController.h"
#import "Group.h"
#import "Friend.h"
#import "FriendCell.h"
#import "GroupHeaderView.h"

@interface QQFriendsTableViewController () <GroupHeaderViewDelegate>

// 保存所有的分组数据
@property (nonatomic, strong) NSArray *groups;

@end

@implementation QQFriendsTableViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - 懒加载数据
- (NSArray *)groups
{
    if(_groups == nil)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friends.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModel = [NSMutableArray array];
        
        for (NSDictionary *dict in arrayDict)
        {
            //模型嵌套了---所以groupWithDict内部还进行了一次字典转模型
            Group *model = [Group groupWithDict:dict];
            [arrayModel addObject:model];
        }
        _groups = arrayModel;
    }
    
    return _groups;
}

#pragma mark - 实现数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

/**
 好友列表展开、合上的效果实现的本质是：numberOfRowsInSection返回值(0表示这个组没数据-合上效果，大于0表示有数据-展开效果）
 具体实现：因为在这个方法中要根据当前组的状态（是否展开）来设置不同的返回值，所以要为Group(组)增加一个是否展开的属性
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Group *group = self.groups[section];
    if(group.isVisible)
    {
        return group.friends.count;
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.获取数据
    Group *group = self.groups[indexPath.section];
    Friend *friend = group.friends[indexPath.row];
    
    //2.创建cell
    FriendCell *cell = [FriendCell friendCellWithTableView:tableView];
        
    //3.将model设置给cell
    cell.friendModel = friend;
    
    //4.返回cell
    return cell;
}

// 设置每一组的组标题（不过这个方法只能设置字符串，但这里要求有一些子控件，所以不合适）
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    Group *group = self.groups[section];
//    return group.name;
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   // UITableViewHeaderFooterView是uiview的子类，这里不直接创建uiview对象，用UITableViewHeaderFooterView具有重用的功能
    /**
        由于 1.我这里需要UITableViewHeaderFooterView中有一个btn和一个label，UITableViewHeaderFooterView没有
            2.我希望UITableViewHeaderFooterView具有group属性
            3.我希望将创建UITableViewHeaderFooterView的代码封装起来，直接返回创建好的UITableViewHeaderFooterView
        
        所以：显然系统的UITableViewHeaderFooterView不够用
        解决：自定义一个类继承UITableViewHeaderFooterView
     */
    
    // 获取数据
    Group *group = self.groups[section];
    
    // 创建UITableViewHeaderFooterView
    GroupHeaderView *headerVw = [GroupHeaderView groupHeaderViewWithTableView:tableView];
    headerVw.tag = section;
    
    // 设置数据
    headerVw.group = group;
    
    // 在刚刚创建好的headerVw中的frame都是0，因为刚刚创建好的时候我们没有为headerVw的frame赋值，所以他的frame都是0
    /** 
        但是，程序运行起来，我们看到的headerVw是有frame的。
        原因：在当前方法中，将headerVw返回以后，UItableview在执行的时候，会用到headerVw。UItableview既然要用headerVw
             那么就必须将headerVw添加到UItableview中，当把headerVw添加到UItableview的时候，UItableview内部会根据
             一些设置来动态的为headerVw的frame赋值，也就是说UItableview即将使用headerVw的时候才会为headerVw的frame赋值
     */
    
    //设置代理
    headerVw.delegate = self;
    
    return headerVw;
    
}

#pragma mark - 实现GroupHeaderViewDelegate的代理方法
- (void)groupHeaderViewDidClickTitleButton:(GroupHeaderView *)groupHeaderView
{
    //刷新tableview
    //[self.tableView reloadData];
    
    //创建一个表示某个组的对象
    NSIndexSet *idxSet = [NSIndexSet indexSetWithIndex:groupHeaderView.tag];
    
    //局部刷新---只刷新某一组
    [self.tableView reloadSections:idxSet withRowAnimation:UITableViewRowAnimationFade];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 统一设置每组的组标题的高度
    self.tableView.sectionHeaderHeight = 44;
}

@end
