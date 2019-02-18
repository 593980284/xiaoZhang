//
//  TestQualityModel.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/13.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//"subType" : "xxx",
//"examNum" : "xxx",
//"passNum" : "xxx",
//"passRate"："xxx"
@interface TestQualityModel : NSObject
@property(nonatomic, assign)NSInteger subType;
@property(nonatomic, assign)NSInteger examNum;
@property(nonatomic, assign)NSInteger passNum;
@property(nonatomic, assign)NSInteger passRate;
@end

NS_ASSUME_NONNULL_END
