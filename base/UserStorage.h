//
//  UserStorage.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/11/27.
//  Copyright © 2018年 胡胡超. All rights reserved.
//111111111

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property(nonatomic, strong)NSString * phone;

@end


@interface UserStorage : NSObject

+ (instancetype)shareInstance;

- (UserModel *)getUserModel;

/**
 储存用户信息

 @param data 可以 字典 UserModel data
  */
- (void)saveUserData:(id)data;

- (void)removeUserData;

@end

NS_ASSUME_NONNULL_END
