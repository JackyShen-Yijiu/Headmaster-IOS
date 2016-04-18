//
//  HomeDataDatailModelRootClass.h
//  Headmaster
//
//  Created by ytzhang on 15/12/6.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeDataDatailModelRootClass : NSObject

@property (nonatomic,strong)NSMutableArray *applyStudentArray;  // 申请学生数量
@property (nonatomic,strong)NSMutableArray *reservationStudentCountArray;  // 预约学生
@property (nonatomic,strong)NSMutableArray *cocoachCoureArray; // 教练授课
@property (nonatomic,strong)NSMutableArray *goodCommentArray; // 好评
@property (nonatomic,strong)NSMutableArray *badCommentArray; // 差评
@property (nonatomic,strong)NSMutableArray *generalCommentArray; // 中评
@property (nonatomic,strong)NSMutableArray *complaintArray; // 投诉

- (instancetype)initWithJsonDict:(id)dictionary;
@end
