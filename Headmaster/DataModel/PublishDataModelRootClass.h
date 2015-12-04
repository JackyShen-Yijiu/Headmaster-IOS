//
//  PublishDataModelRootClass.h
//  Headmaster
//
//  Created by 胡东苑 on 15/12/4.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublishDataModel.h"

@interface PublishDataModelRootClass : NSObject

@property (nonatomic, strong) NSArray *data;

- (instancetype)initWithJsonDict:(id)dictionary;

@end
