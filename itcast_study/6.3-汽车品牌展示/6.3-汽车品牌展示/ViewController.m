//
//  ViewController.m
//  6.3-汽车品牌展示
//
//  Created by J_jie on 16/7/13.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "ViewController.h"
#import "Group.h"

@interface ViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *groups;

@end

@implementation ViewController

#pragma mark - 懒加载数据
- (NSArray *)groups
{
    if(_groups == nil)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"car_simple.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModel = [NSMutableArray array];
        for (NSDictionary *dict in arrayDict)
        {
            Group *model = [Group groupWithDict:dict];
            [arrayModel addObject:model];
        }
        _groups = arrayModel;
    }
    return _groups;
}

#pragma mark - 实现UITableViewDataSource协议的方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //1.根据（section）索引获取组对象
    Group *group = self.groups[section];
    return group.cars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.获取模型数据
    Group *group = self.groups[indexPath.section];
    //2.创建单元格
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    //3.将model的数据设置给单元格，并返回cell
    cell.textLabel.text = group.cars[indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Group *group = self.groups[section];
    return group.title;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    Group *group = self.groups[section];
    return group.desc;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
