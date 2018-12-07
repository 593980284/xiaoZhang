//
//  TimerBtn.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/12/2.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TimerBtn : UIButton
@property(nonatomic, copy)NSString *api;
@property(nonatomic, copy)NSString *(^phoneBlock)();
@property(nonatomic, assign)NSInteger seconds;
@property(nonatomic, strong)UIColor *availableColor;
@property(nonatomic, strong)UIColor *unavailableColor;
@end

