//
//  RegisterNumTableModel.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/13.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RegisterNumTable_rowsModel;
NS_ASSUME_NONNULL_BEGIN

@interface RegisterNumTableModel : NSObject
@property(nonatomic, strong)NSArray<RegisterNumTable_rowsModel *> *rows;
@property(nonatomic, assign)NSInteger total;
@end

NS_ASSUME_NONNULL_END
@interface RegisterNumTable_rowsModel : NSObject
//表格图才有
@property(nonatomic, copy)NSString *signUpDate;
@property(nonatomic, copy)NSString *signUpType;
@property(nonatomic, copy)NSString *studentName;
//柱状图才有
@property(nonatomic, copy)NSString *count;
@property(nonatomic, copy)NSString *name;
@end
