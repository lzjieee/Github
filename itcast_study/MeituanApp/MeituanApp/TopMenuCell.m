//
//  TopMenuCell.m
//  MeituanApp
//
//  Created by J_jie on 16/9/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TopMenuCell.h"
#import "Menu.h"

#define countOfRow 4 // 每行4个

@interface TopMenuCell()

@property(nonatomic, weak) UILabel *label;
@property(nonatomic, weak) UIPageControl *pageControl;

@end

@implementation TopMenuCell

+ (instancetype)topMenuCellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"topmenu_cell";
    TopMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[TopMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (void)setMenus:(NSArray *)menus
{
    _menus = menus;
    [self settingDataForShow];
}
//- (void)setViewControl:(ViewController *)viewControl
//{
//    //_viewControl = viewControl;
//    //[self.scrollView setDelegate:self.viewControl];
//}

// 创建自定义cell中的ui控件
- (void)settingDataForShow
{
    [self createScrollView];
    [self createPageControl];
}

// 重写父类的UITableViewCellStyleDefault
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    //先调一下父类的initWithStyle
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //创建自己的控件
        //2.昵称
        UILabel *lblNickName = [[UILabel alloc] init];
        [self.contentView addSubview:lblNickName];
        self.label = lblNickName;
        self.label.frame = CGRectMake(0, 0, 50, 30);
    }
    return self;
}

// 创建scrollview
- (void)createScrollView
{
    // fix:当外层的tableview滑动，触发刷新cell的时候，会导致拥有scrollview的cell重新创建如果创建之前没有删除就会出现多个scrollview叠加的情况
    // 删除以前创建的scrollview
    [[self.contentView viewWithTag:1000] removeFromSuperview];
    
    int totalPage = (int)(self.menus.count - 1) / 8 + 1;
    // 创建scrollview
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 375, 150)];
    scrollView.contentSize = CGSizeMake(375 * totalPage, 150);
    //设置翻页效果，不允许反弹，不显示水平滑动条，设置代理为自己
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView = scrollView;
    self.scrollView.tag = 1000;
    [self.contentView addSubview:scrollView];
    
    // 设置topmenu的ui
    for (int i = 0; i< self.menus.count; i++)
    {
        Menu *topMenuData = [self.menus objectAtIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:topMenuData.icon] forState:UIControlStateNormal];
        UILabel *lbl = [[UILabel alloc] init];
        lbl.text = topMenuData.name;
        
        int indexOfPage = i % 8 + 1;
        int page = i / 8 + 1;
        CGFloat posW = 38;
        CGFloat posH = 38;
        CGFloat posX = 0;
        CGFloat posY = 0;
        if(indexOfPage < countOfRow + 1)
        {
            posX = 375 * (page - 1) + 44 * indexOfPage + 38*(indexOfPage - 1);
            posY = 10;
        }
        else
        {
            posX = 375 * (page - 1) + 44*(indexOfPage - countOfRow) + 38*(indexOfPage - countOfRow - 1);
            posY = 78;
        }
        btn.frame = CGRectMake(posX, posY, posW, posH);
        [self.scrollView addSubview:btn];
    }
}

// 创建pageControl
- (void)createPageControl
{
    int totalPage = (int)(self.menus.count - 1) / 8 + 1;
    // 创建pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.contentView.bounds.size.width/2 - 50, 130, 100, 30)];
    // 设置pageConteol 的页数
    pageControl.numberOfPages = totalPage;
    pageControl.currentPage = 0;
    // 注意：这里创建的pageControl是白色背景的，所以如果你的背景也是白色就会看不见了
    //pageControl.backgroundColor = [UIColor grayColor];
    // 默认的UIPageControl页面的指示器（圆点）的颜色是白色，碰上白色背景，就很难看出效果来。。所以，有必须更改下UIPageControl中的圆点颜色。最初，通过类继承UIPageControl实现自定义。
    // 发现iOS7.1（不知道是不是从这个版本才有），UIPageControl给了可以控制圆点颜色的方法
    // UIColor自定义rgb 色值为73、 148 、230  那么ios 里面要在后面加.0f 再除以255
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:32.0f/255 green:178.0/255 blue:170.0/255 alpha:1.0f];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl = pageControl;
    [self.contentView addSubview:pageControl];
}

-(void)refreshPageControl:(ViewController *)viewController
{
    [self setPageControlValueAfterScroll];
}

#pragma mark - 提供外面调用的一些实例方法
// 
- (int)setPageControlValueAfterScroll
{
    int currentPage = 0;
    // 记录scrollView 的当前位置，因为已经设置了分页效果，所以：位置/屏幕大小 = 第几页
    currentPage = self.scrollView.contentOffset.x / 375;
    // 根据scrollView 的位置对page 的当前页赋值
    self.pageControl.currentPage = currentPage;
    return currentPage;
}

@end
