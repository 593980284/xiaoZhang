//
//  mineVC.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/11/28.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "mineVC.h"
#import "MineListCell.h"

@interface mineVC ()
@property(nonatomic, weak)UIImageView *headerImgView;
@property(nonatomic, weak)UILabel *phoneLabel;
@property(nonatomic, weak)UILabel *schoolNameLabel;
@end

@implementation mineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUI];
    
    [[UserStorage shareInstance] saveUserData:@{@"schoolName": @"schoolName",
                                                @"phone": @"phone"
                                                }];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UserModel *userModel = [[UserStorage shareInstance] getUserModel];
    _schoolNameLabel.text = userModel.schoolName;
    _phoneLabel.text = userModel.phone;
}

- (void)setUI {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:headerView];
    headerView.sd_layout
    .topSpaceToView(self.view, HC_naviHeight)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(90*HC_320Ratio);
    
    UIImageView *headerImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    headerImgView.layer.cornerRadius = 30*HC_320Ratio;
    headerImgView.clipsToBounds = YES;
    [headerView addSubview:headerImgView];
    self.headerImgView = headerImgView;
    headerImgView.backgroundColor = [UIColor redColor];
    headerImgView.sd_layout
    .leftSpaceToView(headerView, 20*HC_320Ratio)
    .centerYEqualToView(headerView)
    .widthIs(60*HC_320Ratio)
    .heightEqualToWidth();

    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [headerView addSubview:phoneLabel];
    self.phoneLabel = phoneLabel;
    phoneLabel.sd_layout
    .leftSpaceToView(headerImgView, 15*HC_320Ratio)
    .topEqualToView(headerImgView).offset(5*HC_320Ratio)
    .rightSpaceToView(headerView, 0)
    .heightIs(20*HC_320Ratio);

    UILabel *schoolNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [headerView addSubview:schoolNameLabel];
    self.schoolNameLabel = schoolNameLabel;
    schoolNameLabel.sd_layout
    .topSpaceToView(phoneLabel, 0)
    .leftSpaceToView(headerImgView, 15*HC_320Ratio)
    .rightSpaceToView(headerView, 0)
    .bottomEqualToView(headerImgView);
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:line];
    line.sd_layout
    .leftSpaceToView(headerView, 5)
    .rightSpaceToView(headerView, 5)
    .bottomSpaceToView(headerView, 0)
    .heightIs(1);
    
    MineListCell *cell = [[MineListCell alloc]initWithTitle:@"text"];
    cell.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cell];
    
    cell.sd_layout
    .topSpaceToView(headerView, 20)
    .leftSpaceToView(self.view, 10)
    .rightSpaceToView(self.view, 10)
    .heightIs(40*HC_750Ratio);
    
    
}



@end
