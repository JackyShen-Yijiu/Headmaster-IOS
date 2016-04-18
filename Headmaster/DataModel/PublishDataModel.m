//
//  PublishDataModel.m
//  Headmaster
//
//  Created by 胡东苑 on 15/12/4.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "PublishDataModel.h"

@implementation PublishDataModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _bulletinid = [dictionary objectStringForKey:@"bulletinid"];
        _content = [dictionary objectStringForKey:@"content"];
        _createtime = [dictionary objectStringForKey:@"createtime"];
        _bulletobject = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"bulletobject"]];
        _seqindex = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"seqindex"]];
        
    }
    return self;
}

+ (PublishDataModel *)converJsonDicToModel:(NSDictionary *)dic
{
    PublishDataModel * model = [[PublishDataModel alloc] init];
    model.bulletinid = [dic objectStringForKey:@"bulletinid"];
    model.content = [dic objectStringForKey:@"content"];
    model.createtime = [dic objectStringForKey:@"createtime"];
    model.bulletobject = [NSString stringWithFormat:@"%@",[dic objectForKey:@"bulletobject"]];
    model.seqindex = [NSString stringWithFormat:@"%@",[dic objectForKey:@"seqindex"]];
    return model;
}

@end
