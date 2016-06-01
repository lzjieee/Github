//
//  ViewController.m
//  02按钮状态
//
//  Created by lzj on 16/3/28.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)click:(id)sender;
- (IBAction)btnClicked:(id)sender;
- (IBAction)btnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *img;
- (IBAction)changeSize:(id)sender;

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

- (IBAction)click:(id)sender {
    UIButton *btn = (UIButton *)sender;
//1.通过修改frame移动位置
    CGRect current = _img.frame;
    
    switch (btn.tag)
    {
        case 1:
            current.origin.y -= 10.0;
            //_img.frame = current;
            //有动画的移动
            //开启一个动画
            [UIView beginAnimations:nil context:nil];
            //动画时间
            [UIView setAnimationDuration:2];
            //----要执行动画的代码---
            _img.frame = current;
            //提交动画
            [UIView commitAnimations];
            break;
        case 2:
            current.origin.y += 10.0;
            _img.frame = current;
            break;
        case 3:
            current.origin.x -= 10.0;
            _img.frame = current;
            break;
        case 4:
            current.origin.x += 10.0;
            _img.frame = current;
        default:
            break;
    }
    
//2.通过修改center（中心点）来移动----无法修改大小
//    CGPoint centerPoint = self.img.center;
//3.通过bounds修改大小------无法修改位置
//    self.img.bounds;
//4.通过transform--------什么都可以修改，包括旋转等
}

- (IBAction)btnClicked:(id)sender {
}

- (IBAction)btnClicked:(id)sender {
}
- (IBAction)changeSize:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    CGRect current = _img.frame;
    
    if(btn.tag == 0)
    {
        current.size.width *= 2;
        current.size.height *= 2;
        _img.frame = current;
    }
    else if(btn.tag == 1)
    {
        current.size.width /= 2;
        current.size.height /= 2;
        _img.frame = current;
    }
}
@end
