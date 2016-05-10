#import <UIKit/UIKit.h>
#import "JZMailboxCoachid.h"
#import "JZMailboxReplyid.h"

@interface JZMailboxData : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) JZMailboxCoachid * coachid;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * createtime;
@property (nonatomic, strong) NSString * replycontent;
@property (nonatomic, assign) NSInteger replyflag;
@property (nonatomic, strong) JZMailboxReplyid * replyid;
@property (nonatomic, strong) NSString * replytime;
@end