//
//  TeacherModel.m
//  Headmaster
//
//  Created by kequ on 15/12/1.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "TeacherModel.h"

@implementation TeacherModel
/*
 {
 Seniority = 1;
 carmodel =             {
 code = C1;
 modelsid = 1;
 name = "\U624b\U52a8\U6321\U6c7d\U8f66";
 };
 coachid = 56c1932a1bedd418084c04ec;
 commentcount = 0;
 driveschoolinfo =             {
 id = 562dcc3ccb90f25c3bde40da;
 name = "\U4e00\U6b65\U4e92\U8054\U7f51\U9a7e\U6821";
 };
 headportrait =             {
 height = "";
 originalpic = "";
 thumbnailpic = "";
 width = "";
 };
 "is_shuttle" = 1;
 latitude = "40.096263";
 longitude = "116.127921";
 maxprice = 0;
 minprice = 0;
 mobile = 17603199999;
 name = "\U5f20\U4e1c\U4fa0";
 passrate = 99;
 serverclasslist =             (
 );
 starlevel = 5;
 subject =             (
 {
 "_id" = 56c8578be0b90a9d5c6f53ae;
 name = "\U79d1\U76ee\U4e8c";
 subjectid = 2;
 },
 {
 "_id" = 56c8578be0b90a9d5c6f53ad;
 name = "\U79d1\U76ee\U4e09";
 subjectid = 3;
 }
 );
 },
 },

 
 */
+ (TeacherModel *)converJsonDicToModel:(NSDictionary *)dic
{
    TeacherModel * model = [[TeacherModel alloc] init];
    model.userId = [dic objectStringForKey:@"coachid"];
    model.userName = [dic objectStringForKey:@"name"];
    model.porInfo = [HMPortraitInfoModel converJsonDicToModel:[dic objectInfoForKey:@"headportrait"]];
    model.raring = [[dic objectForKey:@"starlevel"] floatValue];
    model.subjectArray = [dic objectForKey:@"subject"];
    model.mobile = [dic objectForKey:@"mobile"];
    model.passrate = [[dic objectForKey:@"passrate"] integerValue];
    return model;
}
@end
