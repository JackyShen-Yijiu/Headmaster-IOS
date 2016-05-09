//
//	JZCommentCommentlist.m
//
//	Create by ytzhang on 9/5/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "JZCommentCommentlist.h"

@interface JZCommentCommentlist ()
@end
@implementation JZCommentCommentlist




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"coachinfo"] isKindOfClass:[NSNull class]]){
		self.coachinfo = [[JZCommentCoachinfo alloc] initWithDictionary:dictionary[@"coachinfo"]];
	}

	if(![dictionary[@"commentcontent"] isKindOfClass:[NSNull class]]){
		self.commentcontent = dictionary[@"commentcontent"];
	}	
	if(![dictionary[@"commentstarlevel"] isKindOfClass:[NSNull class]]){
		self.commentstarlevel = [dictionary[@"commentstarlevel"] integerValue];
	}

	if(![dictionary[@"commenttime"] isKindOfClass:[NSNull class]]){
		self.commenttime = dictionary[@"commenttime"];
	}	
	if(![dictionary[@"reservationid"] isKindOfClass:[NSNull class]]){
		self.reservationid = dictionary[@"reservationid"];
	}	
	if(![dictionary[@"studentinfo"] isKindOfClass:[NSNull class]]){
		self.studentinfo = [[JZCommentStudentinfo alloc] initWithDictionary:dictionary[@"studentinfo"]];
	}

	if(![dictionary[@"subject"] isKindOfClass:[NSNull class]]){
		self.subject = [[JZCommentSubject alloc] initWithDictionary:dictionary[@"subject"]];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.coachinfo != nil){
		dictionary[@"coachinfo"] = [self.coachinfo toDictionary];
	}
	if(self.commentcontent != nil){
		dictionary[@"commentcontent"] = self.commentcontent;
	}
	dictionary[@"commentstarlevel"] = @(self.commentstarlevel);
	if(self.commenttime != nil){
		dictionary[@"commenttime"] = self.commenttime;
	}
	if(self.reservationid != nil){
		dictionary[@"reservationid"] = self.reservationid;
	}
	if(self.studentinfo != nil){
		dictionary[@"studentinfo"] = [self.studentinfo toDictionary];
	}
	if(self.subject != nil){
		dictionary[@"subject"] = [self.subject toDictionary];
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
	if(self.coachinfo != nil){
		[aCoder encodeObject:self.coachinfo forKey:@"coachinfo"];
	}
	if(self.commentcontent != nil){
		[aCoder encodeObject:self.commentcontent forKey:@"commentcontent"];
	}
	[aCoder encodeObject:@(self.commentstarlevel) forKey:@"commentstarlevel"];	if(self.commenttime != nil){
		[aCoder encodeObject:self.commenttime forKey:@"commenttime"];
	}
	if(self.reservationid != nil){
		[aCoder encodeObject:self.reservationid forKey:@"reservationid"];
	}
	if(self.studentinfo != nil){
		[aCoder encodeObject:self.studentinfo forKey:@"studentinfo"];
	}
	if(self.subject != nil){
		[aCoder encodeObject:self.subject forKey:@"subject"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.coachinfo = [aDecoder decodeObjectForKey:@"coachinfo"];
	self.commentcontent = [aDecoder decodeObjectForKey:@"commentcontent"];
	self.commentstarlevel = [[aDecoder decodeObjectForKey:@"commentstarlevel"] integerValue];
	self.commenttime = [aDecoder decodeObjectForKey:@"commenttime"];
	self.reservationid = [aDecoder decodeObjectForKey:@"reservationid"];
	self.studentinfo = [aDecoder decodeObjectForKey:@"studentinfo"];
	self.subject = [aDecoder decodeObjectForKey:@"subject"];
	return self;

}
@end