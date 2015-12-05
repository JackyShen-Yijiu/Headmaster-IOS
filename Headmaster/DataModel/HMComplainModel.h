//
//  HMComplainModel.h
//  Headmaster
//
//  Created by kequ on 15/12/5.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMPortraitInfoModel.h"

@interface HMComplainModel : NSObject
@property(nonatomic,strong)NSString * recomendId;
@property(nonatomic,strong)NSString * recomendContent;
@property(nonatomic,strong)NSString * recomendDate;
@property(nonatomic,strong)NSString * courseType;
@property(nonatomic,strong)NSString * courseName;
@property(nonatomic,assign)BOOL isDealDone;

@property(nonatomic,strong)NSString * coaId;
@property(nonatomic,strong)NSString * coaName;
@property(nonatomic,strong)HMPortraitInfoModel * coaPortrait;

@property(nonatomic,strong)NSString * studentid;
@property(nonatomic,strong)NSString * studendName;
@property(nonatomic,strong)HMPortraitInfoModel * stuPortrait;

+ (HMComplainModel *)converJsonDicToModel:(NSDictionary *)dic;
@end
