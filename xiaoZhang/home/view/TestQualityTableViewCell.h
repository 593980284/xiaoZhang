//
//  TestQualityTableViewCell.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/13.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestQualityModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TestQualityTableViewCell : UITableViewCell
@property(nonatomic, strong)TestQualityModel *model;
@property(nonatomic, strong)NSMutableArray<UILabel *> *lbs;
@property(nonatomic, strong)NSString *num;
@end

NS_ASSUME_NONNULL_END
