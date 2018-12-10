//
//  MineListCell.h
//  xiaoZhang
//
//  Created by nick_beibei on 2018/12/8.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineListCell : UIView
-(instancetype)initWithTitle:(NSString *)title;
@property(nonatomic, strong)UIColor *textColor;
@property(nonatomic, strong)UIFont *font;
@end
