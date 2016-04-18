#import <UIKit/UIKit.h>

@interface HomeDataModelWeeklyData : NSObject

@property (nonatomic, strong) NSString * applystudentcount;
@property (nonatomic, strong) NSString * badcommentcount;
@property (nonatomic, strong) NSString * coachstotalcoursecount;
@property (nonatomic, strong) NSString * complaintstudentcount;
@property (nonatomic, strong) NSString * generalcomment;
@property (nonatomic, strong) NSString * goodcommentcount;
@property (nonatomic, strong) NSString * reservationcoursecountday;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end