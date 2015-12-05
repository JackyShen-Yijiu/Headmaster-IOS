//
//  InformationDataModel.m
//  Headmaster
//
//  Created by 大威 on 15/12/3.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "InformationDataModel.h"

@implementation InformationDataModel

//{
//    "type": 1,
//    "msg": "",
//    "data": [
//             {
//                 "newsid": "5659a2ba46c2e43423b738d9",
//                 "title": "邢台14岁“驾驶员”超载驾车为“练手”",
//                 "logimg": "http://www.bjjatd.com/images/img05.jpg",
//                 "description": "河北新闻网邢台电(燕赵都市报记者张会武 通讯员王宏屹、崔信行)12月1日上午，一少年无证驾驶两轮摩托车超员载人，并在受到执勤民警查纠时强行闯红灯逃离",
//                 "contenturl": "http://www.bjjatd.com/content.aspx?cateid=12&articleid=20",
//                 "createtime": "2015-11-28T12:48:52.977Z",
//                 "seqindex": 7
//             }

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _newsid = [dictionary objectStringForKey:@"newsid"];
        _title = [dictionary objectStringForKey:@"title"];
        _logimg = [dictionary objectStringForKey:@"logimg"];
        _descriptionString = [dictionary objectStringForKey:@"description"];
        _contenturl = [dictionary objectStringForKey:@"contenturl"];
        _createtime = [dictionary objectStringForKey:@"createtime"];
        _seqindex = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"seqindex"]];
    }
    return self;
}

@end
