//
//  ApplyPermission.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/11/29.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "ApplyPermission.h"
@interface ApplyPermission() <CLLocationManagerDelegate>
@property(nonatomic, strong)CLLocationManager *  locationManager ;
@property(nonatomic, copy) void (^complete)(BOOL, BOOL) ;
@end
@implementation ApplyPermission

+ (instancetype)sharedInstance { \
    static ApplyPermission *_instance = nil;
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[self alloc] init];
    });
    return _instance;
}
-(void)applyPermissionWithPermissionType: (ApplyPermissionType) permissionType
                                complete: (void(^)(BOOL isAllow, BOOL))complete
{
    switch (permissionType) {
        case ApplyPermissionTypeLocationAlways:
        case ApplyPermissionTypeWhileLocation:
            [self applyLocationPermissionWithPermissionType:permissionType complete:complete];
            break;
            
        default:
            break;
    }
}

- (void)applyLocationPermissionWithPermissionType:(ApplyPermissionType)permissionType
                                         complete:(void (^)(BOOL, BOOL))complete
{
    CLAuthorizationStatus  status =  [CLLocationManager authorizationStatus];
    if(status == kCLAuthorizationStatusDenied){
        complete(NO, NO);
    }else if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse){
       complete(YES, NO);
    }else if (status == kCLAuthorizationStatusNotDetermined){
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
        if (permissionType == ApplyPermissionTypeLocationAlways) {
            [_locationManager requestAlwaysAuthorization];
        }else{
            [_locationManager requestWhenInUseAuthorization];
        }
        _complete = complete;
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusDenied) {
        _complete(NO, YES);
    }else if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse){
        _complete(YES, YES);
    }
    
    if (status != kCLAuthorizationStatusNotDetermined) {
        _locationManager = nil;
        _complete = nil;
    }
}
@end
