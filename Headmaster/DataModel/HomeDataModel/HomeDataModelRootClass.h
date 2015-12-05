#import <UIKit/UIKit.h>
#import "HomeDataModelData.h"

@interface HomeDataModelRootClass : NSObject

@property (nonatomic, strong) HomeDataModelData * data;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, assign) NSInteger type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end