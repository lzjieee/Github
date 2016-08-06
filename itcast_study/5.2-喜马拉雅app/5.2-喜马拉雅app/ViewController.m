//
//  ViewController.m
//  5.2-喜马拉雅app
//
//  Created by J_jie on 16/7/11.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imgLast;

@end

/**
 新增一个需求：监听uiscrollview的滚动事件
 分析：要监听uiscrollview的滚动事件。需要通过代理实现，无法通过addTarget：的方式监听
 1.为uiscrollview找一个代理对象，也就是设置uiscrollview的delegate属性
    self.scrollview.delegate = self (一般用当前所在的viewController作为控件的代理对象)
    提醒：不需要单独创建一个代理类了，一般用当前所在的viewController作为控件的代理对象
 
 2.为了保证代理对象中拥有对应的方法，所以必须让代理对象（控制器）遵守对应控件的代理协议
    一般控件的代理协议命名规则为：控件名+delegate
 
 3.代理对象中实现需要的方法
 */

@implementation ViewController

//即将开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //NSLog(@"---->即将开始拖拽...scrollViewWillBeginDragging");
}

//拖拽完毕
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"---->拖拽完毕...scrollViewDidEndDragging");
}

//正在拖拽
- (IBAction)btnClicked:(id)sender {
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"---->正在拖拽...scrollViewDidScroll");
    
    NSString *pointStr = NSStringFromCGPoint(scrollView.contentOffset);
    NSLog(@"---->%@", pointStr);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //找到最后一个控件imgLast的最大的y值作为contentsize的y值
    CGFloat maxH = CGRectGetMaxY(self.imgLast.frame);
    
    //设置srollview的contentsize(技巧:只要contentsize的x(y)比scrollview的x(y)的大，就能横向(竖向)滚动。这里不需要横向滚动所以设置x=0)
    self.scrollView.contentSize = CGSizeMake(0, maxH);
    //一开始设置默认滚动到下来一点
    self.scrollView.contentOffset = CGPointMake(0, -74);
    //设置内边距74（因为最上面有个导航栏）,下内边距也是54
    self.scrollView.contentInset = UIEdgeInsetsMake(74, 0, 54, 0);
    
    //让当前的conteoller作为scrollview的代理对象
    self.scrollView.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
