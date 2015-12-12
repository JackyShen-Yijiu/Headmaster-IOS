//
//	HomeDataDetailDMApplystuentlist.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "HomeDataDetailDMApplystuentlist.h"

@interface HomeDataDetailDMApplystuentlist ()
@end
@implementation HomeDataDetailDMApplystuentlist




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"applystudentcount"] isKindOfClass:[NSNull class]]){
		self.applystudentcount = [dictionary[@"applystudentcount"] integerValue];
	}	
	if(![dictionary[@"hour"] isKindOfClass:[NSNull class]]){
		self.hour = [dictionary[@"hour"] integerValue];
	}	
	return self;
}
@end