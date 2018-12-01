//
//  CourseVC.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/11/28.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "CourseVC.h"
#import "ApplyPermission.h"
#import "AddressBookUtils.h"
@interface CourseVC ()

@end

@implementation CourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[ApplyPermission sharedInstance] applyPermissionWithPermissionType:ApplyPermissionTypeAddressBook complete:^(BOOL isAllow, BOOL isFirst) {
        NSArray * a =  [AddressBookUtils getAllPeopleInfoToModel];
        NSLog(@"%@", a);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
