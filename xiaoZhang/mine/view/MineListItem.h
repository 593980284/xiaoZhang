//
//  MineListItem.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/1/23.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineListItem : UIView
- (instancetype)initWithImageStr:(NSString *)imageStr
                           title:(NSString *)title
                          target:(id)target
                             sel:(SEL)sel;
@end

NS_ASSUME_NONNULL_END
