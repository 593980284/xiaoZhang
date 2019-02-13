//
//  UserStorage.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/11/27.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import <Foundation/Foundation.h>
//"schoolId": 140000000111,
//"phone": "18156069602",
//"id": 1,
//"photo": "files/lexiang/schoolmanagerImg/manager_18556506296.png?time=1542433330159",
//"name": "lxadmin",
//"schoolName": "实车测试驾校"

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property(nonatomic, copy)NSString * schoolId;
@property(nonatomic, copy)NSString * phone;
@property(nonatomic, assign)NSInteger  ID;
@property(nonatomic, copy)NSString * photo;
@property(nonatomic, copy)NSString * name;
@property(nonatomic, copy)NSString * schoolName;

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

- (void)saveUserDataWithValue:(id) Value
                       forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
