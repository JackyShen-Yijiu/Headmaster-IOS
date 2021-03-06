#import <UIKit/UIKit.h>
#import "JZMailboxCoachid.h"
#import "JZMailboxReplyid.h"

@interface JZMailboxData : NSObject

@property (nonatomic, strong) NSString * _id;
@property (nonatomic, strong) JZMailboxCoachid * coachid;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * createtime;
@property (nonatomic, strong) NSString * replycontent;
@property (nonatomic, assign) NSInteger replyflag;
@property (nonatomic, strong) JZMailboxReplyid * replyid;
@property (nonatomic, strong) NSString * replytime;
@property (nonatomic, copy) NSString* isRead;
@end