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

@interface FacebookTwitterIntermidiat ()<UIImagePickerControllerDelegate>
{
NSString *userID;
//UIImageView *ProfilePIcImageView;
NSOperationQueue *operationQ;
NSString *MassAge;
MBAlertView *alertmb;
NSMutableDictionary *FacebookUserData;
NSURL *urlString;
UIActivityIndicatorView *Spinner;
    UISwitch *termsCondition;
    UILabel *labelTerm;
    BOOL termsAccept;
}
//@property (nonatomic, strong) UITextField *FistName;
//@property (nonatomic, strong) UITextField *LastName;
//@property (nonatomic, strong) UITextField *Email;
//@property (nonatomic, strong) UITextField *Username;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *EditprofileActivity;
@property (strong, nonatomic) IBOutlet UITextField *FistName;
@property (strong, nonatomic) IBOutlet UITextField *LastName;
@property (strong, nonatomic) IBOutlet UITextField *Email;
@property (strong, nonatomic) IBOutlet UITextField *Username;
@property (strong, nonatomic) IBOutlet UIImageView *ProfilePIcImageView;
@property (strong, nonatomic) IBOutlet UILabel *alertLabel;



@end

@implementation FacebookTwitterIntermidiat
@synthesize ProfilePIcImageView;
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
    termsAccept=NO;
    [self HideNavigationBar];
    [EditprofileActivity setHidden:YES];
    
    EditProfHelper = [[HelperClass alloc] init];
    operationQ=[[NSOperationQueue alloc]init];
    
    _alertLabel.textColor=UIColorFromRGB(0xa6a6a6);
    _alertLabel.font=[UIFont fontWithName:GLOBALTEXTFONT size:15];
    _alertLabel.text=@"Your username and photo will be publicly available. Please make the necessary changes if you wish to remain anonymous";
    
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
    
    
    
    
    
    
    FistName.font=[UIFont fontWithName:GLOBALTEXTFONT size:13];
    FistName.delegate=self;
    [FistName addTarget:self action:@selector(textFieldDidBeginEditing) forControlEvents:UIControlEventEditingDidBegin];
    [FistName addTarget:self action:@selector(textFieldDidEndEditing) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    
    
    
    LastName.font=[UIFont fontWithName:GLOBALTEXTFONT size:13];
    LastName.delegate=self;
    [LastName addTarget:self action:@selector(textFieldDidBeginEditing) forControlEvents:UIControlEventEditingDidBegin];
    [LastName addTarget:self action:@selector(textFieldDidEndEditing) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
   
    
    
    Email.font=[UIFont fontWithName:GLOBALTEXTFONT size:13];
    Email.delegate=self;
    [Email addTarget:self action:@selector(textFieldDidBeginEditing) forControlEvents:UIControlEventEditingDidBegin];
    [Email addTarget:self action:@selector(textFieldDidEndEditing) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    
   
    Username.font=[UIFont fontWithName:GLOBALTEXTFONT size:13];
    Username.delegate=self;
    [Username addTarget:self action:@selector(textFieldDidBeginEditing) forControlEvents:UIControlEventEditingDidBegin];
    [Username addTarget:self action:@selector(textFieldDidEndEditing) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    
    
//    UIButton *SignUp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    SignUp.frame = CGRectMake(10, 290, 100, 21);
//    [SignUp setBackgroundColor:[UIColor clearColor]];
//    [SignUp setTitle:@"Choose Photo" forState:UIControlStateNormal];
//    [SignUp setTitle:@"Choose Photo" forState:UIControlStateSelected];
//    [SignUp setTitle:@"Choose Photo" forState:UIControlStateHighlighted];
//    [SignUp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [SignUp setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
//    [SignUp setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
//    SignUp.titleLabel.font=[UIFont systemFontOfSize:10.0f];
//    SignUp.layer.borderColor = UIColorFromRGB(0xc5c5c5).CGColor;
//    [SignUp addTarget:self action:@selector(choseaPhoto) forControlEvents:UIControlEventTouchUpInside];
//    [whiteBackView addSubview:SignUp];
    
    termsCondition=[[UISwitch alloc]initWithFrame:CGRectMake(10, 325, 40, 15)];
    [termsCondition addTarget:self action: @selector(flip:) forControlEvents:UIControlEventValueChanged];
    [whiteBackView addSubview:termsCondition];
    labelTerm=[[UILabel alloc]initWithFrame:CGRectMake(70,325, 200, 25)];
    labelTerm.font=[UIFont fontWithName:globalTEXTFIELDPLACEHOLDERFONT size:13.0f];
    labelTerm.text=@"accept all terms & conditions.";
    [whiteBackView addSubview:labelTerm];
    
    
    
    Spinner =[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(220+20, 280+20, 20, 20)];
    [Spinner setBackgroundColor:[UIColor lightGrayColor]];
    [Spinner startAnimating];
    [ProfilePIcImageView setContentMode:UIViewContentModeScaleAspectFit];
    
    
    //[ProfilePIcImageView setImage:[UIImage imageNamed:@"BABY.jpg"]];
    
    
    [self SetroundborderWithborderWidth:2.0f WithColour:UIColorFromRGB(0xc9c9c9) ForImageview:ProfilePIcImageView];
    
    [EditProfHelper CreateButtonWithText:100 ycord:360 width:100 height:21 backgroundColor:UIColorFromRGB(0x1aad4b) textcolor:[UIColor whiteColor] labeltext:@"Register" fontName:GLOBALTEXTFONT fontSize:11 textNameForUIControlStateNormal:@"Register" textNameForUIControlStateSelected:@"Register"textNameForUIControlStateHighlighted:@"Register" textNameForselectedHighlighted:@"Register" selectMethod:@selector(SaveupdatedInfo:) selectEvent:UIControlEventTouchUpInside addView:whiteBackView viewController:self];
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
    
//    alertmb = [MBAlertView alertWithBody:@"Your username and photo will be publicly available. Please make the necessary changes if you wish to remain anonymous" cancelTitle:nil cancelBlock:nil];
//    [alertmb addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
//    }];
//    [alertmb addToDisplayQueue];
    
    UIImageView *ImageOverlay = [[UIImageView alloc] initWithFrame:CGRectMake(191, 363, 70, 70)];
    [ImageOverlay setImage:[UIImage imageNamed:@"out-line.png"]];
    [self.view addSubview:ImageOverlay];
}
-(IBAction)flip:(id)sender


{
    
    if([sender isOn])
    {
        NSLog(@"ON");
    }
    else
    {
        NSLog(@"OFF");
        
    }
}
-(void)SetroundborderWithborderWidth:(CGFloat)BorderWidth WithColour:(UIColor *)RGB ForImageview:(UIImageView *)ImageView
{
    
    [[ImageView layer] setCornerRadius:[ImageView frame].size.width/2.0f];
    [[ImageView layer] setBorderColor:[RGB CGColor]];
    [[ImageView layer] setBorderWidth:BorderWidth];
    [[ImageView layer] setMasksToBounds:YES];
    
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

-(void)SaveupdatedInfo:(id)sender
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
    if(termsAccept==NO)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please accept the terms and condition." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
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
          NSString *REturnedURL = [NSString stringWithFormat:@"%@appweb.php?username=%@&connectid=%@&first_name=%@&last_name=%@&mode=%@&device_token=%@&email=%@",DomainURL,[Username.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[userDetais valueForKey:@"userid"],[FistName.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[LastName.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],modename,[NSString stringWithFormat:@"%@",[prefss objectForKey:@"USERDEVICETOKEN"]],[Email.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
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

                  }
                  else
                  {
                      for (NSDictionary *statDataone in [Retrneddata objectForKey:@"userdetails"])
                      {
                          
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
    
    NSString *REturnedURL = [NSString stringWithFormat:@"%@appweb.php?username=%@&connectid=%@&first_name=%@&last_name=%@&mode=%@&device_token=%@&email=%@",DomainURL,Username.text,[userDetais valueForKey:@"id"],FistName.text,LastName.text,modename,devicetocken,Email.text];
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
- (IBAction)changePhotoAction:(id)sender {
//    [self choseaPhoto];
    NSLog(@"It is fired");
    UIImagePickerController  *eImagePickerController = [[UIImagePickerController alloc] init];
    eImagePickerController.delegate = self;
    [self presentViewController:eImagePickerController animated:YES completion:nil];
}
- (IBAction)acceptTermsAction:(UISwitch *)sender {
    termsAccept=sender.isOn;
    NSLog(@"Terms %@",sender.isOn?@"Accepted" : @"Rejected");
}


@end
