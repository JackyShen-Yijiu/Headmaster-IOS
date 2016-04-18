#import <UIKit/UIKit.h>
#import "DataDetailDMYearCoursedata.h"
#import "DataDetailDMYearDatalist.h"

@interface DataDetailDMYearData : NSObject

@property (nonatomic, strong) NSArray * coursedata;
@property (nonatomic, strong) NSArray * datalist;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end