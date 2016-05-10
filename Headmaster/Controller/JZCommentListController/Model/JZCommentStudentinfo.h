//
//	JZCommentStudentinfo.h
//
//	Create by ytzhang on 9/5/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "JZCommentClasstype.h"
#import "JZCommentHeadportrait.h"

@interface JZCommentStudentinfo : NSObject

@property (nonatomic, strong) JZCommentClasstype * classtype;
@property (nonatomic, strong) JZCommentHeadportrait * headportrait;
@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * userid;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end