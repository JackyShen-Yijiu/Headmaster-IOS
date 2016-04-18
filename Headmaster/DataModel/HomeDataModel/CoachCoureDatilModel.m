//
//  CoachCoureDatilModel.m
//  Headmaster
//
//  Created by ytzhang on 15/12/7.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "CoachCoureDatilModel.h"

@implementation CoachCoureDatilModel

/*
 *    "data": [
 {
 "coachid": "562dd2eb15e3999e12327039",
 "name": "王教练",
 "headportrait": {
 "height": "",
 "width": "",
 "thumbnailpic": "",
 "originalpic": "http://7xnjg0.com1.z0.glb.clouddn.com/20151025/183127-.png"
 },
 "starlevel": 5,
 "coursecount": 0,
 "goodcommentcount": 0,
 "badcommentcount": 0,
 "generalcommentcount": 0,
 "complaintcount": 0
 },
 */


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{


}


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
        NSArray *keyArray = [dictionary allKeys];
        for (NSString *key in keyArray) {
            if ([key isEqualToString:@"headportrait"]) {
                NSDictionary *dic = [dictionary objectForKey:key];
                _originalpic = [dic objectForKey:@"originalpic"];
            }
        }
        _coachid = [dictionary objectForKey:@"coachid"];
        _name = [dictionary objectForKey:@"name"];
        _mobile = [dictionary objectForKey:@"mobile"];
        _starlevel = [[dictionary objectForKey:@"starlevel"] integerValue];
        _coursecount = [[dictionary objectForKey:@"coursecount"] integerValue];
        _goodcommentcount = [[dictionary objectForKey:@"goodcommentcount"] integerValue];
        _badcommentcount = [[dictionary objectForKey:@"badcommentcount"] integerValue];
        _generalcommentcount = [[dictionary objectForKey:@"generalcommentcount"] integerValue];
        _complaintcount = [[dictionary objectForKey:@"complaintcount"] integerValue];
}
    return self;
}

@end
