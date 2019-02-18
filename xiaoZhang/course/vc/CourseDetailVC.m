//
//  CourseDetailVC.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/11.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "CourseDetailVC.h"
#import "CoachView.h"
#import "CoachDetailView.h"
#import "StudentTableViewCell.h"
#import "CourseEvaluationVC.h"
@interface CourseDetailVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)CourseDetailModel *courseDetailModel;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)CoachView *coachView;
@property(nonatomic, strong)CoachDetailView *coachDetailView;
@end

@implementation CourseDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    [self.tableView.mj_header beginRefreshing];
    self.title = @"在线约课";
}

- (void)mockdata
{
    self.courseDetailModel = [CourseDetailModel modelWithJSON:@{
        @"coachName": @"水欣欣",
        @"coachPhoto": @"files/coachimg/20170306_371501197308219544B.jpg",
        @"subjectName": @"科目一",
        @"appointmentDate":@ "2018-09-26",
        @"coachSex": @"男",
        @"coachStar": @"8.0",
        @"teachType": @"科目一、四",
        @"teachAge":@"0",
        @"identity": @"",
        @"carNo": @"",
        @"hours": @"2",
        @"list": @[@{
                     @"name": @"曹二燕",
                     @"courseRecordId": @"59",
                     @"studentPhoto": @"files/stuimg/20170615_152322198507073547B.jpg",
                     @"subject": @"1234",
                     @"isEvaluation": @"0"
                 },
                @{
                     @"name": @"布梦雪",
                     @"courseRecordId": @"60",
                     @"studentPhoto": @"files/stuimg/20170528_152327199311150025B.jpg",
                     @"subject": @"23",
                     @"isEvaluation": @"1"
                 }
               ]
        }];
}

- (void)getData{
    HC__weakSelf
    [NetWorkTool requestWithURL:CourseApi_courseDetail params:@{@"appointmentId": self.model.appointmentId} toModel:[CourseDetailModel class] success:^(CourseDetailModel * result) {
        weakSelf.courseDetailModel = result;
//        [weakSelf mockdata];
        [weakSelf.tableView reloadData];
        [weakSelf reloadHeaderView];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSString *msg, NSInteger code) {
        [MBProgressHUD showError:msg];
    } showLoading:nil];
    
}

- (void)reloadHeaderView
{
    _coachView.courseDetailModel = self.courseDetailModel;
    _coachDetailView.courseDetailModel = self.courseDetailModel;
    _coachDetailView.courseModel = self.model;;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = HexColor(@"f5f5f5");
        [self.view addSubview:_tableView];
        _tableView.sd_layout
        .topSpaceToView(self.view, HC_naviHeight)
        .leftSpaceToView(self.view, 0)
        .rightSpaceToView(self.view, 0)
        .bottomSpaceToView(self.view, 0);
        
        [_tableView registerClass:[StudentTableViewCell class] forCellReuseIdentifier:@"StudentTableViewCell"];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self createTableViewHeaderView];
        HC__weakSelf
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf getData];
        }];
        
    }
    return _tableView;
}

- (UIView *)createTableViewHeaderView
{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor whiteColor];
    _coachView = [CoachView new];
    [headerView addSubview:_coachView];
    _coachView.sd_layout
    .topSpaceToView(headerView, 0)
    .rightSpaceToView(headerView, 0)
    .leftSpaceToView(headerView, 0)
    .heightIs(93);
    
    UIView *line = [UIView new];
    line.backgroundColor = HexColor(@"f5f5f5");
    [headerView addSubview:line];
    line.sd_layout
    .topSpaceToView(_coachView, 0)
    .leftSpaceToView(headerView, 30)
    .rightSpaceToView(headerView, 30)
    .heightIs(LineHeight);
    
    _coachDetailView = [CoachDetailView new];
    [headerView addSubview:_coachDetailView];
    _coachDetailView.sd_layout
    .topSpaceToView(_coachView, 5)
    .leftSpaceToView(headerView, 0)
    .rightSpaceToView(headerView, 0);
    
    UIView *bottomView = _coachDetailView;
    [headerView setupAutoHeightWithBottomView:bottomView bottomMargin:10];
    
    [bottomView updateLayout];
    headerView.frame = CGRectMake(0, 0, 1, CGRectGetMaxY(bottomView.frame));
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.courseDetailModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"StudentTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.courseDetailModel.list[indexPath.row];
    HC__weakSelf
    cell.seeEvaluationBlock = ^(StudentModel * _Nonnull model) {
        CourseEvaluationVC *vc = [CourseEvaluationVC new];
        vc.courseRecordId = model.courseRecordId;
        vc.studentName = model.name;
        vc.coachName = weakSelf.courseDetailModel.coachName;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    UILabel *label = [UILabel new];
    label.text = @"学员";
    label.hcTextBlock(TitleColor_333, Font(16, 14), 0);
    [view addSubview:label];
    label.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 30, 0, 0));
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

@end
