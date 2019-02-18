//
//  CourseVC.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/11/28.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "CourseVC.h"
#import "CourseModel.h"
#import "CourseDateView.h"
#import "SelectView.h"
#import "CourseTableViewCell.h"
#import "CourseDetailVC.h"
@interface CourseVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, assign)NSInteger type;//0 实操 1理论 3其他
@property(nonatomic, strong)NSString *dateStr;
@property(nonatomic, strong)NSMutableArray *dataArr;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, strong)CourseDateView *courseDateView;
@property(nonatomic, strong)UITableView *tableView;
@end

@implementation CourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"课程表";
    _dataArr = [NSMutableArray new];
    UILabel *lable = [UILabel new];
    lable.text = @"点击刷新";
    lable.textAlignment = 1;
    [self.view addSubview:lable];
    lable.frame = self.view.bounds;
    [self getDate];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNot:)  name:@"login"  object:nil];
}

- (void)reciveNot:(NSNotification *) not
{
    [self getDate];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"login"  object:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self getDate];
}

- (void)getDate
{
    NSString * schoolId = [[UserStorage shareInstance] getUserModel].schoolId;
    if (schoolId) {
        HC__weakSelf
        [NetWorkTool requestWithURL:CourseApi_dateList params:@{@"schoolId": schoolId} toModel:nil success:^(NSDictionary* result) {
            weakSelf.dateStr = [result[@"list"] firstObject];
            weakSelf.courseDateView.dateArr = result[@"list"];
            [weakSelf.tableView.mj_header beginRefreshing];
        } failure:^(NSString *msg, NSInteger code) {
           
        } showLoading:@""];
    }
}

- (void)getCourse:(BOOL)isMore
{
    if (isMore) {
        self.page++;
    }else{
        self.page = 1;
    }
    NSString * schoolId = [[UserStorage shareInstance] getUserModel].schoolId;
    HC__weakSelf
    if (schoolId) {
        [NetWorkTool requestWithURL:CourseApi_course
                             params:@{@"schoolId": schoolId,
                                      @"date": self.dateStr,
                                      @"page": [NSString stringWithFormat:@"%ld",self.page],
                                      @"rows": @"10"
                                      
                                      } toModel:[CourseListModel class]
                            success:^(CourseListModel* result) {
                                NSArray *data = result.list_1;
                                if (self.type == 1) {
                                   data = result.list_2;
                                }else if (self.type == 2){
                                   data = result.list_3;
                                }
                                if (isMore) {
                                    [weakSelf.dataArr addObjectsFromArray:data];
                                    [weakSelf.tableView.mj_footer  endRefreshing];
                                }else{
                                    weakSelf.dataArr = [data mutableCopy];
                                    [weakSelf.tableView.mj_header endRefreshing];
                                    [weakSelf.tableView.mj_footer resetNoMoreData];
                                }
                                  [weakSelf.tableView reloadData];
                                if (data.count == 0) {
                                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                                }
                               
                            } failure:^(NSString *msg, NSInteger code) {
                                if (isMore) {
                                    [weakSelf.tableView.mj_footer endRefreshing];
                                }else{
                                    [weakSelf.tableView.mj_header endRefreshing];
                                }
                                
                            } showLoading:nil];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CourseTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
//    cell.model = [CourseModel modelWithJSON:@{@"appointmentId": @"153",
//                                              @"subjectName": @"科目二",
//                                              @"shortPeriodTime": @"09:25-11:30",
//                                              @"maxNum":@"10",
//                                              @"appointmentNum": @"0",
//                                              @"noAppointmentNum": @"10",
//                                              @"coachName":@ "宝山",
//                                              @"coachPhoto": @"files/coachimg/20170426_152327198609190017B.jpg",
//                                              @"coachSex": @"男",
//                                              @"identity": @"132000"}];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CourseDetailVC *vc = [CourseDetailVC new];
//    vc.model = [CourseModel modelWithJSON:@{@"appointmentId": @"153",
//                                            @"subjectName": @"科目二",
//                                            @"shortPeriodTime": @"09:25-11:30",
//                                            @"maxNum":@"10",
//                                            @"appointmentNum": @"0",
//                                            @"noAppointmentNum": @"10",
//                                            @"coachName":@ "宝山",
//                                            @"coachPhoto": @"files/coachimg/20170426_152327198609190017B.jpg",
//                                            @"coachSex": @"男",
//                                            @"identity": @"132000"}];
    vc.model = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CourseDateView *)courseDateView
{
    if (!_courseDateView) {
        _courseDateView = [CourseDateView new];
        HC__weakSelf
        [self.view addSubview:_courseDateView];
        _courseDateView.tapBlock = ^(NSString * _Nonnull dataStr) {
            weakSelf.dateStr = dataStr;
            [weakSelf.tableView.mj_header beginRefreshing];
        };
        _courseDateView.sd_layout
        .topSpaceToView(self.view, HC_naviHeight)
        .leftSpaceToView(self.view, 0)
        .rightSpaceToView(self.view, 0)
        .heightIs(120);
        
        SelectView *selectView = [[SelectView alloc]initWithData:@[@"实操",@"理论",@"其他"]];
        selectView.backgroundColor = [UIColor whiteColor];
        selectView.block = ^(NSInteger index) {
            weakSelf.type = index;
            [weakSelf.tableView.mj_header beginRefreshing];
        };
        [self.view addSubview:selectView];
        selectView.sd_layout
        .topSpaceToView(_courseDateView, 0.5)
        .leftSpaceToView(self.view, 0)
        .rightSpaceToView(self.view, 0)
        .heightIs(40);
    }
    return _courseDateView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        _tableView.sd_layout
        .topSpaceToView(self.courseDateView, 40)
        .leftSpaceToView(self.view, 0)
        .rightSpaceToView(self.view, 0)
        .bottomSpaceToView(self.view, 0);
        
        [_tableView registerClass:[CourseTableViewCell class] forCellReuseIdentifier:@"CourseTableViewCell"];
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        HC__weakSelf
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf getCourse:NO];
        }];
        
        _tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [weakSelf getCourse:YES];
        }];
    }
    return _tableView;
}

@end
