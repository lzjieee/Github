//
//  FooterView.m
//  7.1-团购(xib自定义cell)
//
//  Created by J_jie on 16/7/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FooterView.h"

@interface FooterView()
@property (weak, nonatomic) IBOutlet UIButton *btnLoadMore;
@property (weak, nonatomic) IBOutlet UIView *waitingView;

- (IBAction)btnLoadMoreClicked:(id)sender;

@end

@implementation FooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)footerView
{
    FooterView *footerView = [[[NSBundle mainBundle] loadNibNamed:@"FooterView" owner:nil options:nil] lastObject];
    return footerView;
}

- (IBAction)btnLoadMoreClicked:(id)sender
{
    //1.隐藏“加载更多按钮”
    self.btnLoadMore.hidden = YES;
    //2.显示“等待指示器”所在的那个按钮
    self.waitingView.hidden = NO;
    
    //3.增加一条数据（这里没有服务器数据，所以模拟一下，手动加一条）
    //3.1创建model
    //3.2将model加到控制器的goods集合中（注意：在这个类中访问不到控制器的goods，思路：让控制器成为FooterView的代理）
    //FooterView想操作控制器的goods集合，但是没这个能力，所以找到控制器能做，所以让控制器成为FooterView的代理
    //所以FooterView发布协议，控制器成为FooterView的代理对象，遵守协议
    /**
     写代理的方法：
     1. 对应的.h文件中定义代理@protocol
     2. 添加@property (nonatomic, weak) id<FooterViewDelegate> delegate; 代理属性
     */

    
    //*隔一段时间执行代码(为了模拟加载数据等待时间)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)) , dispatch_get_main_queue(), ^{
    
        //调用代理方法实现上面3的功能,控制器内部就会帮我们实现
        //调用代理方法之前为了保证调用不出错，必须判断下，代理对象是否真的实现了这个方法，实现了才调用，否则不调用
        if([self.delegate respondsToSelector:@selector(footViewUpdateData:)])
        {
            [self.delegate footViewUpdateData:self];
        }

        
        self.btnLoadMore.hidden = NO;
        self.waitingView.hidden = YES;
        
    });
    
}

@end
