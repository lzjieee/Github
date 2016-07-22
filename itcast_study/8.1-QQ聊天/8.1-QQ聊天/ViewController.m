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

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *messageFrames;

@end

@implementation ViewController

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
            model.message = message;
            [arrayModel addObject:model];
        }
        _messageFrames = arrayModel;
    }
    return _messageFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
