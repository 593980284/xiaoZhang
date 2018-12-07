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
#define  HC_tabBarHeight   (HC_iPhoneX ? (49.f+34.f) : 49.f)
#define  HC_750Ratio       HC_windowWidth / 750.0
#define  HC_750Font(x)     [UIFont systemFontOfSize:x / HC_750Ratio]
#define  HC__weakSelf      __weak typeof(self) weakSelf = self;


//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)sharedInstance;

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)sharedInstance { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

#define SINGLETON_FOR_CLASS_Api(className) \
\
+ (className *)sharedInstance { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
NSString *path = [[NSBundle mainBundle]pathForResource:NSStringFromClass([self class])ofType:@"plist"];\
NSData *data = [NSData dataWithContentsOfFile:path];\
NSDictionary *dic = [NSDictionary dictionaryWithPlistData:data];\
shared##className = [self modelWithJSON:dic]; \
}); \
return shared##className; \
}

#endif /* ToolMacro_h */
