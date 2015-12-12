//
//	HomeDataDetailDMRootClass.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "HomeDataDetailDMRootClass.h"

@interface HomeDataDetailDMRootClass ()
@end
@implementation HomeDataDetailDMRootClass




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    
    if(![dictionary[@"type"] isKindOfClass:[NSNull class]]){
        self.type = [dictionary[@"type"] integerValue];
    }
    if (self.type == 1) {
        
        if(![dictionary[@"data"] isKindOfClass:[NSNull class]]){
            self.data = [[HomeDataDetailDMData alloc] initWithDictionary:dictionary[@"data"]];
        }

        if(![dictionary[@"msg"] isKindOfClass:[NSNull class]]){
            self.msg = dictionary[@"msg"];
        }
    }
	return self;
}
@end