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

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *messageFrames;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *txtInput;

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

#pragma mark - 代理方法
// 但拖动tableview，让键盘缩回去，思路：让控制器管理的view停止编辑
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

// 单键盘被单击的时候触发
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 1.获取用户的文本
    NSString *text = self.txtInput.text;
    
    // 2.发送消息
    [self sendMessage:text withType:MessageTypeMe];
    
    // 3.模拟回复
    //[self sendMessage:@"不认识" withType:MessageTypeOther];
    
    // 4.清空文本框
    self.txtInput.text = nil;
    
    return YES;
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
    self.txtInput.delegate = self;
    
    //取消tableView的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置tableView的背景
    self.tableView.backgroundColor = [UIColor colorWithRed:236 / 255.0 green:236 / 255.0 blue:236 / 255.0 alpha:1.0];
    //设置tableView不允许选中
    self.tableView.allowsSelection = NO;
    
//******* 监听键盘的弹出事件 *******
    //1.创建NSNotificationCenter对象
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //2.监听键盘弹出通知(你可以选择监听键盘弹出和隐藏，也可以只监听键盘的frame改变，因为键盘的显示隐藏都会发送frame改变的通知)(由于是系统键盘，所以我们这里并不关心发布对象，所以object:nil)
    [center addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
//******* 监听键盘的弹出事件 *******
}

- (void)keyboardWillChangeFrame:(NSNotification *)noteInfo
{
    //NSLog(@"%@", noteInfo);
//    NSLog(@"通知名称：%@", noteInfo.name);
//    NSLog(@"通知发布者：%@", noteInfo.object);
//    NSLog(@"通知的具体内容：%@", noteInfo.userInfo);
    
    // 获取键盘的y值
    CGRect rectEnd = [noteInfo.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = rectEnd.origin.y;
    CGFloat tranformValue = keyboardY - self.view.frame.size.height;
    // 让控制器的view执行一次平移
    [UIView animateWithDuration:.5f animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, tranformValue);
    }];
    
    
    //让UItableview的最后一行滚动到最上面
    NSIndexPath *lastRow = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastRow atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

// 发送消息
- (void)sendMessage:(NSString *)msg withType:(MessageType)type
{
    // 1.获取用户的文本
    //NSString *text = self.txtInput.text;
    
    // 2.创建一个数据模型和frame模型
    Message *model = [[Message alloc] init];
    //当前系统时间
    NSDate *nowDate = [NSDate date];
    // 创建一个日期时间格式化器
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式
    formatter.dateFormat = @"今天 HH:mm";
    model.time = [formatter stringFromDate:nowDate];
    model.type = type;
    model.text = msg;
    
    MessageFrame *modelFrame = [[MessageFrame alloc] init];
    modelFrame.message = model;
    
    // 根据当前消息的时间和上条消息的时间来决定是否显示消息时间
    MessageFrame *lastMessageFrame = [self.messageFrames lastObject];
    NSString *lastTime = lastMessageFrame.message.time;
    if([model.time isEqualToString:lastTime])
    {
        model.hideTime = YES;
    }
    
    // 3.把frame 模型加到集合中
    [self.messageFrames addObject:modelFrame];
    
    // 4.刷新tableview数据
    [self.tableView reloadData];
    
    // 5.把最后一行滚到最上面
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:idxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];

}

- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
