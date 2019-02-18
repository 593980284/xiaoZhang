//
//  AppointmentNumVC.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/14.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "AppointmentNumVC.h"
#import <BAPickView_OC.h>
#import "AAChartKit.h"
#import "AppointmentNumModel.h"
#import "SelectView.h"
@interface AppointmentNumVC ()
@property(nonatomic, strong)UILabel* startLb;
@property(nonatomic, strong)UILabel* endLb;
@property(nonatomic, strong)NSString *startDateStr;
@property(nonatomic, strong)NSString *endDateStr;
@property(nonatomic, strong)NSString *schoolId;
@property (nonatomic, strong) AAChartModel  *aaChartModel;
@property (nonatomic, strong) AAChartView  *aaChartView;
@property (nonatomic, strong) AAChartView  *aaChartView_2;
@property (nonatomic, strong) AAChartView  *aaChartView_3;
@property(nonatomic, strong)AppointmentNumModel* model;
@property(nonatomic, strong)UILabel *tipLb;
@end

@implementation AppointmentNumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"在线约课";
    [self setUI];
    //    self.listArr = [NSMutableArray new];
    self.schoolId = [UserStorage shareInstance].getUserModel.schoolId;
    [self reloadData];
    [self hideWithIndex:0];
}
- (void)hideWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            self.aaChartView.hidden = NO;
            self.aaChartView_2.hidden = YES;
            self.aaChartView_3.hidden = YES;
        }
            break;
        case 1:
        {
            self.aaChartView.hidden = YES;
            self.aaChartView_2.hidden = NO;
            self.aaChartView_3.hidden = YES;
        }
            break;
        case 2:
        {
            self.aaChartView.hidden = YES;
            self.aaChartView_2.hidden = YES;
            self.aaChartView_3.hidden = NO;
        }
            break;
            
        default:
            break;
    }
}
- (void)setUI
{
    HC__weakSelf
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    
    SelectView *selectView = [[SelectView alloc]initWithData:@[@"在线约课",@"预约人数",@"取消人数"]];
    selectView.backgroundColor = [UIColor whiteColor];
    selectView.block = ^(NSInteger index) {
        [weakSelf hideWithIndex:index];
    };
    [self.view addSubview:selectView];
    [self.view addSubview:bgView];
    
    selectView.sd_layout
    .topSpaceToView(self.view, HC_naviHeight)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(50);
    bgView.sd_layout
    .topSpaceToView(selectView, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(50);
    
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
    self.aaChartView.frame = CGRectMake( 15, HC_naviHeight + 50 + 10+50, chartViewWidth, chartViewHeight);
    
    self.aaChartView_2 = [[AAChartView alloc]init];
    self.aaChartView_2.frame = CGRectMake( 15, HC_naviHeight + 50 + 10+50, chartViewWidth, chartViewHeight);
    
    self.aaChartView_3 = [[AAChartView alloc]init];
    self.aaChartView_3.frame = CGRectMake( 15, HC_naviHeight + 50 + 10+50, chartViewWidth, chartViewHeight);
    //  self.aaChartView.delegate = self;
    //    设置aaChartVie 的内容高度(content height)
    //    self.aaChartView.contentHeight = chartViewHeight;
    //    设置aaChartVie 的内容宽度(content  width)
    //    self.aaChartView.contentWidth = chartViewWidth*2;
    [self.view addSubview:self.aaChartView_2];
    [self.view addSubview:self.aaChartView_3];
    [self.view addSubview:self.aaChartView];
    self.aaChartView.backgroundColor = [UIColor whiteColor];
    self.aaChartView_2.backgroundColor = [UIColor whiteColor];
    self.aaChartView_3.backgroundColor = [UIColor whiteColor];
    
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


- (void)reloadData
{
    HC__weakSelf
    [NetWorkTool requestWithURL:HomeApi_appointmentNum
                         params:@{@"schoolId": self.schoolId,
                                  @"startDate": self.startDateStr,
                                  @"endDate": self.endDateStr}
                        toModel:[AppointmentNumModel class]
                        success:^(AppointmentNumModel* result) {
                            weakSelf.model = result;
                        }
                        failure:^(NSString *msg, NSInteger code) {
                            [MBProgressHUD showError:msg];
                        } showLoading:@""];
}

- (void)setModel:(AppointmentNumModel *)model
{
    _model = model;
    NSMutableArray *categories = [NSMutableArray new];
    NSMutableArray *appointmentOnlineArr = [NSMutableArray new];
    NSMutableArray *appointmentReserveArr = [NSMutableArray new];
    NSMutableArray *appointmentCancelArr = [NSMutableArray new];
    
    for (AppointmentNum_ListModel *item in model.appointmentOnline) {
        [categories addObject:item.name];
        [appointmentOnlineArr addObject:[NSNumber numberWithString:item.count]];
    }
    
    for (AppointmentNum_ListModel *item in model.appointmentReserve) {
        [appointmentReserveArr addObject:[NSNumber numberWithString:item.count]];
    }
    
    for (AppointmentNum_ListModel *item in model.appointmentCancel) {
        [appointmentCancelArr addObject:[NSNumber numberWithString:item.count]];
    }
    self.aaChartModel.seriesSet(@[
                                  AASeriesElement.new
                                  .nameSet(@"在线约课")
                                  .dataSet(appointmentOnlineArr)
                                  .colorSet((id)[AAGradientColor configureGradientColorWithStartColorString:@"46ADFF" endColorString:@"00DFD2"])
//                                  .allowPointSelectSet(YES)
                                  ]
                                ).legendEnabledSet(NO);
    self.aaChartModel.categories = categories;//设置 X 轴坐标文字内容
    
    CGFloat chartViewWidth  = self.view.frame.size.width - 15 * 2;
    self.aaChartView.contentWidth = chartViewWidth*(categories.count/20.0 < 1? 1:categories.count/20.0);
    self.aaChartView_2.contentWidth = chartViewWidth*(categories.count/20.0 < 1? 1:categories.count/20.0);
    self.aaChartView_3.contentWidth = chartViewWidth*(categories.count/20.0 < 1? 1:categories.count/20.0);
    [self.aaChartView aa_drawChartWithChartModel:_aaChartModel];
    self.aaChartModel.seriesSet(@[
                                  AASeriesElement.new
                                  .nameSet(@"预约人数")
                                  .dataSet(appointmentReserveArr)
                                  .colorSet((id)[AAGradientColor purpleLakeColor])
//                                  .allowPointSelectSet(YES)
                                  ]
                                ).legendEnabledSet(NO);
    [self.aaChartView_2 aa_drawChartWithChartModel:_aaChartModel];
    self.aaChartModel.seriesSet(@[
                                  AASeriesElement.new
                                  .nameSet(@"取消人数")
                                  .dataSet(appointmentCancelArr)
                                  .colorSet((id)[AAGradientColor sanguineColor])
//                                  .allowPointSelectSet(YES)
                                  ]
                                ).legendEnabledSet(NO);
    [self.aaChartView_3 aa_drawChartWithChartModel:_aaChartModel];
}

@end
