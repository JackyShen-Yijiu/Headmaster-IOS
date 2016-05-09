//
//	JZCommentSubject.h
//
//	Create by ytzhang on 9/5/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface JZCommentSubject : NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger subjectid;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end