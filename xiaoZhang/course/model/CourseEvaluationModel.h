//
//  CourseEvaluationModel.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/12.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CourseEvaluation_listModel;
NS_ASSUME_NONNULL_BEGIN

@interface CourseEvaluationModel : NSObject
/** 教练教学能力评分*/
@property(nonatomic, assign)NSInteger coachAbilityScore;
/** 教练服务态度评分*/
@property(nonatomic, assign)NSInteger coachAttitudeScore;
/** 教练车辆卫生评分*/
@property(nonatomic, assign)NSInteger coachHygieneScore;
@property(nonatomic, copy)NSString *coachLabel;
@property(nonatomic, copy)NSString *coachEvaluationContent;
@property(nonatomic, strong)NSArray<CourseEvaluation_listModel*> *list;
@end

NS_ASSUME_NONNULL_END

@interface CourseEvaluation_listModel : NSObject
@property(nonatomic, copy)NSString *index;
@property(nonatomic, copy)NSString *labelName;
@end
