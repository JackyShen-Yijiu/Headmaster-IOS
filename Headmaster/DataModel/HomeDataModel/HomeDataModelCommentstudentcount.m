//
//	HomeDataModelCommentstudentcount.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "HomeDataModelCommentstudentcount.h"

@interface HomeDataModelCommentstudentcount ()
@end
@implementation HomeDataModelCommentstudentcount




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"badcomment"] isKindOfClass:[NSNull class]]){
		self.badcomment = [dictionary[@"badcomment"] integerValue];
	}

	if(![dictionary[@"generalcomment"] isKindOfClass:[NSNull class]]){
		self.generalcomment = [dictionary[@"generalcomment"] integerValue];
	}

	if(![dictionary[@"goodcommnent"] isKindOfClass:[NSNull class]]){
		self.goodcommnent = [dictionary[@"goodcommnent"] integerValue];
	}	
	return self;
}
@end