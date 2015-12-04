//
//  PublishDataModel.h
//  Headmaster
//
//  Created by 胡东苑 on 15/12/4.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublishDataModel : NSObject

/*
 {
 "bulletinid": "5660ee93f35553011c45f514",
 "content": "今天happy一下",
 "createtime": "2015-12-03T09:48:52.464Z",
 "bulletobject": 1,
 "seqindex": 13
 }
 */

@property (nonatomic, copy) NSString * bulletinid;

@property (nonatomic, copy) NSString * content;

@property (nonatomic, copy) NSString * createtime;

@property (nonatomic, copy) NSString * bulletobject;

@property (nonatomic, copy) NSString * seqindex;

- (instancetype)initWithDictionary:(id)dictionary;

+ (PublishDataModel *)converJsonDicToModel:(NSDictionary *)dic;

@end
