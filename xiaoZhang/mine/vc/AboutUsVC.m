//
//  AboutUsVC.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/1/25.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "AboutUsVC.h"

@interface AboutUsVC ()

@end

@implementation AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    [self setUI];
    self.title = @"关于我们";
}

- (void)setUI
{
    UIImageView *logo = [UIImageView new];
    logo.hcImageBlock(@"logo_content_icon");
    
    UILabel *titleLb = [UILabel new];
    titleLb.hcTextBlock(TitleColor_333, [UIFont systemFontOfSize: 16], 1);
    
    UILabel *contentLb = [UILabel new];
    contentLb.hcTextBlock(TitleColor_333, [UIFont systemFontOfSize:14], 0);
    contentLb.text = @"    乐享学驾app是中寰卫星导航通信有限公司联合运管、南京各大驾校联合打造南京驾培行业服务品牌，进一步促进市场的公平公正、管理服务高效便捷，满足人民群众对培训质量、学驾体验度日益增强的美好学驾需求。";
    
    [self.view sd_addSubviews:@[logo, titleLb, contentLb]];
    
    logo.sd_layout
    .topSpaceToView(self.view, HC_naviHeight + 40)
    .heightIs(100)
    .widthIs(100)
    .centerXEqualToView(self.view);
    
    titleLb.sd_layout
    .rightSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .autoHeightRatio(0)
    .topSpaceToView(logo, 15);
    
    contentLb.sd_layout
    .rightSpaceToView(self.view, 30)
    .leftSpaceToView(self.view, 30)
    .topSpaceToView(titleLb, 30)
    .autoHeightRatio(0);
}

@end
