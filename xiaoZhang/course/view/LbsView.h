//
//  LbsView.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/12.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseEvaluationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LbsView : UIView
@property(nonatomic, strong)NSArray<CourseEvaluation_listModel *> *data;
@property(nonatomic, copy)NSString *coachLabel;
@end

NS_ASSUME_NONNULL_END
