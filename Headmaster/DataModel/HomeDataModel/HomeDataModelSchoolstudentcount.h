#import <UIKit/UIKit.h>

@interface HomeDataModelSchoolstudentcount : NSObject

@property (nonatomic, assign) NSInteger studentcount;
@property (nonatomic, assign) NSInteger subjectid;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end