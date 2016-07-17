//
//  GoodsCell.m
//  7.1-团购(xib自定义cell)
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GoodsCell.h"
#import "Goods.h"

@interface GoodsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblBuyCount;

@end


@implementation GoodsCell

+ (instancetype)goodsCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"goods_cell";
    GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        //loadNibNamed返回值是NSArray（因为xib中可能有很多控件，下面的实例xib中只有一个cell，所以直接调用数组的firstObject返回第一个，就是我们这里要的cell，这个cell是一个GoodsCell对象(创建xib时指定的)）
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsCell" owner:nil options:nil] firstObject];
        //上面的代码有个问题：没有创建cell没有指定重用id，解决方法是，在xib找到cell控件，指定属性identifler 为 goods_cell
    }
    return cell;
}

- (void)setGoods:(Goods *)goods
{
    _goods = goods;
    //把传经来的model数据设置给子控件
    self.imgViewIcon.image = [UIImage imageNamed:goods.icon];
    self.lblTitle.text = goods.title;
    self.lblPrice.text = [NSString stringWithFormat:@"¥ %@", goods.price];
    self.lblBuyCount.text = [NSString stringWithFormat:@"%@ 人已购买", goods.buyCount];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
