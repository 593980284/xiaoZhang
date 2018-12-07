//
//  RefreshTableView.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/12/2.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefreshTableView : UITableView
@property (nonatomic, copy) NSString* api;
@property (nonatomic, strong) NSDictionary* params;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) Class cellClass;

@property (nonatomic, assign) CGFloat sectionHeight;
@property (nonatomic, copy) NSString* sectionKey;
@property (nonatomic, copy) NSString* pageKey;
@property (nonatomic, copy) NSString* sizeKey;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) NSInteger page;
@end

