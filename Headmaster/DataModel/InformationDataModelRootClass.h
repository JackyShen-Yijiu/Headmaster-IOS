//
//  InformationDataModelRootClass.h
//  Headmaster
//
//  Created by 大威 on 15/12/3.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InformationDataModel.h"

@interface InformationDataModelRootClass : NSObject

@property (nonatomic, strong) NSArray *data;

- (instancetype)initWithJsonDict:(id)dictionary;

@end
