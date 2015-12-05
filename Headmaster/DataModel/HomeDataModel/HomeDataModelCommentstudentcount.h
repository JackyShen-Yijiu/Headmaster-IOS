#import <UIKit/UIKit.h>

@interface HomeDataModelCommentstudentcount : NSObject

@property (nonatomic, assign) NSInteger badcomment;
@property (nonatomic, assign) NSInteger generalcomment;
@property (nonatomic, strong) NSString * goodcommnent;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end