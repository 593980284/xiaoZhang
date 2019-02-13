//
//  CoachTableViewCell.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/10.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CoachTableViewCell : UITableViewCell
@property(nonatomic, strong)CourseModel* model;
@end

NS_ASSUME_NONNULL_END
