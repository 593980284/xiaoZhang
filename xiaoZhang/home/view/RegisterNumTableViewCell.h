//
//  RegisterNumTableViewCell.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/13.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterNumTableModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RegisterNumTableViewCell : UITableViewCell
@property(nonatomic, strong)RegisterNumTable_rowsModel *model;
@property(nonatomic, strong)NSMutableArray<UILabel *> *lbs;
@end

NS_ASSUME_NONNULL_END
