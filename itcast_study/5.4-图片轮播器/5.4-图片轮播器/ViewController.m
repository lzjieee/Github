//
//  ViewController.m
//  5.4-图片轮播器
//
//  Created by J_jie on 16/7/12.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

//创建一个用来引用计时器对象的属性
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

//实现uiscrollview的滚动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //计算当前滑到第几页
    //1.获取滚动的x方向偏移
    CGFloat offsetX = self.scrollview.contentOffset.x;
    
    //如果希望拖动大半的情况下，pageControl的点就移动了，可以处理下offsetX
    //用已经偏移的值 + 半页的值 （就是加大了偏移的值，使得当滑动大于一半页时，就当做滑到下一页了）
    offsetX += self.scrollview.frame.size.width * .5;
    
    //2.用x方向的偏移 除以 每一页的宽度 得到当前页数
    int page = offsetX / self.scrollview.frame.size.width;
    //3.将页数设置给UIpageControl
    self.pageControl.currentPage = page;
}

/**
 计时器轮播图片有个bug：但拖拽scrollview，保持一段时间不松手后，一旦松手scrollview会连续滚动多次
 解决思路：在即将拖拽的时候（scrollViewWillBeginDragging）停止定时器，
         拖拽完毕（scrollViewDidEndDragging）再打开一个定时器
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //停止定时器(定时器一旦停止，就废了，下次要重新创建)
    [self.timer invalidate];
    //因为调用完invalidate方法，timer就无法重用了，所以直接设置为nil
    self.timer = nil;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //重新启动一个定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    //获取当前的消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    //改变self.timer对象的优先级
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //动态创建imageView添加到uiscrollview中
    //1.循环创建5个imageView添加到scrollview
    CGFloat imgH = 130;
    CGFloat imgW = 300;
    CGFloat imgY = 0;
    
    for (int i = 0; i<5; i++)
    {
        UIImageView *img = [[UIImageView alloc] init];
        NSString *imgName = [NSString stringWithFormat:@"img_%02d", i+1];
        img.image = [UIImage imageNamed:imgName];
        CGFloat imgX = i * imgW;
        img.frame = CGRectMake(imgX, imgY, imgW, imgH);
        [self.scrollview addSubview:img];
    }
    
    //设置contentsize
    CGFloat maxW = self.scrollview.frame.size.width * 5;
    self.scrollview.contentSize = CGSizeMake(maxW, 0);
    
    //隐藏水平滚动条
    self.scrollview.showsHorizontalScrollIndicator = NO;
    
    self.scrollview.delegate = self;
    
    //实现uiscrollview的分页效果(根据uiscrollview的宽度来分页的)
    self.scrollview.pagingEnabled = YES;
    
    /**
     实现UIpageControl：
     1.拖UIpageControl到storyboard上（注意和scrollview是并排关系，不要将控件拖到scrollview上，不然控件会跟着scrollview滑动，然后就不见了）
     2.然后代码处理UIpageControl的属性：设置总页数；设置当前页
     3.为了同步UIpageControl和uiscrollview的页数，viewcontrol要实现UIScrollViewDelegate代理，
       监听scrollViewDidScroll（滚动时触发），在监听函数内通过当前位置计算页数，设置UIpageControl的当前页
     */
    self.pageControl.numberOfPages = 5;
    self.pageControl.currentPage = 0;
    
    
    //创建一个计时器控件NSTimer控件（实现图片自动轮播）
    //通过scheduledTimerWithTimeInterval创建的计时器，创建好会自动启动
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    
    /**
     这里有个bug，在消息循环对象中，操作界面上其他的ui控件的时候，由于ui线程的优先级较高，所以timer处理了
     解决思路：修改timer的优先级和ui线程的一样高
     */
    //获取当前的消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    //改变self.timer对象的优先级
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)scrollImage
{
    //滚动一次图片
    //1.获取当前页码
    NSInteger page = self.pageControl.currentPage;
    //2.判断是否最后一页，如果是，设置页码=0（回到第一页）。否则页码+1
    if(page == self.pageControl.numberOfPages - 1)
    {
        page = 0;
    }
    else
    {
        page++;
    }
    //self.pageControl.currentPage = page;
    //3.计算下一页的contentOffset
    CGFloat offsetX = page * self.scrollview.frame.size.width;
    //4.设置uiscrollview的contentOffset等于新的contentOffset
    [self.scrollview setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
