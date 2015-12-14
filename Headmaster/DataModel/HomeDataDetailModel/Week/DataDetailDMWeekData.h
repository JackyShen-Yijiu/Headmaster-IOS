#import <UIKit/UIKit.h>
#import "DataDetailDMWeekCoursedata.h"
#import "DataDetailDMWeekDatalist.h"

@interface DataDetailDMWeekData : NSObject

@property (nonatomic, strong) NSArray * coursedata;
@property (nonatomic, strong) NSArray * datalist;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end