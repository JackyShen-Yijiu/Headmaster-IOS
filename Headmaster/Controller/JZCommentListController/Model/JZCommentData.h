//
//	JZCommentData.h
//
//	Create by ytzhang on 9/5/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "JZCommentCommentcount.h"
#import "JZCommentCommentlist.h"

@interface JZCommentData : NSObject

@property (nonatomic, strong) JZCommentCommentcount * commentcount;
@property (nonatomic, strong) NSArray * commentlist;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end