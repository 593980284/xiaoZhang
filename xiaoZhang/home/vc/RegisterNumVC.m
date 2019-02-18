//
//  RegisterNumVC.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/13.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "RegisterNumVC.h"
#import <BAPickView_OC.h>
#import "RegisterNumTableViewCell.h"
#import "AAChartKit.h"
@interface RegisterNumVC ()<UITableViewDelegate, UITableViewDataSource,AAChartViewDidFinishLoadDelegate>
@property(nonatomic, strong)NSString *startDateStr;
@property(nonatomic, strong)NSString *endDateStr;
@property(nonatomic, strong)NSString *viewType; //必填 0 表格 1 曲线图
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UILabel* startLb;
@property(nonatomic, strong)UILabel* endLb;
@property(nonatomic, strong)NSString *schoolId;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, strong)NSMutableArray *listArr;

@property (nonatomic, strong) AAChartModel  *aaChartModel;
@property (nonatomic, strong) AAChartView  *aaChartView;
@property(nonatomic, strong)NSArray<RegisterNumTable_rowsModel*> *ChartArr;
@property(nonatomic, strong)UILabel *tipLb;
@end

@implementation RegisterNumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"报名人数";
    [self setUI];
    self.viewType = @"1";
    self.listArr = [NSMutableArray new];
    self.schoolId = [UserStorage shareInstance].getUserModel.schoolId;
    [self reloadData];
}

- (void)setUI
{
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:bgView];
    
    bgView.sd_layout
    .topSpaceToView(self.view, HC_naviHeight)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(50);
    
    UISegmentedControl *s = [[UISegmentedControl alloc]initWithItems:@[@"柱状图",@"表格"]];
    s.tintColor = BlueColor;
    s.selectedSegmentIndex = 0;
    [s addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    
    [bgView addSubview:s];
    
    s.sd_layout
    .centerYEqualToView(bgView)
    .rightSpaceToView(bgView, 20)
    .heightIs(30)
    .widthIs(115);
    
    _startLb = [UILabel new];
    _startLb.hcTextBlock(BlueColor, SystemFont(16), 0)
    .hcTapBlock(self, @selector(showStartPickerView));
    _startLb.text =  [self.startDateStr stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    
    UILabel *label = [UILabel new];
    label.hcTextBlock(BlueColor, SystemFont(16), 1);
    label.text = @"～";
    
    _endLb = [UILabel new];
    _endLb.text =  [self.endDateStr stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    _endLb.hcTextBlock(BlueColor, SystemFont(16), 0)
    .hcTapBlock(self, @selector(showEndPickerView));
    
    [bgView sd_addSubviews:@[_startLb, label, _endLb]];
    
    _startLb.sd_layout
    .topSpaceToView(bgView, 0)
    .bottomSpaceToView(bgView, 0)
    .leftSpaceToView(bgView, 20);
    [_startLb setSingleLineAutoResizeWithMaxWidth:300];
    
    label.sd_layout
    .topSpaceToView(bgView, 0)
    .bottomSpaceToView(bgView, 0)
    .leftSpaceToView(_startLb, 0)
    .widthIs(15);
    
    _endLb.sd_layout
    .topSpaceToView(bgView, 0)
    .bottomSpaceToView(bgView, 0)
    .leftSpaceToView(label, 0);
    [_endLb setSingleLineAutoResizeWithMaxWidth:300];
    
    CGFloat chartViewWidth  = self.view.frame.size.width - 15 * 2;
    CGFloat chartViewHeight = chartViewWidth/333.0 *407;
    self.aaChartView = [[AAChartView alloc]init];
    self.aaChartView.frame = CGRectMake( 15, HC_naviHeight + 50 + 10, chartViewWidth, chartViewHeight);
    self.aaChartView.delegate = self;
    //    设置aaChartVie 的内容高度(content height)
//    self.aaChartView.contentHeight = chartViewHeight;
    //    设置aaChartVie 的内容宽度(content  width)
//    self.aaChartView.contentWidth = chartViewWidth*2;
    [self.view addSubview:self.aaChartView];
    self.aaChartView.backgroundColor = [UIColor whiteColor];
    
    self.aaChartModel= AAChartModel.new
    .chartTypeSet(AAChartTypeColumn)//图表类型
    .titleSet(@"")//图表主标题
    .subtitleSet(@"")//图表副标题
    //    .yAxisLineWidthSet(@0)//Y轴轴线线宽为0即是隐藏Y轴轴线
//    .colorsThemeSet(@[@"#fe117c"])//设置主体颜色数组
    .yAxisTitleSet(@"人数（人）")//设置 Y 轴标题
    .backgroundColorSet(@"#FFFFFF")
    .yAxisGridLineWidthSet(@1)
    .dataLabelEnabledSet(true);//y轴横向分割线宽度为0(即是隐藏分割线)
    
    _aaChartModel.animationType = AAChartAnimationBounce;//图形的渲染动画为弹性动画
    _aaChartModel.yAxisTitle = @"";
    _aaChartModel.animationDuration = @1000;//图形渲染动画时长为1200毫秒
    
    //设置 AAChartView 的背景色是否为透明
//    self.aaChartView.isClearBackgroundColor = YES;
    _tipLb = [UILabel new];
    _tipLb.hcTextBlock(PlaceholderColor_333, SystemFont(12), 1);
//    _tipLb.text = @"点击柱状查看具体人数";
    _tipLb.text = @"注：向右滑查看更多";
    
    [self.view addSubview:_tipLb];
    _tipLb.sd_layout
    .topSpaceToView(_aaChartView, 5)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(20);
    
}

- (void)valueChange:(UISegmentedControl *)s
{
    if (s.selectedSegmentIndex == 1) {
        self.viewType = @"0";
        [self reloadData];
    }else{
        self.viewType = @"1";
        [self reloadData];
    }
}

- (void)showStartPickerView
{
    HC__weakSelf
    [BAKit_DatePicker ba_creatPickerViewWithType:BAKit_CustomDatePickerDateTypeYMD configuration:^(BAKit_DatePicker *tempView) {
        tempView.ba_maxDate = self.endDate;
        tempView.ba_defautDate = self.startDate;
        tempView.animationType = BAKit_PickerViewAnimationTypeBottom;
    } block:^(NSString *resultString) {
        weakSelf.startDateStr = resultString;
        weakSelf.startLb.text = [resultString stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
        [weakSelf reloadData];
    }];
}

- (void)showEndPickerView
{
    HC__weakSelf
    [BAKit_DatePicker ba_creatPickerViewWithType:BAKit_CustomDatePickerDateTypeYMD configuration:^(BAKit_DatePicker *tempView) {
        tempView.ba_maxDate = [NSDate new];
        tempView.ba_minDate = self.startDate;
        tempView.ba_defautDate = self.endDate;
        tempView.animationType = BAKit_PickerViewAnimationTypeBottom;
    } block:^(NSString *resultString) {
        weakSelf.endDateStr = resultString;
        weakSelf.endLb.text = [resultString stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
        [weakSelf reloadData];
        
    }];
}

- (void)reloadData{
    if ([self.viewType isEqualToString:@"0"]) {
        [self.tableView.mj_header beginRefreshing];
    }else{
        HC__weakSelf
        [NetWorkTool requestWithURL:HomeApi_registerNum
                             params:@{@"schoolId": self.schoolId,
                                      @"startDate": self.startDateStr,
                                      @"endDate": self.endDateStr,
                                      @"viewType": self.viewType,
                                      @"page": NSStringFromInt(self.page)
                                      }
                            toModel:[RegisterNumTableModel class]
                            success:^(RegisterNumTableModel* result) {
                                weakSelf.ChartArr = result.rows;
                            } failure:^(NSString *msg, NSInteger code) {
                                [MBProgressHUD showError:msg];
                            } showLoading:nil];
    }
}


- (void)tableRefresh
{
    self.page = 1;
    HC__weakSelf
    [NetWorkTool requestWithURL:HomeApi_registerNum
                         params:@{@"schoolId": self.schoolId,
                                  @"startDate": self.startDateStr,
                                  @"endDate": self.endDateStr,
                                  @"viewType": self.viewType,
                                  @"page": NSStringFromInt(self.page),
                                  @"rows": @"10"
                                  }
                        toModel:[RegisterNumTableModel class]
                        success:^(RegisterNumTableModel* result) {
                            [weakSelf.tableView.mj_header endRefreshing];
                            if (result.rows.count > 0) {
                                [weakSelf.tableView.mj_footer resetNoMoreData];
                            }else{
                                 [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                            }
                            weakSelf.listArr = [result.rows mutableCopy];
                            [weakSelf.tableView reloadData];
                        } failure:^(NSString *msg, NSInteger code) {
                             [MBProgressHUD showError:msg];
                            [weakSelf.tableView.mj_header endRefreshing];
                        } showLoading:nil];
}

- (void)tableGetMore
{
    self.page++;
    HC__weakSelf
    [NetWorkTool requestWithURL:HomeApi_registerNum
                         params:@{@"schoolId": self.schoolId,
                                  @"startDate": self.startDateStr,
                                  @"endDate": self.endDateStr,
                                  @"viewType": self.viewType,
                                  @"page": NSStringFromInt(self.page),
                                  @"rows": @"10"
                                  }
                        toModel:[RegisterNumTableModel class]
                        success:^(RegisterNumTableModel* result) {
                            if (result.rows.count > 0) {
                                 [weakSelf.tableView.mj_footer endRefreshing];
                            }else{
                                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                            }
                            [weakSelf.listArr addObjectsFromArray:result.rows];
                            [weakSelf.tableView reloadData];
                        } failure:^(NSString *msg, NSInteger code) {
                             [MBProgressHUD showError:msg];
                             [weakSelf.tableView.mj_footer endRefreshing];
                        } showLoading:nil];
}

- (void)setViewType:(NSString *)viewType
{
    _viewType = viewType;
    if ([viewType isEqualToString:@"0"]) {
        self.tableView.hidden = NO;
        self.aaChartView.hidden = YES;
        self.tipLb.hidden = YES;
    }else{
        self.tableView.hidden = YES;
        self.aaChartView.hidden = NO;
        self.tipLb.hidden = NO;
    }
}

- (void)setStartDate:(NSDate *)startDate
{
    _startDate = startDate;
    _startDateStr = [[NSDateFormatter ba_setupDateFormatterWithYMD] stringFromDate:startDate];
}

- (void)setEndDate:(NSDate *)endDate
{
    _endDate = endDate;
    _endDateStr = [[NSDateFormatter ba_setupDateFormatterWithYMD] stringFromDate:endDate];
}

- (void)setStartDateStr:(NSString *)startDateStr
{
    _startDateStr = startDateStr;
    _startDate = [[NSDateFormatter ba_setupDateFormatterWithYMD] dateFromString:startDateStr];
}

- (void)setEndDateStr:(NSString *)endDateStr
{
    _endDateStr = endDateStr;
    _endDate = [[NSDateFormatter ba_setupDateFormatterWithYMD] dateFromString:endDateStr];
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
        
        [_tableView registerClass:[RegisterNumTableViewCell class] forCellReuseIdentifier:@"RegisterNumTableViewCell"];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        HC__weakSelf
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf tableRefresh];
        }];
        
        _tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [weakSelf tableGetMore];
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
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegisterNumTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RegisterNumTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = indexPath.row%2 == 0 ? HexColor(@"E3E3E3"):[UIColor whiteColor];
    cell.contentView.backgroundColor = indexPath.row%2 == 0 ? HexColor(@"E3E3E3"):[UIColor whiteColor];
    cell.model = self.listArr[indexPath.row];
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
    NSArray *arr = @[@"学生姓名",@"报名方式",@"报名时间"];
    NSMutableArray * lbs = [NSMutableArray new];
    for (int i = 0; i<3; i++) {
        UILabel *lb = [UILabel new];
        lb.text = arr[i];
        lb.hcTextBlock(DetialColor_666, SystemFont(12),  0);
        [view addSubview:lb];
        CGFloat widthRatio = 0.6/2;
        if (i==0) {
            widthRatio = 0.4;
        }
        
        lb.sd_layout
        .widthRatioToView(view ,widthRatio)
        .topSpaceToView(view, 0)
        .bottomSpaceToView(view, 0)
        .leftSpaceToView(lbs.count>0 ? lbs.lastObject : view, lbs.count>0? 0: 20);
        [lbs addObject:lb];
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)AAChartViewDidFinishLoad
{
    
}

- (void)setChartArr:(NSArray<RegisterNumTable_rowsModel *> *)ChartArr
{
    _ChartArr = ChartArr;
    NSMutableArray *categories = [NSMutableArray new];
    NSMutableArray *dataSet = [NSMutableArray new];
    for (RegisterNumTable_rowsModel *model in ChartArr) {
        [categories addObject:model.name];
        [dataSet addObject:[NSNumber numberWithString:model.count]];
    }
    self.aaChartModel.seriesSet(@[
                 AASeriesElement.new
                 .nameSet(@"报名人数")
                 .dataSet(dataSet)
                 .colorSet((id)[AAGradientColor configureGradientColorWithStartColorString:@"46ADFF" endColorString:@"00DFD2"])
                 .allowPointSelectSet(YES)
                 ]
                                ).legendEnabledSet(NO);
    ;
    self.aaChartModel.categories = categories;//设置 X 轴坐标文字内容
    
    CGFloat chartViewWidth  = self.view.frame.size.width - 15 * 2;
    self.aaChartView.contentWidth = chartViewWidth*(categories.count/20.0 < 1? 1:categories.count/20.0);
    [self.aaChartView aa_drawChartWithChartModel:_aaChartModel];
    
}


@end
