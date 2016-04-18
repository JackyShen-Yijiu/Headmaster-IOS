//
//  UserInfoModel.m
//  JewelryApp
//
//  Created by kequ on 15/5/1.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import "UserInfoModel.h"
#import "EaseMob.h"

#define USERINFO_IDENTIFY       @"USERINFO_IDENTIFY"

@implementation UserInfoModel (private)

#pragma mark - StoreDefaults
+ (void)storeData:(id)data forKey:(NSString *)key
{
    NSUserDefaults *defults = [NSUserDefaults standardUserDefaults];
    [defults setObject:data forKey:key];
    [defults synchronize];
}

+ (id)dataForKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * data = [defaults objectForKey:key];
    return data;
}
+ (void)removeDataForKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

@end

@implementation UserInfoModel

+ (UserInfoModel *)defaultUserInfo
{
    static UserInfoModel * userInfoModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!userInfoModel) {
            userInfoModel = [[self alloc] init];
        }
    });
    return userInfoModel;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        if ([[self class] isLogin]) {
            [self loginViewDic:[[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData]];
        }
    }
    return self;
}

+ (BOOL)isLogin
{
    return [[self class] dataForKey:USERINFO_IDENTIFY] != nil;
}

- (void)loginOut
{
    [[self class] removeDataForKey:USERINFO_IDENTIFY];
}

- (BOOL)loginViewDic:(NSDictionary *)info
{
  
    self.userID = [[info objectForKey:@"data"] objectForKey:@"userid"];
    self.portrait = [[info objectForKey:@"data"] objectForKey:@"headportrait"];
    self.name = [[info objectForKey:@"data"] objectForKey:@"name"];
    self.tel = [[info objectForKey:@"data"] objectForKey:@"mobile"];
    self.token = [[info objectForKey:@"data"] objectForKey:@"token"];
    self.schoolId = [[[info objectForKey:@"data"] objectForKey:@"driveschool"] objectForKey:@"schoolid"];
    self.schoolName = [[[info objectForKey:@"data"] objectForKey:@"driveschool"] objectForKey:@"name"];
    self.complaintreminder = [[[[info objectForKey:@"data"] objectForKey:@"usersetting"] objectForKey:@"complaintreminder"] stringValue];
    self.newmessagereminder = [[[[info objectForKey:@"data"] objectForKey:@"usersetting"] objectForKey:@"newmessagereminder"] stringValue];
    self.applyreminder = [[[[info objectForKey:@"data"] objectForKey:@"usersetting"] objectForKey:@"applyreminder"] stringValue];
    

    NSString * mds = [info objectForKey:@"md5Pass"];
    //IM登陆注册
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:self.userID password:mds];
  
    if (![[self class] isLogin]) {
        [[self class] storeData:[info JSONData] forKey:USERINFO_IDENTIFY];
    }
    return YES;
}

- (NSDictionary *)messageExt
{
    if (![[self class] isLogin]) {
        return nil;
    }
    return  @{
              @"userId":[[UserInfoModel defaultUserInfo] userID],
              @"nickName":[[UserInfoModel defaultUserInfo] name],
              @"headUrl":[[UserInfoModel defaultUserInfo] portrait],
              @"userType":@"2"
              };
}

@end
