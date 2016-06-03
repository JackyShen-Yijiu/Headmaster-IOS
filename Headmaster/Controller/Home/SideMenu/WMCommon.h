//
//  WMCommon.h
//  Headmaster
//
//  Created by ytzhang on 16/5/23.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WMCommon : NSObject

@property (nonatomic, assign) CGFloat screenW;

@property (nonatomic, assign) CGFloat screenH;

@property (nonatomic, assign) state homeState;

+ (instancetype)getInstance;
@end
