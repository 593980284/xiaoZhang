//
//  LoginVC.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/11/27.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "LoginVC.h"
#import "PasswordView.h"
#import "LoginApi.h"
@interface LoginVC ()
@property(nonatomic, weak)PasswordView * passwordView;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarAlpha = 0;
    [self setUI];
}

- (void)setUI
{
    UIScrollView *scrollView = [UIScrollView new];
    [self.view addSubview:scrollView];
    scrollView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(HC_naviHeight, 0, 0, 0));
    PasswordView * passwordView = [PasswordView new];
    passwordView.codeApi = LoginApi_Code;
    [scrollView addSubview:passwordView];
    passwordView.sd_layout
    .topSpaceToView(scrollView, 0)
    .leftSpaceToView(scrollView, 0)
    .rightSpaceToView(scrollView, 0)
    .heightIs(200);
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
