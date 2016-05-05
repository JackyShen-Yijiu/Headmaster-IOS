#import <UIKit/UIKit.h>
#import "JZComplaintClasstype.h"
#import "JZComplaintHeadportrait.h"

@interface JZComplaintStudentinfo : NSObject

@property (nonatomic, strong) JZComplaintClasstype * classtype;
@property (nonatomic, strong) JZComplaintHeadportrait * headportrait;
@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * userid;
@end