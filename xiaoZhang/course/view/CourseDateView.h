//
//  CourseDateView.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/9.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseDateView : UIView
@property(nonatomic, strong)NSArray* dateArr;
@property(nonatomic, copy)void(^tapBlock)(NSString *dataStr);
@end

NS_ASSUME_NONNULL_END
