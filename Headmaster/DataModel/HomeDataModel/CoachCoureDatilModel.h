//
//  CoachCoureDatilModel.h
//  Headmaster
//
//  Created by ytzhang on 15/12/7.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoachCoureDatilModel : NSObject

@property (nonatomic,strong) NSString *coachid;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *originalpic;
@property (nonatomic,assign) NSInteger  starlevel;
@property (nonatomic,assign) NSInteger  coursecount;
@property (nonatomic,assign) NSInteger  goodcommentcount;
@property (nonatomic,assign) NSInteger  badcommentcount;
@property (nonatomic,assign) NSInteger  generalcommentcount;
@property (nonatomic,assign) NSInteger  complaintcount;

- (instancetype)initWithDictionary:(id)dictionary;
@end
