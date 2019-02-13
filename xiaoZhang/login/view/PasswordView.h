//
//  PasswordView.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/12/2.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimerBtn.h"

@interface PasswordView : UIView
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet TimerBtn *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@property (nonatomic, copy) NSString *codeApi;
@property (nonatomic, copy) NSString *commitApi;
@property (nonatomic, copy) void(^finishBlock)(NSDictionary * data);
@end
