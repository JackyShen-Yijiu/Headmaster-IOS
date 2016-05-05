#import <UIKit/UIKit.h>
#import "JZComplaintData.h"

@interface JZComplaintRootClass : NSObject

@property (nonatomic, strong) JZComplaintData * data;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, assign) NSInteger type;
@end