//
//  TestQualityVC.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/12.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "TestQualityVC.h"
#import <BAPickView_OC.h>
#import "TestQualityModel.h"
#import "TestQualityTableViewCell.h"

@interface TestQualityVC ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)UIButton* dateBtn;
@property(nonatomic, strong)UIButton* typeBtn;
@property(nonatomic, strong)NSString *dataStr;
@property(nonatomic, assign)NSInteger type;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray<TestQualityModel*> *dataArr;
@end

@implementation TestQualityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"考试质量";
    [self setUI];
    [self.tableView.mj_header beginRefreshing];
}

- (void)setUI
{
    UIView *headView = [UIView new];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    headView.sd_layout
    .topSpaceToView(self.view, HC_naviHeight)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(50);
    
    _dateBtn = [UIButton new];
    [_dateBtn setImage:[UIImage imageNamed:@"arrow_bottom"] forState:0];
    _dateBtn.hcNomalTextBlock(BlueColor, [self.dataStr stringByReplacingOccurrencesOfString:@"-" withString:@"/"] , SystemFont(16))
    .hcTapBlock(self, @selector(showPickView));
    _dateBtn.titleLabel.sd_layout
    .centerYEqualToView(_dateBtn)
    .centerXEqualToView(_dateBtn)
    .autoHeightRatio(0);
    [_dateBtn.titleLabel setSingleLineAutoResizeWithMaxWidth:300];
    _dateBtn.imageView.sd_layout
    .heightIs(15)
    .widthIs(15)
    .centerYEqualToView(_dateBtn)
    .leftSpaceToView(_dateBtn.titleLabel, 4);
    [headView addSubview:_dateBtn];
    
    _dateBtn.sd_layout
    .topSpaceToView(headView, 0)
    .leftSpaceToView(headView, 0)
    .bottomSpaceToView(headView, 0)
    .widthRatioToView(headView, 0.5);
    
    _typeBtn = [UIButton new];
    [_typeBtn setImage:[UIImage imageNamed:@"arrow_bottom"] forState:0];
    _typeBtn.hcNomalTextBlock(DetialColor_666,@"全部科目", SystemFont(16))
    .hcTapBlock(self, @selector(selectType));
    _typeBtn.titleLabel.sd_layout
    .centerYEqualToView(_typeBtn)
    .centerXEqualToView(_typeBtn)
    .autoHeightRatio(0);
    [_typeBtn.titleLabel setSingleLineAutoResizeWithMaxWidth:300];
    _typeBtn.imageView.sd_layout
    .heightIs(15)
    .widthIs(15)
    .centerYEqualToView(_typeBtn)
    .leftSpaceToView(_typeBtn.titleLabel, 4);
    [headView addSubview:_typeBtn];
    
    _typeBtn.sd_layout
    .topSpaceToView(headView, 0)
    .leftSpaceToView(_dateBtn, 0)
    .bottomSpaceToView(headView, 0)
    .widthRatioToView(headView, 0.5);
}

- (void)showPickView
{
    HC__weakSelf
    [BAKit_DatePicker ba_creatPickerViewWithType:BAKit_CustomDatePickerDateTypeYM configuration:^(BAKit_DatePicker *tempView) {
        tempView.ba_maxDate = [NSDate new];
        tempView.ba_defautDate = self.date;
        tempView.animationType = BAKit_PickerViewAnimationTypeBottom;
    } block:^(NSString *resultString) {
        weakSelf.dataStr = resultString;
        [weakSelf.dateBtn setTitle:[resultString stringByReplacingOccurrencesOfString:@"-" withString:@"/"] forState:0];
        [weakSelf.tableView.mj_header beginRefreshing];
    }];
}

- (void)selectType
{
    HC__weakSelf
    UIAlertController *sheetVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [sheetVC addAction:cancelAction];
    NSArray *titles = @[@"全部科目",@"科目一",@"科目二",@"科目三",@"安全文明驾驶"];
    for (int i = 0; i < titles.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:titles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf.typeBtn setTitle:titles[i] forState:0];
            weakSelf.type = i;
            [weakSelf.tableView.mj_header beginRefreshing];
        }];
        [sheetVC addAction:action];
    }
    
    [self presentViewController:sheetVC animated:YES completion:nil];
}

- (void)setDate:(NSDate *)date
{
    _date = date;
    _dataStr = [[NSDateFormatter ba_setupDateFormatterWithYM] stringFromDate:date];
}

- (void)setDataStr:(NSString *)dataStr
{
    _dataStr = dataStr;
    _date = [[NSDateFormatter ba_setupDateFormatterWithYM] dateFromString: dataStr];
}


- (void)getData
{
    
    NSString *schoolId = [UserStorage shareInstance].getUserModel.schoolId;
    if (schoolId.isEmpty) {
        [MBProgressHUD showMessage:@"没有学校（schoolId），请重新登录"];
        return;
    }
    HC__weakSelf
    [NetWorkTool requestWithURL:HomeApi_tsetQuality
                         params:@{@"schoolId": schoolId,
                                  @"date": self.dataStr,
                                  @"subType":NSStringFromInt(self.type)
                                  } toModel:[TestQualityModel class] success:^(NSArray<TestQualityModel *>* result) {
                                      weakSelf.dataArr = [result mutableCopy];
                                      [weakSelf.tableView reloadData];
                                      [weakSelf.tableView.mj_header endRefreshing];
                                  } failure:^(NSString *msg, NSInteger code) {
                                      [MBProgressHUD showError:msg];
                                      [weakSelf.tableView.mj_header endRefreshing];
                                  } showLoading:nil];
}



- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.hcCornerRadiusBlock(7, YES);
        _tableView.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:_tableView];
        _tableView.sd_layout
        .topSpaceToView(self.view, 5+50+HC_naviHeight)
        .leftSpaceToView(self.view, 15)
        .rightSpaceToView(self.view, 15)
        .bottomSpaceToView(self.view, 10);
        
        [_tableView registerClass:[TestQualityTableViewCell class] forCellReuseIdentifier:@"TestQualityTableViewCell"];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        HC__weakSelf
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf getData];
        }];
        
    }
    return _tableView;
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
    TestQualityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TestQualityTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = indexPath.row%2 == 0 ? HexColor(@"E3E3E3"):[UIColor whiteColor];
    cell.contentView.backgroundColor = indexPath.row%2 == 0 ? HexColor(@"E3E3E3"):[UIColor whiteColor];
    cell.model = self.dataArr[indexPath.row];
    cell.num =  NSStringFromInt(indexPath.row);
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    NSArray *arr = @[@"序号",@"科目类型",@"考试人数",@"合格人数",@"合格率"];
    NSMutableArray * lbs = [NSMutableArray new];
    for (int i = 0; i<5; i++) {
        UILabel *lb = [UILabel new];
        lb.text = arr[i];
        lb.hcTextBlock(TitleColor_333, SystemFont(14),  1);
        [view addSubview:lb];
        CGFloat widthRatio = 0.9/4.0;
        if (i==0) {
            widthRatio = 0.1;
        }
       
        lb.sd_layout
        .widthRatioToView(view ,widthRatio)
        .topSpaceToView(view, 0)
        .bottomSpaceToView(view, 0)
        .leftSpaceToView(lbs.count>0 ? lbs.lastObject : view, 0);
        [lbs addObject:lb];
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
@end
