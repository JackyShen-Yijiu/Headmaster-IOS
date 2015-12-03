//
//  HMPorTraitModel.m
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HMPortraitInfoModel.h"

@implementation HMPortraitInfoModel
+ (HMPortraitInfoModel *)converJsonDicToModel:(NSDictionary *)dic
{
    if (!dic || ![dic isKindOfClass:[NSDictionary class]] ||![dic allKeys].count) {
        return nil;
    }
    HMPortraitInfoModel * model = [[HMPortraitInfoModel alloc] init];
    model.originalpic = [dic objectStringForKey:@"originalpic"];
    model.originalpic = @"http://www.ld12.com/upimg358/allimg/c140923/141146256125540-1T5F.jpg";
    return model;
}
@end
