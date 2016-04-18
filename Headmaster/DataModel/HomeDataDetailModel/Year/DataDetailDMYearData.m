//
//	DataDetailDMYearData.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "DataDetailDMYearData.h"

@interface DataDetailDMYearData ()
@end
@implementation DataDetailDMYearData




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
			DataDetailDMYearCoursedata * coursedataItem = [[DataDetailDMYearCoursedata alloc] initWithDictionary:coursedataDictionary];
			[coursedataItems addObject:coursedataItem];
		}
		self.coursedata = coursedataItems;
	}
	if(dictionary[@"datalist"] != nil && [dictionary[@"datalist"] isKindOfClass:[NSArray class]]){
		NSArray * datalistDictionaries = dictionary[@"datalist"];
		NSMutableArray * datalistItems = [NSMutableArray array];
		for(NSDictionary * datalistDictionary in datalistDictionaries){
			DataDetailDMYearDatalist * datalistItem = [[DataDetailDMYearDatalist alloc] initWithDictionary:datalistDictionary];
			[datalistItems addObject:datalistItem];
		}
		self.datalist = datalistItems;
	}
	return self;
}
@end