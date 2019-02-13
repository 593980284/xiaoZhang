//
//  ModifyPhoneVC.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/1/30.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, ModifyPhoneStep) {
    ModifyPhoneStepOne,
    ModifyPhoneStepTwo
    
};
@interface ModifyPhoneVC : BaseVC
@property(nonatomic, assign) ModifyPhoneStep step;
@end

NS_ASSUME_NONNULL_END
