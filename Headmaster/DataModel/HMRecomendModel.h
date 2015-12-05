//
//  HMRecomendModel.h
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMPortraitInfoModel.h"

@interface HMRecomendModel : NSObject
@property(nonatomic,strong)NSString * recomendId;
@property(nonatomic,strong)NSString * recomendContent;
@property(nonatomic,strong)NSString * recomendDate;
//@property(nonatomic,strong)NSString * courseType;
@property(nonatomic,strong)NSString * courseName;
@property(nonatomic,assign)CGFloat rating;

@property(nonatomic,strong)NSString * coaId;
@property(nonatomic,strong)NSString * coaName;
@property(nonatomic,strong)HMPortraitInfoModel * coaPortrait;

@property(nonatomic,strong)NSString * studentid;
@property(nonatomic,strong)NSString * studendName;
@property(nonatomic,strong)HMPortraitInfoModel * stuPortrait;

+ (HMRecomendModel *)converJsonDicToModel:(NSDictionary *)dic;
@end
