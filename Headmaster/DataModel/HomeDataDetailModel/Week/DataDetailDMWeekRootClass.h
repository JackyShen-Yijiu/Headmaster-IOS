#import <UIKit/UIKit.h>
#import "DataDetailDMWeekData.h"

@interface DataDetailDMWeekRootClass : NSObject

@property (nonatomic, strong) DataDetailDMWeekData * data;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, assign) NSInteger type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end