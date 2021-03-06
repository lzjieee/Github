//
//  ViewController.m
//  7.1-团购(xib自定义cell)
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "Goods.h"
#import "GoodsCell.h"
#import "FooterView.h"
#import "HeaderView.h"

@interface ViewController () <UITableViewDataSource, FooterViewDelegate>

@property (nonatomic, strong) NSMutableArray *goods;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - 懒加载数据
- (NSMutableArray *)goods
{
    if(_goods == nil)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tgs" ofType:@"plist"];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *modelArray = [NSMutableArray array];
        
        for (NSDictionary *dict in arrayDict)
        {
            Goods *model = [Goods goodsWithDict:dict];
            [modelArray addObject:model];
        }
        _goods = modelArray;
    }
    
    return _goods;
}

#pragma mark - 实现FooterViewDelegate的代理方法
- (void)footViewUpdateData:(FooterView *)footView
{
    //3.1创建model
    Goods *model = [[Goods alloc] init];
    model.title = @"驴肉火烧";
    model.price = @"6";
    model.buyCount = @"1000";
    model.icon = @"xiaojie.png";
    //3.2将model加到控制器的goods集合中
    [self.goods addObject:model];
    
    //4.刷新UItableView（注意:总行数变化了必须整个刷新）
    [self.tableView reloadData];
    
    //把uitabelview滚到最后
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:self.goods.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:idxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark - 实现数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.获取model
    Goods *model = self.goods[indexPath.row];
    //2.创建cell
//    NSString *ID = @"goods_cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if(cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
    
    //2.1通过xib方式创建cell(自定义cell方法goodsCellWithTableView，返回GoodsCell)
    GoodsCell *cell = [GoodsCell goodsCellWithTableView:tableView];
    
    //3.model数据设置给cell
    /**
     在控制器中直接为xib的cell的每个控件赋值数据造成的问题：
        1.控制器强依赖cell，一旦cell内部控件发生变化，那么控制器的代码也要改（造成了紧耦合）
        2.cell的封装不完整，凡是用到cell的地方，每次编写cell的子控件依次赋值的语句，比如：cell.xxx = model.xxx
     解决方法：
        直接把model给自定义CELL类，让cell类自己去完成解析model赋值给自己的子控键
        (自定义cell类中添加model属性，重写set方法，创建cell的时候将model赋值给这个model属性就会调用set方法)
    */
    cell.goods = model;
    
    //4.返回cell
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    //通过xib创建cell，如果没有为tableview指定行高，运行时会有一个警告
    self.tableView.rowHeight = 44;
    
    //设置tableview的footerview (footerview的特点只能改x和高度，不能修改y和宽)
    //由于我们想在footerview里添加好几个控件，而且变化多，所以直接加按钮会很死板，
    //正确思路是添加一个UIview，然后再添加想要的其他控件，也可用一个xib来描述这部分
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    btn.backgroundColor = [UIColor orangeColor];
//    self.tableView.tableFooterView = btn;
    
    //通过xib加载tabelview的footerview
    //由于要对view里面的控件做操作，所以不能用UIView来作为xib对象，要自定义一个继承UIView的类才行
    //等待控件(activity indicator view)默认是不转的，勾选属性behavior animating才会转 ，勾选（隐藏的时候停止） hiddes when stopped
    FooterView *footerView = [FooterView footerView];
    //设置自定义的FootView代理
    footerView.delegate = self;
    self.tableView.tableFooterView = footerView;
    
    //创建headerview
    HeaderView *headerView = [HeaderView headerView];
    self.tableView.tableHeaderView = headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
