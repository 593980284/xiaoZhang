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
    TPKeyboardAvoidingScrollView *scrollView = [TPKeyboardAvoidingScrollView new];
    [self.view addSubview:scrollView];
    scrollView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(HC_naviHeight, 0, 0, 0));
    
    // logo
    UIImageView *logoImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    logoImgView.backgroundColor = [UIColor greenColor];
    [scrollView addSubview:logoImgView];
    logoImgView.sd_layout
    .topSpaceToView(scrollView, 35*HC_320Ratio)
    .centerXEqualToView(scrollView)
    .heightIs(100*HC_320Ratio)
    .widthEqualToHeight();
    
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = 5;
    style.alignment = 1;
    NSAttributedString * attrStr = [[NSAttributedString alloc]
                                    initWithString:@"乐享学驾\n校长版"
                                    attributes:@{
                                                 NSFontAttributeName: HC_320Font(24),
                                                 NSForegroundColorAttributeName: TitleColor_333,
                                                 NSParagraphStyleAttributeName: style
                                                 }];
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    textLabel.numberOfLines = 2;
    textLabel.attributedText = attrStr;
    [scrollView addSubview:textLabel];
    textLabel.sd_layout
    .topSpaceToView(logoImgView, 10*HC_320Ratio)
    .centerXEqualToView(scrollView)
    .widthIs(HC_windowWidth)
    .heightIs(64*HC_320Ratio);
    
    PasswordView * passwordView = [PasswordView new];
    passwordView.codeApi = LoginApi_Code;
    passwordView.commitApi = LoginApi_testLogin;
    HC__weakSelf;
    passwordView.finishBlock = ^(NSDictionary *data) {
        [[UserStorage shareInstance] saveUserData:data];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    [scrollView addSubview:passwordView];
    passwordView.sd_layout
    .topSpaceToView(scrollView, 250)
    .leftSpaceToView(scrollView, 0)
    .rightSpaceToView(scrollView, 0)
    .heightIs(200);
    
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
