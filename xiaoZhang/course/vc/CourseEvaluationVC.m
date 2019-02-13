//
//  CourseEvaluationVC.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/12.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "CourseEvaluationVC.h"
#import "LEEStarRating.h"
#import "CourseEvaluationModel.h"
#import "LbsView.h"
@interface CourseEvaluationVC ()
@property(nonatomic, strong)UILabel *studentNameLb;
@property(nonatomic, strong)UILabel *coachNameLb;
@property(nonatomic, strong)LEEStarRating *statView_1;
@property(nonatomic, strong)LEEStarRating *statView_2;
@property(nonatomic, strong)LEEStarRating *statView_3;
@property(nonatomic, strong)LbsView *lbsView;
@property(nonatomic, strong)UILabel *evaluationContent;
@property(nonatomic, strong)CourseEvaluationModel *model;
@end

@implementation CourseEvaluationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"学员评价";
    [self getData];
    [self setUI];
   
}

- (void)getData
{
    HC__weakSelf
    [NetWorkTool requestWithURL:CourseApi_courseEvaluation params:@{@"courseRecordId": self.courseRecordId} toModel:[CourseEvaluationModel class]  success:^(CourseEvaluationModel* result) {
        weakSelf.model = result;
        [weakSelf reloadView];
    } failure:^(NSString *msg, NSInteger code) {
        [MBProgressHUD showError:msg];
    } showLoading:@""];
}

- (void)reloadView{
    _studentNameLb.text = [NSString stringWithFormat:@"学员：%@",_studentName];
    _coachNameLb.text = [NSString stringWithFormat:@"教练：%@",_coachName];
    
    _statView_1.currentScore = self.model.coachAbilityScore / 2.0;
    _statView_2.currentScore = self.model.coachAttitudeScore / 2.0;
    _statView_3.currentScore = self.model.coachHygieneScore / 2.0;
    _lbsView.data = self.model.list;
    _lbsView.coachLabel = self.model.coachLabel;
    
    _evaluationContent.text = self.model.coachEvaluationContent;
}

- (void)setUI
{
    UIScrollView *scrollView = [UIScrollView new];
    [self.view addSubview:scrollView];
    scrollView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(HC_naviHeight, 0, 0, 0));
    
    UIView *headerView = [UIView new];
    headerView.hcBgColorBlock([UIColor whiteColor])
    .hcCornerRadiusBlock(7, YES);
    
    [scrollView addSubview:headerView];
    
    headerView.sd_layout
    .topSpaceToView(scrollView, 10)
    .leftSpaceToView(scrollView, 15)
    .rightSpaceToView(scrollView, 15)
    .heightIs(45);
    
    _coachNameLb = [UILabel new];
    _coachNameLb.hcTextBlock(TitleColor_333, Font(16, 14), 0);
    _studentNameLb = [UILabel new];
    _studentNameLb.hcTextBlock(TitleColor_333, Font(16, 14), 2);
    
    [headerView sd_addSubviews:@[_coachNameLb, _studentNameLb]];
    _coachNameLb.sd_layout
    .topSpaceToView(headerView, 0)
    .leftSpaceToView(headerView, 12)
    .bottomSpaceToView(headerView, 0)
    .widthRatioToView(headerView, 0.5);
    
    _studentNameLb.sd_layout
    .topSpaceToView(headerView, 0)
    .leftSpaceToView(_coachNameLb, 0)
    .bottomSpaceToView(headerView, 0)
    .rightSpaceToView(headerView, 12);
    
    UILabel *titleLb = [UILabel new];
    titleLb.text = @"学员评价";
    titleLb.hcTextBlock(TitleColor_333, Font(16, 14), 0);
    
    [scrollView addSubview:titleLb];
    titleLb.sd_layout
    .leftSpaceToView(scrollView, 20)
    .heightIs(40)
    .topSpaceToView(headerView, 5)
    .rightSpaceToView(scrollView, 20);
    
    UIView *contentView = [UIView new];
    contentView.hcCornerRadiusBlock(7, YES)
    .hcBgColorBlock([UIColor whiteColor]);
    
    [scrollView addSubview:contentView];
    contentView.sd_layout
    .topSpaceToView(titleLb, 0)
    .leftSpaceToView(scrollView, 15)
    .rightSpaceToView(scrollView, 15);
    
    [scrollView setupAutoContentSizeWithBottomView:contentView bottomMargin:20];
    NSArray *arr = @[@"教学能力",@"服务态度",@"车辆卫生"];
    for (int i = 0; i<arr.count; i++) {
        UILabel *lb = [UILabel new];
        lb.text = arr[i];
        lb.hcTextBlock(DetialColor_666, SystemFont(14), 0);
        
        [contentView addSubview:lb];
        lb.sd_layout
        .topSpaceToView(contentView, 10+40*i)
        .leftSpaceToView(contentView, 10)
        .heightIs(20);
        [lb setSingleLineAutoResizeWithMaxWidth:300];
        
        LEEStarRating *starView = [[LEEStarRating alloc]initWithFrame:CGRectMake(0, 0, 600, 20) Count:5];
        starView.type = RatingTypeHalf;
        starView.spacing = 17;
        
        [contentView addSubview:starView];
        starView.sd_layout
        .centerYEqualToView(lb)
        .leftSpaceToView(lb, 0)
        .widthIs(20*10)
        .heightIs(17);
        
        if (i==0) {
            _statView_1 = starView;
        }else if (i==1){
            _statView_2 = starView;
        }else if (i==2){
            _statView_3 = starView;
        }
    }
    
    _lbsView = [LbsView new];
    [contentView addSubview:_lbsView];
    _lbsView.sd_layout
    .topSpaceToView(_statView_3, 20)
    .leftSpaceToView(contentView, 10);
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = HexColor(@"#FFF3E6");
    bgView.layer.cornerRadius = 5;
    bgView.clipsToBounds = YES;
    
    [contentView addSubview:bgView];
    bgView.sd_layout
    .topSpaceToView(_lbsView, 10)
    .leftSpaceToView(contentView, 10)
    .rightSpaceToView(contentView, 10);
    _evaluationContent = [UILabel new];
    
//    _evaluationContent.textContainerInset = UIEdgeInsetsMake(12, 12, 16, 12);
    _evaluationContent.hcTextBlock(TitleColor_333, SystemFont(12), 0);
    
    [bgView addSubview:_evaluationContent];
    _evaluationContent.sd_layout
    .topSpaceToView(bgView, 12)
    .leftSpaceToView(bgView, 12)
    .rightSpaceToView(bgView, 12)
    .autoHeightRatio(0);
    
    [bgView setupAutoHeightWithBottomView:_evaluationContent bottomMargin:16];
    [contentView setupAutoHeightWithBottomView:bgView bottomMargin:20];
    
}



@end
