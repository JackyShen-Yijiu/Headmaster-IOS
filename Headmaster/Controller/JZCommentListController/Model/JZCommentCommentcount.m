//
//	JZCommentCommentcount.m
//
//	Create by ytzhang on 9/5/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "JZCommentCommentcount.h"

@interface JZCommentCommentcount ()
@end
@implementation JZCommentCommentcount




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"badcomment"] isKindOfClass:[NSNull class]]){
		self.badcomment = [dictionary[@"badcomment"] integerValue];
	}

	if(![dictionary[@"generalcomment"] isKindOfClass:[NSNull class]]){
		self.generalcomment = [dictionary[@"generalcomment"] integerValue];
	}

	if(![dictionary[@"goodcommnent"] isKindOfClass:[NSNull class]]){
		self.goodcommnent = [dictionary[@"goodcommnent"] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[@"badcomment"] = @(self.badcomment);
	dictionary[@"generalcomment"] = @(self.generalcomment);
	dictionary[@"goodcommnent"] = @(self.goodcommnent);
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:@(self.badcomment) forKey:@"badcomment"];	[aCoder encodeObject:@(self.generalcomment) forKey:@"generalcomment"];	[aCoder encodeObject:@(self.goodcommnent) forKey:@"goodcommnent"];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.badcomment = [[aDecoder decodeObjectForKey:@"badcomment"] integerValue];
	self.generalcomment = [[aDecoder decodeObjectForKey:@"generalcomment"] integerValue];
	self.goodcommnent = [[aDecoder decodeObjectForKey:@"goodcommnent"] integerValue];
	return self;

}
@end