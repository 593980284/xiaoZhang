//
//  CourseModel.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/9.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "CourseModel.h"
@implementation CourseListModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass
{
   return  @{@"list_1": @"CourseModel",
             @"list_2": @"CourseModel",
             @"list_3": @"CourseModel"
             };
}
@end
@implementation CourseModel
@end
