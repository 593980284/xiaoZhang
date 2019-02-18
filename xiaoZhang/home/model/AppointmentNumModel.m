//
//  AppointmentNumModel.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/14.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "AppointmentNumModel.h"

@implementation AppointmentNumModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass
{
    return  @{@"appointmentOnline": @"AppointmentNum_ListModel",
              @"appointmentReserve": @"AppointmentNum_ListModel",
              @"appointmentCancel": @"AppointmentNum_ListModel"
              };
}
@end

@implementation AppointmentNum_ListModel

@end
