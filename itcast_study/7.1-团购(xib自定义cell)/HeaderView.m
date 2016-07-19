//
//  HeaderView.m
//  7.1-团购(xib自定义cell)
//
//  Created by J_jie on 16/7/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//但这个函数被执行了，证明nib都已经从xib唤醒了，可以使用控件了
- (void)awakeFromNib
{
    //在这里就表示headerView已经从xib中创建好了
//    self.scrollView.contentSize = ...
}

+ (instancetype)headerView
{
    HeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:nil options:nil] lastObject];
    return headerView;
}

@end
