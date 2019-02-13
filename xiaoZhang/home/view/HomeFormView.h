//
//  HomeFormView.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/6.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeFormView : UIView
-(instancetype)initWithTitle:(NSString *)title;
@property(nonatomic, strong)NSArray *values;
@property(nonatomic, copy)void(^tapBlock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
