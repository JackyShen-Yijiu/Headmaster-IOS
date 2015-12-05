//
//  HMComplainModel.m
//  Headmaster
//
//  Created by kequ on 15/12/5.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HMComplainModel.h"

@implementation HMComplainModel


+ (HMComplainModel *)converJsonDicToModel:(NSDictionary *)dic
{
    HMComplainModel * model = [[HMComplainModel alloc] init];
    
    model.recomendId = [dic objectStringForKey:@"reservationid"];
    model.recomendContent = [dic  objectStringForKey:@"complaintcontent"];
    model.recomendDate = [dic objectStringForKey:@"complaintDateTime"];
    model.isDealDone = [[dic objectForKey:@"complainthandlestate"] boolValue];
    
    NSDictionary* coachInfo = [dic objectInfoForKey:@"coachinfo"];
    model.coaName = [coachInfo objectStringForKey:@"name"];
    model.coaId = [coachInfo objectStringForKey:@"coachid"];
    model.coaPortrait = [HMPortraitInfoModel converJsonDicToModel:[coachInfo objectInfoForKey:@"headportrait"]];
    
    NSDictionary * stuInfo = [dic objectInfoForKey:@"studentinfo"];
    model.studentid = [stuInfo objectStringForKey:@"userid"];
    model.studendName = [stuInfo objectStringForKey:@"name"];
    model.stuPortrait = [HMPortraitInfoModel converJsonDicToModel:[stuInfo objectInfoForKey:@"headportrait"]];;
    
    model.courseType = [[stuInfo objectInfoForKey:@"classtype"] objectStringForKey:@"name"];
    model.courseName = [[dic objectInfoForKey:@"subject"] objectStringForKey:@"name"];
    
    return model;
}

@end
