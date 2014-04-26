//
//  FacebookTwitterIntermidiat.m
//  TrafficCop
//
//  Created by macbook_ms on 12/03/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "FacebookTwitterIntermidiat.h"
#import "MFSideMenu.h"
#import "MBHUDView.h"
#import "AppDelegate.h"
#import "ZSImageView.h"
#import "DashboardViewController.h"
#import "LoginViewController.h"

@interface FacebookTwitterIntermidiat ()
{
NSString *userID;
UIImageView *ProfilePIcImageView;
NSOperationQueue *operationQ;
NSString *MassAge;
MBAlertView *alertmb;
NSMutableDictionary *FacebookUserData;
NSURL *urlString;
UIActivityIndicatorView *Spinner;
}
@property (nonatomic, strong) UITextField *FistName;
@property (nonatomic, strong) UITextField *LastName;
@property (nonatomic, strong) UITextField *Email;
@property (nonatomic, strong) UITextField *Username;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *EditprofileActivity;



@end

@implementation FacebookTwitterIntermidiat
@synthesize whiteBackView;
@synthesize EditProfileScroll = _EditProfileScroll;
@synthesize FistName;
@synthesize LastName;
@synthesize Email;
@synthesize Username;
@synthesize EditprofileActivity;
@synthesize isCommingFromFacebook;
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
    
    [self HideNavigationBar];
    [EditprofileActivity setHidden:YES];
    
    EditProfHelper = [[HelperClass alloc] init];
    operationQ=[[NSOperationQueue alloc]init];
    
    [EditProfHelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    NSUserDefaults *userDetail=[NSUserDefaults standardUserDefaults];
    userID=[userDetail valueForKey:@"userid"];
    NSLog(@"The value for key id:%@",userID);
    NSLog(@"The value for the basik update:%hhd",isCommingFromFacebook);
    if (isCommingFromFacebook)
    {
         [self mypoeration];
    }
   else
   {
       [self MytwitterImage];
   }
  
    // Assigning scrollview property
    
    _EditProfileScroll.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + self.view.frame.size.height/4);
    _EditProfileScroll.scrollEnabled = YES;
    _EditProfileScroll.delegate = self;
    _EditProfileScroll.backgroundColor = [UIColor clearColor];
    _EditProfileScroll.userInteractionEnabled = YES;
    
    self.whiteBackView.layer.cornerRadius=10.0f;
    self.whiteBackView.layer.borderWidth=1.0f;
    self.whiteBackView.layer.borderColor=[UIColor whiteColor].CGColor;
    self.whiteBackView.backgroundColor=UIColorFromRGB(0xffffff);
    //[EditProfHelper SetupHeaderView:self.view viewController:self];
    UILabel *editProfile=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 300, 20)];
    editProfile.text=@"";
    editProfile.textAlignment=NSTextAlignmentCenter;
    editProfile.textColor=[UIColor blackColor];
    editProfile.font=[UIFont fontWithName:globalTEXTFIELDPLACEHOLDERFONT size:13.0f];
    [whiteBackView addSubview:editProfile];
    
    
    UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(10, 45, 200, 20)];
    lable1.font=[UIFont systemFontOfSize:13];
    lable1.textColor=[UIColor blackColor];
    lable1.textAlignment=NSTextAlignmentLeft;
    lable1.text=@"First Name";
    [whiteBackView addSubview:lable1];
    UIView *textbackground=[[UIView alloc]initWithFrame:CGRectMake(10, 65, 280, 25)];
    textbackground.layer.borderColor=UIColorFromRGB(0xcccccc).CGColor;
    textbackground.layer.borderWidth=1.0f;
    textbackground.layer.cornerRadius=1.0f;
    textbackground.backgroundColor=[UIColor clearColor];
    [whiteBackView addSubview:textbackground];
    FistName=[[UITextField alloc]initWithFrame:CGRectMake(15, 65, 270, 25)];
    FistName.backgroundColor=[UIColor clearColor];
    FistName.borderStyle=UITextBorderStyleNone;
    FistName.textColor=[UIColor darkGrayColor];
    FistName.font=[UIFont systemFontOfSize:12];
    FistName.delegate=self;
    [FistName addTarget:self action:@selector(textFieldDidBeginEditing) forControlEvents:UIControlEventEditingDidBegin];
    [FistName addTarget:self action:@selector(textFieldDidEndEditing) forControlEvents:UIControlEventEditingDidEndOnExit];
    [whiteBackView addSubview:FistName];
    
    UILabel *lable2=[[UILabel alloc]initWithFrame:CGRectMake(10, 100, 200, 20)];
    lable2.font=[UIFont systemFontOfSize:13];
    lable2.textColor=[UIColor blackColor];
    lable2.textAlignment=NSTextAlignmentLeft;
    lable2.text=@"Last Name";
    [whiteBackView addSubview:lable2];
    UIView *textbackground2=[[UIView alloc]initWithFrame:CGRectMake(10, 120, 280, 25)];
    textbackground2.layer.borderColor=UIColorFromRGB(0xcccccc).CGColor;
    textbackground2.layer.borderWidth=1.0f;
    textbackground2.layer.cornerRadius=1.0f;
    textbackground2.backgroundColor=[UIColor clearColor];
    [whiteBackView addSubview:textbackground2];
    
    
    LastName=[[UITextField alloc]initWithFrame:CGRectMake(15, 120, 270, 25)];
    LastName.backgroundColor=[UIColor clearColor];
    LastName.borderStyle=UITextBorderStyleNone;
    LastName.textColor=[UIColor darkGrayColor];
    LastName.font=[UIFont systemFontOfSize:12];
    LastName.delegate=self;
    [LastName addTarget:self action:@selector(textFieldDidBeginEditing) forControlEvents:UIControlEventEditingDidBegin];
    [LastName addTarget:self action:@selector(textFieldDidEndEditing) forControlEvents:UIControlEventEditingDidEndOnExit];
    [whiteBackView addSubview:LastName];
    
    UILabel *lable3=[[UILabel alloc]initWithFrame:CGRectMake(10, 155, 200, 20)];
    lable3.font=[UIFont systemFontOfSize:13];
    lable3.textColor=[UIColor blackColor];
    lable3.textAlignment=NSTextAlignmentLeft;
    lable3.text=@"Email";
    [whiteBackView addSubview:lable3];
    
    
    UIView *textbackground3=[[UIView alloc]initWithFrame:CGRectMake(10, 175, 280, 25)];
    textbackground3.layer.borderColor=UIColorFromRGB(0xcccccc).CGColor;
    textbackground3.layer.borderWidth=1.0f;
    textbackground3.layer.cornerRadius=1.0f;
    textbackground3.backgroundColor=[UIColor clearColor];
    [whiteBackView addSubview:textbackground3];
    
    Email=[[UITextField alloc]initWithFrame:CGRectMake(15, 175, 270, 25)];
    Email.backgroundColor=[UIColor clearColor];
    Email.borderStyle=UITextBorderStyleNone;
    Email.textColor=[UIColor darkGrayColor];
    Email.font=[UIFont systemFontOfSize:12];
    Email.delegate=self;
    [Email addTarget:self action:@selector(textFieldDidBeginEditing) forControlEvents:UIControlEventEditingDidBegin];
    [Email addTarget:self action:@selector(textFieldDidEndEditing) forControlEvents:UIControlEventEditingDidEndOnExit];
    [whiteBackView addSubview:Email];
    
    UILabel *lable4=[[UILabel alloc]initWithFrame:CGRectMake(10, 210, 200, 20)];
    lable4.font=[UIFont systemFontOfSize:13];
    lable4.textColor=[UIColor blackColor];
    lable4.textAlignment=NSTextAlignmentLeft;
    lable4.text=@"Username";
    [whiteBackView addSubview:lable4];
    UIView *textbackground4=[[UIView alloc]initWithFrame:CGRectMake(10, 230, 280, 25)];
    textbackground4.layer.borderColor=UIColorFromRGB(0xcccccc).CGColor;
    textbackground4.layer.borderWidth=1.0f;
    textbackground4.layer.cornerRadius=1.0f;
    textbackground4.backgroundColor=[UIColor clearColor];
    [whiteBackView addSubview:textbackground4];
    Username=[[UITextField alloc]initWithFrame:CGRectMake(15, 230, 270, 25)];
    Username.backgroundColor=[UIColor clearColor];
    Username.borderStyle=UITextBorderStyleNone;
    Username.textColor=[UIColor darkGrayColor];
    Username.font=[UIFont systemFontOfSize:12.0f];
    Username.delegate=self;
    [whiteBackView addSubview:Username];
    
    UILabel *lable5=[[UILabel alloc]initWithFrame:CGRectMake(10, 265, 200, 20)];
    lable5.font=[UIFont systemFontOfSize:13];
    lable5.textColor=[UIColor blackColor];
    lable5.textAlignment=NSTextAlignmentLeft;
    lable5.text=@"Change Photo";
    [whiteBackView addSubview:lable5];
    
    UIView *choseback=[[UIView alloc]initWithFrame:CGRectMake(10, 290, 100, 21)];
    choseback.layer.cornerRadius=4.0f;
    choseback.layer.borderColor=[UIColor lightGrayColor].CGColor;
    choseback.layer.borderWidth=1.0f;
    choseback.backgroundColor=[UIColor whiteColor];
    [whiteBackView addSubview:choseback];
    
    UIButton *SignUp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    SignUp.frame = CGRectMake(10, 290, 100, 21);
    [SignUp setBackgroundColor:[UIColor clearColor]];
    [SignUp setTitle:@"Choose Photo" forState:UIControlStateNormal];
    [SignUp setTitle:@"Choose Photo" forState:UIControlStateSelected];
    [SignUp setTitle:@"Choose Photo" forState:UIControlStateHighlighted];
    [SignUp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [SignUp setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [SignUp setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    SignUp.titleLabel.font=[UIFont systemFontOfSize:10.0f];
    SignUp.layer.borderColor = UIColorFromRGB(0xc5c5c5).CGColor;
    [SignUp addTarget:self action:@selector(choseaPhoto) forControlEvents:UIControlEventTouchUpInside];
    [whiteBackView addSubview:SignUp];
    
    ProfilePIcImageView = [[UIImageView alloc] initWithFrame:CGRectMake(220, 280, 70, 70)];
    Spinner =[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(220+20, 280+20, 20, 20)];
    [Spinner setBackgroundColor:[UIColor lightGrayColor]];
    [Spinner startAnimating];
    [ProfilePIcImageView setContentMode:UIViewContentModeScaleAspectFit];
    
    [ProfilePIcImageView setBackgroundColor:[UIColor clearColor]];
    //[ProfilePIcImageView setImage:[UIImage imageNamed:@"BABY.jpg"]];
    [whiteBackView addSubview:ProfilePIcImageView];
   
    
    [EditProfHelper CreateButtonWithText:100 ycord:340 width:100 height:21 backgroundColor:UIColorFromRGB(0x1aad4b) textcolor:[UIColor whiteColor] labeltext:@"Register" fontName:@"System" fontSize:11 textNameForUIControlStateNormal:@"Register" textNameForUIControlStateSelected:@"Register"textNameForUIControlStateHighlighted:@"Register" textNameForselectedHighlighted:@"Register" selectMethod:@selector(SaveupdatedInfo:) selectEvent:UIControlEventTouchUpInside addView:whiteBackView viewController:self];
    [_EditProfileScroll addSubview:whiteBackView];
//    FistName.text=[userDetail valueForKey:@"first_name"];
//    LastName.text=[userDetail valueForKey:@"last_name"];
//    Email.text=[userDetail valueForKey:@"email"];
//    Username.text=[userDetail valueForKey:@"username"];
    
    FistName.text=[userDetail valueForKey:@"FBfirst_name"];
    LastName.text=[userDetail valueForKey:@"FBlast_name"];
    Email.text=[userDetail valueForKey:@"FBemail"];
    Username.text=[userDetail valueForKey:@"FBusername"];
    
    Username.userInteractionEnabled=YES;
    
    alertmb = [MBAlertView alertWithBody:@"Your username and photo will be publicly available. Please make the necessary changes if you wish to remain anonymous" cancelTitle:nil cancelBlock:nil];
    [alertmb addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
    }];
    [alertmb addToDisplayQueue];
    
}
- (void)textFieldDidEndEditing {
    [UIView animateWithDuration:.25 animations:^{
        _EditProfileScroll.contentOffset = CGPointMake(0, 0);
    }];
}

- (void)textFieldDidBeginEditing {
    [_EditProfileScroll setContentOffset:CGPointMake(0, 50) animated:YES];
}
- (void)textFieldDidBeginEditingone {
    [UIView animateWithDuration:.25 animations:^{
        _EditProfileScroll.contentOffset = CGPointMake(0, 120);
    }];
}

-(void)MytwitterImage
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSUserDefaults *userDetais=[NSUserDefaults standardUserDefaults];
        NSString *urlone =[userDetais objectForKey:@"user_image"];
        
        urlString=[NSURL URLWithString:urlone];
        UIImage *image1=[UIImage imageWithData:[NSData dataWithContentsOfURL:urlString]];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [Spinner stopAnimating];
            [ProfilePIcImageView setImage:image1];
            
            
        });
        
    });
}
-(void)mypoeration
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        NSString *urlone = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=200&height=200&redirect=false",userID];
        NSURL *url=[NSURL URLWithString:urlone];
        NSData *data=[NSData dataWithContentsOfURL:url];
        NSDictionary *mainDic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"main dic is %@", mainDic);
        
        NSDictionary *imageDic=[mainDic valueForKey:@"data"];
        NSString *userImge=[imageDic valueForKey:@"url"];
        urlString=[NSURL URLWithString:userImge];
        UIImage *image1=[UIImage imageWithData:[NSData dataWithContentsOfURL:urlString]];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [Spinner stopAnimating];
            [ProfilePIcImageView setImage:image1];
            
            
        });
        
    });
}

-(IBAction)SaveupdatedInfo:(id)sender
{
    NSLog(@"check classssssss");
    
    
    BOOL ChekeEdit=YES;
    NSString *trimmedusremail = [[self.Email text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if(![trimmedusremail length]>0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter your email..." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        ChekeEdit=NO;
        return;
    }
    
    if([trimmedusremail length]>0)
    {
        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        
        if ([emailTest evaluateWithObject:Email.text] == NO)
        {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Enter a valid Email address" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            ChekeEdit=NO;
            return;
        }
        
    }
    if (![EditProfHelper CleanTextField:Username.text].length>1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"User name should have minimum 4 character" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        ChekeEdit=NO;
        return;
    }
    if (![EditProfHelper CleanTextField:FistName.text].length>1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"First name can't left blank" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        ChekeEdit=NO;
        return;
    }
    if (![EditProfHelper CleanTextField:LastName.text].length>1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Last name can't left blank" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        ChekeEdit=NO;
        return;
    }
    if (ChekeEdit==YES)
    {
        //[self performSelectorOnMainThread:@selector(theActivity) withObject:nil waitUntilDone:NO];
        [EditprofileActivity startAnimating];
 
    
    
    
    
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
          
          AppDelegate *mainDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
          NSString *devicetocken;
        
            NSUserDefaults *prefss = [NSUserDefaults standardUserDefaults];
            devicetocken = [prefss objectForKey:@"USERDEVICETOKEN"];
        
          NSString *modename;
          if (isCommingFromFacebook==TRUE)
          {
              modename=@"facebook_register" ;
          }
          else
          {
              modename=@"twitter_register";
          }
          
          NSUserDefaults *userDetais=[NSUserDefaults  standardUserDefaults];
          NSString *REturnedURL = [NSString stringWithFormat:@"http://esolzdemos.com/lab3/trafficcop/IOS/appweb.php?username=%@&connectid=%@&first_name=%@&last_name=%@&mode=%@&device_token=%@&email=%@",[Username.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[userDetais valueForKey:@"userid"],[FistName.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[LastName.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],modename,[NSString stringWithFormat:@"%@",[prefss objectForKey:@"USERDEVICETOKEN"]],[Email.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
       // [userDetais valueForKey:@"id"]
        NSLog(@"chk rt one idd  is -->>  %@", [userDetais valueForKey:@"id"]);
        NSLog(@"chk rt one user idddd -->>  %@", [userDetais valueForKey:@"userid"]);
        
        
          NSLog(@"The return url:%@",REturnedURL);
          NSData *imageData = UIImageJPEGRepresentation(ProfilePIcImageView.image, 0.6);
          
          
          NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
          [request setURL:[NSURL URLWithString:REturnedURL]];
          [request setHTTPMethod:@"POST"];
          
          if(imageData > 0)
          {
              
              
              NSLog(@"the data formetnotupdate Successfully");
              NSString *boundary = @"---------------------------14737809831466499882746641449";
              NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
              [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
              
              NSMutableData *body = [NSMutableData data];
              [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
              [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_image\"; filename=\"image.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
              [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
              [body appendData:[NSData dataWithData:imageData]];
              [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];	[request setHTTPBody:body];
              
          }
          
          NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

        NSLog(@"ret dataaa %@", returnData);
        
          
        
         // NSData *returnData=[NSData dataWithContentsOfURL:[NSURL URLWithString:REturnedURL]];
          NSError *error;
          NSDictionary* Retrneddata  = [NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:&error];
          NSLog(@"jsonData ---- %@",Retrneddata);
          
          dispatch_async(dispatch_get_main_queue(), ^{
              
              for (NSDictionary *statData in [Retrneddata objectForKey:@"extraparam"])
              
              {
                  
                  
                  
                  if([[statData objectForKey:@"response"] isEqualToString:GLOBALERRSTRING])
                  {
                     
                      [EditprofileActivity stopAnimating];
                      [EditprofileActivity setHidden:YES];
                      UIAlertView *alert=[[UIAlertView alloc]initWithTitle:[statData objectForKey:@"response"] message:[statData objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                      [alert show];
//                      alertmb = [MBAlertView alertWithBody:[statData objectForKey:@"message"] cancelTitle:@" " cancelBlock:nil];
//                      [alertmb addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
//                      }];
//                      [alertmb addToDisplayQueue];
                  }
                  else
                  {
                      for (NSDictionary *statDataone in [Retrneddata objectForKey:@"userdetails"])
                      {
                          
                         
//                          NSLog(@"This is my image");
//                          NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//                          [prefs setObject:[statDataone objectForKey:@"first_name"] forKey:@"first_name"];
//                          [prefs setObject:[statDataone objectForKey:@"last_name"] forKey:@"last_name"];
//                         // NSString *userImage=[NSString stringWithFormat:@"%@%@",@"esolzdemos.com/lab3/trafficcop/images/profile/thumb/",]
//                          [prefs setObject:[statDataone objectForKey:@"user_image"] forKey:@"user_image"];
//                          [prefs setObject:[statDataone objectForKey:@"userid"] forKey:@"userid"];
//                          [prefs setObject:[statDataone objectForKey:@"username"] forKey:@"username"];
//                          [prefs setObject:[statDataone objectForKey:@"email"] forKey:@"email"];
//                          [prefs setObject:@"" forKey:@"password"];
//                          [[NSUserDefaults standardUserDefaults] synchronize];
                          
                          
                          NSLog(@"This is my image");
                          NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                          [prefs setObject:[statDataone objectForKey:@"first_name"] forKey:@"first_name"];
                          [prefs setObject:[statDataone objectForKey:@"last_name"] forKey:@"last_name"];
                          // NSString *userImage=[NSString stringWithFormat:@"%@%@",@"esolzdemos.com/lab3/trafficcop/images/profile/thumb/",]
                          [prefs setObject:[statDataone objectForKey:@"user_image"] forKey:@"user_image"];
                          [prefs setObject:[statDataone objectForKey:@"userid"] forKey:@"userid"];
                          [prefs setObject:[statDataone objectForKey:@"username"] forKey:@"username"];
                          [prefs setObject:[statDataone objectForKey:@"email"] forKey:@"email"];
                          [prefs setObject:@"" forKey:@"password"];
                          
                          
                          NSLog(@"chkkkkk999 %@--- %@---  %@ ---", [prefs objectForKey:@"username"], [prefs objectForKey:@"userid"], [prefs objectForKey:@"email"]);
                          
                          
                      }
                      
                      [self performSelectorOnMainThread:@selector(DoneUpload)
                                             withObject:nil
                                          waitUntilDone:YES];
                  }
              }
        
                           // [self performSelectorOnMainThread:@selector(DoneUpload) withObject:nil waitUntilDone:YES];

          
          });
      });
}
}
-(void)ChangetheDetails
{
    
    BOOL ChekeEdit=YES;
    NSString *trimmedusremail = [[self.Email text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if(![trimmedusremail length]>0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter your email..." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        ChekeEdit=NO;
        return;
    }
    
    if([trimmedusremail length]>0)
    {
        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        
        if ([emailTest evaluateWithObject:Email.text] == NO)
        {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Enter a valid Email address" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            ChekeEdit=NO;
            return;
        }
    }
    if ([EditProfHelper CleanTextField:Username.text].length<5) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"User name should have minimum 4 character" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        ChekeEdit=NO;
        return;
    }
    if ([EditProfHelper CleanTextField:FistName.text].length<1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"First name can't left blank" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        ChekeEdit=NO;
        return;
    }
    if ([EditProfHelper CleanTextField:LastName.text].length<1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Last name can't left blank" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        ChekeEdit=NO;
        return;
    }
    if (ChekeEdit==YES)
    {
        //[self performSelectorOnMainThread:@selector(theActivity) withObject:nil waitUntilDone:NO];
        [EditprofileActivity startAnimating];
         NSInvocationOperation *operation=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(UploadImageinthread) object:nil];
         [operationQ addOperation:operation];
    }
    
}

-(void)UploadImageinthread
{
//    NSString *Stringurl=[NSString stringWithFormat:@"%@userid=%@&mode=edit_account&email=%@&username=%@&first_name=%@&last_name=%@",DemoProfile,userID,[[EditProfHelper CleanTextField:self.Email.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[EditProfHelper CleanTextField:self.Username.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[EditProfHelper CleanTextField:self.FistName.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[EditProfHelper CleanTextField:self.LastName.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSLog(@"The change profile Details:%@",Stringurl);
//    // exit(0);
    
    AppDelegate *mainDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *devicetocken;
    NSUserDefaults *prefss = [NSUserDefaults standardUserDefaults];
    devicetocken = [prefss objectForKey:@"USERDEVICETOKEN"];
    NSString *modename;
    if (isCommingFromFacebook==TRUE)
    {
        modename=@"facebook_register" ;
    }
    else
    {
       modename=@"twitter_register";
    }
   
    NSUserDefaults *userDetais=[NSUserDefaults  standardUserDefaults];
    [FacebookUserData setObject:Username.text forKey:@"username"];
    [FacebookUserData setObject:[userDetais valueForKey:@"id"] forKey:@"connectid"];
    [FacebookUserData setObject:FistName.text forKey:@"first_name"];
    [FacebookUserData setObject:LastName.text forKey:@"last_name"];
    
    [FacebookUserData setObject:modename forKey:@"mode"];
    
    [FacebookUserData setObject:devicetocken forKey:@"device_token"];
    [FacebookUserData setObject:@"" forKey:@"password"];
    
    NSString *REturnedURL = [NSString stringWithFormat:@"http://esolzdemos.com/lab3/trafficcop/IOS/appweb.php?username=%@&connectid=%@&first_name=%@&last_name=%@&mode=%@&device_token=%@&email=%@",Username.text,[userDetais valueForKey:@"id"],FistName.text,LastName.text,modename,devicetocken,Email.text];
    NSData *returnData=[NSData dataWithContentsOfURL:[NSURL URLWithString:REturnedURL]];
    NSError *error;
    NSDictionary* Retrneddata  = [NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:&error];
    NSLog(@"jsonData ---- %@",Retrneddata);
    //NSString *REturnedURL = [EditProfHelper CallURLForServerReturn:FacebookUserData URL:LOGINPAGE];
    
    NSLog(@"The return url:%@",REturnedURL);
//    NSData *imageData = UIImageJPEGRepresentation(ProfilePIcImageView.image, 0.6);
//    
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString:REturnedURL]];
//    [request setHTTPMethod:@"POST"];
//    
//    if(imageData > 0)
//    {
//        
//        
//        NSLog(@"the data formetnotupdate Successfully");
//        NSString *boundary = @"---------------------------14737809831466499882746641449";
//        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
//        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
//        
//        NSMutableData *body = [NSMutableData data];
//        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_image\"; filename=\"image.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[NSData dataWithData:imageData]];
//        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];	[request setHTTPBody:body];
//        
//    }
//    
//    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    
    
//    NSDictionary *Retrneddata=[NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:nil];
//     NSLog(@"Retrneddata ---- %@",Retrneddata);
    
    
    
   // NSDictionary *Retrneddata = [EditProfHelper executeFetch:REturnedURL];
    
     for (NSDictionary *statData in [Retrneddata objectForKey:@"extraparam"]) {
     
    
     
     if([[statData objectForKey:@"response"] isEqualToString:GLOBALERRSTRING])
     {
     alertmb = [MBAlertView alertWithBody:[statData objectForKey:@"message"] cancelTitle:@" " cancelBlock:nil];
     [alertmb addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
     }];
     [alertmb addToDisplayQueue];
     }
     else
     {
     for (NSDictionary *statDataone in [Retrneddata objectForKey:@"userdetails"])
     {
     
     NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
     [prefs setObject:[statDataone objectForKey:@"first_name"] forKey:@"first_name"];
     [prefs setObject:[statDataone objectForKey:@"last_name"] forKey:@"last_name"];
     [prefs setObject:[statDataone objectForKey:@"user_image"] forKey:@"user_image"];
     [prefs setObject:[statDataone objectForKey:@"userid"] forKey:@"userid"];
     [prefs setObject:[statDataone objectForKey:@"username"] forKey:@"username"];
     [prefs setObject:[statDataone objectForKey:@"email"] forKey:@"email"];
     [prefs setObject:@"" forKey:@"password"];
     [[NSUserDefaults standardUserDefaults] synchronize];
     
     [self performSelectorOnMainThread:@selector(DoneUpload)
     withObject:nil
     waitUntilDone:YES];
     
     }
     }
     }
//    
//    
//    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    
//    NSDictionary *MainDic=[NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:nil];
//    MassAge=[MainDic valueForKey:@"message"];
    [self performSelectorOnMainThread:@selector(DoneUpload) withObject:nil waitUntilDone:YES];
    
}
-(void)DoneUpload
{
    [EditprofileActivity stopAnimating];
    [EditprofileActivity setHidden:YES];
    //    [EditProfHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
    AppDelegate *maindelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    DashboardViewController *dashbord=[[DashboardViewController alloc]init];
    [maindelegate SetUpTabbarControllerwithcenterView:dashbord];
    
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:MassAge delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//    [alert show];
}

-(void)theActivity
{
    [EditProfHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
}

#pragma mark -
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView animateWithDuration:.25 animations:^{
        _EditProfileScroll.contentOffset = CGPointMake(0, 0);
    }];
    [textField resignFirstResponder];
    return YES;
}
-(void)choseaPhoto {
    MBAlertView *destruct = [MBAlertView alertWithBody:@"Select my picture from" cancelTitle:nil cancelBlock:nil];
    destruct.imageView.image = [UIImage imageNamed:@"image.png"];
    [destruct addButtonWithText:@"Album" type:MBAlertViewItemTypeDestructive block:^{
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.allowsEditing = YES;
        //[self presentModalViewController:picker animated:YES];
        [self presentViewController:picker animated:YES completion:nil];
    }];
    [destruct addButtonWithText:@"Camera" type:MBAlertViewItemTypeDestructive block:^{
#if TARGET_IPHONE_SIMULATOR
        {
            MBAlertView *aler = [MBAlertView alertWithBody:@"Device doesnot support camera,Select my picture from album?" cancelTitle:@"Cancel" cancelBlock:nil];
            [aler addButtonWithText:@"Yes" type:MBAlertViewItemTypeDestructive block:^{
                NSLog(@"Get Image From Album");
                UIImagePickerController * picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                picker.allowsEditing = YES;
                picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                [self presentViewController:picker animated:YES completion:nil];
                //[self presentModalViewController:picker animated:YES];
            }];
            [aler addToDisplayQueue];
        }
#else
        {
            UIImagePickerController * pickerone = [[UIImagePickerController alloc] init];
            pickerone.delegate = self;
            pickerone.allowsEditing = YES;
            pickerone.sourceType = UIImagePickerControllerSourceTypeCamera;
            //self.saveButton.enabled = YES;
            [self presentModalViewController:pickerone animated:YES];
        }
#endif
    }];
    [destruct addToDisplayQueue];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [[picker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    UIImage* originalImage = nil;
    originalImage = [info objectForKey:UIImagePickerControllerEditedImage];
    if(originalImage==nil)
    {
        NSLog(@"image picker original");
        originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    } else {
        
        NSLog(@"image picker editedImage");
    }
    if(originalImage==nil)
    {
        NSLog(@"image picker croprect");
        originalImage = [info objectForKey:UIImagePickerControllerCropRect];
    }
    [ProfilePIcImageView setImage:originalImage];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [[picker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIBarButtonItem Callbacks

 -(void)textFieldDidBeginEditing:(UITextField *)textField
  {
      if (textField==Username)
      {
          [_EditProfileScroll setContentOffset:CGPointMake(0, 50) animated:YES];
      }
  }

- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
-(IBAction)hideKeyboard:(id)sender {
    [(UITextField*)sender resignFirstResponder];
}
-(IBAction)movetozero:(id)sender {
    [(UITextField*)sender resignFirstResponder];
    [_EditProfileScroll setContentOffset:CGPointZero animated:YES];
}
-(IBAction)movetotop:(id)sender {
    [_EditProfileScroll setContentOffset:CGPointMake(0, 100) animated:YES];
}
-(IBAction)movetotopone:(id)sender {
    [_EditProfileScroll setContentOffset:CGPointMake(0, 150) animated:YES];
}
- (IBAction)goback:(id)sender
{
   // [self.navigationController popViewControllerAnimated:YES];
    
    CATransition* transition = [EditProfHelper AddAnimationOnView];
    LoginViewController *control1 = [[LoginViewController alloc] init];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController] pushViewController:control1 animated:NO];
}
@end
