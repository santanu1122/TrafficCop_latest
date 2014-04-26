//
//  ForgetPassWordViewController.m
//  TrafficCop
//
//  Created by macbook_ms on 06/12/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import "ForgetPassWordViewController.h"
#import "AppDelegate.h"
#import "VarifyCodeViewController.h"
#import "ChangepassViewController.h"
#import "MFSideMenu.h"
#import "LoginViewController.h"

@interface ForgetPassWordViewController ()
{
    UITextField *EmilTxt;
    UILabel *alertLable;
    NSString *SuccessStr;
}
@property (strong, nonatomic) IBOutlet UIView *headerView;

@end

@implementation ForgetPassWordViewController
@synthesize headerView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

- (void)rightSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{}];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [headerView setBackgroundColor:[UIColor colorWithRed:(247/255.0) green:(247/255.0) blue:(247/255.0) alpha:1]];
    ForgetPassWordHelper=[[HelperClass alloc]init];
    UIView *MainView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 400)];
    [ForgetPassWordHelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    MainView.backgroundColor=[UIColor clearColor];
    [self.ForgetScroll addSubview:MainView];
    
    [ForgetPassWordHelper CreatelabelWithValueCenter:87 ycord:20 width:210 height:40 backgroundColor:[UIColor clearColor] textcolor:UIColorFromRGB(0x00002b) labeltext:@"Forgot Password" fontName:@"Arial" fontSize:16 addView:MainView];
    
    [ForgetPassWordHelper CreatelabelWithValueCenter:20 ycord:55 width:280 height:30 backgroundColor:[UIColor clearColor] textcolor:[UIColor blackColor] labeltext:@"We need some information to verify your ID.This protects your account from unauthorised access" fontName:@"Arial" fontSize:13 addView:MainView];
    
    
    UIView *EnterEmailView=[[UIView alloc]initWithFrame:CGRectMake(10, 100, 300, 180)];
    EnterEmailView.layer.borderColor=[UIColor whiteColor].CGColor;
    EnterEmailView.layer.borderWidth=1.0f;
    EnterEmailView.layer.cornerRadius=4.0f;
    [EnterEmailView setBackgroundColor:[UIColor whiteColor]];
    [MainView addSubview:EnterEmailView];
    
    
    
    UILabel *theEmailLable=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, 200, 20)];
    theEmailLable.textColor=[UIColor lightGrayColor];
    theEmailLable.text=@"Enter Your Email";
    theEmailLable.textAlignment=NSTextAlignmentLeft;
    theEmailLable.font=[UIFont systemFontOfSize:12];
    [EnterEmailView addSubview:theEmailLable];
    
    
    UIView *textBackView=[[UIView alloc]initWithFrame:CGRectMake(10, 60, 280, 25)];
    textBackView.backgroundColor=[UIColor whiteColor];
    textBackView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    textBackView.layer.borderWidth=1.0f;
    textBackView.layer.cornerRadius=2.0f;
    [EnterEmailView addSubview:textBackView];
    EmilTxt=[[UITextField alloc]initWithFrame:CGRectMake(15, 60, 270, 25)];
    EmilTxt.backgroundColor=[UIColor clearColor];
    
    EmilTxt.borderStyle=UITextBorderStyleNone;
    EmilTxt.textColor=[UIColor blackColor];
    EmilTxt.font=[UIFont systemFontOfSize:12];
    EmilTxt.delegate=self;
    [EnterEmailView addSubview:EmilTxt];
    [ForgetPassWordHelper CreateButtonWithText:100 ycord:96 width:100 height:25 backgroundColor:UIColorFromRGB(0x1aad4b) textcolor:[UIColor whiteColor] labeltext:@"Send Me" fontName:globalTEXTFIELDPLACEHOLDERFONT fontSize:10 textNameForUIControlStateNormal:@"Send Me" textNameForUIControlStateSelected:@"Send Me" textNameForUIControlStateHighlighted:@"Send Me" textNameForselectedHighlighted:globalTEXTFIELDPLACEHOLDERFONT selectMethod:@selector(Sendingemail:) selectEvent:UIControlEventTouchUpInside addView:EnterEmailView viewController:self];
    alertLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 135, 300, 25)];
    alertLable.textColor=[UIColor redColor];
    alertLable.textAlignment=NSTextAlignmentCenter;
    
    alertLable.font=[UIFont systemFontOfSize:10];
    [EnterEmailView addSubview:alertLable];
    
    
}
-(IBAction)Sendingemail:(id)sender
{
    BOOL Flag=YES;
    
    NSString *trimmedusremail = [[EmilTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if(![trimmedusremail length]>0)
    {
        alertLable.text=@"Enter Your Email";
        
        Flag=NO;
        return;
    }
    
    if([trimmedusremail length]>0)
    {
        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        
        if ([emailTest evaluateWithObject:EmilTxt.text] == NO)
        {
            alertLable.text=@"Enter a valid Email address";
            Flag=NO;
            return;
        }
    }
    if (Flag==YES)
    {
       
       
        NSString *StringUrl=[NSString stringWithFormat:@"%@mode=verify_email&email=%@",Domain5,trimmedusremail];
        NSLog(@"The string url:%@",StringUrl);
        NSURL *url=[NSURL URLWithString:StringUrl];
        NSData *data=[NSData dataWithContentsOfURL:url];
        NSDictionary *mainDic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSDictionary *ExtraParam=[mainDic valueForKey:@"extraparam"];
        NSString *massAge=[ExtraParam valueForKey:@"message"];
        SuccessStr=[ExtraParam valueForKey:@"response"];
        if ([SuccessStr isEqualToString:@"success"])
        {
           
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:SuccessStr message:massAge delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
            [alert show];
            
        }
        else
        {
          
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:SuccessStr message:massAge delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
            [alert show];
        }
 

        }
}

 - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
   if ([SuccessStr isEqualToString:@"success"])
   {
       VarifyCodeViewController *varify=[[VarifyCodeViewController alloc]initWithNibName:@"VarifyCodeViewController" bundle:nil];
       [self.navigationController pushViewController:varify animated:YES];
   }
 
}

-(IBAction)Sendback:(id)sender {
    LoginViewController *loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:Nil];
    [self.navigationController pushViewController:loginView animated:YES];
}

-(void)TheLoader
{
      [ForgetPassWordHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
