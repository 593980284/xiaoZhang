//
//  CourseModel.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/9.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CourseModel;
@interface CourseListModel : NSObject
@property(nonatomic, strong)NSArray<CourseModel *> *list_1;
@property(nonatomic, strong)NSArray<CourseModel *> *list_2;
@property(nonatomic, strong)NSArray<CourseModel *> *list_3;
@end
NS_ASSUME_NONNULL_BEGIN

@interface CourseModel : NSObject
@property(nonatomic, copy)NSString *appointmentId;
@property(nonatomic, copy)NSString *subjectName;
@property(nonatomic, copy)NSString *shortPeriodTime;
@property(nonatomic, copy)NSString *maxNum;
@property(nonatomic, copy)NSString *appointmentNum;
@property(nonatomic, copy)NSString *noAppointmentNum;
@property(nonatomic, copy)NSString *coachName;
@property(nonatomic, copy)NSString *coachPhoto;
@property(nonatomic, copy)NSString *coachSex;
@property(nonatomic, copy)NSString *identity;
@end

NS_ASSUME_NONNULL_END
