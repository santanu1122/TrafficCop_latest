//
//  AppDelegate.m
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 05/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import "AppDelegate.h"
#import "SideMenuViewController.h"
#import "MFSideMenuContainerViewController.h"
#import "SideMenuViewControllerOne.h"
#import "ViewController.h"
#import "LoginViewController.h"
#import "EditProfileViewController.h"

#import "RecordAudioViewController.h"
#import "ReportBadDriverViewController.h"
#import "AddVehicleDescViewController.h"
#import "LeaderboardViewController.h"
#import "ReportDetailsViewController.h"
#import "HelperClass.h"
#import "SimiarReportViewController.h"


#import "PassWordChange.h"
#import "SimiarReportViewController.h"
#import "EvedenceLockerView.h"
#import "MyallaudioViewController.h"

@implementation AppDelegate

@synthesize navigationController;
@synthesize dashBord;


- (ViewController *)demoController {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
        
    } else {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
    }
    
    return self.viewController;
}

- (UINavigationController *)navigationController {
    
    return [[UINavigationController alloc] initWithRootViewController:[self demoController]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    AppHelper = [[HelperClass alloc] init];
    
//    NSLog(@"The string value:%@",str);
//    if ([str integerValue]>0)
//    {
//        self.dashBord=[[DashboardViewController alloc]initWithNibName:@"DashboardViewController" bundle:nil];
//        [self SetUpTabbarControllerwithcenterView:self.dashBord];
//    }
//    else
//    {
     navigationController=[[UINavigationController alloc]initWithRootViewController:[self demoController]];
     self.window.rootViewController=navigationController;
    //}
    
#warning remove this while create new ipa
    
    NSUserDefaults *UserDefaults = [NSUserDefaults standardUserDefaults];
    [UserDefaults setObject:@"f40432f37e2b5057d6f77a522f64a2013e43f79fd818a8c0dd1402be63f7152" forKey:@"USERDEVICETOKEN"];
    [UserDefaults synchronize];
    
#warning remove this while create new ipa
   
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"faild to get device token %@",error);
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken
{
    self.deviceTokenString = [[[[devToken description]
                           stringByReplacingOccurrencesOfString:@"<"withString:@""]
                          stringByReplacingOccurrencesOfString:@">" withString:@""]
                         stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSUserDefaults *UserDefaults = [NSUserDefaults standardUserDefaults];
    [UserDefaults setObject:self.deviceTokenString forKey:@"USERDEVICETOKEN"];
    [UserDefaults synchronize];
}
-(void)SetUpTabbarController {
    
    SideMenuViewController *leftSideMenuController = [[SideMenuViewController alloc] init];
    SideMenuViewControllerOne *rightSideMenuController = [[SideMenuViewControllerOne alloc] init];
    DashboardViewController *Dashboard = [[DashboardViewController alloc] init];
   
    MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController
                                                    containerWithCenterViewController:Dashboard
                                                    leftMenuViewController:leftSideMenuController
                                                    rightMenuViewController:rightSideMenuController];
    self.window.rootViewController = container;
}

-(void)SetUpTabbarControllerwithcenterView :(UIViewController *)CenterView
{
    
    SideMenuViewController *leftSideMenuController = [[SideMenuViewController alloc] init];
    SideMenuViewControllerOne *rightSideMenuController = [[SideMenuViewControllerOne alloc] init];
    MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController
                                                    containerWithCenterViewController:[[UINavigationController alloc] initWithRootViewController:CenterView]
                                                    leftMenuViewController:leftSideMenuController
                                                    rightMenuViewController:rightSideMenuController];
    self.window.rootViewController = container;
    
}
-(void)RemovetabbarController
{
    
    NSUserDefaults *userDetais=[NSUserDefaults standardUserDefaults];
    [userDetais removeObjectForKey:@"userid"];
    [userDetais synchronize];
    NSLog(@"The value of user detais:%@",[userDetais valueForKey:@"userid"]);
    self.window.rootViewController = [self navigationController];
    
}

-(void)clearsession
{
    [self.session close];
    [FBSession.activeSession closeAndClearTokenInformation];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBSession.activeSession handleOpenURL:url];
        return [FBAppCall handleOpenURL:url
                      sourceApplication:sourceApplication
                        fallbackHandler:^(FBAppCall *call) {
                            NSLog(@"In fallback handler");
        }];
}
@end
