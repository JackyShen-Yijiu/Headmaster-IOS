#import <UIKit/UIKit.h>

@interface HomeDataDetailDMComplaintlist : NSObject

@property (nonatomic, assign) NSInteger complaintcount;
@property (nonatomic, assign) NSInteger hour;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end