//
//  ApplyPermission.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/11/29.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,ApplyPermissionType)
{
    ApplyPermissionTypeWhileLocation,
    ApplyPermissionTypeLocationAlways    
};
@interface ApplyPermission : NSObject
+ (instancetype)sharedInstance;
- (void)applyPermissionWithPermissionType: (ApplyPermissionType) permissionType
                                complete: (void(^)(BOOL isAllow, BOOL isFirst)) complete;
@end

