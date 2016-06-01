//
//  ViewController.m
//  02-1ui常用属性
//
//  Created by lzj on 16/3/29.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnIcon;
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

- (IBAction)btnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if(btn.tag == 1)  //平移
    {
        //初始位置为0，-50即是上移50到达这个点。下面这个代码的意思是告诉控件平移到局里原始位置-50的地方
        //_btnIcon.transform = CGAffineTransformMakeTranslation(0, -50);
        
        //基于上次的值，不断移动
        _btnIcon.transform = CGAffineTransformTranslate(_btnIcon.transform, 0, 50);
    }
    else if(btn.tag == 2)
    {
        _btnIcon.transform = CGAffineTransformMakeRotation(M_PI_4);
    }
    else if(btn.tag == 3)
    {
        self.btnIcon.transform = CGAffineTransformMakeScale(1.5, 1.5);
    }
    
    //获取当前控制器管理的view的所有子控件
    for(UIView *view in self.view.subviews)
    {
        view.backgroundColor = [UIColor yellowColor];
    }
    
    //子控件的superview变色
    _btnIcon.superview.backgroundColor = [UIColor grayColor];
    
    //根据tag拿控件
    //UITextField *textField = (UITextField *)[self.view viewWithTag:1000];
}
@end
