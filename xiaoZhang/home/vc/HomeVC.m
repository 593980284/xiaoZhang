//
//  HomeVC.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/11/28.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "HomeVC.h"
#import "DemoVC.h"
#import "LoginApi.h"
@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, 100, 100);
//    self.navBarAlpha = 0.5;
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    NSLog(@"%@",LoginApi_login);
    [NetWorkTool requestWithURL:LoginApi_login params:@{} toModel:nil success:^(id result) {
        
    } failure:^(NSString *msg, NSInteger code) {
        
    } showLoading:@"加载。。"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
 [self.navigationController pushViewController:[DemoVC new] animated:YES];
    
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
