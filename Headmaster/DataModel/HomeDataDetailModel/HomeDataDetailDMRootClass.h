#import <UIKit/UIKit.h>
#import "HomeDataDetailDMData.h"

@interface HomeDataDetailDMRootClass : NSObject

@property (nonatomic, strong) HomeDataDetailDMData * data;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, assign) NSInteger type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end