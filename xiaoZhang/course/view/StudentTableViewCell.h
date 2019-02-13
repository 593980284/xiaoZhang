//
//  StudentTableViewCell.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/11.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface StudentTableViewCell : UITableViewCell
@property(nonatomic, strong)StudentModel *model;
@property(nonatomic, copy)void(^seeEvaluationBlock)(StudentModel *model);
@end

NS_ASSUME_NONNULL_END
