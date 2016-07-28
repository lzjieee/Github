//
//  GroupHeaderView.m
//  9.2-好友列表
//
//  Created by J_jie on 16/7/28.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "GroupHeaderView.h"
#import "Group.h"

@interface GroupHeaderView ()

@property (nonatomic, weak) UIButton *btnGroupTitle;
@property (nonatomic, weak) UILabel *lblCount;

@end

@implementation GroupHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)groupHeaderViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"group_header_view";
    GroupHeaderView *headerVw = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (headerVw == nil)
    {
        headerVw = [[GroupHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return headerVw;
}

// 重写initWithReuseIdentifier，加入自定义的子控件
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier])
    {
        //创建按钮
        UIButton *btnGroupTitle = [[UIButton alloc] init];
        [self.contentView addSubview:btnGroupTitle];
        self.btnGroupTitle = btnGroupTitle;
        //控件一样的属性应该在创建的时候(这里)设置，不一样的在赋值数据的时候处理
        [btnGroupTitle setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
        [btnGroupTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置按钮中内容整体左对齐
        btnGroupTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 设置按钮的内容的内边距
        btnGroupTitle.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        // 设置按钮标题距离左边的边距
        btnGroupTitle.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        // 设置按钮的点击事件
        [btnGroupTitle addTarget:self action:@selector(btnGroupTitleClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        /***** 解决图片旋转被拉伸变形的问题 *****/
        // 设置按钮中的图片的现实模式
        btnGroupTitle.imageView.contentMode = UIViewContentModeCenter;
        // 设置图片框超出的部分不要裁掉
        btnGroupTitle.imageView.clipsToBounds = NO;
        /***** 解决图片旋转被拉伸变形的问题 *****/
        
        //创建label
        UILabel *lblCount = [[UILabel alloc] init];
        [self.contentView addSubview:lblCount];
        self.lblCount = lblCount;
    }
    return self;
}

// 重写group属性的set方法
- (void)setGroup:(Group *)group
{
    _group = group;
    
    //设置数据
    [self.btnGroupTitle setTitle:group.name forState:UIControlStateNormal];
    self.lblCount.text = [NSString stringWithFormat:@"%d / %d", group.online, group.friends.count];
    
    //设置按钮的旋转问题（为了防止重用的时候GroupHeaderView上次的状态影响到当前的对象了）
    if(self.group.isVisible)
    {
        self.btnGroupTitle.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    else
    {
        self.btnGroupTitle.imageView.transform = CGAffineTransformMakeRotation(0);
    }
    
    //设置frame（由于这个函数中，系统还没动态设置headerview的frame的值，所以self.bounds都是0，这里不能用这个属性）
    //self.btnGroupTitle.frame = self.bounds;
    //在layoutSubviews（当前控件的frame发生改变的时候回调用这个方法）方法中self.bounds就有值了
}

// 当前控件的frame发生改变的时候回调用这个方法
- (void)layoutSubviews
{
    [super layoutSubviews];
    //设置子控件的frame
    self.btnGroupTitle.frame = self.bounds;
    CGFloat lblW = 100;
    CGFloat lblH = self.bounds.size.height;
    CGFloat lblX = self.bounds.size.width - 10 - lblW;
    CGFloat lblY = 0;
    self.lblCount.frame = CGRectMake(lblX, lblY, lblW, lblH);
}

- (void)btnGroupTitleClicked:(id)sender
{
    // 1.设置组状态(每次点击设置与之前状态相反的状态)
    self.group.visible = !self.group.isVisible;
    // 2.通过代理方法 刷新 tableview
    //首先判断代理对象是否实现了代理方法
    if([self.delegate respondsToSelector:@selector(groupHeaderViewDidClickTitleButton:)])
    {
        //调用代理方法
        [self.delegate groupHeaderViewDidClickTitleButton:self];
    }
    
    //3.让按钮中的图片旋转(注意：这里转没用的因为self是指当前点击的GroupHeaderView，但是步骤2会去刷新tableview那时候GroupHeaderView又被创建了一次，因为这里有动画，你就会看到转过去又转回来了，如果没动画，看上去就会没转一样)
    //self.btnGroupTitle.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    //所以在didMoveToSuperview中处理
}

//当一个新的GroupHeaderView已经加到某个父控件中会执行的方法
-(void)didMoveToSuperview
{
    if(self.group.isVisible)
    {
        self.btnGroupTitle.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    else
    {
        self.btnGroupTitle.imageView.transform = CGAffineTransformMakeRotation(0);
    }
    
}

@end
