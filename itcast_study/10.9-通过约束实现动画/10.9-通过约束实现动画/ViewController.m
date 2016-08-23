//
//  ViewController.m
//  10.9-通过约束实现动画
//
//  Created by J_jie on 16/8/23.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *greenView;

// storyboard中选中约束，可以拖线生成变量
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *greenViewTop;
- (IBAction)btnClicked:(id)sender;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClicked:(id)send
{
    self.greenViewTop.constant += 100;
    
    [UIView animateWithDuration:1 animations:^{
        // 这样写是没有动画效果的（因为这里只设置了约束，系统什么时候计算frame不知道）
        // 解决方法：把这句话放外面， 再让greenView重新刷新一下layout
        // self.greenViewTop.constant += 100;
        
        // 下面这句代码会根据新的约束重新计算完frame以后赋值
        [self.greenView layoutIfNeeded];
    }];
    
}

@end
