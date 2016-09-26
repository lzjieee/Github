//
//  ViewController.m
//  MeituanApp
//
//  Created by mac on 16/9/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "Menu.h"
#import "Item.h"
#import "TopMenuCell.h"
#import "MidMenuCell.h"
#import "ItemCell.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property(nonatomic, strong) NSArray *menus;
@property(nonatomic, strong) NSArray *items;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ViewController

#pragma mark - 懒加载数据
- (NSArray *)menus
{
    if (_menus == nil)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Menu.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModel = [NSMutableArray array];
        
        for (NSDictionary *dict in arrayDict)
        {
            Menu *model = [Menu menuWithDict:dict];
            [arrayModel addObject:model];
        }
        _menus = arrayModel;
    }
    return _menus;
}

- (NSArray *)items
{
    if(_items == nil)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Item.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModel = [NSMutableArray array];
        
        for (NSDictionary *dict in arrayDict)
        {
            Item *model = [Item itemWithDict:dict];
            [arrayModel addObject:model];
        }
        _items = arrayModel;
    }
    return _items;
}

#pragma mark - 实现TableView数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        TopMenuCell *cell = [TopMenuCell topMenuCellWithTable:tableView];
        cell.menus = [self getTopMenuDatas];
        [cell.scrollView setDelegate:self];
        // 设置代理
        self.delegate = cell;
        return cell;
    }
    else if(indexPath.row == 1)
    {
        MidMenuCell *cell = [MidMenuCell midMenuCellWithTable:tableView];
        cell.menus = [self getMidMenuDatas];
        return cell;
    }
    else
    {
        ItemCell *cell = [ItemCell itemCellWithTable:tableView];
        if(indexPath.row - 2 >= 0)
        {
            cell.item = [self.items objectAtIndex:indexPath.row - 2];
        }
        return cell;
    }
}

#pragma mark - 实现TableView代理方法，指定行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 150;
    }
    else if(indexPath.row == 1)
    {
        return 180;
    }
    else
    {
        return 90;
    }
}

#pragma mark - 实现scrollview代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 首先判断代理对象是否实现了代理方法
    if([self.delegate respondsToSelector:@selector(refreshPageControl:)])
    {
        //调用代理方法
        [self.delegate refreshPageControl:self];
    }
}
- (NSMutableArray *)getTopMenuDatas
{
    NSMutableArray *muArray = [NSMutableArray array];
    for (int i = 0; i < self.menus.count; i++)
    {
        Menu *topMenu = [self.menus objectAtIndex:i];
        if(topMenu.topMenu == YES)
        {
            [muArray addObject:topMenu];
        }
    }
    return muArray;
}
- (NSMutableArray *)getMidMenuDatas
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < self.menus.count; i++)
    {
        Menu *midMenu = [self.menus objectAtIndex:i];
        if(midMenu.topMenu == NO)
        {
            [array addObject:midMenu];
        }
    }
    return array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSLog(@"%ld", self.items.count);
//    NSLog(@"%ld", self.menus.count);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //------ tableView的属性 ---------
    //分割线颜色
    //self.tableView.separatorColor = [UIColor blackColor];
    
    //分割线样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
