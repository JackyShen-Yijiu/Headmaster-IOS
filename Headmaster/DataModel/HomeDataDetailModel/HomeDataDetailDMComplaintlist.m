//
//	HomeDataDetailDMComplaintlist.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "HomeDataDetailDMComplaintlist.h"

@interface HomeDataDetailDMComplaintlist ()
@end
@implementation HomeDataDetailDMComplaintlist




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"complaintcount"] isKindOfClass:[NSNull class]]){
		self.complaintcount = [dictionary[@"complaintcount"] integerValue];
	}
	if(![dictionary[@"hour"] isKindOfClass:[NSNull class]]){
		self.hour = [dictionary[@"hour"] integerValue];
	}	
	return self;
}
@end