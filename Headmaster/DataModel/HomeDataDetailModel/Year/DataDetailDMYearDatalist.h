#import <UIKit/UIKit.h>

@interface DataDetailDMYearDatalist : NSObject

@property (nonatomic, assign) NSInteger applystudentcount;
@property (nonatomic, assign) NSInteger badcommentcount;
@property (nonatomic, assign) NSInteger complaintcount;
@property (nonatomic, assign) NSInteger generalcomment;
@property (nonatomic, assign) NSInteger goodcommentcount;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger reservationcoursecount;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end