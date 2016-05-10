//
//	JZCommentRootClass.h
//
//	Create by ytzhang on 9/5/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "JZCommentData.h"

@interface JZCommentRootClass : NSObject

@property (nonatomic, strong) JZCommentData * data;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, assign) NSInteger type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end