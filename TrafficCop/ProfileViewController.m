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

//@property (nonatomic, strong) UITextField *LastName;
//@property (nonatomic, strong) UITextField *Email;
//@property (nonatomic, strong) UITextField *Username;
@property (strong, nonatomic) IBOutlet UILabel *profileTitle;
@property (strong, nonatomic) IBOutlet UITextField *FistName;
@property (strong, nonatomic) IBOutlet UITextField *LastName;
@property (strong, nonatomic) IBOutlet UITextField *Email;
@property (strong, nonatomic) IBOutlet UITextField *Username;

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
//    self.Whitebackview.layer.cornerRadius=10.0f;
//    self.Whitebackview.layer.borderWidth=1.0f;
//    self.Whitebackview.layer.borderColor=[UIColor whiteColor].CGColor;
//    self.Whitebackview.backgroundColor=UIColorFromRGB(0xffffff);
    [profilehelper SetupHeaderView:self.view viewController:self];
    [profilehelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    ZSImageView *imageView = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
	imageView.defaultImage = [UIImage imageNamed:@"FH-noimage-circle"];
	imageView.imageUrl = [userDefauld objectForKey:@"user_image"];
	imageView.contentMode = UIViewContentModeScaleAspectFill;
     [self SetroundborderWithborderWidth:2.0f WithColour:UIColorFromRGB(0xc9c9c9) ForImageview:imageView];
    [self.userImage addSubview:imageView];
    
    [self.userImage setImage:[UIImage imageNamed:@"FH-noimage-circle"]];
    
    _profileTitle.font=[UIFont fontWithName:GLOBALTEXTFONT_Title size:18];
    
    FistName.font=[UIFont fontWithName:GLOBALTEXTFONT size:13];
    FistName.tag=100;
    FistName.delegate=self;
//    [FistName addTarget:self action:@selector(textFieldDidBeginEditings:) forControlEvents:UIControlEventEditingDidBegin];
//    [FistName addTarget:self action:@selector(textFieldDidEndEditings:) forControlEvents:UIControlEventEditingDidEndOnExit];
//    
    
    LastName.font=[UIFont fontWithName:GLOBALTEXTFONT size:13];
    LastName.tag=101;
    LastName.delegate=self;
//    [LastName addTarget:self action:@selector(textFieldDidBeginEditings:) forControlEvents:UIControlEventEditingDidBegin];
//    [LastName addTarget:self action:@selector(textFieldDidEndEditings:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    Email.font=[UIFont fontWithName:GLOBALTEXTFONT size:13];
    Email.tag=102;
    Email.delegate=self;
//    [Email addTarget:self action:@selector(textFieldDidBeginEditings:) forControlEvents:UIControlEventEditingDidBegin];
//    [Email addTarget:self action:@selector(textFieldDidEndEditings:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    Username.font=[UIFont fontWithName:GLOBALTEXTFONT size:13];
    Username.tag=103;
    Username.delegate=self;
//    [Username addTarget:self action:@selector(textFieldDidBeginEditings:) forControlEvents:UIControlEventEditingDidBegin];
//    [Username addTarget:self action:@selector(textFieldDidEndEditings:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    FistName.text=[userDefauld valueForKey:@"first_name"];
    LastName.text=[userDefauld valueForKey:@"last_name"];
    Email.text=[userDefauld valueForKey:@"email"];
    Username.text=[userDefauld valueForKey:@"username"];
    
    UIImageView *ImageOverlay = [[UIImageView alloc] initWithFrame:CGRectMake(20, 27, 70, 70)];
    [ImageOverlay setImage:[UIImage imageNamed:@"out-line.png"]];
    [_Whitebackview addSubview:ImageOverlay];
    
    [FistName setUserInteractionEnabled:NO];
    [LastName setUserInteractionEnabled:NO];
    [Email setUserInteractionEnabled:NO];
    [Username setUserInteractionEnabled:NO];

    

    
}
-(void)SetroundborderWithborderWidth:(CGFloat)BorderWidth WithColour:(UIColor *)RGB ForImageview:(ZSImageView *)ImageView
{
    
    [[ImageView layer] setCornerRadius:[ImageView frame].size.width/2.0f];
    [[ImageView layer] setBorderColor:[RGB CGColor]];
    [[ImageView layer] setBorderWidth:BorderWidth];
    [[ImageView layer] setMasksToBounds:YES];
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
   
   
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)txtfld{
    NSLog(@"tag of textField is %d",txtfld.tag);
    int i=txtfld.tag-100;
    [_mainBackScroll setContentOffset:CGPointMake(0, i*50) animated:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)txtfld{
    NSLog(@"tag of textField is %d",txtfld.tag);
    int i=txtfld.tag-100;
    if(i==0){
        [UIView animateWithDuration:.25 animations:^{
            _mainBackScroll.contentOffset = CGPointMake(0, 0);
        }];
    }
    else{
        [UIView animateWithDuration:.25 animations:^{
            _mainBackScroll.contentOffset = CGPointMake(0, (i*50)-50);
        }];
        
    }
}
- (void)textFieldDidBeginEditings:(UITextField *)txtfld{
    NSLog(@"tag of textField is %d",txtfld.tag);
    int i=txtfld.tag-100;
    [_mainBackScroll setContentOffset:CGPointMake(0, i*50) animated:YES];
}
- (void)textFieldDidEndEditings:(UITextField *)txtfld{
    NSLog(@"tag of textField is %d",txtfld.tag);
    int i=txtfld.tag-100;
    if(i==0){
        [UIView animateWithDuration:.25 animations:^{
            _mainBackScroll.contentOffset = CGPointMake(0, 0);
        }];
    }
    else{
        [UIView animateWithDuration:.25 animations:^{
            _mainBackScroll.contentOffset = CGPointMake(0, (i*50)-50);
        }];
        
    }
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
