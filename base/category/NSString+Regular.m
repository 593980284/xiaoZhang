//
//  NSString+Regular.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/12/2.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "NSString+Regular.h"

@implementation NSString (Regular)
- (BOOL)reg_isPhone
{
    NSString * MOBILE = @"^[0-9]{11}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:self];
}

- (BOOL)isEmpty
{
    if (self == nil || self.length == 0) {
        return YES;
    }
    return NO;
}
@end
