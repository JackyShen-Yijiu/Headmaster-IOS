#import <UIKit/UIKit.h>

@interface HomeDataDetailDMApplystuentlist : NSObject

@property (nonatomic, assign) NSInteger applystudentcount;
@property (nonatomic, assign) NSInteger hour;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end