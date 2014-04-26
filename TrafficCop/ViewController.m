//
//  ViewController.m
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 05/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import "ViewController.h"
#import "HelperClass.h"
#import <QuartzCore/CoreAnimation.h>
#import "LoginViewController.h"
#import "AppDelegate.h"


@interface ViewController ()
{
    HelperClass *SS;
}
@property (strong, nonatomic) NSTimer *Timer;
@end


@implementation ViewController
@synthesize Timer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self HideNavigationBar];
    
//    HelperClass *obj = [HelperClass SaveVehicleDescDataForReport];
//    obj.VehicleMake = @"This is test Data";
    
    SS = [[HelperClass alloc] init];
    
    // set background view with image
    
    [SS SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    
    // Create logo image
    
    [SS CreateImageviewWithImage:self.view xcord:60 ycord:150 width:200 height:50 backgroundColor:[UIColor clearColor] imageName:GLOBALLOGOIMAGE];
    
    // set indecater and start animating
    
    [SS SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
    
    
    NSUserDefaults *prefss = [NSUserDefaults standardUserDefaults];
    NSString *str=[prefss valueForKey:@"userid"];
    
    if ([str intValue] > 0) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            
            NSString *USERDEVICETOKEN = [prefss objectForKey:@"USERDEVICETOKEN"];
            NSString *Username        = [prefss objectForKey:@"USERNAME"];
            NSString *UserPassword    = [prefss objectForKey:@"PASSWORD"];
            
            
            NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
            [tempDict setObject:Username forKey:@"email_username"];
            [tempDict setObject:UserPassword forKey:@"password"];
            [tempDict setObject:LOGINMODE forKey:@"mode"];
            [tempDict setObject:USERDEVICETOKEN forKey:@"device_token"];
            
            NSString *REturnedURL = [SS CallURLForServerReturn:tempDict URL:LOGINPAGE];
            NSLog(@"userdevicetoken ----- %@",REturnedURL);
            
            NSDictionary *Retrneddata = [SS executeFetch:REturnedURL];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SS HidePopupView];
                
                for (NSDictionary *statData in [Retrneddata objectForKey:@"extraparam"]) {
                    
                    if([[statData objectForKey:@"response"] isEqualToString:GLOBALERRSTRING]) {
                        
                        [self HideIndicator];
                        
                    } else {
                        for (NSDictionary *statDataone in [Retrneddata objectForKey:@"userdetails"]) {
                            
                            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                            [prefs setObject:[statDataone objectForKey:@"first_name"] forKey:@"first_name"];
                            [prefs setObject:[statDataone objectForKey:@"last_name"] forKey:@"last_name"];
                            [prefs setObject:[statDataone objectForKey:@"user_image"] forKey:@"user_image"];
                            [prefs setObject:[statDataone objectForKey:@"userid"] forKey:@"userid"];
                            [prefs setObject:[statDataone objectForKey:@"username"] forKey:@"username"];
                            [prefs setObject:[statDataone objectForKey:@"email"] forKey:@"email"];
                            [prefs setObject:UserPassword forKey:@"password"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            
                            AppDelegate *maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                            DashboardViewController *dashbord=[[DashboardViewController alloc]init];
                            [maindelegate SetUpTabbarControllerwithcenterView:dashbord];
                            
                        }
                    }
                }
            });
        });
    }
    else {
        self.Timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(HideIndicator) userInfo:nil repeats:NO];
    }
}

-(void) HideIndicator
{
    [SS SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
    
    [self GoToLoginview];
}

-(void) GoToLoginview
{
    CATransition* transition = [SS AddAnimationOnView];
    LoginViewController *control1 = [[LoginViewController alloc] init];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController] pushViewController:control1 animated:NO];
}

-(void)HideNavigationBar
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
