//
//  RefreshTableView.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/12/2.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "RefreshTableView.h"
@interface RefreshTableView()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, assign)NSInteger currentPage;
@end
@implementation RefreshTableView
- (void)refreshData
{
    self.currentPage = 1;
    [self getData];
}

- (void)getMoreData
{
    self.currentPage ++;
    [self getData];
}

- (void)getData
{
    NSMutableDictionary *params = [self.params mutableCopy];
    [params setObject:NSStringFromInt(self.currentPage) forKey:self.pageKey];
    [params setObject:NSStringFromInt(self.size) forKey:self.sizeKey];
    HC__weakSelf;
    [NetWorkTool requestWithURL:self.api params:params toModel:nil success:^(id result) {
        
    } failure:^(NSString *msg, NSInteger code) {
        
    } showLoading:nil];
}
@end
