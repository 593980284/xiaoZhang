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

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    HomeFormView * dayFormView = [HomeFormView new];
    [self.view addSubview:dayFormView];
    dayFormView.sd_layout
    .topSpaceToView(self.view, HC_naviHeight)
    .leftSpaceToView(self.view, 15)
      .rightSpaceToView(self.view, 15)
    .heightIs(150);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    BaseNaviVC* vc = [[BaseNaviVC alloc]initWithRootViewController:[LoginVC new]];
    [self presentViewController:vc animated:YES completion:nil];
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
