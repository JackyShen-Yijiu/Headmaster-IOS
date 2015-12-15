#import <UIKit/UIKit.h>

@interface HomeDataModelCommentstudentcount : NSObject

@property (nonatomic, assign) NSInteger badcomment;
@property (nonatomic, assign) NSInteger generalcomment;
@property (nonatomic, assign) NSInteger goodcommnent;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end