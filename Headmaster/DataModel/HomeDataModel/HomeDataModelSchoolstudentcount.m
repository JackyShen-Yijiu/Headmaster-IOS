//
//	HomeDataModelSchoolstudentcount.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "HomeDataModelSchoolstudentcount.h"

@interface HomeDataModelSchoolstudentcount ()
@end
@implementation HomeDataModelSchoolstudentcount




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"studentcount"] isKindOfClass:[NSNull class]]){
		self.studentcount = [dictionary[@"studentcount"] integerValue];
	}

	if(![dictionary[@"subjectid"] isKindOfClass:[NSNull class]]){
		self.subjectid = [dictionary[@"subjectid"] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[@"studentcount"] = @(self.studentcount);
	dictionary[@"subjectid"] = @(self.subjectid);
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
	[aCoder encodeObject:@(self.studentcount) forKey:@"studentcount"];	[aCoder encodeObject:@(self.subjectid) forKey:@"subjectid"];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.studentcount = [[aDecoder decodeObjectForKey:@"studentcount"] integerValue];
	self.subjectid = [[aDecoder decodeObjectForKey:@"subjectid"] integerValue];
	return self;

}
@end