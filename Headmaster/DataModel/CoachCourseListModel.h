//
//  CoachCourseListModel.h
//  Headmaster
//
//  Created by ytzhang on 15/12/6.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoachCourseListModel : NSObject

/*"coachcourselist": [
                    {
                        "coursecount": "int,学时",
                        "coachcount": "int,教练"
                    }
                    ], */

@property (nonatomic,strong) NSArray *coachCourseListArray;
@property (nonatomic,strong) NSString *coursecount;
@property (nonatomic,strong) NSString *coachcount;

@end
