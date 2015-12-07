#import <UIKit/UIKit.h>

@interface HomeDataModelCommentstudentcount : NSObject

@property (nonatomic, assign) NSString * badcomment;
@property (nonatomic, assign) NSString * generalcomment;
@property (nonatomic, strong) NSString * goodcommnent;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end