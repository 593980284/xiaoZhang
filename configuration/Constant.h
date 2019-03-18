//
//  Constant.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/11/28.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#ifndef Constant_h
#define Constant_h
//#define HC_DEBUG YES
//处于开发测试阶段
//#ifdef HC_DEBUG
//#define kBaseUrl @"http://111.39.245.156:8087/app/lexiang/"
//#define kBaseImageUrl @"http://111.39.245.156:8087/"
////处于发布正式阶段
//#else
#define kBaseUrl @"http://112.2.0.75:9001/app/lexiang/"
#define kBaseImageUrl @"http://112.2.0.75:9001/"
//#endif

#define HexColor(x)  [UIColor colorWithHexString:x]
#define SystemFont(x)  [UIFont systemFontOfSize:x]
#define Font(x,y)  [UIFont systemFontOfSize:x weight:y]
#define BlueColor [UIColor colorWithHexString:@"#4498FF"]
#define MainColor [UIColor colorWithHexString:@"#FFFFFF"]
#define LineColor    [UIColor colorWithHexString:@"aaaaaa"]
#define TitleColor_333   [UIColor colorWithHexString:@"333333"]
#define DetialColor_666   [UIColor colorWithHexString:@"666666"]
#define PlaceholderColor_333   [UIColor colorWithHexString:@"999999"]
#define PlaceholderImage   [UIImage imageNamed:@"placeholderimg"]
#define LineHeight   0.5

#endif /* Constant_h */

