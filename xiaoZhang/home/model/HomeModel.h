//
//  HomeModel.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/1/30.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeModel : NSObject
/**当月：在线约课取消人数*/
@property(nonatomic, assign)NSInteger appointMonthCancelCount;
/**当月：在线约课人数*/
@property(nonatomic, assign)NSInteger appointMonthCount;
/**本日：在线约课取消人数*/
@property(nonatomic, assign)NSInteger appointTodayCancelCount;
/**本日：在线约课人数*/
@property(nonatomic, assign)NSInteger appointTodayCount;
/**当月：考试人数*/
@property(nonatomic, assign)NSInteger examCount;
/**当月：合格人数*/
@property(nonatomic, assign)NSInteger examPass;
/**当月：报名人数*/
@property(nonatomic, assign)NSInteger signUpMonthCount;
/**本日：新增人数/报名人数*/
@property(nonatomic, assign)NSInteger signUpTodayCount;
/**昨日：新增人数*/
@property(nonatomic, assign)NSInteger signUpYesterdayCount;

@end

NS_ASSUME_NONNULL_END
