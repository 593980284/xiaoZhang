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
        contact.thumbnailImageData = model.thumbnailImageData;
         NSString *  name = [NSString stringWithFormat:@"%@%@",model.familyName,model.givenName];
        contact.name = name;
        if (contact.thumbnailImageData == nil || contact.thumbnailImageData.length == 0) {
            if (name.length > 2) {
                name = [name substringFromIndex:name.length - 2];
            }
          UIImage *image = [self creatPlaceHoderImage:name];
          contact.thumbnailImageData = UIImageJPEGRepresentation(image,1.0f);//第二个参数为压缩倍数
        }
       
        contact.phoneNumbers = [self translation1:model.phoneNumbers];
        [array addObject:contact];
    }
    return [array copy];
}

+ (UIImage *)creatPlaceHoderImage:(NSString *)name{
    UIGraphicsBeginImageContext(CGSizeMake(60, 60));
    CGContextRef context = UIGraphicsGetCurrentContext();//75 150 243
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:75/255.0 green:150/255.0  blue:243/255.0  alpha:1].CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 60, 60));
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSMutableAttributedString *nameStr = [[NSMutableAttributedString alloc]initWithString:name attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20], NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                                                            NSParagraphStyleAttributeName:paragraphStyle
                                                                                                            }];
    [nameStr drawInRect:CGRectMake(0, 19, 60, 22)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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
