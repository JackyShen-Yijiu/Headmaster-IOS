#import <UIKit/UIKit.h>

@interface HomeDataDetailDMBadcommentlist : NSObject

@property (nonatomic, assign) NSInteger commnetcount;
@property (nonatomic, assign) NSInteger hour;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end