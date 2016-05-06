#import <UIKit/UIKit.h>
#import "HomeDataModelCommentstudentcount.h"
#import "HomeDataModelSchoolstudentcount.h"

@interface HomeDataModelData : NSObject

@property (nonatomic, assign) NSInteger applystudentcount;
@property (nonatomic, assign) NSInteger coachcoursenow;
@property (nonatomic, assign) NSInteger coachstotalcoursecount;
@property (nonatomic, strong) HomeDataModelCommentstudentcount * commentstudentcount;
@property (nonatomic, assign) NSInteger complaintstudentcount;
@property (nonatomic, assign) NSInteger coursestudentnow;
@property (nonatomic, assign) NSInteger finishreservationnow;
@property (nonatomic, assign) NSInteger reservationcoursecountday;
@property (nonatomic, strong) NSArray * schoolstudentcount;

@property (nonatomic, strong) NSArray * overstockstudent;
@property (nonatomic, strong) NSArray * passrate;

@end