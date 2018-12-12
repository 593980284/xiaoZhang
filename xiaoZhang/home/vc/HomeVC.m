//
//  HomeVC.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/12/1.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "HomeVC.h"
#import "HomeFormView.h"
@interface HomeVC ()
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
    
    UILabel *label = [UILabel new];
 
    label.hcTextBlock([UIColor redColor], [UIFont systemFontOfSize:13], 1)
    .hcBorderBlock([UIColor blueColor], 1, YES)
    .hcShadowBlock([UIColor blackColor], 0.5, 6, 6);
    
    label.text = @"111111";
    [self.view addSubview:label];
    label.frame = CGRectMake(100, 100, 100, 100);
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
