//
//	JZCommentCommentcount.h
//
//	Create by ytzhang on 9/5/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface JZCommentCommentcount : NSObject

@property (nonatomic, assign) NSInteger badcomment;
@property (nonatomic, assign) NSInteger generalcomment;
@property (nonatomic, assign) NSInteger goodcommnent;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end