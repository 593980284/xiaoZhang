//
//  HomeVC.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/12/1.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "HomeVC.h"
#import "HomeFormView.h"
#import "LoginVC.h"
#import "BaseNaviVC.h"
@interface HomeVC ()
@property(nonatomic, weak)UILabel *label;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    HomeFormView * dayFormView = [HomeFormView new];
//    [self.view addSubview:dayFormView];
//    dayFormView.sd_layout
//    .topSpaceToView(self.view, HC_naviHeight)
//    .leftSpaceToView(self.view, 15)
//    .rightSpaceToView(self.view, 15)
//    .heightIs(150);
    
    UIImageView *label = [UIImageView new];
 
    label.hcBorderBlock([UIColor blueColor], 1)//设置边框颜色、宽度
    .hcCornerRadiusBlock(5, NO)//圆角、超出部分是否显示
    .hcTextBlock([UIColor blackColor], [UIFont systemFontOfSize:16], 1)//字体颜色、大小、对齐
    .hcShadowBlock([UIColor blackColor], 0.5, 6, 6)//阴影颜色、透明度、偏移
    .hcBgColorBlock([UIColor yellowColor])//背景色
    .hcTapBlock(self, @selector(tap:))
    .hcImageBlock(@"header");
    
   
    [self.view addSubview:label];
    label.frame = CGRectMake(100, 100, 100, 100);

}

- (void)dealloc {
    
}

- (void)tap:(UIButton *)sender{
    NSLog(@"111");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
