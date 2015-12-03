//
//  CoachOfCourse.h
//  SingerDataView
//
//  Created by ytzhang on 15/12/1.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^didClick)(UIButton *btn);

@interface CoachOfCourse : UIView

@property (nonatomic,strong) didClick didClick;

@end
