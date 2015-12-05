#import <UIKit/UIKit.h>
#import "HomeDataModelCommentstudentcount.h"
#import "HomeDataModelSchoolstudentcount.h"

@interface HomeDataModelData : NSObject

@property (nonatomic, strong) NSString * applystudentcount;
@property (nonatomic, strong) NSString * coachcoursenow;
@property (nonatomic, strong) NSString * coachstotalcoursecount;
@property (nonatomic, strong) HomeDataModelCommentstudentcount * commentstudentcount;
@property (nonatomic, strong) NSString * complaintstudentcount;
@property (nonatomic, strong) NSString * coursestudentnow;
@property (nonatomic, strong) NSString * finishreservationnow;
@property (nonatomic, strong) NSString * reservationcoursecountday;
@property (nonatomic, strong) NSArray * schoolstudentcount;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end