#import <UIKit/UIKit.h>

@interface HomeDataDetailDMReservationstudentlist : NSObject

@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger studentcount;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end