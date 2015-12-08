#import <UIKit/UIKit.h>
#import "HomeDataModelCommentstudentcount.h"
#import "HomeDataModelSchoolstudentcount.h"

@interface HomeDataModelData : NSObject

@property (nonatomic, strong) NSString * applystudentcount;
@property (nonatomic, assign) NSInteger coachcoursenow;
@property (nonatomic, assign) NSInteger coachstotalcoursecount;
@property (nonatomic, strong) HomeDataModelCommentstudentcount * commentstudentcount;
@property (nonatomic, strong) NSString * complaintstudentcount;
@property (nonatomic, assign) NSInteger coursestudentnow;
@property (nonatomic, assign) NSInteger finishreservationnow;
@property (nonatomic, assign) NSInteger reservationcoursecountday;
@property (nonatomic, strong) NSArray * schoolstudentcount;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end