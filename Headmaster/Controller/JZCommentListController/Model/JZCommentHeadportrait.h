//
//	JZCommentHeadportrait.h
//
//	Create by ytzhang on 9/5/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface JZCommentHeadportrait : NSObject

@property (nonatomic, strong) NSString * height;
@property (nonatomic, strong) NSString * originalpic;
@property (nonatomic, strong) NSString * thumbnailpic;
@property (nonatomic, strong) NSString * width;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end