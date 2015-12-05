//
//	HomeDataModelData.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "HomeDataModelData.h"

@interface HomeDataModelData ()
@end
@implementation HomeDataModelData




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"applystudentcount"] isKindOfClass:[NSNull class]]){
		self.applystudentcount = dictionary[@"applystudentcount"];
	}	
	if(![dictionary[@"coachcoursenow"] isKindOfClass:[NSNull class]]){
		self.coachcoursenow = dictionary[@"coachcoursenow"];
	}	
	if(![dictionary[@"coachstotalcoursecount"] isKindOfClass:[NSNull class]]){
		self.coachstotalcoursecount = dictionary[@"coachstotalcoursecount"];
	}	
	if(![dictionary[@"commentstudentcount"] isKindOfClass:[NSNull class]]){
		self.commentstudentcount = [[HomeDataModelCommentstudentcount alloc] initWithDictionary:dictionary[@"commentstudentcount"]];
	}

	if(![dictionary[@"complaintstudentcount"] isKindOfClass:[NSNull class]]){
		self.complaintstudentcount = dictionary[@"complaintstudentcount"];
	}	
	if(![dictionary[@"coursestudentnow"] isKindOfClass:[NSNull class]]){
		self.coursestudentnow = dictionary[@"coursestudentnow"];
	}	
	if(![dictionary[@"finishreservationnow"] isKindOfClass:[NSNull class]]){
		self.finishreservationnow = dictionary[@"finishreservationnow"];
	}	
	if(![dictionary[@"reservationcoursecountday"] isKindOfClass:[NSNull class]]){
		self.reservationcoursecountday = dictionary[@"reservationcoursecountday"];
	}	
	if(dictionary[@"schoolstudentcount"] != nil && [dictionary[@"schoolstudentcount"] isKindOfClass:[NSArray class]]){
		NSArray * schoolstudentcountDictionaries = dictionary[@"schoolstudentcount"];
		NSMutableArray * schoolstudentcountItems = [NSMutableArray array];
		for(NSDictionary * schoolstudentcountDictionary in schoolstudentcountDictionaries){
			HomeDataModelSchoolstudentcount * schoolstudentcountItem = [[HomeDataModelSchoolstudentcount alloc] initWithDictionary:schoolstudentcountDictionary];
			[schoolstudentcountItems addObject:schoolstudentcountItem];
		}
		self.schoolstudentcount = schoolstudentcountItems;
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
	if(self.coachcoursenow != nil){
		dictionary[@"coachcoursenow"] = self.coachcoursenow;
	}
	if(self.coachstotalcoursecount != nil){
		dictionary[@"coachstotalcoursecount"] = self.coachstotalcoursecount;
	}
	if(self.commentstudentcount != nil){
		dictionary[@"commentstudentcount"] = [self.commentstudentcount toDictionary];
	}
	if(self.complaintstudentcount != nil){
		dictionary[@"complaintstudentcount"] = self.complaintstudentcount;
	}
	if(self.coursestudentnow != nil){
		dictionary[@"coursestudentnow"] = self.coursestudentnow;
	}
	if(self.finishreservationnow != nil){
		dictionary[@"finishreservationnow"] = self.finishreservationnow;
	}
	if(self.reservationcoursecountday != nil){
		dictionary[@"reservationcoursecountday"] = self.reservationcoursecountday;
	}
	if(self.schoolstudentcount != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(HomeDataModelSchoolstudentcount * schoolstudentcountElement in self.schoolstudentcount){
			[dictionaryElements addObject:[schoolstudentcountElement toDictionary]];
		}
		dictionary[@"schoolstudentcount"] = dictionaryElements;
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
	if(self.coachcoursenow != nil){
		[aCoder encodeObject:self.coachcoursenow forKey:@"coachcoursenow"];
	}
	if(self.coachstotalcoursecount != nil){
		[aCoder encodeObject:self.coachstotalcoursecount forKey:@"coachstotalcoursecount"];
	}
	if(self.commentstudentcount != nil){
		[aCoder encodeObject:self.commentstudentcount forKey:@"commentstudentcount"];
	}
	if(self.complaintstudentcount != nil){
		[aCoder encodeObject:self.complaintstudentcount forKey:@"complaintstudentcount"];
	}
	if(self.coursestudentnow != nil){
		[aCoder encodeObject:self.coursestudentnow forKey:@"coursestudentnow"];
	}
	if(self.finishreservationnow != nil){
		[aCoder encodeObject:self.finishreservationnow forKey:@"finishreservationnow"];
	}
	if(self.reservationcoursecountday != nil){
		[aCoder encodeObject:self.reservationcoursecountday forKey:@"reservationcoursecountday"];
	}
	if(self.schoolstudentcount != nil){
		[aCoder encodeObject:self.schoolstudentcount forKey:@"schoolstudentcount"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.applystudentcount = [aDecoder decodeObjectForKey:@"applystudentcount"];
	self.coachcoursenow = [aDecoder decodeObjectForKey:@"coachcoursenow"];
	self.coachstotalcoursecount = [aDecoder decodeObjectForKey:@"coachstotalcoursecount"];
	self.commentstudentcount = [aDecoder decodeObjectForKey:@"commentstudentcount"];
	self.complaintstudentcount = [aDecoder decodeObjectForKey:@"complaintstudentcount"];
	self.coursestudentnow = [aDecoder decodeObjectForKey:@"coursestudentnow"];
	self.finishreservationnow = [aDecoder decodeObjectForKey:@"finishreservationnow"];
	self.reservationcoursecountday = [aDecoder decodeObjectForKey:@"reservationcoursecountday"];
	self.schoolstudentcount = [aDecoder decodeObjectForKey:@"schoolstudentcount"];
	return self;

}
@end