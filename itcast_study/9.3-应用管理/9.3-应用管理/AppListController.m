//
//  AppListController.m
//  9.3-应用管理
//
//  Created by J_jie on 16/7/28.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "AppListController.h"
#import "App.h"
#import "AppCell.h"

@interface AppListController () <AppCellDelegate>
@property(nonatomic, strong) NSArray *apps;

@end

@implementation AppListController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (NSArray *)apps
{
    if(_apps == nil)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"apps_full.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModel = [NSMutableArray array];
        
        for (NSDictionary *dict in arrayDict)
        {
            App *model = [App appWithDict:dict];
            [arrayModel addObject:model];
        }
        _apps = arrayModel;
    }
    
    return _apps;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apps.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取model
    App *app = self.apps[indexPath.row];
    
    //创建cell
    static NSString *ID = @"app_cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if(cell == nil)
//    {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"xibName" owner:nil options:nil] lastObject];
//    }
    
    //**其实不用这么麻烦** 可以在main.storyboard选中tableview cell，指定identifier属性为重用id“app_cell”
    //下面的代码首先回去缓存池中找是否有可重用的cell，如果没有那么就会取storyboard文件中，查找是否有重用id为“app_cell”
    //的cell，所以后面就不用做cell==nil那部分了，但是如果你是自己新建xib来作为cell就要做cell==nil以后创建新的cell的操作了
    //通过storyboard
    AppCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.delegate = self;
    
    //赋值cell
    cell.app = app;
    
    return cell;
}

#pragma mark - 实现appCell的代理方法
- (void)appCellDidCilckDownloadButton:(AppCell *)appCell
{
    //创建label
    UILabel *lblMsg = [[UILabel alloc] init];
    lblMsg.text = @"loading...";
    lblMsg.backgroundColor = [UIColor blackColor];
    lblMsg.textColor = [UIColor redColor];
    
    CGFloat msgW = 200;
    CGFloat msgH = 20;
    CGFloat msgX = (self.view.frame.size.width - msgW) * .5f;
    CGFloat msgY = (self.view.frame.size.height - msgH) * .5f;
    lblMsg.frame = CGRectMake(msgX, msgY, msgW, msgH);
    lblMsg.font = [UIFont systemFontOfSize:14];
    lblMsg.textAlignment = NSTextAlignmentCenter;
    
    lblMsg.alpha = 0.0;
    lblMsg.layer.cornerRadius = 5;
    lblMsg.layer.masksToBounds = YES;
    
    //把label加到self.view（因为这里用的是tableviewcontroller所以，self.view是tableview）
    //所以这样写会有个bug，lblMsg会随着tableview滚动，不是我想要的效果
    //[self.view addSubview:lblMsg]1;
    //解决方法：将lblMsg加到当前的窗口中
    [[[UIApplication sharedApplication] keyWindow] addSubview:lblMsg];
    
    
    //动画方式让文字逐渐显示
    [UIView animateWithDuration:.5f animations:^{
        //当执行完了执行下面的代码
        lblMsg.alpha = 0.6;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.5f delay:.5f options:UIViewAnimationOptionCurveLinear animations:^{
            lblMsg.alpha = 0;
        } completion:^(BOOL finished) {
            [lblMsg removeFromSuperview];
        }];
    }];
}

@end
