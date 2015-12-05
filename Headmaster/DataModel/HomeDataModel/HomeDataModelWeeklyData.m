//
//	HomeDataModelWeeklyData.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "HomeDataModelWeeklyData.h"

@interface HomeDataModelWeeklyData ()
@end
@implementation HomeDataModelWeeklyData




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"applystudentcount"] isKindOfClass:[NSNull class]]){
		self.applystudentcount = dictionary[@"applystudentcount"];
	}	
	if(![dictionary[@"badcommentcount"] isKindOfClass:[NSNull class]]){
		self.badcommentcount = dictionary[@"badcommentcount"];
	}	
	if(![dictionary[@"coachstotalcoursecount"] isKindOfClass:[NSNull class]]){
		self.coachstotalcoursecount = dictionary[@"coachstotalcoursecount"];
	}	
	if(![dictionary[@"complaintstudentcount"] isKindOfClass:[NSNull class]]){
		self.complaintstudentcount = dictionary[@"complaintstudentcount"];
	}	
	if(![dictionary[@"generalcomment"] isKindOfClass:[NSNull class]]){
		self.generalcomment = dictionary[@"generalcomment"];
	}	
	if(![dictionary[@"goodcommentcount"] isKindOfClass:[NSNull class]]){
		self.goodcommentcount = dictionary[@"goodcommentcount"];
	}	
	if(![dictionary[@"reservationcoursecountday"] isKindOfClass:[NSNull class]]){
		self.reservationcoursecountday = dictionary[@"reservationcoursecountday"];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.applystudentcount != nil){
		dictionary[@"applystudentcount"] = self.applystudentcount;
	}
	if(self.badcommentcount != nil){
		dictionary[@"badcommentcount"] = self.badcommentcount;
	}
	if(self.coachstotalcoursecount != nil){
		dictionary[@"coachstotalcoursecount"] = self.coachstotalcoursecount;
	}
	if(self.complaintstudentcount != nil){
		dictionary[@"complaintstudentcount"] = self.complaintstudentcount;
	}
	if(self.generalcomment != nil){
		dictionary[@"generalcomment"] = self.generalcomment;
	}
	if(self.goodcommentcount != nil){
		dictionary[@"goodcommentcount"] = self.goodcommentcount;
	}
	if(self.reservationcoursecountday != nil){
		dictionary[@"reservationcoursecountday"] = self.reservationcoursecountday;
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
	if(self.applystudentcount != nil){
		[aCoder encodeObject:self.applystudentcount forKey:@"applystudentcount"];
	}
	if(self.badcommentcount != nil){
		[aCoder encodeObject:self.badcommentcount forKey:@"badcommentcount"];
	}
	if(self.coachstotalcoursecount != nil){
		[aCoder encodeObject:self.coachstotalcoursecount forKey:@"coachstotalcoursecount"];
	}
	if(self.complaintstudentcount != nil){
		[aCoder encodeObject:self.complaintstudentcount forKey:@"complaintstudentcount"];
	}
	if(self.generalcomment != nil){
		[aCoder encodeObject:self.generalcomment forKey:@"generalcomment"];
	}
	if(self.goodcommentcount != nil){
		[aCoder encodeObject:self.goodcommentcount forKey:@"goodcommentcount"];
	}
	if(self.reservationcoursecountday != nil){
		[aCoder encodeObject:self.reservationcoursecountday forKey:@"reservationcoursecountday"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.applystudentcount = [aDecoder decodeObjectForKey:@"applystudentcount"];
	self.badcommentcount = [aDecoder decodeObjectForKey:@"badcommentcount"];
	self.coachstotalcoursecount = [aDecoder decodeObjectForKey:@"coachstotalcoursecount"];
	self.complaintstudentcount = [aDecoder decodeObjectForKey:@"complaintstudentcount"];
	self.generalcomment = [aDecoder decodeObjectForKey:@"generalcomment"];
	self.goodcommentcount = [aDecoder decodeObjectForKey:@"goodcommentcount"];
	self.reservationcoursecountday = [aDecoder decodeObjectForKey:@"reservationcoursecountday"];
	return self;

}
@end