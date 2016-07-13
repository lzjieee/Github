//
//  ViewController.m
//  6.2-UITableView展示多组数据
//
//  Created by J_jie on 16/7/13.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tabelView;

@end

@implementation ViewController

//注意：如果运行看不到数据，可能是tableView的属性问题（在storyboard的tableView控价上设置style属性为Groups，默认是plain）

#pragma mark - 数据源方法
//返回要显示多少组数据
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //展示3组数据（亚、非、欧）
    return 3;
}

//一组有多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //根据不同的组，返回每组显示不同条数的数据
    if (section == 0) //亚洲
    {
        return 3;
    }
    else if(section == 1)//非洲
    {
        return 2;
    }
    else if(section == 2)    //欧洲
    {
        return 1;
    }
    return 0;
}


//每组每行显示的数据内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建单元格
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    if (indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"中国";
        }
        else if(indexPath.row == 1)
        {
            cell.textLabel.text = @"日本";
        }
        else
        {
            cell.textLabel.text = @"韩国";
        }
    }
    else if(indexPath.section == 1)
    {
        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"南非";
        }
        else
        {
            cell.textLabel.text = @"索马里";
        }
    }
    else
    {
        cell.textLabel.text = @"荷兰";
    }
    
    return cell;
}

//每一组的组标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"亚洲";
    }
    else if(section == 1)
    {
        return @"非洲";
    }
    else
    {
        return @"欧洲";
    }
}

//每一组的组尾
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"亚细亚洲，日出的地方";
    }
    else if(section == 1)
    {
        return @"阿里非加州，阳光灼热的地方";
    }
    else
    {
        return @"欧罗巴洲，日落的地方";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tabelView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
