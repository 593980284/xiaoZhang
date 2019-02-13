//
//  CourseDetailModel.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/11.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "CourseDetailModel.h"

@implementation CourseDetailModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass
{
    return  @{@"list":[StudentModel class]};
}
@end
@implementation StudentModel

@end
