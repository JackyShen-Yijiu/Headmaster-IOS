#import <UIKit/UIKit.h>
#import "DataDetailDMMonthData.h"

@interface DataDetailDMMonthRootClass : NSObject

@property (nonatomic, strong) DataDetailDMMonthData * data;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, assign) NSInteger type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end