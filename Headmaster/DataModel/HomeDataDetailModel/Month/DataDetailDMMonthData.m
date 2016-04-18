//
//	DataDetailDMMonthData.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "DataDetailDMMonthData.h"

@interface DataDetailDMMonthData ()
@end
@implementation DataDetailDMMonthData




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[@"coursedata"] != nil && [dictionary[@"coursedata"] isKindOfClass:[NSArray class]]){
		NSArray * coursedataDictionaries = dictionary[@"coursedata"];
		NSMutableArray * coursedataItems = [NSMutableArray array];
		for(NSDictionary * coursedataDictionary in coursedataDictionaries){
			DataDetailDMMonthCoursedata * coursedataItem = [[DataDetailDMMonthCoursedata alloc] initWithDictionary:coursedataDictionary];
			[coursedataItems addObject:coursedataItem];
		}
		self.coursedata = coursedataItems;
	}
	if(dictionary[@"datalist"] != nil && [dictionary[@"datalist"] isKindOfClass:[NSArray class]]){
		NSArray * datalistDictionaries = dictionary[@"datalist"];
		NSMutableArray * datalistItems = [NSMutableArray array];
		for(NSDictionary * datalistDictionary in datalistDictionaries){
			DataDetailDMMonthDatalist * datalistItem = [[DataDetailDMMonthDatalist alloc] initWithDictionary:datalistDictionary];
			[datalistItems addObject:datalistItem];
		}
		self.datalist = datalistItems;
	}
	return self;
}
@end