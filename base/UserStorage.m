//
//  UserStorage.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/11/27.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "UserStorage.h"

static NSString * userKey = @"userKey_____HC";
static UserStorage * _instance = nil;
static NSString * storageSubPath = @"/Documents/userData_HC_";

@implementation UserModel

@end
@interface UserStorage()
@property(nonatomic, strong)YYKVStorage * storage;
@end
@implementation UserStorage
+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance =  [[self alloc]init];
        NSString * homedirectorypath =NSHomeDirectory();
        NSString * storagePath =[homedirectorypath stringByAppendingString:storageSubPath];
        _instance.storage = [[YYKVStorage alloc]initWithPath:storagePath type:YYKVStorageTypeMixed];
        NSLog(@"%@",storagePath);
    }) ;
    return _instance ;
}
- (UserModel *)getUserModel{
    YYKVStorageItem* item = [_storage getItemForKey:userKey];
    if (item.value.length > 0) {
        return [UserModel modelWithJSON:item.value];
    }else{
        return nil;
    }
}
- (void)saveUserData:(id)data{
    BOOL available = NO;
    if ([data isKindOfClass:[NSDictionary class]] || [data isKindOfClass:[NSMutableDictionary class]]) {
        data = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
        available = YES;
    }else if ([data isKindOfClass:[UserModel class]]){
        UserModel * model = (UserModel *) data;
        data = [model modelToJSONData];
        available = YES;
    }else if([data isKindOfClass:[NSData class]]){
        available = YES;
    }
    NSAssert(available, @"saveUserData: 只支持NSDictionary UserModel NSData");
    if(available){
    [_storage saveItemWithKey:userKey value:data];
        
    }
}

- (void)removeUserData{
    [_storage removeAllItems];
}
@end
