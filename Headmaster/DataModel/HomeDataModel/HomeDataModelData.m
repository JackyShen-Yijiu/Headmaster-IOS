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
		self.applystudentcount = [NSString stringWithFormat:@"%@",dictionary[@"applystudentcount"]];
	}	
	if(![dictionary[@"coachcoursenow"] isKindOfClass:[NSNull class]]){
		self.coachcoursenow = [dictionary[@"coachcoursenow"] integerValue];
	}	
	if(![dictionary[@"coachstotalcoursecount"] isKindOfClass:[NSNull class]]){
		self.coachstotalcoursecount = [dictionary[@"coachstotalcoursecount"] integerValue];
	}	
	if(![dictionary[@"commentstudentcount"] isKindOfClass:[NSNull class]]){
		self.commentstudentcount = [[HomeDataModelCommentstudentcount alloc] initWithDictionary:dictionary[@"commentstudentcount"]];
	}

	if(![dictionary[@"complaintstudentcount"] isKindOfClass:[NSNull class]]){
		self.complaintstudentcount = [NSString stringWithFormat:@"%@",dictionary[@"complaintstudentcount"]];
	}	
	if(![dictionary[@"coursestudentnow"] isKindOfClass:[NSNull class]]){
		self.coursestudentnow = [dictionary[@"coursestudentnow"] integerValue];
	}	
	if(![dictionary[@"finishreservationnow"] isKindOfClass:[NSNull class]]){
		self.finishreservationnow = [dictionary[@"finishreservationnow"] integerValue];
	}	
	if(![dictionary[@"reservationcoursecountday"] isKindOfClass:[NSNull class]]){
		self.reservationcoursecountday = [dictionary[@"reservationcoursecountday"] integerValue];
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
@end