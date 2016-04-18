//
//	HomeDataDetailDMReservationstudentlist.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "HomeDataDetailDMReservationstudentlist.h"

@interface HomeDataDetailDMReservationstudentlist ()
@end
@implementation HomeDataDetailDMReservationstudentlist




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"hour"] isKindOfClass:[NSNull class]]){
		self.hour = [dictionary[@"hour"] integerValue];
	}	
	if(![dictionary[@"studentcount"] isKindOfClass:[NSNull class]]){
		self.studentcount = [dictionary[@"studentcount"] integerValue];
	}	
	return self;
}
@end