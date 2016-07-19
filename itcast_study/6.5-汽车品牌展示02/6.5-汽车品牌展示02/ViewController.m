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

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSArray *groups;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSInteger groupIndex;
@property NSInteger rowIndex;

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

//设置UItableview右边的索引条
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //方法一：
//    NSMutableArray *arrayIndex = [NSMutableArray array];
//    for (Group *group in self.groups)
//    {
//        [arrayIndex addObject:group.title];
//    }
//    
//    return arrayIndex;
    
    //方法2：因为group本身没有“title”属性，所以会把group数组中的对象的title放到一个NSArray并返回
    return [self.groups valueForKeyPath:@"title"];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Group *group = self.groups[section];
    return group.title;
}

#pragma mark - 实现UITableViewDelegate代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.获取model数据
    //根据组索引获取对用组的模型
    Group *group = self.groups[indexPath.section];
    //根据行索引获取对应的车数据
    Car *car = group.cars[indexPath.row];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"编辑名称" message:car.name delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    //修改UIAlertView的样式，显示一个文本框
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    //获取文本框，并且设置文半框默认文字是car.name
    [alertView textFieldAtIndex:0].text = car.name;
    
    alertView.delegate = self;
    //alertView.tag = indexPath.row;
    self.groupIndex = indexPath.section;
    self.rowIndex = indexPath.row;
    
    //显示对话框
    [alertView show];
}

#pragma mark - 实现UIAlertViewDelegate代理方法
//UIAlertView点击按钮的监听
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1) //确定
    {
        //1.获取用户输入的内容
        NSString *name = [alertView textFieldAtIndex:0].text;
        //2.找到对应的model
        Group *group = self.groups[self.groupIndex];
        Car *car = group.cars[self.rowIndex];
        //3.修改model的name
        car.name = name;
        //4.刷新tableview
        //刷新一个cell(总行数不变的时候才能使用这个，总行数变化了必须整个刷新,因为局部刷新其实是先删除该行，再重新显示)
        //4.1创建行对象
        NSIndexPath *idxPath = [NSIndexPath indexPathForRow:self.rowIndex inSection:self.groupIndex];
        [self.tableView reloadRowsAtIndexPaths:@[idxPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        //刷新整个tableView
        //[self.tableView reloadData];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
