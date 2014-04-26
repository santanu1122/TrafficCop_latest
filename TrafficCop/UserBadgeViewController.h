//
//  UserBadgeViewController.h
//  TrafficCop
//
//  Created by Iphone_2 on 02/04/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserReportObject;
@interface UserBadgeViewController : UIViewController <NSURLConnectionDataDelegate,NSURLConnectionDelegate,UITableViewDelegate,UITableViewDataSource>

@end


@interface UserReportObject : NSObject

@property (nonatomic,retain) NSString *BadgeImage;
@property (nonatomic,retain) NSString *BadgeName;
@property (nonatomic,retain) NSString *BadgePostImageUrl;
@property (nonatomic,retain) NSString *BadgePostText;
@property (nonatomic,retain) NSString *BadgeSiteUrl;

-(id)initWithBadgeImage:(NSString *)ParamBadgeImage BadgeName:(NSString *)ParamBadgeName BadgePostImageUrl:(NSString *)ParamBadgePostImageUrl BadgePostText:(NSString *)ParamBadgePostText BadgeSiteUrl:(NSString *)ParamBadgeSiteUrl;

@end
