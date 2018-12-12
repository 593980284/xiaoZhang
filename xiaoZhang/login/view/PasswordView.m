//
//  PasswordView.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/12/2.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "PasswordView.h"

@implementation PasswordView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self= [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil]lastObject];
        HC__weakSelf
        _codeBtn.phoneBlock = ^NSString *{
            return weakSelf.phoneTF.text;
        };
        self.codeTF.text = @"222";
        self.phoneTF.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"userPhone"];
    }
    return self;
}
- (void)setCodeApi:(NSString *)codeApi
{
    _codeApi = codeApi;
    _codeBtn.api = codeApi;
}

- (IBAction)commit:(id)sender {
    NSString * phone = _phoneTF.text;
    NSString * msgCode = _codeTF.text;
    if (phone.reg_isPhone == NO) {
        [MBProgressHUD showSuccess:@"请输入手机号"];
        return;
    }
    if (msgCode.length == 0) {
        [MBProgressHUD showSuccess:@"请输入验证码"];
        return;
    }
  
    [NetWorkTool requestWithURL:self.commitApi params:@{@"phone": phone, @"msgCode": msgCode} toModel:nil success:^(id result) {
         [[NSUserDefaults standardUserDefaults] setValue:phone forKey:@"userPhone"];
        self.finishBlock(result);
    } failure:^(NSString *msg, NSInteger code) {
         [MBProgressHUD showSuccess:msg];
    } showLoading:@""];
}
@end
