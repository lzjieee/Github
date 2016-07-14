//
//  ViewController.m
//  6.5-汽车品牌展示02
//
//  Created by J_jie on 16/7/14.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "ViewController.h"
#import "Group.h"
#import "Car.h"

@interface ViewController () <UITableViewDataSource>

@property (nonatomic, strong) NSArray *groups;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

#pragma mark - 懒加载
- (NSArray *)groups
{
    if (_groups == nil)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cars_total.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *modelsArray = [NSMutableArray array];
        
        for (NSDictionary *dict in arrayDict)
        {
            Group *model = [Group groupWithDict:dict];
            [modelsArray addObject:model];
        }
        _groups = modelsArray;
    }
    return _groups;
}

#pragma mark - 实现数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Group *group = self.groups[section];
    return group.cars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.获取model数据
    //根据组索引获取对用组的模型
    Group *group = self.groups[indexPath.section];
    //根据行索引获取对应的车数据
    Car *car = group.cars[indexPath.row];
    
    //2.创建cell(可重用)
    static NSString *ID = @"car_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.imageView.image = [UIImage imageNamed:car.icon];
    cell.textLabel.text = car.name;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Group *group = self.groups[section];
    return group.title;
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
