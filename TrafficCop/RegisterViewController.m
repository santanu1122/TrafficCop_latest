//
//  RegisterViewController.m
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 06/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import "RegisterViewController.h"
#import <QuartzCore/CoreAnimation.h>
#import "MBHUDView.h"
#import "MFSideMenu.h"
#import "LoginViewController.h"
#import "EditProfileViewController.h"
#import "DashboardViewController.h"
#import "AppDelegate.h"
#import "TermsConditionViewController.h"

@interface RegisterViewController ()<UIAlertViewDelegate>

@end

@implementation RegisterViewController

@synthesize REGScrollview           = _REGScrollview;
@synthesize UserNameField           = _UserNameField;
@synthesize UserEmailField          = _UserEmailField;
@synthesize UserPasswordField       = _UserPasswordField;
@synthesize UserRetypepassField     = _UserRetypepassField;
@synthesize SwitchTerms             = _SwitchTerms;
@synthesize TermsAndCondition       = _TermsAndCondition;
@synthesize AGREETermsAndCondition  = _AGREETermsAndCondition;
@synthesize UserFirstNameField      = _UserFirstNameField;
@synthesize UserLastNameField       = _UserLastNameField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    RegHelperClass = [[HelperClass alloc] init];
    _AGREETermsAndCondition = NO;
    
    //Assigning scrollview property
    
    _REGScrollview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + self.view.frame.size.height/4);
    _REGScrollview.scrollEnabled = YES;
    _REGScrollview.delegate = self;
    _REGScrollview.backgroundColor = [UIColor clearColor];
    _REGScrollview.userInteractionEnabled = YES;
 
    //Assigning background image
    
    
    [RegHelperClass SetViewBackgroundImage:self.view imageName:GLOBALBACKIMAGE];
    [RegHelperClass setTopView:self.view];
    
        
}

/* Validation Start */

-(IBAction)RegButtonClicked:(id)sender {
    //[self movetotop:Nil];
    [self hideKeyboard:Nil];
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    // blank field checking
    
    if(![RegHelperClass CleanTextField:_UserNameField.text].length > 0) {
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Sorry" message:USERNAMEBLANKERR delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertview show];
        
//        alert = [MBAlertView alertWithBody:USERNAMEBLANKERR cancelTitle:@"Cancel" cancelBlock:nil];
//        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
//            
//        
//            
//        }];
//        [alert addToDisplayQueue];
       // [_UserNameField becomeFirstResponder];
        return;
    }
    
    // validate specal character
    
    else if(![RegHelperClass ValidateSpecialCharacter:_UserNameField.text])
    {
//        alert = [MBAlertView alertWithBody:USERNAMESPECLCHR cancelTitle:@"Cancel" cancelBlock:nil];
//        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
//            
//            
//            
//        }];
//        [alert addToDisplayQueue];
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Sorry" message:USERNAMESPECLCHR delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertview show];
        //[_UserNameField becomeFirstResponder];
        return;
    }
    
    // blank field checking
    
    else if(![RegHelperClass CleanTextField:_UserEmailField.text].length > 0) {
//        alert = [MBAlertView alertWithBody:EMAILBLANKERR cancelTitle:@"Cancel" cancelBlock:nil];
//        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
//            
//            
//        }];
//        [alert addToDisplayQueue];
       // [_UserEmailField becomeFirstResponder];
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Sorry" message:EMAILBLANKERR delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertview show];
        return;
    }
    
    // Email Validation
    
    else if([emailTest evaluateWithObject:[RegHelperClass CleanTextField:_UserEmailField.text]] == NO) {
//        alert = [MBAlertView alertWithBody:INVALIEDEMAIL cancelTitle:@"Cancel" cancelBlock:nil];
//        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
//        }];
//        [alert addToDisplayQueue];
        //[_UserEmailField becomeFirstResponder];
        
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Sorry" message:INVALIEDEMAIL delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertview show];
        return;
    }
    
    // blank field checking
    
    else if(![RegHelperClass CleanTextField:_UserPasswordField.text].length > 0) {
//        alert = [MBAlertView alertWithBody:PASSWORDBLANKERR cancelTitle:@"Cancel" cancelBlock:nil];
//        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
//        }];
//        [alert addToDisplayQueue];
        //[_UserPasswordField becomeFirstResponder];
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Sorry" message:PASSWORDBLANKERR delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertview show];
        return;
    }
    
    // password langth checking
    
    else if([RegHelperClass CleanTextField:_UserPasswordField.text].length < 6 || [RegHelperClass CleanTextField:_UserPasswordField.text].length > 12) {
//        alert = [MBAlertView alertWithBody:MINCHRPASS cancelTitle:@"Cancel" cancelBlock:nil];
//        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
//        }];
//        [alert addToDisplayQueue];
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Sorry" message:MINCHRPASS delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertview show];
        //[_UserPasswordField becomeFirstResponder];
        return;
    }
    
    // blank field checking
    
    else if(![RegHelperClass CleanTextField:_UserRetypepassField.text].length > 0) {
//        alert = [MBAlertView alertWithBody:REPASSWORDBLANKERR cancelTitle:@"Cancel" cancelBlock:nil];
//        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
//        }];
//        [alert addToDisplayQueue];
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Sorry" message:REPASSWORDBLANKERR delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertview show];
        //[_UserRetypepassField becomeFirstResponder];
        return;
    }
    
    // password checking
    
    else if(![[RegHelperClass CleanTextField:_UserRetypepassField.text] isEqualToString:[RegHelperClass CleanTextField:_UserPasswordField.text]]) {
//        alert = [MBAlertView alertWithBody:MISMATCHPASSWORD cancelTitle:@"Cancel" cancelBlock:nil];
//        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
//        }];
//        [alert addToDisplayQueue];
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Sorry" message:MISMATCHPASSWORD delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertview show];
       // [_UserRetypepassField becomeFirstResponder];
        return;
    }
    
    // blank field checking
    
    else if(![RegHelperClass CleanTextField:_UserFirstNameField.text].length > 0) {
//        alert = [MBAlertView alertWithBody:FIRSTNAMEBLANKERR cancelTitle:@"Cancel" cancelBlock:nil];
//        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
//        }];
//        [alert addToDisplayQueue];
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Sorry" message:FIRSTNAMEBLANKERR delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertview show];
        
       // [_UserFirstNameField becomeFirstResponder];
        return;
    }
    
    // blank field checking
    
    else if(![RegHelperClass CleanTextField:_UserLastNameField.text].length > 0) {
//        alert = [MBAlertView alertWithBody:LASTNAMEBLANKERR cancelTitle:@"Cancel" cancelBlock:nil];
//        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
//        }];
//        [alert addToDisplayQueue];
        //[_UserLastNameField becomeFirstResponder];
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Sorry" message:LASTNAMEBLANKERR delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertview show];
        return;
    }
    
    // Terms Agreement checking
    
    else if(!_AGREETermsAndCondition) {
//        alert = [MBAlertView alertWithBody:AGREETERMS cancelTitle:@"Cancel" cancelBlock:nil];
//        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
//        }];
//        [alert addToDisplayQueue];
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"Sorry" message:AGREETERMS delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertview show];
        
        return;
    }
    
    // everything Goes fine
    
    else {
        
        [RegHelperClass AddBlackOverlay:self.view xcord:0 ycord:0 width:self.view.frame.size.width height:self.view.frame.size.height backgroundColor:[UIColor blackColor] OpacitY:0.9f Text:@"Please wait" TextColor:[UIColor whiteColor] FontName:globalTEXTFIELDPLACEHOLDERFONT FontSize:18 IsTextEnabled:YES];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
            [tempDict setObject:[RegHelperClass CleanTextField:_UserFirstNameField.text] forKey:@"first_name"];
            [tempDict setObject:[RegHelperClass CleanTextField:_UserLastNameField.text] forKey:@"last_name"];
            [tempDict setObject:[RegHelperClass CleanTextField:_UserNameField.text] forKey:@"username"];
            [tempDict setObject:[RegHelperClass CleanTextField:_UserEmailField.text] forKey:@"email"];
            [tempDict setObject:[RegHelperClass CleanTextField:_UserPasswordField.text] forKey:@"password"];
            [tempDict setObject:REGISTRATIONMODE forKey:@"mode"];
            NSUserDefaults *prefss = [NSUserDefaults standardUserDefaults];
            
            [tempDict setObject:[prefss objectForKey:@"USERDEVICETOKEN"] forKey:@"device_token"];
            
            NSString *REturnedURL = [RegHelperClass CallURLForServerReturn:tempDict URL:LOGINPAGE];
            NSLog(@"REturnedURL --- %@",REturnedURL);
            NSDictionary *Retrneddata = [RegHelperClass executeFetch:REturnedURL];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [RegHelperClass HidePopupView];
                
                for (NSDictionary *statData in [Retrneddata objectForKey:@"extraparam"]) {
                    
                    if([[statData objectForKey:@"response"] isEqualToString:GLOBALERRSTRING]) {
                        alert = [MBAlertView alertWithBody:[statData objectForKey:@"message"] cancelTitle:@"Cancel" cancelBlock:nil];
                        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
                        }];
                        [alert addToDisplayQueue];
                    } else {
                        for (NSDictionary *statDataone in [Retrneddata objectForKey:@"userdetails"]) {
                            
                            
                            alert = [MBAlertView alertWithBody:@"You Have Successfully Registered!" cancelTitle:@"Cancel" cancelBlock:nil];
                            [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
                                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                                [prefs setObject:[statDataone objectForKey:@"first_name"] forKey:@"first_name"];
                                [prefs setObject:[statDataone objectForKey:@"last_name"] forKey:@"last_name"];
                                [prefs setObject:[statDataone objectForKey:@"user_image"] forKey:@"user_image"];
                                [prefs setObject:[statDataone objectForKey:@"userid"] forKey:@"userid"];
                                [prefs setObject:[statDataone objectForKey:@"username"] forKey:@"username"];
                                [prefs setObject:[statDataone objectForKey:@"email"] forKey:@"email"];
                                [prefs setValue:[RegHelperClass CleanTextField:_UserPasswordField.text] forKey:@"password"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                                
                                AppDelegate *maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                                [maindelegate SetUpTabbarController];
                                
                                DashboardViewController *editProfile = [[DashboardViewController alloc] initWithNibName:@"DashboardViewController" bundle:Nil];
                                CATransition* transition = [RegHelperClass AddAnimationOnView];
                                [self.navigationController.view.layer addAnimation:transition forKey:nil];
                                [[self navigationController] pushViewController:editProfile animated:NO];
                                
                            }];
                            [alert addToDisplayQueue];
                            
                        }
                    }
                }
                
            });
        });
        
    }
}

/* Validation end */


-(IBAction)hideKeyboard:(id)sender {
    [(UITextField*)sender resignFirstResponder];
}
-(IBAction)movetozero:(id)sender {
    [(UITextField*)sender resignFirstResponder];
    [_REGScrollview setContentOffset:CGPointZero animated:YES];
}
-(IBAction)movetotop:(id)sender {
    [_REGScrollview setContentOffset:CGPointMake(0, 100) animated:YES];
}
-(IBAction)movetotopone:(id)sender {
    [_REGScrollview setContentOffset:CGPointMake(0, 150) animated:YES];
}
-(IBAction)ChangeSwitchValue:(id)sender {
    
    if(_SwitchTerms.isOn)
        _AGREETermsAndCondition = YES;
    else
        _AGREETermsAndCondition = NO;
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //[_REGScrollview setContentOffset:CGPointMake(0, 0)];
}
-(IBAction)goBack:(id)sender {
    
    CATransition* transition = [RegHelperClass AddAnimationOnView];
    LoginViewController *control1 = [[LoginViewController alloc] init];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController] pushViewController:control1 animated:NO];
    
    }
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (IBAction)termsAndConditionPage:(id)sender {
    TermsConditionViewController *terms=[[TermsConditionViewController alloc]initWithNibName:@"TermsConditionViewController" bundle:nil];
    [self.navigationController pushViewController:terms animated:YES];

}

@end
