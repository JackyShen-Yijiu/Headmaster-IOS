#import <UIKit/UIKit.h>
#import "HomeDataDetailDMApplystuentlist.h"
#import "HomeDataDetailDMBadcommentlist.h"
#import "HomeDataDetailDMCoachcourselist.h"
#import "HomeDataDetailDMComplaintlist.h"
#import "HomeDataDetailDMBadcommentlist.h"
#import "HomeDataDetailDMBadcommentlist.h"
#import "HomeDataDetailDMReservationstudentlist.h"

@interface HomeDataDetailDMData : NSObject

@property (nonatomic, strong) NSArray * applystuentlist;
@property (nonatomic, strong) NSArray * badcommentlist;
@property (nonatomic, strong) NSArray * coachcourselist;
@property (nonatomic, strong) NSArray * complaintlist;
@property (nonatomic, strong) NSArray * generalcommentlist;
@property (nonatomic, strong) NSArray * goodcommentlist;
@property (nonatomic, strong) NSArray * reservationstudentlist;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end