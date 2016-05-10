//
//	JZCommentStudentinfo.m
//
//	Create by ytzhang on 9/5/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "JZCommentStudentinfo.h"

@interface JZCommentStudentinfo ()
@end
@implementation JZCommentStudentinfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"classtype"] isKindOfClass:[NSNull class]]){
		self.classtype = [[JZCommentClasstype alloc] initWithDictionary:dictionary[@"classtype"]];
	}

	if(![dictionary[@"headportrait"] isKindOfClass:[NSNull class]]){
		self.headportrait = [[JZCommentHeadportrait alloc] initWithDictionary:dictionary[@"headportrait"]];
	}

	if(![dictionary[@"mobile"] isKindOfClass:[NSNull class]]){
		self.mobile = dictionary[@"mobile"];
	}	
	if(![dictionary[@"name"] isKindOfClass:[NSNull class]]){
		self.name = dictionary[@"name"];
	}	
	if(![dictionary[@"userid"] isKindOfClass:[NSNull class]]){
		self.userid = dictionary[@"userid"];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.classtype != nil){
		dictionary[@"classtype"] = [self.classtype toDictionary];
	}
	if(self.headportrait != nil){
		dictionary[@"headportrait"] = [self.headportrait toDictionary];
	}
	if(self.mobile != nil){
		dictionary[@"mobile"] = self.mobile;
	}
	if(self.name != nil){
		dictionary[@"name"] = self.name;
	}
	if(self.userid != nil){
		dictionary[@"userid"] = self.userid;
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
	if(self.classtype != nil){
		[aCoder encodeObject:self.classtype forKey:@"classtype"];
	}
	if(self.headportrait != nil){
		[aCoder encodeObject:self.headportrait forKey:@"headportrait"];
	}
	if(self.mobile != nil){
		[aCoder encodeObject:self.mobile forKey:@"mobile"];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:@"name"];
	}
	if(self.userid != nil){
		[aCoder encodeObject:self.userid forKey:@"userid"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.classtype = [aDecoder decodeObjectForKey:@"classtype"];
	self.headportrait = [aDecoder decodeObjectForKey:@"headportrait"];
	self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
	self.name = [aDecoder decodeObjectForKey:@"name"];
	self.userid = [aDecoder decodeObjectForKey:@"userid"];
	return self;

}
@end