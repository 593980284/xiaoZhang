//
//  Constant.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/11/28.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#ifndef Constant_h
#define Constant_h
//处于开发测试阶段
#ifdef DEBUG
#define kBaseUrl @"http://111.39.245.156:8087/app/lexiang/"
//处于发布正式阶段
#else
#define kBaseUrl @"http://112.2.0.75:9001/app/lexiang/"
#endif

#define HexColor(x)  [UIColor colorWithHexString:x]
#define LineColor    [UIColor colorWithHexString:@"aaaaaa"]
#define LineHeight   0.5

#endif /* Constant_h */

