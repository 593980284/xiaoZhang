//
//  TimerBtn.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/12/2.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "TimerBtn.h"
@interface TimerBtn()
@property(nonatomic, strong)YYTimer *timer;
@property(nonatomic, assign)NSInteger remaining;
@end
@implementation TimerBtn

- (void)startTimer
{
    [self stopTimer];
    self.enabled = NO;
    self.remaining = self.seconds;
    [self setTitle:[self getTimerStrIng] forState:0];
    _timer = [YYTimer timerWithTimeInterval:1 target:self selector:@selector(handleTimer) repeats:YES];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    self.titleLabel.text = title;
    [super setTitle:title forState:state];
}

- (void)stopTimer
{
    [_timer invalidate];
    _timer = nil;
}

- (void)dealloc
{
    [self stopTimer];
}

- (void)handleTimer
{
    self.remaining --;
    if (self.remaining == 0) {
        [self stopTimer];
        [self setTitle:@"再次获取" forState:0];
        self.enabled = YES;
    }else{
        [self setTitle:[self getTimerStrIng] forState:0];
    }
}

- (NSString *)getTimerStrIng
{
    return [NSString stringWithFormat:@"已发送%lds", self.remaining];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
     [self initData];
}

- (void)initData
{
    self.seconds = 60;
    self.availableColor = HexColor(@"666666");
    self.unavailableColor = HexColor(@"999999");
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    self.enabled = YES;
    [self setTitle:@"获取验证码" forState:0];
    [self addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
}

- (instancetype)init
{
    if (self = [super init]) {
        [self initData];
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if (enabled) {
        self.layer.borderColor = _availableColor.CGColor;
    }else{
        self.layer.borderColor = _unavailableColor.CGColor;
    }
}

- (void)btnTap:(UIButton *)sender
{
    NSString *phone = self.phoneBlock();
    if (phone.reg_isPhone == NO) {
        [MBProgressHUD showSuccess:@"请输入手机号"];
    }else{
        HC__weakSelf
        [NetWorkTool requestWithURL:self.api params:@{@"phone": phone} toModel:nil success:^(id result) {
            [weakSelf startTimer];
            [MBProgressHUD showSuccess:@"已发送"];
        } failure:^(NSString *msg, NSInteger code) {
            [MBProgressHUD showSuccess:msg];
        } showLoading:@""];
    }
}

- (void)setAvailableColor:(UIColor *)availableColor
{
    _availableColor = availableColor;
    [self setTitleColor:availableColor forState:0];
}

- (void)setUnavailableColor:(UIColor *)unavailableColor
{
    _unavailableColor = unavailableColor;
    [self setTitleColor:unavailableColor forState:UIControlStateDisabled];
}

@end
