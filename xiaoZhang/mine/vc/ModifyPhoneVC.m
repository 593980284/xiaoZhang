//
//  ModifyPhoneVC.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/1/30.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "ModifyPhoneVC.h"
#import "PasswordView.h"
#import <TPKeyboardAvoidingScrollView.h>

@interface ModifyPhoneVC ()
@property(nonatomic, copy)NSString* commitApi;
@property(nonatomic, copy)NSString* codeApi;
@property(nonatomic, copy)NSString* btnText;
@property(nonatomic, copy)NSString* rightImage;
@property(nonatomic, copy)NSString* tip;

@end

@implementation ModifyPhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更换登录手机号";
    TPKeyboardAvoidingScrollView *scrollView = [TPKeyboardAvoidingScrollView new];
    [self.view addSubview:scrollView];
    scrollView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(HC_naviHeight, 0, 0, 0));
    
    
    UIImageView *leftImageView = [UIImageView new];
    leftImageView.hcImageBlock(@"one_step");
    
    UIView *line = [UIView new];
    line.backgroundColor = BlueColor;
    
    UIImageView *rightImageView = [UIImageView new];
    rightImageView.hcImageBlock(self.rightImage);
    
    UILabel *tipLb = [UILabel new];
    tipLb.text = self.tip;
    tipLb.hcTextBlock(TitleColor_333, [UIFont systemFontOfSize:14], 1);
    
    [scrollView sd_addSubviews:@[leftImageView, line,  rightImageView, tipLb]];
    
    line.sd_layout
    .heightIs(1)
    .centerXEqualToView(scrollView)
    .widthIs(100)
    .topSpaceToView(scrollView, 40);
    
    leftImageView.sd_layout
    .centerYEqualToView(line)
    .heightIs(23)
    .widthIs(94/2)
    .rightSpaceToView(line, 10);
    
    rightImageView.sd_layout
    .centerYEqualToView(line)
    .heightIs(23)
    .widthIs(94/2)
    .leftSpaceToView(line, 10);
    
    
    tipLb.sd_layout
    .topSpaceToView(leftImageView, 20)
    .leftSpaceToView(scrollView, 0)
    .rightSpaceToView(scrollView, 0)
    .heightIs(20);
    
    
    PasswordView * passwordView = [PasswordView new];
    //取上次登录的手机号
    passwordView.codeApi = self.codeApi;
    passwordView.commitApi = self.commitApi;
    passwordView.phoneTF.placeholder = self.step == ModifyPhoneStepOne ? @"请输入您当前手机号" : @"请输入您新手机号";
    [passwordView.commitBtn setTitle:self.btnText  forState:0];
    HC__weakSelf;
    __block PasswordView * passwordView_2 = passwordView;
    passwordView.finishBlock = ^(NSDictionary *data) {
        if (weakSelf.step == ModifyPhoneStepOne) {
            ModifyPhoneVC *vc = [ModifyPhoneVC new];
            vc.step = ModifyPhoneStepTwo;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
            [[UserStorage shareInstance] saveUserDataWithValue: passwordView_2.phoneTF.text forKey:@"phone"];
            [self.navigationController popWithStep:2 animated:YES];
        }
    };
    [scrollView addSubview:passwordView];
    passwordView.sd_layout
    .topSpaceToView(tipLb, 20)
    .leftSpaceToView(scrollView, 0)
    .rightSpaceToView(scrollView, 0)
    .heightIs(200 + 35);
    
    [scrollView setupAutoContentSizeWithBottomView:passwordView bottomMargin:0];
    
}

- (void)setStep:(ModifyPhoneStep)step
{
    _step = step;
    switch (step) {
        case ModifyPhoneStepOne:
        {
            self.commitApi = MineApi_checkOldPhone;
            self.codeApi = LoginApi_Code;
            self.btnText = @"下一步";
            self.rightImage = @"two_step_u";
            self.tip = @"验证当前手机号";
        }
            break;
        case ModifyPhoneStepTwo:
        {
            self.commitApi = MineApi_checkNewPhone;
            self.codeApi = LoginApi_Code;
            self.btnText = @"确定";
            self.rightImage = @"two_step";
            self.tip = @"确认更换手机号";
        }
            break;
            
        default:
            break;
    }
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
