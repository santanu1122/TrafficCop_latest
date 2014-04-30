//
//  ChangepassViewController.m
//  TrafficCop
//
//  Created by macbook_ms on 06/12/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//http://www.esolzdemos.com/lab3/trafficcop/IOS/forgot.php?mode=new_password&user_password=1234567

#import "ChangepassViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "HelperClass.h"
#import "MFSideMenu.h"

@interface ChangepassViewController () {
     BOOL Chake;
}
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic, strong) UITextField *NewPassWord;
@property (nonatomic, strong) UITextField *ConformNewPassWord;
@end

@implementation ChangepassViewController
@synthesize NewPassWord;
@synthesize ConformNewPassWord;
@synthesize changpassScroll;
@synthesize theSuccessMsg;

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
    
    [self.headerView setBackgroundColor:[UIColor colorWithRed:(247/255.0) green:(247/255.0) blue:(247/255.0) alpha:1]];
    [[self.navigationController navigationBar] setHidden:YES];
    changePassWordHelper=[[HelperClass alloc]init];
    [changePassWordHelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    [changePassWordHelper SetupHeaderView:self.view viewController:self];
    UIView *EnterPassView=[[UIView alloc]initWithFrame:CGRectMake(10, 70, 300, 200)];
    EnterPassView.layer.borderColor=[UIColor whiteColor].CGColor;
    EnterPassView.layer.borderWidth=1.0f;
    EnterPassView.layer.cornerRadius=8.0f;
    [EnterPassView setBackgroundColor:[UIColor whiteColor]];
    [changpassScroll addSubview:EnterPassView];
    UILabel *themainheaderLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 20)];
    themainheaderLbl.textColor=[UIColor lightGrayColor];
    themainheaderLbl.text=@"Change Password";
    themainheaderLbl.textAlignment=NSTextAlignmentLeft;
    themainheaderLbl.font=[UIFont fontWithName:GLOBALTEXTFONT size:13];
    [EnterPassView addSubview:themainheaderLbl];
    
    UILabel *thenewpassLable=[[UILabel alloc]initWithFrame:CGRectMake(10, 45, 200, 20)];
    thenewpassLable.textColor=[UIColor lightGrayColor];
    thenewpassLable.text=@"Password";
    thenewpassLable.textAlignment=NSTextAlignmentLeft;
    thenewpassLable.font=[UIFont fontWithName:GLOBALTEXTFONT size:13];
    [EnterPassView addSubview:thenewpassLable];
    
    UIView *textBackView=[[UIView alloc]initWithFrame:CGRectMake(10, 65, 280, 25)];
    textBackView.backgroundColor=[UIColor whiteColor];
    textBackView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    textBackView.layer.borderWidth=1.0f;
    textBackView.layer.cornerRadius=2.0f;
    [EnterPassView addSubview:textBackView];
    NewPassWord=[[UITextField alloc]initWithFrame:CGRectMake(15, 65, 270, 25)];
    NewPassWord.secureTextEntry=YES;
    NewPassWord.backgroundColor=[UIColor clearColor];
    NewPassWord.borderStyle=UITextBorderStyleNone;
    NewPassWord.textColor=[UIColor blackColor];
    NewPassWord.font=[UIFont fontWithName:GLOBALTEXTFONT size:13];
    NewPassWord.delegate=self;
    [EnterPassView addSubview:NewPassWord];
    
    UILabel *TheConformNewPassword=[[UILabel alloc]initWithFrame:CGRectMake(10, 100, 200, 20)];
    TheConformNewPassword.textColor=[UIColor lightGrayColor];
    TheConformNewPassword.text=@"ConfirmPassword";
    TheConformNewPassword.textAlignment=NSTextAlignmentLeft;
    TheConformNewPassword.font=[UIFont fontWithName:GLOBALTEXTFONT size:13];
    [EnterPassView addSubview:TheConformNewPassword];
    
    UIView *textBackView2=[[UIView alloc]initWithFrame:CGRectMake(10, 120, 280, 25)];
    textBackView2.backgroundColor=[UIColor whiteColor];
    textBackView2.layer.borderColor=[UIColor lightGrayColor].CGColor;
    textBackView2.layer.borderWidth=1.0f;
    textBackView2.layer.cornerRadius=2.0f;
    [EnterPassView addSubview:textBackView2];
    ConformNewPassWord=[[UITextField alloc]initWithFrame:CGRectMake(15, 120, 270, 25)];
    ConformNewPassWord.secureTextEntry=YES;
    ConformNewPassWord.backgroundColor=[UIColor clearColor];
    ConformNewPassWord.borderStyle=UITextBorderStyleNone;
    ConformNewPassWord.textColor=[UIColor blackColor];
    ConformNewPassWord.font=[UIFont fontWithName:GLOBALTEXTFONT size:13];
    ConformNewPassWord.delegate=self;
    [EnterPassView addSubview:ConformNewPassWord];
    
    [changePassWordHelper CreateButtonWithText:100 ycord:160 width:100 height:21 backgroundColor:UIColorFromRGB(0x1aad4b) textcolor:[UIColor whiteColor] labeltext:@"Change" fontName:globalTEXTFIELDPLACEHOLDERFONT fontSize:13 textNameForUIControlStateNormal:@"Change" textNameForUIControlStateSelected:@"Change" textNameForUIControlStateHighlighted:@"Change" textNameForselectedHighlighted:@"Change" selectMethod:@selector(ChangeUserPassWord:) selectEvent:UIControlEventTouchUpInside addView:EnterPassView viewController:self];
    
    
    
}
-(IBAction)ChangeUserPassWord:(id)sender
{
   
  
    Chake=YES;
   
    if (NewPassWord.text.length<4)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Password length should be more then four" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        Chake=NO;
    }
    if (![NewPassWord.text isEqualToString:ConformNewPassWord.text])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Password and ConfirmPassword should be same" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        Chake=NO;
 
    }
    
    
    
    if (Chake==YES)
    {
       
       
        dispatch_async(dispatch_get_main_queue(), ^{
        NSString *StringUrl=[NSString stringWithFormat:@"%@mode=new_password&user_password=%@",Domain5,ConformNewPassWord.text];
        NSLog(@"The url of the update Json:%@",StringUrl);
        NSURL *url=[NSURL URLWithString:StringUrl];
        NSData *data=[NSData dataWithContentsOfURL:url];
        NSDictionary *mainDic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSDictionary *ExtraParam=[mainDic valueForKey:@"extraparam"];
        NSString *massAge=[ExtraParam valueForKey:@"message"];
       
       
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:massAge delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
  
            
        
        });
        

    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    if (Chake==YES) {
        AppDelegate *MainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        LoginViewController *log = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:Nil];
        [MainDelegate SetUpTabbarControllerwithcenterView:log];
    }
   
}
- (IBAction)backtopriviouspage:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
