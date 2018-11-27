//
//  ViewController.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/11/27.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UserStorage shareInstance] saveUserData:@{@"phone": @"1223445"}];
    UserModel * model =  [[UserStorage shareInstance] getUserModel];
    NSLog(@"%@",model.phone);
    [[UserStorage shareInstance] removeUserData];
     NSLog(@"%@",model.phone);
}


@end
