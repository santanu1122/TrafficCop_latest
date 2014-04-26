//
//  AppDelegate.h
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 05/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "ShowAllReportViewController.h"
#import "DashboardViewController.h"



@class ViewController;
@class HelperClass;

@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate>
{
     UINavigationController *navigationController;
    HelperClass *AppHelper;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) ShowAllReportViewController *reportview;
@property (strong, nonatomic) DashboardViewController *dashBord;

@property (strong, nonatomic) NSString *deviceTokenString;

@property (strong, nonatomic) FBSession *session;

-(void)clearsession;
-(void)SetUpTabbarController;
-(void)RemovetabbarController;
-(void)SetUpTabbarControllerwithcenterView :(UIViewController *)CenterView;

@end
