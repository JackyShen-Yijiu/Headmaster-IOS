//
//	JZCommentCoachinfo.h
//
//	Create by ytzhang on 9/5/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "JZCommentHeadportrait.h"

@interface JZCommentCoachinfo : NSObject

@property (nonatomic, strong) NSString * coachid;
@property (nonatomic, strong) JZCommentHeadportrait * headportrait;
@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * name;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end