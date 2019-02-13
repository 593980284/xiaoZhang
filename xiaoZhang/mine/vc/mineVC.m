//
//  mineVC.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/11/28.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "mineVC.h"
#import "MineListCell.h"
#import "MineView.h"
#import "MineListItem.h"
#import "SetVC.h"
#import "AboutUsVC.h"

@interface mineVC ()
@property(nonatomic, weak)UIImageView *headerImgView;
@property(nonatomic, weak)UILabel *phoneLabel;
@property(nonatomic, weak)UILabel *schoolNameLabel;
@end

@implementation mineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBarAlpha = 0;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [self setUI];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UserModel *userModel = [[UserStorage shareInstance] getUserModel];
    _schoolNameLabel.text = userModel.schoolName;
    _phoneLabel.text = userModel.phone;
    [_headerImgView setImageWithImageString:userModel.photo placeholderString:@"head"];
    _headerImgView.backgroundColor = [UIColor redColor];
}
- (void)setUI {
    
    UIScrollView *scrollView = [UIScrollView new];
    [self.view addSubview:scrollView];
    scrollView.sd_layout
    .spaceToSuperView(UIEdgeInsetsZero);
    
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectZero];
    headerView.hcImageBlock(@"tap_bg")
    .hcTapBlock(self, @selector(gotoPersonalCenter));
    
    [scrollView  addSubview:headerView];
    headerView.sd_layout
    .topSpaceToView(scrollView, 0)
    .leftSpaceToView(scrollView, 0)
    .rightSpaceToView(scrollView, 0)
    .heightIs(90*HC_320Ratio + HC_naviHeight);
    
    UIImageView *headerImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [headerView addSubview:headerImgView];
    self.headerImgView = headerImgView;
    headerImgView.sd_layout
    .leftSpaceToView(headerView, 20*HC_320Ratio)
    .topSpaceToView(headerView, HC_naviHeight )
    .widthIs(60*HC_320Ratio)
    .heightEqualToWidth();
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [headerView addSubview:phoneLabel];
    self.phoneLabel = phoneLabel;
    self.phoneLabel.textColor = [UIColor whiteColor];
    phoneLabel.sd_layout
    .leftSpaceToView(headerImgView, 15*HC_320Ratio)
    .topEqualToView(headerImgView).offset(5*HC_320Ratio)
    .rightSpaceToView(headerView, 0)
    .heightIs(20*HC_320Ratio);
    
    UILabel *schoolNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [headerView addSubview:schoolNameLabel];
    self.schoolNameLabel = schoolNameLabel;
    self.schoolNameLabel.textColor = [UIColor whiteColor];
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
    
    NSArray *titleArray = @[
                            @{@"title": @"清除缓存", @"image": @"clean_ cache"},
                            @{@"title": @"关于我们", @"image": @"about_our"}
                            ];
    for (int i = 0; i < titleArray.count; i ++) {
        NSDictionary *dic = titleArray[i];
        MineListItem *item = [[MineListItem alloc]initWithImageStr:dic[@"image"]  title:dic[@"title"]  target:self sel:@selector(tap:)];
        item.tag = 100 + i;
        [scrollView addSubview:item];
        
        item.sd_layout
        .topSpaceToView(headerView, 10 + 45* i)
        .heightIs(45)
        .leftSpaceToView(scrollView, 0)
        .rightSpaceToView(scrollView, 0);
    }
    
    //    NSString *systemVersion = [NSString stringWithFormat:@"版本v%@",HC_appVersion];
    //    NSArray *titleArray = @[@"清除缓存",@"关于我们"];
    //    CGFloat cellHeight = 40;
    //    MineView *mineView = [[MineView alloc] initWithCellArray:titleArray withCellHeight:cellHeight];
    //    [self.view addSubview:mineView];
    //    mineView.backgroundColor = [UIColor whiteColor];
    //    mineView.sd_layout
    //    .topSpaceToView(headerView, 20)
    //    .leftSpaceToView(self.view, 10)
    //    .rightSpaceToView(self.view, 10)
    //    .heightIs(titleArray.count*cellHeight*HC_320Ratio);
}


- (void)tap:(UITapGestureRecognizer *)gr
{
    UIView *view = gr.view;
    switch (view.tag - 100) {
        case 0:
            {
                [self alertWithTitle:@"提示" message:@"是否清除缓存?" sureTitle:@"清除" handler:^(UIAlertAction *action) {
                     [MBProgressHUD showSuccess:@"清除成功"];
                }];
            }
            break;
        case 1:
        {
            AboutUsVC *vc = [AboutUsVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)gotoPersonalCenter
{
    SetVC *vc = [SetVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
