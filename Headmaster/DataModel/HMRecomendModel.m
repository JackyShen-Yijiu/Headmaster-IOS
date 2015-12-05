//
//  HMRecomendModel.m
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HMRecomendModel.h"

@implementation HMRecomendModel

+ (HMRecomendModel *)converJsonDicToModel:(NSDictionary *)dic
{
    HMRecomendModel * model = [[HMRecomendModel alloc] init];
    
    model.recomendId = [dic objectStringForKey:@"reservationid"];
    model.recomendContent = [dic  objectStringForKey:@"commentcontent"];
    model.recomendDate = [dic objectStringForKey:@"commenttime"];
    model.rating = [[dic objectForKey:@"commentstarlevel"] floatValue];
    
    NSDictionary* coachInfo = [dic objectInfoForKey:@"coachinfo"];
    model.coaName = [coachInfo objectStringForKey:@"name"];
    model.coaId = [coachInfo objectStringForKey:@"coachid"];
    model.coaPortrait = [HMPortraitInfoModel converJsonDicToModel:[coachInfo objectInfoForKey:@"headportrait"]];

    NSDictionary * stuInfo = [dic objectInfoForKey:@"studentinfo"];
    model.studentid = [stuInfo objectStringForKey:@"userid"];
    model.studendName = [stuInfo objectStringForKey:@"name"];
    model.stuPortrait = [HMPortraitInfoModel converJsonDicToModel:[stuInfo objectInfoForKey:@"headportrait"]];;
    
 
    model.courseName = [[stuInfo objectInfoForKey:@"classtype"] objectStringForKey:@"name"];
//    model.courseType = [[stuInfo objectInfoForKey:@"classtype"] objectStringForKey:@"name"];
    
    return model;
}

@end
