//
//  ProfileViewController.m
//  TrafficCop
//
//  Created by macbook_ms on 06/02/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "ProfileViewController.h"
#import "HelperClass.h"
#import "ZSImageView.h"
#import "MFSideMenu.h"

@interface ProfileViewController ()<UITextFieldDelegate>
{
    HelperClass *profilehelper;
}
@property (nonatomic, strong) UITextField *FistName;
@property (nonatomic, strong) UITextField *LastName;
@property (nonatomic, strong) UITextField *Email;
@property (nonatomic, strong) UITextField *Username;

@end

@implementation ProfileViewController
@synthesize FistName;
@synthesize LastName;
@synthesize Email;
@synthesize Username;

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
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden=YES;
    NSUserDefaults *userDefauld=[NSUserDefaults standardUserDefaults];
    profilehelper =[[HelperClass alloc]init];
    self.Whitebackview.layer.cornerRadius=10.0f;
    self.Whitebackview.layer.borderWidth=1.0f;
    self.Whitebackview.layer.borderColor=[UIColor whiteColor].CGColor;
    self.Whitebackview.backgroundColor=UIColorFromRGB(0xffffff);
    [profilehelper SetupHeaderView:self.view viewController:self];
    [profilehelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    ZSImageView *imageView = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 0, 101, 86)];
	imageView.defaultImage = [UIImage imageNamed:@"FH-noimage-circle"];
	imageView.imageUrl = [userDefauld objectForKey:@"user_image"];
	imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.userImage addSubview:imageView];
    
    UIView *textbackground1=[[UIView alloc]initWithFrame:CGRectMake(10, 135, 280, 25)];
    textbackground1.layer.borderColor=UIColorFromRGB(0xcccccc).CGColor;
    textbackground1.layer.borderWidth=1.0f;
    textbackground1.layer.cornerRadius=1.0f;
    textbackground1.backgroundColor=[UIColor clearColor];
    [self.Whitebackview addSubview:textbackground1];
    
    UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(10, 115, 200, 20)];
    lable1.font=[UIFont systemFontOfSize:13.0f];
    lable1.textColor=[UIColor blackColor];
    lable1.textAlignment=NSTextAlignmentLeft;
    lable1.text=@"First Name";
    [self.Whitebackview addSubview:lable1];
    

    FistName=[[UITextField alloc]initWithFrame:CGRectMake(15, 135, 270, 25)];
    FistName.backgroundColor=[UIColor clearColor];
    FistName.borderStyle=UITextBorderStyleNone;
    FistName.textColor=[UIColor darkGrayColor];
    FistName.font=[UIFont systemFontOfSize:13.0f];
    FistName.delegate=self;
    [self.Whitebackview addSubview:FistName];
    
    UILabel *lable2=[[UILabel alloc]initWithFrame:CGRectMake(10, 170, 200, 20)];
    lable2.font=[UIFont systemFontOfSize:13];
    lable2.textColor=[UIColor blackColor];
    lable2.textAlignment=NSTextAlignmentLeft;
    lable2.text=@"Last Name";
    [self.Whitebackview addSubview:lable2];
   
    UIView *textbackground2=[[UIView alloc]initWithFrame:CGRectMake(10, 190, 280, 25)];
    textbackground2.layer.borderColor=UIColorFromRGB(0xcccccc).CGColor;
    textbackground2.layer.borderWidth=1.0f;
    textbackground2.layer.cornerRadius=1.0f;
    textbackground2.backgroundColor=[UIColor clearColor];
    [self.Whitebackview addSubview:textbackground2];
    
    
    LastName=[[UITextField alloc]initWithFrame:CGRectMake(15, 190, 270, 25)];
    LastName.backgroundColor=[UIColor clearColor];
    LastName.borderStyle=UITextBorderStyleNone;
    LastName.textColor=[UIColor darkGrayColor];
    LastName.font=[UIFont systemFontOfSize:13.0f];
    LastName.delegate=self;
    [LastName addTarget:self action:@selector(textFieldDidBeginEditing) forControlEvents:UIControlEventEditingDidBegin];
    [LastName addTarget:self action:@selector(textFieldDidEndEditing) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.Whitebackview addSubview:LastName];
    
    UILabel *lable3=[[UILabel alloc]initWithFrame:CGRectMake(10, 225, 200, 20)];
    lable3.font=[UIFont systemFontOfSize:13.0f];
    lable3.textColor=[UIColor blackColor];
    lable3.textAlignment=NSTextAlignmentLeft;
    lable3.text=@"Email";
    [self.Whitebackview addSubview:lable3];
    
    
    UIView *textbackground3=[[UIView alloc]initWithFrame:CGRectMake(10, 245, 280, 25)];
    textbackground3.layer.borderColor=UIColorFromRGB(0xcccccc).CGColor;
    textbackground3.layer.borderWidth=1.0f;
    textbackground3.layer.cornerRadius=1.0f;
    textbackground3.backgroundColor=[UIColor clearColor];
    [self.Whitebackview addSubview:textbackground3];
    
    Email=[[UITextField alloc]initWithFrame:CGRectMake(15, 245, 225, 25)];
    Email.backgroundColor=[UIColor clearColor];
    Email.borderStyle=UITextBorderStyleNone;
    Email.textColor=[UIColor darkGrayColor];
    Email.font=[UIFont systemFontOfSize:13.0f];
    Email.delegate=self;
    [Email addTarget:self action:@selector(textFieldDidBeginEditing) forControlEvents:UIControlEventEditingDidBegin];
    [Email addTarget:self action:@selector(textFieldDidEndEditing) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.Whitebackview addSubview:Email];
    
    UILabel *lable4=[[UILabel alloc]initWithFrame:CGRectMake(10, 280, 200, 20)];
    lable4.font=[UIFont systemFontOfSize:13];
    lable4.textColor=[UIColor blackColor];
    lable4.textAlignment=NSTextAlignmentLeft;
    lable4.text=@"Username";
    [self.Whitebackview addSubview:lable4];
    UIView *textbackground4=[[UIView alloc]initWithFrame:CGRectMake(10, 300, 280, 25)];
    textbackground4.layer.borderColor=UIColorFromRGB(0xcccccc).CGColor;
    textbackground4.layer.borderWidth=1.0f;
    textbackground4.layer.cornerRadius=1.0f;
    textbackground4.backgroundColor=[UIColor clearColor];
    [self.Whitebackview addSubview:textbackground4];
    Username=[[UITextField alloc]initWithFrame:CGRectMake(15, 300, 270, 25)];
    Username.backgroundColor=[UIColor clearColor];
    Username.borderStyle=UITextBorderStyleNone;
    Username.textColor=[UIColor darkGrayColor];
    Username.font=[UIFont systemFontOfSize:13.0f];
    Username.delegate=self;
    [self.Whitebackview addSubview:Username];
    FistName.text=[userDefauld valueForKey:@"first_name"];
    LastName.text=[userDefauld valueForKey:@"last_name"];
    Email.text=[userDefauld valueForKey:@"email"];
    Username.text=[userDefauld valueForKey:@"username"];
    [FistName setUserInteractionEnabled:NO];
    [LastName setUserInteractionEnabled:NO];
    [Email setUserInteractionEnabled:NO];
    [Username setUserInteractionEnabled:NO];

    

    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
   
   
    return YES;
}

- (void)leftSideMenuButtonPressed:(id)sender
 {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
 }

- (void)rightSideMenuButtonPressed:(id)sender
  {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{}];
  }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
