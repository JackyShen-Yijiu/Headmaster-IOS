//
//	HomeDataDetailDMData.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "HomeDataDetailDMData.h"

@interface HomeDataDetailDMData ()
@end
@implementation HomeDataDetailDMData




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if([dictionary objectArrayForKey:@"applystuentlist"]){
		NSArray * applystuentlistDictionaries = dictionary[@"applystuentlist"];
		NSMutableArray * applystuentlistItems = [NSMutableArray array];
		for(NSDictionary * applystuentlistDictionary in applystuentlistDictionaries){
			HomeDataDetailDMApplystuentlist * applystuentlistItem = [[HomeDataDetailDMApplystuentlist alloc] initWithDictionary:applystuentlistDictionary];
			[applystuentlistItems addObject:applystuentlistItem];
		}
		self.applystuentlist = applystuentlistItems;
	}
	if([dictionary objectArrayForKey:@"badcommentlist"]){
		NSArray * badcommentlistDictionaries = dictionary[@"badcommentlist"];
		NSMutableArray * badcommentlistItems = [NSMutableArray array];
		for(NSDictionary * badcommentlistDictionary in badcommentlistDictionaries){
			HomeDataDetailDMBadcommentlist * badcommentlistItem = [[HomeDataDetailDMBadcommentlist alloc] initWithDictionary:badcommentlistDictionary];
			[badcommentlistItems addObject:badcommentlistItem];
		}
		self.badcommentlist = badcommentlistItems;
	}
	if([dictionary objectArrayForKey:@"coachcourselist"]){
		NSArray * coachcourselistDictionaries = dictionary[@"coachcourselist"];
		NSMutableArray * coachcourselistItems = [NSMutableArray array];
		for(NSDictionary * coachcourselistDictionary in coachcourselistDictionaries){
			HomeDataDetailDMCoachcourselist * coachcourselistItem = [[HomeDataDetailDMCoachcourselist alloc] initWithDictionary:coachcourselistDictionary];
			[coachcourselistItems addObject:coachcourselistItem];
		}
		self.coachcourselist = coachcourselistItems;
	}
	if([dictionary objectArrayForKey:@"complaintlist"]){
		NSArray * complaintlistDictionaries = dictionary[@"complaintlist"];
		NSMutableArray * complaintlistItems = [NSMutableArray array];
		for(NSDictionary * complaintlistDictionary in complaintlistDictionaries){
			HomeDataDetailDMComplaintlist * complaintlistItem = [[HomeDataDetailDMComplaintlist alloc] initWithDictionary:complaintlistDictionary];
			[complaintlistItems addObject:complaintlistItem];
		}
		self.complaintlist = complaintlistItems;
	}
	if([dictionary objectArrayForKey:@"generalcommentlist"]){
		NSArray * generalcommentlistDictionaries = dictionary[@"generalcommentlist"];
		NSMutableArray * generalcommentlistItems = [NSMutableArray array];
		for(NSDictionary * generalcommentlistDictionary in generalcommentlistDictionaries){
			HomeDataDetailDMBadcommentlist * generalcommentlistItem = [[HomeDataDetailDMBadcommentlist alloc] initWithDictionary:generalcommentlistDictionary];
			[generalcommentlistItems addObject:generalcommentlistItem];
		}
		self.generalcommentlist = generalcommentlistItems;
	}
	if([dictionary objectArrayForKey:@"goodcommentlist"]){
		NSArray * goodcommentlistDictionaries = dictionary[@"goodcommentlist"];
		NSMutableArray * goodcommentlistItems = [NSMutableArray array];
		for(NSDictionary * goodcommentlistDictionary in goodcommentlistDictionaries){
			HomeDataDetailDMBadcommentlist * goodcommentlistItem = [[HomeDataDetailDMBadcommentlist alloc] initWithDictionary:goodcommentlistDictionary];
			[goodcommentlistItems addObject:goodcommentlistItem];
		}
		self.goodcommentlist = goodcommentlistItems;
	}
	if([dictionary objectArrayForKey:@"goodcommentlist"]){
		NSArray * reservationstudentlistDictionaries = dictionary[@"reservationstudentlist"];
		NSMutableArray * reservationstudentlistItems = [NSMutableArray array];
		for(NSDictionary * reservationstudentlistDictionary in reservationstudentlistDictionaries){
			HomeDataDetailDMReservationstudentlist * reservationstudentlistItem = [[HomeDataDetailDMReservationstudentlist alloc] initWithDictionary:reservationstudentlistDictionary];
			[reservationstudentlistItems addObject:reservationstudentlistItem];
		}
		self.reservationstudentlist = reservationstudentlistItems;
	}
	return self;
}
@end