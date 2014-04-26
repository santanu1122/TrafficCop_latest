//
//  PassWordChange.m
//  TrafficCop
//
//  Created by macbook_ms on 10/12/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//http://www.esolzdemos.com/lab3/trafficcop/IOS/changepass.php?password=123456&userid=28

#import "PassWordChange.h"
#import "AppDelegate.h"
#import "MFSideMenu.h"


@interface PassWordChange ()<UIAlertViewDelegate>
{
    NSString *userid;
    NSString *passwordTxt;
  BOOL changeUserPassword;
}
@property (nonatomic, strong) UITextField *Previous_password;
@property (nonatomic, strong) UITextField *New_Password;
@property (nonatomic, strong) UITextField *ConformNew_Password;
@end

@implementation PassWordChange
@synthesize changePassScroll;
@synthesize Previous_password;
@synthesize New_Password;
@synthesize ConformNew_Password;

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
    NSUserDefaults *userdefalds=[NSUserDefaults standardUserDefaults];
    userid=[userdefalds valueForKey:@"userid"];
    passwordTxt=[userdefalds valueForKey:@"password"];

    [[[self navigationController] navigationBar] setHidden:YES];
    
    changePassWordHelper=[[HelperClass alloc]init];
    [changePassWordHelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    [changePassWordHelper SetupHeaderView:self.view viewController:self];
    UIView *WhiteBackGround=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 300, 300)];
    WhiteBackGround.layer.cornerRadius=10.0f;
    WhiteBackGround.layer.borderWidth=1.0f;
    WhiteBackGround.layer.borderColor=[UIColor whiteColor].CGColor;
    [WhiteBackGround setBackgroundColor:[UIColor whiteColor]];
    [changePassScroll addSubview:WhiteBackGround];
    UILabel *themainheaderLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 300, 20)];
    themainheaderLbl.textColor=[UIColor darkGrayColor];
    themainheaderLbl.text=@"Change Password";
    themainheaderLbl.textAlignment=NSTextAlignmentCenter;
    themainheaderLbl.font=[UIFont systemFontOfSize:13];
    [WhiteBackGround addSubview:themainheaderLbl];
    
    UILabel *thenewpassLable=[[UILabel alloc]initWithFrame:CGRectMake(10, 45, 200, 20)];
    thenewpassLable.textColor=[UIColor darkGrayColor];
    thenewpassLable.text=@"previous Password";
    thenewpassLable.textAlignment=NSTextAlignmentLeft;
    thenewpassLable.font=[UIFont systemFontOfSize:13];
    [WhiteBackGround addSubview:thenewpassLable];
    
    
    UIView *textBackView=[[UIView alloc]initWithFrame:CGRectMake(10, 65, 280, 25)];
    textBackView.backgroundColor=[UIColor whiteColor];
    textBackView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    textBackView.layer.borderWidth=1.0f;
    textBackView.layer.cornerRadius=2.0f;
    [WhiteBackGround addSubview:textBackView];
    Previous_password=[[UITextField alloc]initWithFrame:CGRectMake(15, 65, 270, 25)];
    Previous_password.backgroundColor=[UIColor clearColor];
    Previous_password.secureTextEntry=YES;
    Previous_password.placeholder=@"previous Password";
    Previous_password.borderStyle=UITextBorderStyleNone;
    Previous_password.textColor=[UIColor blackColor];
    Previous_password.font=[UIFont systemFontOfSize:12];
    Previous_password.delegate=self;
    [WhiteBackGround addSubview:Previous_password];
    
    UILabel *NewPassword=[[UILabel alloc]initWithFrame:CGRectMake(10, 100, 200, 20)];
    NewPassword.textColor=[UIColor darkGrayColor];
    NewPassword.text=@"New Password";
    NewPassword.textAlignment=NSTextAlignmentLeft;
    NewPassword.font=[UIFont systemFontOfSize:13];
    [WhiteBackGround addSubview:NewPassword];
    
    
    UIView *textBackView2=[[UIView alloc]initWithFrame:CGRectMake(10, 120, 280, 25)];
    textBackView2.backgroundColor=[UIColor whiteColor];
    textBackView2.layer.borderColor=[UIColor lightGrayColor].CGColor;
    textBackView2.layer.borderWidth=1.0f;
    textBackView2.layer.cornerRadius=2.0f;
    [WhiteBackGround addSubview:textBackView2];
    New_Password=[[UITextField alloc]initWithFrame:CGRectMake(15, 120, 270, 25)];
    New_Password.backgroundColor=[UIColor clearColor];
    New_Password.borderStyle=UITextBorderStyleNone;
    [New_Password setPlaceholder:@"New Password"];
    [New_Password setSecureTextEntry:YES];
    New_Password.textColor=[UIColor blackColor];
    New_Password.font=[UIFont systemFontOfSize:12];
    New_Password.delegate=self;
    [WhiteBackGround addSubview:New_Password];
    
    UILabel *TheConformNewPassword=[[UILabel alloc]initWithFrame:CGRectMake(10, 155, 200, 20)];
    TheConformNewPassword.textColor=[UIColor lightGrayColor];
    TheConformNewPassword.text=@"Confirm New Password";
    TheConformNewPassword.textAlignment=NSTextAlignmentLeft;
    TheConformNewPassword.font=[UIFont systemFontOfSize:13];
    [WhiteBackGround addSubview:TheConformNewPassword];
    
    
    UIView *textBackView3=[[UIView alloc]initWithFrame:CGRectMake(10, 175, 280, 25)];
    textBackView3.backgroundColor=[UIColor whiteColor];
    textBackView3.layer.borderColor=[UIColor lightGrayColor].CGColor;
    textBackView3.layer.borderWidth=1.0f;
    textBackView3.layer.cornerRadius=2.0f;
    [WhiteBackGround addSubview:textBackView3];
    ConformNew_Password=[[UITextField alloc]initWithFrame:CGRectMake(15, 175, 270, 25)];
    [ConformNew_Password setSecureTextEntry:YES];
    
    [ConformNew_Password setPlaceholder:@"Confirm New Password"];
    ConformNew_Password.backgroundColor=[UIColor clearColor];
    ConformNew_Password.borderStyle=UITextBorderStyleNone;
    ConformNew_Password.textColor=[UIColor blackColor];
    ConformNew_Password.font=[UIFont systemFontOfSize:12];
    ConformNew_Password.delegate=self;
    
    [WhiteBackGround addSubview:ConformNew_Password];
    
    UIButton *ChangepasswordBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    ChangepasswordBtn.frame = CGRectMake(100, 250, 100, 21);
    [ChangepasswordBtn setBackgroundColor:UIColorFromRGB(0x1aad4b)];
    [ChangepasswordBtn setTitle:@"Change" forState:UIControlStateNormal];
    [ChangepasswordBtn setTitle:@"Change" forState:UIControlStateSelected];
    [ChangepasswordBtn setTitle:@"Change" forState:UIControlStateHighlighted];
    [ChangepasswordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ChangepasswordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [ChangepasswordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    ChangepasswordBtn.titleLabel.font=[UIFont systemFontOfSize:11.0f];
    ChangepasswordBtn.layer.borderColor = UIColorFromRGB(0xc5c5c5).CGColor;
    [ChangepasswordBtn addTarget:self action:@selector(UserPassWordChange:) forControlEvents:UIControlEventTouchUpInside];
    [WhiteBackGround addSubview:ChangepasswordBtn];


}





-(IBAction)UserPassWordChange:(id)sender
{
    
    [Previous_password resignFirstResponder];
    [New_Password resignFirstResponder];
    [ConformNew_Password resignFirstResponder];
    changeUserPassword=YES;
    
    if (Previous_password.text.length<5||![Previous_password.text isEqualToString:passwordTxt]) {
        UIAlertView *Show1=[[UIAlertView alloc]initWithTitle:nil message:@"Your password is wrong" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Show1 show];
        changeUserPassword=NO;
    }
    
    if (New_Password.text.length<5||ConformNew_Password.text.length<5)
    {
        UIAlertView *Show1=[[UIAlertView alloc]initWithTitle:nil message:@"Password should have minimum 4 charector" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Show1 show];
        changeUserPassword=NO;
    }
    if (![New_Password.text isEqualToString:ConformNew_Password.text])
    {
        UIAlertView *Show2=[[UIAlertView alloc]initWithTitle:nil message:@"Password did't match" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Show2 show];
        changeUserPassword=NO;
    }
    
    if (changeUserPassword==YES)
    {
        NSString *StringUrl=[NSString stringWithFormat:@"%@changepass.php?password=%@&userid=%@",DomainURL,ConformNew_Password.text,userid];
        NSLog(@"The url:%@",StringUrl);
        NSURL *url=[NSURL URLWithString:StringUrl];
        NSData *Data=[NSData dataWithContentsOfURL:url];
        NSDictionary *Maindic=[NSJSONSerialization JSONObjectWithData:Data options:kNilOptions error:nil];
        NSString *Successmsg=[Maindic valueForKey:@"message"];
        NSString *responce=[Maindic valueForKey:@"response"];
        UIAlertView *Show=[[UIAlertView alloc]initWithTitle:responce message:Successmsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Show show];
    }
    
    
    
    
    }

- (void)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftSideMenuButtonPressed:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

- (void)rightSideMenuButtonPressed:(id)sender
{
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{}];
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
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    ConformNew_Password.text=nil;
    New_Password.text=nil;
    Previous_password.text=nil;
    
}

@end
