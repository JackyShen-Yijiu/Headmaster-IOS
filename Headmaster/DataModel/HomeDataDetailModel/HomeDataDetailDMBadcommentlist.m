//
//	HomeDataDetailDMBadcommentlist.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "HomeDataDetailDMBadcommentlist.h"

@interface HomeDataDetailDMBadcommentlist ()
@end
@implementation HomeDataDetailDMBadcommentlist




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"commnetcount"] isKindOfClass:[NSNull class]]){
		self.commnetcount = [dictionary[@"commnetcount"] integerValue];
	}	
	if(![dictionary[@"hour"] isKindOfClass:[NSNull class]]){
		self.hour = [dictionary[@"hour"] integerValue];
	}
	return self;
}
@end