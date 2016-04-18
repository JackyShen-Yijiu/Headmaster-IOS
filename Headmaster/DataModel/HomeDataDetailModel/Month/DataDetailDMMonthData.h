#import <UIKit/UIKit.h>
#import "DataDetailDMMonthCoursedata.h"
#import "DataDetailDMMonthDatalist.h"

@interface DataDetailDMMonthData : NSObject

@property (nonatomic, strong) NSArray * coursedata;
@property (nonatomic, strong) NSArray * datalist;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end