//
//	HomeDataDetailDMCoachcourselist.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "HomeDataDetailDMCoachcourselist.h"

@interface HomeDataDetailDMCoachcourselist ()
@end
@implementation HomeDataDetailDMCoachcourselist




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"coachcount"] isKindOfClass:[NSNull class]]){
		self.coachcount = [dictionary[@"coachcount"] integerValue];
	}	
	if(![dictionary[@"coursecount"] isKindOfClass:[NSNull class]]){
		self.coursecount = [dictionary[@"coursecount"] integerValue];
	}	
	return self;
}
@end