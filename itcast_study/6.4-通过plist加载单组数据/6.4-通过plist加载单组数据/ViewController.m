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
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                   reuseIdentifier:nil];
    
    cell.imageView.image = [UIImage imageNamed:hero.icon];
    cell.textLabel.text = hero.name;
    cell.detailTextLabel.text = hero.intro;
    
    //设置单元格右边小箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //(自定义右边)当上面accessoryType的属性不够用，你想右边显示其他的时候
    //cell.accessoryView = [[UISwitch alloc] init];
    
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
    
    //统一设置UItableview的所有行的行高(效率高，所以当你确认每一cell的行高一样的时候用这个)
    //设置不同行高，要实现代理方法
    self.tableView.rowHeight = 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
