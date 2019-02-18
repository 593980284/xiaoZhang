//
//  AppointmentNumModel.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/14.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface AppointmentNum_ListModel : NSObject
@property(nonatomic, copy)NSString *count;
@property(nonatomic, copy)NSString *name;
@end
NS_ASSUME_NONNULL_BEGIN

@interface AppointmentNumModel : NSObject
/** 预约人数相关数据*/
@property(nonatomic, strong)NSArray<AppointmentNum_ListModel *> *appointmentOnline;
/** 在线约课相关数据*/
@property(nonatomic, strong)NSArray<AppointmentNum_ListModel *> *appointmentReserve;
/** 取消人数相关数据*/
@property(nonatomic, strong)NSArray<AppointmentNum_ListModel *> *appointmentCancel;
@end

NS_ASSUME_NONNULL_END
