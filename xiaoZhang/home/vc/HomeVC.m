//
//  HomeVC.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/12/1.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "HomeVC.h"
#import "LoginVC.h"
#import "BaseNaviVC.h"
#import "HomeModel.h"
#import "HomeTopView.h"
#import "HomeFormView.h"
#import "TestQualityVC.h"
@interface HomeVC ()<UIScrollViewDelegate> 
@property(nonatomic, weak)UILabel *label;
@property(nonatomic, strong)HomeModel *model;
@property(nonatomic, weak)UIScrollView *scrollView;
@property(nonatomic, strong) HomeTopView  * topView;
@property(nonatomic, strong) HomeFormView  * todayView;
@property(nonatomic, strong) HomeFormView  * monthView;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"乐享学驾";
    self.titleColor = [UIColor whiteColor];
    self.navBarAlpha = 0;
    self.navigationController.navigationBar.barTintColor = BlueColor;
    [self setUI];
    [self.scrollView.mj_header beginRefreshing];
    self.view.backgroundColor = HexColor(@"F1F1F1");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNot:)  name:@"login"  object:nil];
}

- (void)reciveNot:(NSNotification *) not
{
    [self getData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"login"  object:nil];
}

- (void)getData
{
    NSString * schoolId = @"";
    if ([[UserStorage shareInstance] getUserModel].schoolId) {
        schoolId = [[UserStorage shareInstance] getUserModel].schoolId;
    }
    HC__weakSelf
    [NetWorkTool requestWithURL:HomeApi_home params:@{@"schoolId": schoolId} toModel:[HomeModel class] success:^(HomeModel* result) {
        weakSelf.model = result;
        [weakSelf.scrollView.mj_header endRefreshing];
    } failure:^(NSString *msg, NSInteger code) {
        [MBProgressHUD showError:msg];
        [weakSelf.scrollView.mj_header endRefreshing];
    } showLoading:nil];
}

- (void)setModel:(HomeModel *)model
{
    _model = model;
    
    self.topView.values = @[[NSString stringWithFormat:@"%ld", model.signUpTodayCount],
                            [NSString stringWithFormat:@"%ld", model.signUpYesterdayCount]
                            ];
    self.todayView.values = @[[NSString stringWithFormat:@"%ld", model.signUpTodayCount],
                              [NSString stringWithFormat:@"%ld", model.appointTodayCount],
                              [NSString stringWithFormat:@"%ld/%ld", model.appointTodayCount,model.appointTodayCancelCount],
                              [NSString stringWithFormat:@"0/0没有字段"]
                              ];
    self.monthView.values = @[[NSString stringWithFormat:@"%ld", model.signUpMonthCount],
                              [NSString stringWithFormat:@"%ld", model.appointMonthCount],
                              [NSString stringWithFormat:@"%ld/%ld", model.appointMonthCount,model.appointMonthCancelCount],
                              [NSString stringWithFormat:@"%ld/%ld", model.examCount,model.examPass]
                              ];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsety = scrollView.contentOffset.y;
    if (offsety > 0) {
        self.navBarAlpha = offsety/HC_naviHeight;
    }else{
        self.navBarAlpha = 0;
    }
        
}

- (void)setUI
{
    
    UIImageView *imgView = [UIImageView new];
    imgView.hcImageBlock(@"tap_bg");
    [self.view addSubview:imgView];
    imgView.sd_layout
    .topSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(HC_naviHeight+ 50);
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.delegate = self;
    scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    [self.view addSubview:scrollView];
    scrollView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    self.scrollView = scrollView;
    
    self.topView = [[HomeTopView alloc]initWithTitles:@[@"本日新增学员(人)",@"昨日新增学员(人)"]];
    
    [scrollView addSubview:self.topView];
    self.topView.sd_layout
    .topSpaceToView(scrollView, HC_naviHeight)
    .leftSpaceToView(scrollView, 20)
    .rightSpaceToView(scrollView, 20)
    .heightIs(80);
    
    self.todayView = [[HomeFormView alloc]initWithTitle:@"今日"];
    [scrollView addSubview:self.todayView];
    self.todayView
    .sd_layout.topSpaceToView(self.topView, 15)
    .leftSpaceToView(scrollView, 20)
    .rightSpaceToView(scrollView, 20);
    
    self.monthView = [[HomeFormView alloc]initWithTitle:@"本月"];
    [scrollView addSubview:self.monthView];
    self.monthView
    .sd_layout.topSpaceToView(self.todayView, 15)
    .leftSpaceToView(scrollView, 20)
    .rightSpaceToView(scrollView, 20);
    
    self.todayView.tapBlock = ^(NSInteger index) {
        switch (index) {
            case 0:
                {}
                break;
                
            default:
                break;
        }
    };
    
    self.monthView.tapBlock = ^(NSInteger index) {
        switch (index) {
            case 0:
            {}
                break;
                
            default:
                break;
        }
    };
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
