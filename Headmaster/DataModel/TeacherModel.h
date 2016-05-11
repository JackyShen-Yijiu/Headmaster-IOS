//
//  TeacherModel.h
//  Headmaster
//
//  Created by kequ on 15/12/1.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMPortraitInfoModel.h"
@interface TeacherModel : NSObject
@property(nonatomic,strong)NSString * userId;
@property(nonatomic,strong)NSString * userName;
@property(nonatomic,strong)HMPortraitInfoModel * porInfo;
@property(nonatomic,assign)CGFloat raring;
@property (nonatomic, strong) NSArray *subjectArray;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, assign) NSInteger passrate;
@property (nonatomic, assign) NSInteger isonline;
@property (nonatomic, assign) NSInteger coursecountr;
+ (TeacherModel *)converJsonDicToModel:(NSDictionary *)dic;
@end
