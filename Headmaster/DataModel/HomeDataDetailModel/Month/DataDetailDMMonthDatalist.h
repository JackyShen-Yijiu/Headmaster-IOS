#import <UIKit/UIKit.h>

@interface DataDetailDMMonthDatalist : NSObject

@property (nonatomic, assign) NSInteger applystudentcount;
@property (nonatomic, assign) NSInteger badcommentcount;
@property (nonatomic, assign) NSInteger complaintcount;
@property (nonatomic, assign) NSInteger generalcomment;
@property (nonatomic, assign) NSInteger goodcommentcount;
@property (nonatomic, assign) NSInteger reservationcoursecount;
@property (nonatomic, assign) NSInteger weekindex;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end