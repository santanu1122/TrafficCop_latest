//
//  VarifyCodeViewController.m
//  TrafficCop
//
//  Created by macbook_ms on 06/12/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//http://www.esolzdemos.com/lab3/trafficcop/IOS/forgot.php?mode=verify_code&code=0cac6a581dfe4356d2b0c796f5216617

#import "VarifyCodeViewController.h"
#import "AppDelegate.h"
#import "ChangepassViewController.h"
#import "AppDelegate.h"
#import "MFSideMenu.h"
@interface VarifyCodeViewController ()
{
    NSString *SuccessStr;
}
@property (nonatomic, strong) UITextField *VerifyCodeText;
@property (strong, nonatomic) IBOutlet UIView *Headerview;

@end

@implementation VarifyCodeViewController
@synthesize TheUsermassage;
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
    
    [self.Headerview setBackgroundColor:[UIColor colorWithRed:(247/255.0) green:(247/255.0) blue:(247/255.0) alpha:1]];
    VarifyCodeHelper=[[HelperClass alloc]init];
    UIView *MainView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 400)];
    [VarifyCodeHelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    MainView.backgroundColor=[UIColor clearColor];
    [self.VarifyCodeScroll addSubview:MainView];
    
    [VarifyCodeHelper CreatelabelWithValueCenter:87 ycord:20 width:210 height:40 backgroundColor:[UIColor clearColor] textcolor:UIColorFromRGB(0x00002b) labeltext:@"Forgot Password" fontName:GLOBALTEXTFONT_Title fontSize:16 addView:MainView];
    
    [VarifyCodeHelper CreatelabelWithValueCenter:20 ycord:55 width:280 height:30 backgroundColor:[UIColor clearColor] textcolor:[UIColor blackColor] labeltext:@"We need some information to verify your ID.This protects your account from unauthorised access" fontName:GLOBALTEXTFONT fontSize:13.0f addView:MainView];
    
    
    UIView *EnterEmailView=[[UIView alloc]initWithFrame:CGRectMake(10, 100, 300, 180)];
    EnterEmailView.layer.borderColor=[UIColor whiteColor].CGColor;
    EnterEmailView.layer.borderWidth=1.0f;
    EnterEmailView.layer.cornerRadius=4.0f;
    [EnterEmailView setBackgroundColor:[UIColor whiteColor]];
    [MainView addSubview:EnterEmailView];
    // [ForgetPassWordHelper CreatelabelWithValue:10 ycord:50 width:200 height:20 backgroundColor:[UIColor clearColor] textcolor:[UIColor lightGrayColor] labeltext:@"Enter Your Email" fontName:@"Arial" fontSize:12 addView:EnterEmailView];
    
    
    UILabel *theEmailLable=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, 200, 20)];
    theEmailLable.textColor=[UIColor lightGrayColor];
    theEmailLable.text=@"Enter Verification Code";
    theEmailLable.textAlignment=NSTextAlignmentLeft;
    theEmailLable.font=[UIFont fontWithName:GLOBALTEXTFONT size:12];
    [EnterEmailView addSubview:theEmailLable];
    
    
    UIView *textBackView=[[UIView alloc]initWithFrame:CGRectMake(10, 60, 280, 25)];
    textBackView.backgroundColor=[UIColor whiteColor];
    textBackView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    textBackView.layer.borderWidth=1.0f;
    textBackView.layer.cornerRadius=2.0f;
    [EnterEmailView addSubview:textBackView];
    self.VerifyCodeText=[[UITextField alloc]initWithFrame:CGRectMake(15, 60, 270, 25)];
    self.VerifyCodeText.backgroundColor=[UIColor clearColor];
    self.VerifyCodeText.borderStyle=UITextBorderStyleNone;
    self.VerifyCodeText.textColor=[UIColor blackColor];
    self.VerifyCodeText.font=[UIFont systemFontOfSize:12];
    self.VerifyCodeText.delegate=self;
    [EnterEmailView addSubview:self.VerifyCodeText];
    [VarifyCodeHelper CreateButtonWithText:100 ycord:96 width:100 height:25 backgroundColor:UIColorFromRGB(0x1aad4b) textcolor:[UIColor whiteColor] labeltext:@"Send Me" fontName:globalTEXTFIELDPLACEHOLDERFONT fontSize:10 textNameForUIControlStateNormal:@"Send Me" textNameForUIControlStateSelected:@"Send Me" textNameForUIControlStateHighlighted:@"Send Me" textNameForselectedHighlighted:globalTEXTFIELDPLACEHOLDERFONT selectMethod:@selector(Codevarify:) selectEvent:UIControlEventTouchUpInside addView:EnterEmailView viewController:self];
    
  
    
}
-(IBAction)Codevarify:(id)sender
{
    //[self performSelectorOnMainThread:@selector(TheLoader) withObject:nil waitUntilDone:NO];
    // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    NSString *StrString=[NSString stringWithFormat:@"%@mode=verify_code&code=%@",Domain5,self.VerifyCodeText.text];
    NSURL *url=[NSURL URLWithString:StrString];
    NSData *data=[NSData dataWithContentsOfURL:url];
    NSDictionary *mainDic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSDictionary *ExtraParam=[mainDic valueForKey:@"extraparam"];
    NSString *massAge=[ExtraParam valueForKey:@"message"];
    SuccessStr=[ExtraParam valueForKey:@"response"];
    
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:SuccessStr message:massAge delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"cancel", nil];
        [alert show];
       
   
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([SuccessStr isEqualToString:@"success"])
        {
 
            ChangepassViewController *change=[[ChangepassViewController alloc]initWithNibName:@"ChangepassViewController" bundle:nil];
            [self.navigationController pushViewController:change animated:YES];
            
            
        }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)BacktoForgetpassword:(id)sender
{
    
[self.navigationController popViewControllerAnimated:YES]; 
}

@end
