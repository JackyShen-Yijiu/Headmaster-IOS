#import <UIKit/UIKit.h>
#import "HomeDataModelWeeklyData.h"

@interface HomeDataModelWeeklyRootClass : NSObject

@property (nonatomic, strong) HomeDataModelWeeklyData * data;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, assign) NSInteger type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end