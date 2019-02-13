//
//  CoachDetailView.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/11.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "CoachDetailView.h"
@interface CoachDetailView()
@property(nonatomic, strong)NSMutableArray<UILabel *> *lbs;
@end

@implementation CoachDetailView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        NSArray *titles = @[@"所属驾校：",@"课程科目：",@"绑定车辆：",@"上课日期：",@"课程时间：",
                            @"课程课时：",@"总名额数：",@"已报名额：",@"剩余名额："
                            ];
        _lbs = [NSMutableArray new];
        
        for (int i = 0; i < titles.count; i++) {
            UILabel *titleLb = [UILabel new];
            titleLb.text = titles[i];
            titleLb.hcTextBlock(DetialColor_666, SystemFont(14), 0);
            
            UILabel *valueLb = [UILabel new];
            valueLb.hcTextBlock(TitleColor_333, SystemFont(14), 0);
            
            [self sd_addSubviews:@[titleLb, valueLb]];
            
            titleLb.sd_layout
            .heightIs(30)
            .leftSpaceToView(self, 30)
            .topSpaceToView(self, 30*i);
            [titleLb setSingleLineAutoResizeWithMaxWidth:300];
            
            valueLb.sd_layout
            .heightIs(30)
            .leftSpaceToView(titleLb, 5)
            .topSpaceToView(self, 30*i)
            .rightSpaceToView(self, 0);
            
            [_lbs addObject:valueLb];
        }
        
        [self setupAutoHeightWithBottomView:_lbs.lastObject bottomMargin:0];
    }
    return self;
}

- (void)setCourseDetailModel:(CourseDetailModel *)courseDetailModel
{
    _courseDetailModel = courseDetailModel;
    _lbs[0].text = @"无字段";
    _lbs[1].text = courseDetailModel.subjectName;
    _lbs[2].text = courseDetailModel.carNo;
    _lbs[3].text = courseDetailModel.appointmentDate;
    _lbs[5].text = [NSString stringWithFormat:@"%@小时", courseDetailModel.hours];
}

- (void)setCourseModel:(CourseModel *)courseModel
{
    _courseModel = courseModel;
    _lbs[4].text = courseModel.shortPeriodTime;
    _lbs[6].text = courseModel.maxNum;
    _lbs[7].text = courseModel.appointmentNum;
    _lbs[8].text = courseModel.noAppointmentNum;
    
}
@end
