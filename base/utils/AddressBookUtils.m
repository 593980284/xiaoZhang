//
//  AddressBookUtils.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/12/1.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "AddressBookUtils.h"
@implementation HCContact
@end
@implementation AddressBookUtils
+ (NSArray<CNContact *> *)getAllPeopleInfo{
    // 1.获取授权状态
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    
    // 2.如果是已经授权,才能获取联系人
    if (status != CNAuthorizationStatusAuthorized) return @[];
    
    CNContactStore * store = [CNContactStore new];
    NSArray<CNContact *> * peopleArray = [store unifiedContactsMatchingPredicate:nil keysToFetch:@[@"givenName",
                                                                                      @"phoneNumbers",
                                                                                      @"thumbnailImageData",
                                                                                      @"familyName"] error:nil];
    return peopleArray;
}

+ (NSArray <HCContact *> *)getAllPeopleInfoToModel
{
    NSArray *peopleArray = [self getAllPeopleInfo];
    NSMutableArray *array = [NSMutableArray new];
    for (CNContact *model in peopleArray) {
        HCContact *contact = [HCContact new];
        contact.givenName = model.givenName;
        contact.thumbnailImageData = model.thumbnailImageData;
        contact.familyName = model.familyName;
        contact.phoneNumbers = [self translation1:model.phoneNumbers];
        [array addObject:contact];
    }
    return [array copy];
}

/**
 phoneNumbers
 */
+ (NSArray *)translation1:(NSArray<CNLabeledValue*> *) dataArr{
    NSMutableArray *arr = [NSMutableArray new];
    for(CNLabeledValue * value in dataArr){
        [arr addObject:[value.value stringValue]];
    }
    return [arr copy];
}
@end
