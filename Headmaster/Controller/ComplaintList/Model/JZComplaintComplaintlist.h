#import <UIKit/UIKit.h>
#import "JZComplaintCoachinfo.h"
#import "JZComplaintComplainthandinfo.h"
#import "JZComplaintStudentinfo.h"

@interface JZComplaintComplaintlist : NSObject

@property (nonatomic, strong) JZComplaintCoachinfo * coachinfo;
@property (nonatomic, strong) NSString * complaintDateTime;
@property (nonatomic, strong) NSString * complaintcontent;
@property (nonatomic, strong) JZComplaintComplainthandinfo * complainthandinfo;
@property (nonatomic, strong) NSString * complaintid;
@property (nonatomic, assign) NSInteger feedbacktype;
@property (nonatomic, assign) NSInteger feedbackusertype;
@property (nonatomic, strong) NSArray * piclistr;
@property (nonatomic, strong) JZComplaintStudentinfo * studentinfo;
@end