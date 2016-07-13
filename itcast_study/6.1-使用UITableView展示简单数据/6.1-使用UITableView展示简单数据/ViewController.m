//
//  ViewController.m
//  6.1-使用UITableView展示简单数据
//
//  Created by J_jie on 16/7/13.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

/**
 创建tableview的方法
 1.为uitabelview设置数据源对象
 2.让数据源对象遵守UITableViewDataSource协议
 3.让数据源对象实现UITableViewDataSource协议的方法（一般实现3个方法）

 */

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置数据源和设置代理的两种方式
    //1.代码方式
    //2.拖线方式
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**********  UITableView的数据源方法   **********/

//1.告诉tableview要显示几组（这个方法可以不实现，默认分1组）
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//2.每一组显示几行数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

//3.告诉uitiabelview每一行怎么显示数据（返回一个cell）
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //表示当前第几组
    //indexPath.section;
    //表示当前第几行
    //indexPath.row
    
    //创建一个单元（cell）对象并返回
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    //为单元格指定数据
    cell.textLabel.text = @"hello";
    return cell;
}

/**********  UITableView的数据源方法   **********/

@end
