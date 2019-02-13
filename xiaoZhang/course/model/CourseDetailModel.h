//
//  CourseDetailModel.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/11.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import <Foundation/Foundation.h>
@class StudentModel;
NS_ASSUME_NONNULL_BEGIN
//"coachName": "水欣欣",
//"coachPhoto": "files/coachimg/20170306_371501197308219544B.jpg",
//"subjectName": "科目一",
//"appointmentDate": "2018-09-26",
//"coachSex": "男",
//"coachStar": "8.0",
//"teachType": "科目一、四",
//"teachAge": "",
//"identity": "",
//"carNo": "",
//"hours": 2,
//1：科目1, 2：科目2, 3：科目3, 4：科目四 23：科目二三
@interface CourseDetailModel : NSObject
@property(nonatomic, copy)NSString *coachName;
@property(nonatomic, copy)NSString *coachPhoto;
@property(nonatomic, copy)NSString *subjectName;
@property(nonatomic, copy)NSString *appointmentDate;
@property(nonatomic, copy)NSString *coachSex;
@property(nonatomic, copy)NSString *noAppointmentNum;
@property(nonatomic, assign)NSInteger coachStar;
@property(nonatomic, copy)NSString *teachType;
@property(nonatomic, copy)NSString *teachAge;
@property(nonatomic, copy)NSString *identity;
@property(nonatomic, copy)NSString *carNo;
@property(nonatomic, copy)NSString *hours;
@property(nonatomic, strong)NSArray<StudentModel *> *list;
@end

NS_ASSUME_NONNULL_END
//"name": "曹二燕",
//"courseRecordId": 59,
//"studentPhoto": "files/stuimg/20170615_152322198507073547B.jpg",
//"subject": 1,
//"isEvaluation": 0
@interface StudentModel : NSObject
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *courseRecordId;
@property(nonatomic, copy)NSString *studentPhoto;
@property(nonatomic, copy)NSString *subject;
@property(nonatomic, assign)NSInteger isEvaluation;
@end
