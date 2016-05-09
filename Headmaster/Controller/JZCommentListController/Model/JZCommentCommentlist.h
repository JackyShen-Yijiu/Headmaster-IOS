//
//	JZCommentCommentlist.h
//
//	Create by ytzhang on 9/5/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "JZCommentCoachinfo.h"
#import "JZCommentStudentinfo.h"
#import "JZCommentSubject.h"

@interface JZCommentCommentlist : NSObject

@property (nonatomic, strong) JZCommentCoachinfo * coachinfo;
@property (nonatomic, strong) NSString * commentcontent;
@property (nonatomic, assign) NSInteger commentstarlevel;
@property (nonatomic, strong) NSString * commenttime;
@property (nonatomic, strong) NSString * reservationid;
@property (nonatomic, strong) JZCommentStudentinfo * studentinfo;
@property (nonatomic, strong) JZCommentSubject * subject;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end