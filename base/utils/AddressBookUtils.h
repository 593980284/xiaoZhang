//
//  AddressBookUtils.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/12/1.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>
@interface HCContact : NSObject
@property (nonatomic, copy) NSString *givenName;
@property (nonatomic, copy) NSString *familyName;
@property (nonatomic, strong) NSData *thumbnailImageData;
@property (nonatomic, strong) NSArray *phoneNumbers;
@end
@interface AddressBookUtils : NSObject

+ (NSArray <HCContact *> *)getAllPeopleInfoToModel;

+ (NSArray <CNContact *> *)getAllPeopleInfo;
@end

