#import <UIKit/UIKit.h>

@interface DataDetailDMWeekCoursedata : NSObject

@property (nonatomic, assign) NSInteger coachcount;
@property (nonatomic, assign) NSInteger coursecount;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end