//
//  TeacherModel.m
//  Headmaster
//
//  Created by kequ on 15/12/1.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "TeacherModel.h"

@implementation TeacherModel
+ (TeacherModel *)converJsonDicToModel:(NSDictionary *)dic
{
    TeacherModel * model = [[TeacherModel alloc] init];
    model.userId = [dic objectStringForKey:@"coachid"];
    model.userName = [dic objectStringForKey:@"name"];
    model.porInfo = [HMPortraitInfoModel converJsonDicToModel:[dic objectInfoForKey:@"headportrait"]];
    model.raring = [[dic objectForKey:@"starlevel"] floatValue];
    return model;
}
@end
