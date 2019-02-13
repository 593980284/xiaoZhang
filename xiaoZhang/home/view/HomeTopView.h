//
//  HomeTopView.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/1/30.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTopView : UIView
-(instancetype)initWithTitles:(NSArray *)titles;
@property(nonatomic, strong)NSArray *values;
@end

NS_ASSUME_NONNULL_END
