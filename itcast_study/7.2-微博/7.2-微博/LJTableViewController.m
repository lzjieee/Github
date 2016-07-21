//
//  LJTableViewController.m
//  7.2-微博
//
//  Created by J_jie on 16/7/20.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "LJTableViewController.h"
#import "LJWeibo.h"
#import "LJWeiboCell.h"
#import "LJWeiboFrame.h"


@interface LJTableViewController ()

@property (nonatomic, strong) NSArray *weiboFrames;

@end


@implementation LJTableViewController

#pragma mark - 让懒加载
- (NSArray *)weiboFrames
{
    if(_weiboFrames == nil)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"weibo.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModel = [NSMutableArray array];
        
        for (NSDictionary *dict in arrayDict)
        {
            //创建数据模型
            LJWeibo *model = [LJWeibo WeiboWithDict:dict];
            //创建frame模型
            LJWeiboFrame *modelFrame = [[LJWeiboFrame alloc] init];
            //把数据模型赋值给frame模型
            modelFrame.weibo = model;
            [arrayModel addObject:modelFrame];
        }
        _weiboFrames = arrayModel;
    }
    
    return _weiboFrames;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //因为这里使用的是TableViewController，所以不用在再实现数据源协议了TableViewController已经实现过了
    //而且也不用拖线，才能访问到tableview了，直接self.tableview就能访问了。而且self.tableview和self.view是一样的对象
    NSLog(@"%@", self.view);
    NSLog(@"%@", self.tableView);
    
    //self.tableView.rowHeight = 300;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.weiboFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1.获取model数据
    LJWeiboFrame *model = self.weiboFrames[indexPath.row];
    
    //2.创建cell
    //这种UITableViewCell创建的cell局限性太大，而且每一行cell样式不一样（不能用xib），所以自己写一个类继承UITableViewCell重写initWithStyle方法，改造自己的cell
    LJWeiboCell *cell = [LJWeiboCell weiboCellWithTableView:self.tableView];
    
    //3.设置cell的数据(想要赋值以后自动改变cell控件的数据，重写weibo属性的set方法)
    cell.weiboFrame = model;
    
    //4.返回cell
    return cell;
}

#pragma mark - Table view 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJWeiboFrame *weiboFrame = self.weiboFrames[indexPath.row];
    return weiboFrame.rowHeight;
}


@end
