//
//  LoginViewController.m
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 05/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/CoreAnimation.h>
#import "MBHUDView.h"
#import "MFSideMenu.h"
#import "RegisterViewController.h"
#import "EditProfileViewController.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "ForgetPassWordViewController.h"
#import "FacebookTwitterIntermidiat.h"


@interface LoginViewController ()
{
    HelperClass *LoginHelper;
    HelperClass *obj;
    MBAlertView *alert;
    NSString *fullName;
    NSString *userImage;
    NSString *user_id;
    NSMutableDictionary *FacebookUserData;
    NSMutableDictionary *TwitterUserData;
    NSString *massAge;
    NSString *FBAccessToken, *strfbId, *response;
    BOOL GotError, IsFBThreadFire;
    NSOperationQueue *OperationQueue;
}
@property (nonatomic, retain) NSString *username;
@property (nonatomic,retain) UIImageView *LoginArea;
@property (nonatomic,strong) UITextField *UserNameField;
@property (nonatomic,strong) UITextField *UserPassField;
@property (nonatomic, strong) ACAccount *facebookAccount;
@property (nonatomic, strong) ACAccount *twitterAccount;
@property (nonatomic, retain) ACAccountStore *accountStore;
@property (nonatomic, retain) IBOutlet UIView *Errview;
@property (strong, nonatomic) IBOutlet UILabel *twitterLabel;
@property (strong, nonatomic) IBOutlet UILabel *facebookLabel;

@end

@implementation LoginViewController
@synthesize LoginArea;
@synthesize UserNameField;
@synthesize UserPassField;
@synthesize facebookAccount;
@synthesize twitterAccount;
@synthesize accountStore;
@synthesize Errview;

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
    OperationQueue=[[NSOperationQueue alloc]init];

    
    [super viewDidLoad];
    
    [self HideNavigationBar];
    NSUserDefaults *userDefalus=[NSUserDefaults standardUserDefaults];
     userDefalus=nil;
    [userDefalus synchronize];
   // HelperClass *obj = [HelperClass SaveVehicleDescDataForReport];
   // NSLog(@"LoginHelper -- VehicleMake %@",obj.);
    
    LoginHelper = [[HelperClass alloc] init];
    
    FacebookUserData = [[NSMutableDictionary alloc] init];
    TwitterUserData = [[NSMutableDictionary alloc] init];
    
    
    [LoginHelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    
    self.UserNameField.delegate = self;
    self.UserPassField.delegate = self;
    
    // Create logo image
    
    Errview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [self.view addSubview:Errview];
    
    [LoginHelper CreateImageviewWithImage:self.view xcord:60 ycord:40 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:GLOBALLOGOIMAGE];
    
    // Set login section background
    
    LoginArea = [[UIImageView alloc] initWithFrame:CGRectMake(15, 90, 291, 161)];
    LoginArea.image = [UIImage imageNamed:LOGINTEXTREGIONBACKGROUNDIMG];
    [self.view addSubview:LoginArea];
    
    //
    
    [LoginHelper CreateImageviewWithImage:LoginArea xcord:35 ycord:45 width:24 height:24 backgroundColor:[UIColor clearColor] imageName:@"user.png"];
    
    UserNameField = [LoginHelper CrateTextField:globalTextFieldXCord ycord:127 width:globalTextFieldWidth height:globalTextFieldHeight backgroundColor:[UIColor clearColor] backGroundImage:Nil textcolor:globalTEXTFIELDPLACEHOLDERCOLOR palceholdertext:LOGINFIELDPLACEHOLDER fontName:GLOBALTEXTFONT fontSize:globalTEXTFIELDPLACEHOLDERFONTSIZE Secure:NO addView:self.view viewController:self delegate:Nil textfieldName:UserNameField];
    
    [UserNameField addTarget:self action:@selector(RetunButtonClicked:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    UserPassField = [LoginHelper CrateTextField:globalTextFieldXCord ycord:175 width:globalTextFieldWidth height:globalTextFieldHeight backgroundColor:[UIColor clearColor] backGroundImage:Nil textcolor:globalTEXTFIELDPLACEHOLDERCOLOR palceholdertext:PASSWORDFIELDPLACEHOLDER fontName:GLOBALTEXTFONT fontSize:globalTEXTFIELDPLACEHOLDERFONTSIZE Secure:YES addView:self.view viewController:self delegate:Nil textfieldName:UserPassField];
    
    [UserPassField addTarget:self action:@selector(RetunButtonClicked:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [LoginHelper CreateImageviewWithImage:LoginArea xcord:20 ycord:80 width:248 height:2 backgroundColor:[UIColor clearColor] imageName:LOGINDEVIDERIMAGE];
    
    [LoginHelper CreateImageviewWithImage:LoginArea xcord:35 ycord:92 width:24 height:24 backgroundColor:[UIColor clearColor] imageName:@"password.png"];
    
    [LoginHelper CreateButtonWithValue:33 ycord:265 width:255 height:50 backgroundColor:[UIColor clearColor] textcolor:[UIColor whiteColor] labeltext:LOGINBUTTON fontName:GLOBALTEXTFONT fontSize:16 imageNameForUIControlStateNormal:LOGINBUTTONIMG imageNameForUIControlStateSelected:LOGINBUTTONIMG imageNameForUIControlStateHighlighted:LOGINBUTTONIMG imageNameForselectedHighlighted:LOGINBUTTONIMG selectMethod:@selector(PerformLogin) selectEvent:UIControlEventTouchUpInside addView:self.view viewController:self];
    
    [LoginHelper CreateButtonWithValue:33 ycord:320 width:255 height:50 backgroundColor:[UIColor clearColor] textcolor:[UIColor whiteColor] labeltext:LOGINBUTTON fontName:GLOBALTEXTFONT fontSize:16 imageNameForUIControlStateNormal:REGISTERBUTTIMG imageNameForUIControlStateSelected:REGISTERBUTTIMG imageNameForUIControlStateHighlighted:REGISTERBUTTIMG imageNameForselectedHighlighted:REGISTERBUTTIMG selectMethod:@selector(PerformRegister) selectEvent:UIControlEventTouchUpInside addView:self.view viewController:self];
    
    [LoginHelper CreatelabelWithValue:0 ycord:385 width:320 height:25 backgroundColor:[UIColor clearColor] textcolor:UIColorFromRGB(0xa6a6a6) labeltext:ALTERNATIVELOGINTEXT fontName:GLOBALTEXTFONT fontSize:20 addView:self.view];
    
    
    [LoginHelper CreateButtonWithValue:71 ycord:424 width:75 height:75 backgroundColor:[UIColor clearColor] textcolor:UIColorFromRGB(0xa6a6a6) labeltext:Nil fontName:GLOBALTEXTFONT fontSize:0 imageNameForUIControlStateNormal:LOGINFACEBOOK imageNameForUIControlStateSelected:LOGINFACEBOOK imageNameForUIControlStateHighlighted:LOGINFACEBOOK imageNameForselectedHighlighted:LOGINFACEBOOK selectMethod:@selector(FacebookLoginone) selectEvent:UIControlEventTouchUpInside addView:self.view viewController:self];
    
    [LoginHelper CreateButtonWithValue:170 ycord:424 width:75 height:75 backgroundColor:[UIColor clearColor] textcolor:UIColorFromRGB(0xa6a6a6) labeltext:ALTERNATIVELOGINTEXT fontName:GLOBALTEXTFONT fontSize:22 imageNameForUIControlStateNormal:LOGINTWITTER imageNameForUIControlStateSelected:LOGINTWITTER imageNameForUIControlStateHighlighted:LOGINTWITTER imageNameForselectedHighlighted:LOGINTWITTER selectMethod:@selector(TwitterLoginone) selectEvent:UIControlEventTouchUpInside addView:self.view viewController:self];
    
    _facebookLabel.font=[UIFont fontWithName:GLOBALTEXTFONT size:15];
    _twitterLabel.font=[UIFont fontWithName:GLOBALTEXTFONT size:15];
    
    UIView *ForgetPassBackview=[[UIView alloc]initWithFrame:CGRectMake(20, 239, 255, 20)];
    ForgetPassBackview.layer.cornerRadius=0.0;
    ForgetPassBackview.layer.borderWidth=0.0;
    ForgetPassBackview.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self.view addSubview:ForgetPassBackview];
    UILabel *backviewLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 255, 20)];
    backviewLbl.backgroundColor=[UIColor clearColor];
    backviewLbl.text=@"Forgot password?";
    backviewLbl.textColor=[UIColor darkGrayColor];
    backviewLbl.font=[UIFont systemFontOfSize:10.00];
    backviewLbl.textAlignment=NSTextAlignmentLeft;
    [ForgetPassBackview addSubview:backviewLbl];
    
    UIButton *ForpassWordbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [ForpassWordbutton setFrame:CGRectMake(20, 235, 255, 35)];
    [ForpassWordbutton setBackgroundColor:[UIColor clearColor]];
    [ForpassWordbutton addTarget:self action:@selector(genaratenewpassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ForpassWordbutton];
    
    
}
-(IBAction)RetunButtonClicked:(UITextField *)textField
{
        [textField resignFirstResponder];
}

-(IBAction)genaratenewpassword:(id)sender
{
    ForgetPassWordViewController *Forgetpass = [[ForgetPassWordViewController alloc] initWithNibName:@"ForgetPassWordViewController" bundle:nil];
    
    [self.navigationController pushViewController:Forgetpass animated:YES];

}


-(void)PerformLogin
{
    if(![LoginHelper CleanTextField:UserNameField.text].length > 0) {
        alert = [MBAlertView alertWithBody:USERNAMEBLANKERR cancelTitle:@"Cancel" cancelBlock:nil];
        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
        }];
        [alert addToDisplayQueue];
        [UserNameField becomeFirstResponder];
        return;
    }
    else if(![LoginHelper CleanTextField:UserPassField.text].length > 0) {
        alert = [MBAlertView alertWithBody:PASSWORDBLANKERR cancelTitle:@"Cancel" cancelBlock:nil];
        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
        }];
        [alert addToDisplayQueue];
        [UserPassField becomeFirstResponder];
        return;
    } else {
        
        [UserNameField resignFirstResponder];
        [UserPassField resignFirstResponder];
        
        [LoginHelper AddBlackOverlay:self.view xcord:0 ycord:0 width:self.view.frame.size.width height:self.view.frame.size.height backgroundColor:[UIColor blackColor] OpacitY:0.9f Text:@"Please wait" TextColor:[UIColor whiteColor] FontName:globalTEXTFIELDPLACEHOLDERFONT FontSize:18 IsTextEnabled:YES];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            NSUserDefaults *prefss = [NSUserDefaults standardUserDefaults];
            NSString *USERDEVICETOKEN = [prefss objectForKey:@"USERDEVICETOKEN"];
            
            [prefss setObject:[LoginHelper CleanTextField:UserNameField.text] forKey:@"USERNAME"];
            [prefss setObject:[LoginHelper CleanTextField:UserPassField.text] forKey:@"PASSWORD"];
            
            [prefss synchronize];
            
            
            NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
            [tempDict setObject:[LoginHelper CleanTextField:UserNameField.text] forKey:@"email_username"];
            [tempDict setObject:[LoginHelper CleanTextField:UserPassField.text] forKey:@"password"];
            [tempDict setObject:LOGINMODE forKey:@"mode"];
            [tempDict setObject:USERDEVICETOKEN forKey:@"device_token"];
            
            NSString *REturnedURL = [LoginHelper CallURLForServerReturn:tempDict URL:LOGINPAGE];
            NSLog(@"userdevicetoken ----- %@",REturnedURL);

            NSDictionary *Retrneddata = [LoginHelper executeFetch:REturnedURL];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [LoginHelper HidePopupView];
                
                for (NSDictionary *statData in [Retrneddata objectForKey:@"extraparam"]) {
                    
                    if([[statData objectForKey:@"response"] isEqualToString:GLOBALERRSTRING]) {
                        alert = [MBAlertView alertWithBody:[statData objectForKey:@"message"] cancelTitle:@"Cancel" cancelBlock:nil];
                        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
                        }];
                        [alert addToDisplayQueue];
                    } else {
                        for (NSDictionary *statDataone in [Retrneddata objectForKey:@"userdetails"]) {
                            
                            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                             [prefs setObject:[statDataone objectForKey:@"first_name"] forKey:@"first_name"];
                             [prefs setObject:[statDataone objectForKey:@"last_name"] forKey:@"last_name"];
                             [prefs setObject:[statDataone objectForKey:@"user_image"] forKey:@"user_image"];
                             [prefs setObject:[statDataone objectForKey:@"userid"] forKey:@"userid"];
                             [prefs setObject:[statDataone objectForKey:@"username"] forKey:@"username"];
                             [prefs setObject:[statDataone objectForKey:@"email"] forKey:@"email"];
                             [prefs setObject:UserPassField.text forKey:@"password"];
                            NSLog(@"The value of user id is:%@",[statDataone objectForKey:@"user_image"]);
                            
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            
                            AppDelegate *maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                            [maindelegate SetUpTabbarController];
                            
                            EditProfileViewController *editProfile = [[EditProfileViewController alloc] initWithNibName:@"EditProfileViewController" bundle:Nil];
                            CATransition* transition = [LoginHelper AddAnimationOnView];
                            [self.navigationController.view.layer addAnimation:transition forKey:nil];
                            [[self navigationController] pushViewController:editProfile animated:NO];
                            
                        }
                    }
                }
            });
        });
        
    }
}
-(void)HelperClassProtocolRequiredMethod:(HelperClass *)HelperClassObj ObjCarier:(NSDictionary *)ObjCarier
{
    NSLog(@"ObjCarier --- %@",ObjCarier);
}
-(IBAction)hideKeyboard:(id)sender {
    [(UITextField*)sender resignFirstResponder];
}
#pragma mark -
#pragma mark - UIBarButtonItem Callbacks

- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

- (void)rightSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{}];
}
-(void)FacebookLoginone
{
    
    [LoginHelper AddBlackOverlay:self.view xcord:0 ycord:0 width:self.view.frame.size.width height:self.view.frame.size.height backgroundColor:[UIColor blackColor] OpacitY:0.9f Text:@"Please wait" TextColor:[UIColor whiteColor] FontName:globalTEXTFIELDPLACEHOLDERFONT FontSize:18 IsTextEnabled:YES];
    
   // [self performSelectorOnMainThread:@selector(FacebookLogin) withObject:nil waitUntilDone:YES];
    
    if (FBSession.activeSession.isOpen)
    {
         NSLog(@"here --11 ");
        [self updateViewForFbShare];
       
    }
    
    else
    {
         NSLog(@"here --22 ");
        [self openSessionWithAllowLoginUI:YES];
       
    }
    
}
//-(void)FacebookLogin
//{
//    if(!accountStore)
//        accountStore = [[ACAccountStore alloc] init];
//    NSString *deviceToken;
//    ACAccountType *facebookTypeAccount = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
//    AppDelegate *mainDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
//    if ([mainDelegate.deviceTokenString isKindOfClass:NULL]) {
//        
//       deviceToken=@"";
//        
//    }
//    else
//    {
//        deviceToken=mainDelegate.deviceTokenString;
//    }
//    [accountStore requestAccessToAccountsWithType:facebookTypeAccount
//                                          options:@{ACFacebookAppIdKey: @"176357389225508", ACFacebookPermissionsKey: @[@"email"]}
//                                       completion:^(BOOL granted, NSError *error) {
//                                           if(granted){
//                                               
//                                               NSArray *accounts = [accountStore accountsWithAccountType:facebookTypeAccount];
//                                               facebookAccount = [accounts lastObject];
//                                               NSLog(@"Success");
//                                               dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//                                                   
//                                                   NSURL *meurl = [NSURL URLWithString:@"https://graph.facebook.com/me"];
//                                                   SLRequest *merequest = [SLRequest requestForServiceType:SLServiceTypeFacebook
//                                                                                             requestMethod:SLRequestMethodGET
//                                                                                                       URL:meurl
//                                                                                                parameters:nil];
//                                                   
//                                                   merequest.account = facebookAccount;
//                                                   
//                                                   NSLog(@"merequest --- %@",merequest);
//                                                   
//                                                   [merequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
//                                                       NSMutableDictionary *meDataString = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
//                                                       
//                                                       NSUserDefaults *prefss = [NSUserDefaults standardUserDefaults];
//                                                       NSString *USERDEVICETOKEN = [prefss objectForKey:@"USERDEVICETOKEN"];
//                                                    
//                                                       [FacebookUserData setObject:[meDataString objectForKey:@"username"] forKey:@"username"];
//                                                       [FacebookUserData setObject:[meDataString objectForKey:@"id"] forKey:@"connectid"];
//                                                       [FacebookUserData setObject:[meDataString objectForKey:@"first_name"] forKey:@"first_name"];
//                                                       [FacebookUserData setObject:[meDataString valueForKey:@"email"] forKey:@"email"];
//                                                       [FacebookUserData setObject:[meDataString objectForKey:@"last_name"] forKey:@"last_name"];
//                                                       [FacebookUserData setObject:@"facebook_register" forKey:@"mode"];
//                                                       [FacebookUserData setObject:USERDEVICETOKEN forKey:@"device_token"];
//                                                       [FacebookUserData setObject:@"" forKey:@"password"];
//                                                       NSString *string=[NSString stringWithFormat:@"http://esolzdemos.com/lab3/trafficcop/IOS/appweb.php?mode=connectid_check&connectid=%@&authprovider=%@&device_token=%@",[meDataString objectForKey:@"id"],@"facebook",deviceToken];
//                                                       NSLog(@"The string Url:%@",string);
//                                                       
//                                                       NSURL *url=[NSURL URLWithString:string];
//                                                       NSData *data=[NSData dataWithContentsOfURL:url];
//                                                       NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//                                                       
//                                                       NSArray *ExtraParam=[dic objectForKey:@"extraparam"];
//                                                       for (NSDictionary *Dictemp in ExtraParam)
//                                                       {
//                                                            massAge=[Dictemp valueForKey:@"message"];
//                                                       }
//                                                       
//                                                           if ([massAge isEqualToString:@"success"])
//                                                           {
//                                                               
//                                                               [LoginHelper HidePopupView];
//                                                               NSArray *DataArry=[dic objectForKey:@"userdetails"];
//                                                               for (NSDictionary *Dictemp2 in DataArry)
//                                                               {
//                                                                   NSString *userId=[Dictemp2 valueForKey:@"userid"];
//                                                                   NSString *userName=[Dictemp2 valueForKey:@"username"];
//                                                                   NSString *FirstName=[Dictemp2 valueForKey:@"first_name"];
//                                                                   NSString *Lastname=[Dictemp2 valueForKey:@"last_name"];
//                                                                   NSString *email=[Dictemp2 valueForKey:@"email"];
//                                                                   NSString *userImagemw=[Dictemp2 valueForKey:@"user_image"];
//                                                                  
//                                                                   NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//                                                                   [prefs setObject:FirstName forKey:@"first_name"];
//                                                                   [prefs setObject:Lastname forKey:@"last_name"];
//                                                                   [prefs setObject:userImagemw forKey:@"user_image"];
//                                                                   [prefs setObject:userId forKey:@"userid"];
//                                                                   [prefs setObject:userName forKey:@"username"];
//                                                                   [prefs setObject:email forKey:@"email"];
//                                                                   [prefs setObject:@"" forKey:@"password"];
//                                                                   [[NSUserDefaults standardUserDefaults] synchronize];
//                                                                   
//                                                               }
//                                                               dispatch_async(dispatch_get_main_queue(), ^{
//                                                                   
//                                                                   [self Redirectme2];
//                                                                   
//                                                                   
//                                                               });
//                                                           
//                                                      }
//                                                         
//                                                           
//                                                           else
//                                                           {
//                                                            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//                                                            [prefs setObject:[FacebookUserData objectForKey:@"first_name"] forKey:@"first_name"];
//                                                            [prefs setObject:[FacebookUserData objectForKey:@"last_name"] forKey:@"last_name"];
//                                                            [prefs setObject:[FacebookUserData objectForKey:@"user_image"] forKey:@"user_image"];
//                                                            [prefs setObject:[FacebookUserData objectForKey:@"userid"] forKey:@"userid"];
//                                                            [prefs setObject:[meDataString objectForKey:@"id"] forKey:@"id"];
//                                                            [prefs setObject:[FacebookUserData objectForKey:@"username"] forKey:@"username"];
//                                                            [prefs setObject:[FacebookUserData objectForKey:@"email"] forKey:@"email"];
//                                                           
//                                                            [[NSUserDefaults standardUserDefaults] synchronize];
//                                                           
//                                                            [self performSelectorOnMainThread:@selector(Redirect)
//                                                                                  withObject:nil
//                                                                               waitUntilDone:YES];
//                                                           }
//                                                       
//                                                       
//                                                       }];
//                                                   
//
//                                               });
//                                           }
//                                           
//                                           else {
//                                               
////                                               [self performSelectorOnMainThread:@selector(Settingserr:)
////                                                                      withObject:@"There is no Facebook Account in our phone settings"
////                                                                   waitUntilDone:YES];
////                                               
////                                               NSLog(@"Fail");
////                                               NSLog(@"Error: %@", error);
//                                               
//                                              // [self FacebookLoginWeb];
//                                               //[self me];
//                                               
//                                               
//                                               
//                                               NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//                                               [prefs setObject:[FacebookUserData objectForKey:@"first_name"] forKey:@"first_name"];
//                                               [prefs setObject:[FacebookUserData objectForKey:@"last_name"] forKey:@"last_name"];
//                                               [prefs setObject:[FacebookUserData objectForKey:@"user_image"] forKey:@"user_image"];
//                                               [prefs setObject:[FacebookUserData objectForKey:@"userid"] forKey:@"userid"];
//                                               [prefs setObject:[FacebookUserData objectForKey:@"id"] forKey:@"id"];
//                                               [prefs setObject:[FacebookUserData objectForKey:@"username"] forKey:@"username"];
//                                               [prefs setObject:[FacebookUserData objectForKey:@"email"] forKey:@"email"];
//                                               
//                                               [[NSUserDefaults standardUserDefaults] synchronize];
//                                               
//                                              // [self FacebookLoginWeb];
//                                               
//                                               
//                                               
//                                               
//                                           }
//                                       }];
//}


- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI
{
    NSArray *permissions = [[NSArray alloc] initWithObjects: @"email", nil];
    NSLog(@"open1");
    
    NSLog(@"openSessionWithAllowLoginUI---");
    
    return [FBSession openActiveSessionWithReadPermissions:permissions allowLoginUI:allowLoginUI completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
        
        NSLog(@"session = %@", session);
        NSLog(@"error = %@", error);
        NSLog(@"open2");
        
        [self sessionStateChanged:session state:status error:error];
        NSLog(@"openSessionWithAllowLoginUI  sss---");
        
    }];
    
    return YES;
    
}

-(void)ChangeStateFacebook {
    [self openSessionWithAllowLoginUI:YES];
    NSLog(@"chek here -- 33");
}


- (void)updateViewForFbShare

{
     NSLog(@"chek here xx-- 44");
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if (appDelegate.session.isOpen)
        
    {
        NSLog(@"chek here vvv 55");
        FBAccessToken=appDelegate.session.accessTokenData.accessToken;
        NSLog(@"fb access token in update view for fb share-- %@", FBAccessToken);
        
        if(![FBAccessTokenData  isEqual:@""] && !IsFBThreadFire)
            
        {
            IsFBThreadFire=TRUE;
            
            NSInvocationOperation *RegisterOperation=[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(getFacebookFeed) object:nil];
            
            [OperationQueue addOperation:RegisterOperation];
            
             NSLog(@"chek here jsgdf 66");
            
        } else {
            NSLog(@"----juzz");
        }
        
    }
    
    else
        
    {
        NSLog(@"----juzz 777");
        
        [[self view] setUserInteractionEnabled:YES];
        
        [[FBSession activeSession] closeAndClearTokenInformation];
        
        [[FBSession activeSession] close];
        
    }
    
}

-(void) getFacebookFeed
{
    NSLog(@"chk 11");
    
    NSUserDefaults *prefss = [NSUserDefaults standardUserDefaults];
    NSString *deviceToken = [prefss objectForKey:@"USERDEVICETOKEN"];
    NSLog(@"device token for fb is %@", deviceToken);
    
    @try
    {
        
        NSError *gotError       =   nil;
        NSString *url           =   [NSString stringWithFormat:@"%@me?access_token=%@",GraphAPI, FBAccessToken];
        NSLog(@"url string is %@", url);
        
        NSData *getData         =   [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        NSLog(@"getdata is  %@", getData);
        
        if([getData length]>0)
        {
            NSArray *getArray   =   [NSJSONSerialization JSONObjectWithData:getData options:kNilOptions error:&gotError];
            if(!gotError)
            {
                NSLog(@"chk 33---");
                
                strfbId                          =   [getArray valueForKey:@"id"];
//                NSUserDefaults *userid = [NSUserDefaults standardUserDefaults];
//                [userid setValue:strfbId forKey:@"id"];
                
                NSLog(@"idddd");
                
                
                if (strfbId) {
                    
                    NSLog(@"chk 44---hh");
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
                        
                      //  NSData *data             =   [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=200&height=200&redirect=false",[NSString stringWithFormat:@"%@",[getArray valueForKey:@"id"]]]]];
                        
                        NSString *str = [NSString stringWithFormat:@"%@appweb.php?mode=connectid_check&connectid=%@&authprovider=%@&device_token=%@",DomainURL,strfbId,@"facebook",deviceToken];
                        
                        NSLog(@"The update String:%@",str);
                        
                        
                         NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
                       
                            
                        NSLog(@"The update data:%@",data);
                        
                        
                        
                        
                        dispatch_async(dispatch_get_main_queue(), ^(void) {
                            NSDictionary *dic   =   [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                            NSLog(@"chk dicccc %@", dic);
                        
//                        for (NSDictionary *statData in [dic objectForKey:@"extraparam"])
                            
                            NSDictionary *statData = [dic objectForKey:@"extraparam"];
                     //   {
                            NSLog(@"ck 11cc");
                            response            =   [[statData valueForKey:@"response"]objectAtIndex:0];
                           NSLog(@"ck ccssssss");
                            NSLog(@"response chk -- %@", response);
                            NSString *strRespose = response;
                            NSLog(@"string repons %@",strRespose);
                            
                            
                            if ([response isEqualToString:@"success"]) {
                               
                                NSLog(@"chk 55ollo");
                                
                                NSDictionary *userDetails = [dic objectForKey:@"userdetails"];
                                NSLog(@"user details isss %@", userDetails);
                                
                                NSUserDefaults *Userdata = [NSUserDefaults standardUserDefaults];
                                [Userdata setValue:[[userDetails valueForKey:@"userid"]objectAtIndex:0] forKey:@"userid"];
                                [Userdata setValue:[[userDetails valueForKey:@"username"]objectAtIndex:0] forKey:@"username"];
                                
                                [Userdata setValue:[[userDetails valueForKey:@"first_name"]objectAtIndex:0] forKey:@"first_name"];
                                
                                [Userdata setValue:[[userDetails valueForKey:@"last_name"]objectAtIndex:0] forKey:@"last_name"];
                                
                                [Userdata setValue:[[userDetails valueForKey:@"email"]objectAtIndex:0] forKey:@"email"];
                                
                                [Userdata setValue:[[userDetails valueForKey:@"user_image"]objectAtIndex:0] forKey:@"user_image"];
                                
                                NSLog(@"user defauld chk %@", [Userdata valueForKey:@"username"]);
                                
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        [self Redirectme2];
                                        
                                    });
                                
                            }
                            
                            else {
                                
                                NSLog(@"chk 66gg");
                                NSUserDefaults *userid = [NSUserDefaults standardUserDefaults];
                                [userid setValue:strfbId forKey:@"userid"];

                                
                                NSError *errorone               =   nil;
                                NSString *SavedImage            =   [NSString stringWithFormat:@"%@%@/picture?width=%d&height=%d&redirect=%@",GraphAPIFACEBOOK,strfbId,FACEBOOKIMAGEHEIGHT,FACEBOOKIMAGEHEIGHT,FACEBOOKIMAGEREDIRECT];
                                NSData *dataone                 =   [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:SavedImage] options:NSDataReadingUncached error:&errorone];
                                NSDictionary *imageresult       =   [NSJSONSerialization JSONObjectWithData:dataone options:kNilOptions error:&errorone];
                                NSDictionary *picturedata       =   [imageresult objectForKey:@"data"];
                                NSString *profileimageURL       =   [picturedata objectForKey:@"url"];
                                
                                NSLog(@"get arrayyyy %@", getArray);
                                
                                NSUserDefaults *SetUserData      = [NSUserDefaults standardUserDefaults];
                                [SetUserData setObject:[getArray valueForKey:@"link"] forKey:@"FBlink"];
                                [SetUserData setObject:[getArray valueForKey:@"email"] forKey:@"FBemail"];
                                [SetUserData setObject:[getArray valueForKey:@"id"] forKey:@"FBconnectid"];
                                [SetUserData setObject:[getArray valueForKey:@"first_name"] forKey:@"FBfirst_name"];
                                [SetUserData setObject:[getArray valueForKey:@"last_name"] forKey:@"FBlast_name"];
                                [SetUserData setObject:[getArray valueForKey:@"username"] forKey:@"FBusername"];
                                [SetUserData setObject:profileimageURL forKey:@"FBProfileImage"];
                                [SetUserData setObject:@"facebook_register" forKey:@"mode"];
                                [SetUserData synchronize];
                                
                                [self Redirect];
                                
                            }
                       // }
                            
                        });
                        
                    });
                }
                
            }
            else
            {
                @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%@",gotError.localizedDescription] userInfo:nil];
            }
        }
        else
        {
            @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"Data is null.."] userInfo:nil];
        }
    }
    @catch (NSException *FbLoginException)
    {
        NSLog(@"FbLoginException ---- %@",FbLoginException);
    }
}



- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error

{
    NSLog(@"test 1---");
    
    NSLog(@"SessionStateChanged: %@", error);
    
    switch (state)
    
    {
        case FBSessionStateOpen:
            
            if (!error)
                
            {
                
                // We have a valid session
                NSLog(@"test 2---");
                
                [[self view] setUserInteractionEnabled:YES];
                
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                appDelegate.session=session;
                
                NSLog(@"Valid Session");
                
                // _FBAccessToken=appDelegate.session.accessTokenData.accessToken;
                
                
                [self updateViewForFbShare];
                
                //[self fbLogin];
                
            }
            
            break;
            
        case FBSessionStateClosed:
            
        case FBSessionStateClosedLoginFailed:
            NSLog(@"Valid Session qq");
            
            [[self view] setUserInteractionEnabled:YES];
            [FBSession.activeSession closeAndClearTokenInformation];
            
            break;
            
        default:
            
            break;
    }
}



-(void)Redirectme2
{
    AppDelegate *maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    DashboardViewController *dashbord=[[DashboardViewController alloc]init];
    [maindelegate SetUpTabbarControllerwithcenterView:dashbord];
}


-(void)Redirect
{
//    AppDelegate *maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [maindelegate SetUpTabbarController];
//    
//    EditProfileViewController *editProfile = [[EditProfileViewController alloc] initWithNibName:@"EditProfileViewController" bundle:Nil];
//    CATransition* transition = [LoginHelper AddAnimationOnView];
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
//    [[self navigationController] pushViewController:editProfile animated:NO];
    
    CATransition* transition = [LoginHelper AddAnimationOnView];
    FacebookTwitterIntermidiat *control1 = [[FacebookTwitterIntermidiat alloc] init];
    control1.isCommingFromFacebook=YES;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController] pushViewController:control1 animated:NO];
    
//     FacebookTwitterIntermidiat *facetwitter=[[FacebookTwitterIntermidiat alloc]initWithNibName:@"FacebookTwitterIntermidiat" bundle:nil];
//    facetwitter.isCommingFromFacebook=YES;
//     [self.navigationController pushViewController:facetwitter animated:YES];iamgenamed
    
    
}
-(void)Settingserr:(NSString *)Textmessage {
    
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Account Settings Err" message:Textmessage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
     [alertview show];
     [LoginHelper HidePopupView];
}
//Get "me":
//- (void)me{
//    
//    NSLog(@"in meeeee ");
//    
//    NSURL *meurl = [NSURL URLWithString:@"https://graph.facebook.com/me"];
//    SLRequest *merequest = [SLRequest requestForServiceType:SLServiceTypeFacebook
//                                              requestMethod:SLRequestMethodGET
//                                                        URL:meurl
//                                                 parameters:nil];
//    
//    merequest.account = facebookAccount;
//    
//    [merequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
//        NSMutableDictionary *meDataString = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];;
//        //NSLog(@" meDataString %@", meDataString);
//        
//        NSUserDefaults *prefss = [NSUserDefaults standardUserDefaults];
//        NSString *USERDEVICETOKEN = [prefss objectForKey:@"USERDEVICETOKEN"];
//        
//        [FacebookUserData setObject:[meDataString objectForKey:@"username"] forKey:@"username"];
//        [FacebookUserData setObject:[meDataString objectForKey:@"id"] forKey:@"connectid"];
//        [FacebookUserData setObject:[meDataString objectForKey:@"first_name"] forKey:@"first_name"];
//        [FacebookUserData setObject:[meDataString objectForKey:@"last_name"] forKey:@"last_name"];
//        [FacebookUserData setObject:@"facebook_register" forKey:@"mode"];
//        [FacebookUserData setObject:USERDEVICETOKEN forKey:@"device_token"];
//        [FacebookUserData setObject:@"" forKey:@"password"];
//        
//        [self FacebookLoginWeb];
//        
//    }];
//}


//-(void)FacebookLoginWeb
//{
//    NSArray *permissions = [[NSArray alloc] initWithObjects: @"email",nil];
//    [FBSession openActiveSessionWithReadPermissions:permissions allowLoginUI:YES completionHandler:^(FBSession *session,FBSessionState status,NSError *error) {
//        if (status == FBSessionStateClosedLoginFailed) {
//            NSLog(@"Not Done Facebook Login");
//        } else {
//            
//            NSString *fburl = [NSString stringWithFormat:@"https://graph.facebook.com/me?access_token=%@",[FBSession activeSession].accessTokenData.accessToken];
//            NSError* error = nil;
//            NSData *dataURL =  [NSData dataWithContentsOfURL:[NSURL URLWithString:fburl]options:NSDataReadingUncached error:&error];
//            
//            NSDictionary* jsonResults = [NSJSONSerialization JSONObjectWithData:dataURL options:kNilOptions error:&error];
//            NSError* errorone = nil;
//            
//            NSURL *urlone = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=200&height=200&redirect=false",[jsonResults valueForKey:@"id"]]];
//            
//            NSData *dataone = [[NSData alloc] initWithContentsOfURL:urlone options:NSDataReadingUncached error:&errorone];
//            NSDictionary *imageresult = [NSJSONSerialization JSONObjectWithData:dataone options:kNilOptions error:&errorone];
//            
//            NSLog(@"imageresult ==== %@",imageresult);
//            if(errorone)
//            {
//                NSLog(@" error%@",imageresult);
//                 NSLog(@"----- %@",[imageresult objectForKey:@"url"]);
//            } else {
//                NSDictionary *picturedata = [imageresult objectForKey:@"data"];
//                NSString *profileimageURL = [picturedata objectForKey:@"url"];
//                NSLog(@"profileimageURL --- %@",profileimageURL);
//                NSLog(@" email is %@",[jsonResults objectForKey:@"email"]);
//                
//                [FacebookUserData setObject:profileimageURL forKey:@"FacebookuserImage"];
//                [FacebookUserData setObject:[jsonResults objectForKey:@"email"] forKey:@"email"];
//            }
//            
//        }
//    }];
//}



-(void)TwitterLoginone {
    
    [LoginHelper AddBlackOverlay:self.view xcord:0 ycord:0 width:self.view.frame.size.width height:self.view.frame.size.height backgroundColor:[UIColor blackColor] OpacitY:0.9f Text:@"Please wait" TextColor:[UIColor whiteColor] FontName:globalTEXTFIELDPLACEHOLDERFONT FontSize:18 IsTextEnabled:YES];
    
    [self performSelectorOnMainThread:@selector(TwitterLogin)
                           withObject:nil
                        waitUntilDone:YES];
}
-(void)TwitterLogin
{
    
    NSUserDefaults *prefss = [NSUserDefaults standardUserDefaults];
    NSString *deviceToken = [prefss objectForKey:@"USERDEVICETOKEN"];
    
    if(!accountStore)
        accountStore = [[ACAccountStore alloc] init];
    ACAccountType *TwitterTypeAccount = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:TwitterTypeAccount options:nil completion:^(BOOL granted, NSError *error)
    {
        
        if (granted) {
            
           
            
            NSArray *accounts = [accountStore accountsWithAccountType:TwitterTypeAccount];
            if (accounts.count > 0)
            {
                ACAccount *twitterAccountone = [accounts lastObject];
                
                NSLog(@"twitterAccountone --- %@",twitterAccountone);
               
              
                _username=twitterAccountone.username;

                
                user_id = [[twitterAccountone valueForKey:@"properties"] valueForKey:@"user_id"];
                NSLog(@"useer name and userid:%@ %@",_username,user_id);
                
                NSLog(@"the user Id:%@",user_id);
                
                SLRequest *twitterInfoRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/users/show.json"] parameters:[NSDictionary dictionaryWithObject:_username forKey:@"screen_name"]];
                
                [twitterInfoRequest setAccount:twitterAccountone];
                NSString *string=[NSString stringWithFormat:@"%@appweb.php?mode=connectid_check&connectid=%@&authprovider=%@&device_token=%@",DomainURL,user_id,@"twitter",deviceToken];
                NSLog(@"The update String:%@",string);
                
               
                NSURL *url=[NSURL URLWithString:string];
                NSData *data=[NSData dataWithContentsOfURL:url];
                NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                
                NSArray *ExtraParam=[dic objectForKey:@"extraparam"];
                for (NSDictionary *Dictemp in ExtraParam)
                {
                    massAge=[Dictemp valueForKey:@"message"];
                }
                

                
                [twitterInfoRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        // Check if we reached the reate limit
                        
                        if ([urlResponse statusCode] == 429) {
                            
                            NSLog(@"Rate limit reached");
                            
                            return;
                            
                        }
                        if (error) {
                            NSLog(@"Error: %@", error.localizedDescription);
                            return;
                        }
                        if (responseData) {
                            NSError *error = nil;
                            NSArray *TWData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                            NSLog(@"the twodeta:%@",TWData);
                            fullName=[(NSDictionary *)TWData objectForKey:@"name"];
                            NSLog(@"The full name:%@",fullName);
                            userImage = [(NSDictionary *)TWData objectForKey:@"profile_image_url_https"];
                            if ([massAge isEqualToString:@"success"])
                            {
                                 //fdhth
                                [LoginHelper HidePopupView];
                                NSArray *DataArry=[dic objectForKey:@"userdetails"];
                                for (NSDictionary *Dictemp2 in DataArry)
                                {
                                    NSString *userId=[Dictemp2 valueForKey:@"userid"];
                                    NSString *userName=[Dictemp2 valueForKey:@"username"];
                                    NSString *FirstName=[Dictemp2 valueForKey:@"first_name"];
                                    NSString *Lastname=[Dictemp2 valueForKey:@"last_name"];
                                    NSString *email=[Dictemp2 valueForKey:@"email"];
                                    NSString *userImagemw=[Dictemp2 valueForKey:@"user_image"];
                                    
                                    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                                    [prefs setObject:FirstName forKey:@"first_name"];
                                    [prefs setObject:Lastname forKey:@"last_name"];
                                    [prefs setObject:userImagemw forKey:@"user_image"];
                                    [prefs setObject:userId forKey:@"userid"];
                                    [prefs setObject:userName forKey:@"username"];
                                    [prefs setObject:email forKey:@"email"];
                                    [prefs setObject:@"" forKey:@"password"];
                                    [[NSUserDefaults standardUserDefaults] synchronize];
                                    
                                }
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    
                                    [self Redirectme2];
                                    
                                    
                                });
                            }
                            else
                            {
                               [LoginHelper HidePopupView];
                                
                                [self LogintThroughTwitter];
                            }
                            
                        }
                    });
                }];
            }else {
               
                [self performSelectorOnMainThread:@selector(Settingserr:)
                                       withObject:@"Please add Twitter account in your phone settings"
                                    waitUntilDone:YES];
            }
        } else {
            
            [self performSelectorOnMainThread:@selector(Settingserr:)
                                   withObject:@"Please allow access your twitter account from settings"
                                waitUntilDone:YES];
        }
    }];
}
-(void)logintwitter2
{
    @try
    {
        NSString *devicetocan;
        AppDelegate *mainDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
       
        NSUserDefaults *prefss = [NSUserDefaults standardUserDefaults];
        devicetocan = [prefss objectForKey:@"USERDEVICETOKEN"];
        
        NSArray *sepatearArray=[fullName componentsSeparatedByString:@" "];
        NSString *fastname=[sepatearArray objectAtIndex:0];
        NSString *lastName=[sepatearArray objectAtIndex:1];
        NSLog(@"The first name and last name:%@ %@",fastname,lastName);
        
       
        
//        FacebookTwitterIntermidiat *fbtwiteinter=[[FacebookTwitterIntermidiat alloc]initWithNibName:@"FacebookTwitterIntermidiat" bundle:nil];
//        fbtwiteinter.isCommingFromFacebook=NO;
//        [self.navigationController pushViewController:fbtwiteinter animated:YES];
        
        
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
          NSString *Strurl=[NSString stringWithFormat:@"%@appweb.php?mode=twitter_register&connectid=%@&first_name=%@&last_name=%@&username=%@&password=%@&image_url=%@&device_token=%@",DomainURL,user_id,fastname,lastName,_username,@"",userImage,devicetocan];
         NSLog(@"The user id of twitter:%@",user_id);
         NSLog(@"The string url:%@",Strurl);
         NSURL *url=[NSURL URLWithString:Strurl];
         NSData *data=[NSData dataWithContentsOfURL:url];
         NSDictionary *mainDictionary=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
         NSArray *Extraparam=[mainDictionary valueForKey:@"extraparam"];
         NSDictionary *dic1=[Extraparam objectAtIndex:0];
         NSString *responce=[dic1 valueForKey:@"response"];
         NSArray *Userinfo=[mainDictionary valueForKey:@"userdetails"];
         NSDictionary *dic2=[Userinfo objectAtIndex:0];
         NSLog(@"response:%@",responce);
         if ([responce isEqualToString:@"success"])
         {
         NSUserDefaults *userDetail=[NSUserDefaults standardUserDefaults];
         NSString *userid=[dic2 valueForKey:@"userid"];
         NSString *UserName=[dic2 valueForKey:@"username"];
         //NSString *FastName=[dic2 valueForKey:@"first_name"];
         //NSString *lastname=[dic2 valueForKey:@"last_name"];
         
         NSString *userEmail=[dic2 valueForKey:@"email"];
         [userDetail setObject:userid forKey:@"userid"];
         [userDetail setObject:UserName forKey:@"username"];
         [userDetail setObject:fastname forKey:@"first_name"];
         [userDetail setObject:lastName forKey:@"last_name"];
         [userDetail setObject:userImage forKey:@"user_image"];
         [userDetail setObject:userEmail forKey:@"email"];
         [userDetail setObject:UserPassField.text forKey:@"password"];
         [[NSUserDefaults standardUserDefaults] synchronize];
         }
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 
             });
         DashboardViewController *fbtwiteinter=[[DashboardViewController alloc]init];
         
         [mainDelegate SetUpTabbarControllerwithcenterView:fbtwiteinter];
         
         });
                    
                        
    }
    @catch (NSException *exception)
    {
        
    }
}



-(void)LogintThroughTwitter
{
    @try
    {
       NSArray *sepatearArray=[fullName componentsSeparatedByString:@" "];
       NSString *fastname=[sepatearArray objectAtIndex:0];
        NSString *lastName=[sepatearArray objectAtIndex:1];
        NSLog(@"The first name and last name:%@ %@",fastname,lastName);
       
        NSUserDefaults *userDetail=[NSUserDefaults standardUserDefaults];
        
        [userDetail setObject:user_id forKey:@"id"];
        [userDetail setObject:_username forKey:@"username"];
        [userDetail setObject:fastname forKey:@"first_name"];
        [userDetail setObject:lastName forKey:@"last_name"];
        [userDetail setObject:userImage forKey:@"user_image"];
        [userDetail setObject:@"" forKey:@"email"];
        [userDetail setObject:@"" forKey:@"password"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
//        FacebookTwitterIntermidiat *fbtwiteinter=[[FacebookTwitterIntermidiat alloc]initWithNibName:@"FacebookTwitterIntermidiat" bundle:nil];
//        fbtwiteinter.isCommingFromFacebook=NO;
//        [self.navigationController pushViewController:fbtwiteinter animated:YES];
        
        CATransition* transition = [LoginHelper AddAnimationOnView];
        FacebookTwitterIntermidiat *control1 = [[FacebookTwitterIntermidiat alloc] init];
        control1.isCommingFromFacebook=NO;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [[self navigationController] pushViewController:control1 animated:NO];
       
        
     
    }
    @catch (NSException *exception)
    {
        
    }
}
-(void)PerformRegister
{
    CATransition* transition = [LoginHelper AddAnimationOnView];
    RegisterViewController *control1 = [[RegisterViewController alloc] init];
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
}
@end
