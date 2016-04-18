//
//	DataDetailDMYearDatalist.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "DataDetailDMYearDatalist.h"

@interface DataDetailDMYearDatalist ()
@end
@implementation DataDetailDMYearDatalist




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"applystudentcount"] isKindOfClass:[NSNull class]]){
		self.applystudentcount = [dictionary[@"applystudentcount"] integerValue];
	}

	if(![dictionary[@"badcommentcount"] isKindOfClass:[NSNull class]]){
		self.badcommentcount = [dictionary[@"badcommentcount"] integerValue];
	}

	if(![dictionary[@"complaintcount"] isKindOfClass:[NSNull class]]){
		self.complaintcount = [dictionary[@"complaintcount"] integerValue];
	}

	if(![dictionary[@"generalcomment"] isKindOfClass:[NSNull class]]){
		self.generalcomment = [dictionary[@"generalcomment"] integerValue];
	}

	if(![dictionary[@"goodcommentcount"] isKindOfClass:[NSNull class]]){
		self.goodcommentcount = [dictionary[@"goodcommentcount"] integerValue];
	}

	if(![dictionary[@"month"] isKindOfClass:[NSNull class]]){
		self.month = [dictionary[@"month"] integerValue];
	}

	if(![dictionary[@"reservationcoursecount"] isKindOfClass:[NSNull class]]){
		self.reservationcoursecount = [dictionary[@"reservationcoursecount"] integerValue];
	}

	return self;
}
@end