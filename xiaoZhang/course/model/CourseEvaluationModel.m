//
//  CourseEvaluationModel.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/12.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "CourseEvaluationModel.h"

@implementation CourseEvaluationModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass
{
    return  @{@"list":[CourseEvaluation_listModel class]};
}
@end

@implementation CourseEvaluation_listModel

@end
