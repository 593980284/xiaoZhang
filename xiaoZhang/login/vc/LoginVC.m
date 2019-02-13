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
#import <TPKeyboardAvoidingScrollView.h>
#import "AppDelegate.h"
#import "TabBarController.h"

@interface LoginVC ()
@property(nonatomic, weak)PasswordView * passwordView;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarAlpha = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}

- (void)setUI
{
    TPKeyboardAvoidingScrollView *scrollView = [TPKeyboardAvoidingScrollView new];
    [self.view addSubview:scrollView];
    scrollView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(HC_naviHeight, 0, 0, 0));

    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    textLabel.hcTextBlock(TitleColor_333, [UIFont systemFontOfSize:22], 0);
    textLabel.text=@"欢迎登录乐享学驾校长端";
    [scrollView addSubview:textLabel];
    textLabel.sd_layout
    .topSpaceToView(scrollView, 30*HC_320Ratio)
    .leftSpaceToView(scrollView, 15)
    .widthIs(HC_windowWidth)
    .heightIs(64*HC_320Ratio);
    
    PasswordView * passwordView = [PasswordView new];
    //取上次登录的手机号
    passwordView.phoneTF.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"userPhone"];
    passwordView.codeApi = LoginApi_Code;
    passwordView.commitApi = LoginApi_testLogin;
    HC__weakSelf;
    passwordView.finishBlock = ^(NSDictionary *data) {
        [[UserStorage shareInstance] saveUserData:data];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
        //保存登录的手机号
        NSString *phone = @"";
        if (data[@"phone"]) {
            phone = data[@"phone"];
        }
        [[NSUserDefaults standardUserDefaults] setValue:phone forKey:@"userPhone"];
        
        AppDelegate * delegagte =  (AppDelegate *) [UIApplication sharedApplication].delegate;
        if (delegagte.window.rootViewController == self) {
            TabBarController *tabBar = [TabBarController new];
            delegagte.window.rootViewController = tabBar;
        }else{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
    };
    [scrollView addSubview:passwordView];
    passwordView.sd_layout
    .topSpaceToView(textLabel, 68*HC_360Ratio)
    .leftSpaceToView(scrollView, 0)
    .rightSpaceToView(scrollView, 0)
    .heightIs(200 + 35);
    
    [scrollView setupAutoContentSizeWithBottomView:passwordView bottomMargin:0];
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
