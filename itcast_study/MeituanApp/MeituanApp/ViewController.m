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
    return 3;
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
    
    //声明一个重用id (加static是为了ID不要经常被删除创建，知道应用退出才销毁ID)
    static NSString *ID = @"hero_cell";
    //根据这个重用id去缓存中查找对应的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        //在创建cell的时候指定一个重用id reuseIdentifier，当指定了这个值，当这个cell滚出，就会自动放到缓存池里
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.textLabel.text = @"ssss";
    
    //设置单元格右边小箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //(自定义右边)当上面accessoryType的属性不够用，你想右边显示其他的时候
    //cell.accessoryView = [[UISwitch alloc] init];
    
    //------------- 设置单元格的属性 ---------------
    
    //单元格背景色
    //cell.backgroundColor = [UIColor yellowColor];
    
    //设置选中的背景色（由于没有直接的属性设置，可以通过）
    //    UIView *bgview = [[UIView alloc] init];
    //    bgview.backgroundColor = [UIColor greenColor];
    //    cell.selectedBackgroundView = bgview;
    
    //cell.backgroundView (可以利用这个属性来设置单元格图片，等)
    
    return cell;
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
