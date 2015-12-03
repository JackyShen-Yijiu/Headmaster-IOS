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
    
    model.recomendId = [dic objectStringForKey:@"_id"];
    model.recomendContent = [[dic objectInfoForKey:@"coachcomment"] objectStringForKey:@"commentcontent"];
    model.recomendDate = [[dic objectInfoForKey:@"coachcomment"] objectStringForKey:@"commenttime"];
    model.rating = 3.5f;
    
    NSDictionary* coachInfo = [dic objectInfoForKey:@"coachid"];
    model.coaName = [coachInfo objectStringForKey:@"name"];
    model.coaId = [coachInfo objectStringForKey:@"_id"];
    model.coaPortrait = [HMPortraitInfoModel converJsonDicToModel:[coachInfo objectInfoForKey:@"headportrait"]];

    model.studentid = @"sss";
    model.studendName = @"sss";
    model.stuPortrait = [HMPortraitInfoModel converJsonDicToModel:[coachInfo objectInfoForKey:@"headportrait"]];;
    
    model.recomendContent = @"教课非常帮,教课非常帮,教课非常帮,教课非常帮,教课非常帮";
    model.recomendDate = @"2013-2-05";
    model.courseName = @"科目2";
    model.courseType = @"经济班";
    
    model.coaName = @"教练2";
    model.studendName = @"学生1";
    
    return model;
}

@end
