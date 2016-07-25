//
//  ViewController.m
//  8.1-QQ聊天
//
//  Created by J_jie on 16/7/21.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "ViewController.h"
#import "Message.h"
#import "MessageFrame.h"
#import "MessageCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *messageFrames;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - 懒加载
- (NSMutableArray *)messageFrames
{
    if(_messageFrames == nil)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModel = [NSMutableArray array];
        
        for (NSDictionary *dict in arrayDict)
        {
            Message *message = [Message messageWithDict:dict];
            MessageFrame *model = [[MessageFrame alloc] init];
            
            //获取上一个model
            Message *lastMessage = (Message *)[[arrayModel lastObject] message];
            //判断当前model的消息发送时间是否和上一个model的发送时间一致
            if([message.time isEqualToString:lastMessage.time])
            {
                message.hideTime = YES;
            }
            else
            {
                message.hideTime = NO;
            }
            
            model.message = message;
            [arrayModel addObject:model];
        }
        _messageFrames = arrayModel;
    }
    return _messageFrames;
}

#pragma mark - 实现代理的数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取model
    MessageFrame *modelFrame = self.messageFrames[indexPath.row];
    //创建cell
    MessageCell *cell = [MessageCell messageCellWith:self.tableView];
    //把model数据设置给cell
    cell.messageFrame = modelFrame;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageFrame *messageFrame = self.messageFrames[indexPath.row];
    return messageFrame.rowHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //取消tableView的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置tableView的背景
    self.tableView.backgroundColor = [UIColor colorWithRed:236 / 255.0 green:236 / 255.0 blue:236 / 255.0 alpha:1.0];
    //设置tableView不允许选中
    self.tableView.allowsSelection = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
