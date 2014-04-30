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

@property (strong, nonatomic) IBOutlet UITextField *Previous_password;
@property (strong, nonatomic) IBOutlet UITextField *New_Password;
@property (strong, nonatomic) IBOutlet UITextField *ConformNew_Password;
@property (strong, nonatomic) IBOutlet UIView *myPassWordChageView;
@property (strong, nonatomic) IBOutlet UILabel *headerLabel;

@end

@implementation PassWordChange
@synthesize changePassScroll;
@synthesize Previous_password;
@synthesize New_Password;
@synthesize ConformNew_Password;
@synthesize headerLabel;

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
    
    headerLabel.font=[UIFont fontWithName:GLOBALTEXTFONT_Title size:18];
    
    changePassWordHelper=[[HelperClass alloc]init];
    [changePassWordHelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    [changePassWordHelper SetupHeaderView:self.view viewController:self];
    
    
    
    Previous_password.secureTextEntry=YES;
    Previous_password.font=[UIFont fontWithName:GLOBALTEXTFONT size:12];
    Previous_password.delegate=self;
    
    [New_Password setSecureTextEntry:YES];
    New_Password.font=[UIFont fontWithName:GLOBALTEXTFONT size:12];
    New_Password.delegate=self;
    
   
    
    
    [ConformNew_Password setSecureTextEntry:YES];
    ConformNew_Password.font=[UIFont fontWithName:GLOBALTEXTFONT size:12];
    ConformNew_Password.delegate=self;
   
    
    UIButton *ChangepasswordBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    ChangepasswordBtn.frame = CGRectMake(100, 220, 100, 21);
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
    [self.myPassWordChageView addSubview:ChangepasswordBtn];


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
        return;
    }
    
    if (New_Password.text.length<5||ConformNew_Password.text.length<5)
    {
        UIAlertView *Show1=[[UIAlertView alloc]initWithTitle:nil message:@"Password should have minimum 4 charector" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Show1 show];
        changeUserPassword=NO;
        return;
    }
    if (![New_Password.text isEqualToString:ConformNew_Password.text])
    {
        UIAlertView *Show2=[[UIAlertView alloc]initWithTitle:nil message:@"Password did't match" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Show2 show];
        changeUserPassword=NO;
        return;
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
        return;
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
