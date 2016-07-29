//
//  AppCell.m
//  9.3-应用管理
//
//  Created by J_jie on 16/7/28.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "AppCell.h"
#import "App.h"

@interface AppCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnDownload;

@end


@implementation AppCell

-(void)setApp:(App *)app
{
    _app = app;
    
    self.imgViewIcon.image = [UIImage imageNamed:app.icon];
    self.lblName.text = app.name;
    self.lblInfo.text = [NSString stringWithFormat:@"大小:%@ | 下载量:%@", app.size, app.download];
    
    //更新下载按钮的状态
    if(app.isDownloaded)
    {
        self.btnDownload.enabled = NO;
    }
    else
    {
        self.btnDownload.enabled = YES;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnDownloadClicked:(id)sender
{
    self.btnDownload.enabled = NO;
    //标记模型已经点击过了
    self.app.isDownloaded = YES;
    //弹出消息提示label
    if([self.delegate respondsToSelector:@selector(appCellDidCilckDownloadButton:)])
    {
        [self.delegate appCellDidCilckDownloadButton:self];
    }
}
@end
