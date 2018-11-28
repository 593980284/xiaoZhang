//
//  ToolMacro.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/11/28.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#ifndef ToolMacro_h
#define ToolMacro_h

#define  HC_systemVersion  [[UIDevice currentDevice].systemVersion floatValue]
#define  HC_windowWidth    [UIScreen mainScreen].bounds.size.width
#define  HC_windowHeight   [UIScreen mainScreen].bounds.size.height
#define  HC_iPhoneX        ((HC_windowWidth == 375.f && HC_windowHeight == 812.f) ||(HC_windowHeight == 375.f && HC_windowWidth == 812.f))
#define  HC_iPhoneXS       ((HC_windowWidth == 414.f && HC_windowHeight == 896.f) ||(HC_windowHeight == 414.f && HC_windowWidth == 896.f))
#define  HC_statusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define  HC_safeBottom     [[UIApplication sharedApplication] statusBarFrame].size.height == 44 ? 34 : 0
#define  HC_naviHeight     [[UIApplication sharedApplication] statusBarFrame].size.height + 44

#endif /* ToolMacro_h */
