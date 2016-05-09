//
//	JZCommentData.m
//
//	Create by ytzhang on 9/5/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "JZCommentData.h"

@interface JZCommentData ()
@end
@implementation JZCommentData




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"commentcount"] isKindOfClass:[NSNull class]]){
		self.commentcount = [[JZCommentCommentcount alloc] initWithDictionary:dictionary[@"commentcount"]];
	}

	if(dictionary[@"commentlist"] != nil && [dictionary[@"commentlist"] isKindOfClass:[NSArray class]]){
		NSArray * commentlistDictionaries = dictionary[@"commentlist"];
		NSMutableArray * commentlistItems = [NSMutableArray array];
		for(NSDictionary * commentlistDictionary in commentlistDictionaries){
			JZCommentCommentlist * commentlistItem = [[JZCommentCommentlist alloc] initWithDictionary:commentlistDictionary];
			[commentlistItems addObject:commentlistItem];
		}
		self.commentlist = commentlistItems;
	}
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.commentcount != nil){
		dictionary[@"commentcount"] = [self.commentcount toDictionary];
	}
	if(self.commentlist != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(JZCommentCommentlist * commentlistElement in self.commentlist){
			[dictionaryElements addObject:[commentlistElement toDictionary]];
		}
		dictionary[@"commentlist"] = dictionaryElements;
	}
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
	if(self.commentcount != nil){
		[aCoder encodeObject:self.commentcount forKey:@"commentcount"];
	}
	if(self.commentlist != nil){
		[aCoder encodeObject:self.commentlist forKey:@"commentlist"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.commentcount = [aDecoder decodeObjectForKey:@"commentcount"];
	self.commentlist = [aDecoder decodeObjectForKey:@"commentlist"];
	return self;

}
@end