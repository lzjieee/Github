//
//  ViewController.m
//  6.4-通过plist加载单组数据
//
//  Created by J_jie on 16/7/14.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "ViewController.h"
#import "Hero.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *heros;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - 懒加载
- (NSArray *)heros
{
    if (_heros == nil)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"heros.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *modelsArray = [NSMutableArray array];
        
        for (NSDictionary *dict in arrayDict)
        {
            Hero *model = [Hero heroWithDict:dict];
            [modelsArray addObject:model];
        }
        _heros = modelsArray;
    }
    return _heros;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.heros.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Hero *hero = self.heros[indexPath.row];
    
    
    //（实例中每个单元格样式一样、或有特定规律的）每次都创建一个单元格，效率较低，所以考虑单元格重用
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    /**
        重用cell思路：
        1.创建单元格的时候指定一个重用id（标记）
        2.当需要一个新的cell的时候，先去缓存中根据重用id去查找是否有可用的单元格
        3.如果有就取出来用（修改单元格的数据为新的数据）
          如果没有需要的cell，此时只能重新创建一个了
     */
    
    //声明一个重用id (加static是为了ID不要经常被删除创建，知道应用退出才销毁ID)
    static NSString *ID = @"hero_cell";
    //根据这个重用id去缓存中查找对应的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        //在创建cell的时候指定一个重用id reuseIdentifier，当指定了这个值，当这个cell滚出，就会自动放到缓存池里
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    //输出cell的地址
    NSLog(@"%p---->行索引%ld", cell, (long)indexPath.row);
    
    
    cell.imageView.image = [UIImage imageNamed:hero.icon];
    cell.textLabel.text = hero.name;
    cell.detailTextLabel.text = hero.intro;
    
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

#pragma mark - 实现代理方法，指定行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int rowNum = indexPath.row;
    if (rowNum % 2 == 0)
    {
        return 60;
    }
    return 100;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //------ tableView的属性 ---------
    
    //统一设置UItableview的所有行的行高(效率高，所以当你确认每一cell的行高一样的时候用这个)
    //设置不同行高，要实现代理方法
    self.tableView.rowHeight = 60;
    
    //分割线颜色
    self.tableView.separatorColor = [UIColor blackColor];
    
    //分割线样式
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置最上方显示的uivew，他可以使任意控件等等
    self.tableView.tableHeaderView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    //设置最下方的view
    self.tableView.tableFooterView = [[UISwitch alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
