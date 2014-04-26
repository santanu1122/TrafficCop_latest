//
//  UserAccountViewController.m
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 08/12/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import "UserAccountViewController.h"
#import "HelperClass.h"

@interface UserAccountViewController () {
    HelperClass *UserAccountHelper;
    
}
@property (nonatomic,retain) IBOutlet  UITableView *MyaccountTableView;
@property (nonatomic,retain) IBOutlet UIScrollView *EditProfileScrollview;
@property (nonatomic,retain) IBOutlet UITextField *UserNameField;
@property (nonatomic,retain) IBOutlet UITextField *UserEmailField;
@property (nonatomic,retain) IBOutlet UITextField *UserPasswordField;
@property (nonatomic,retain) IBOutlet UITextField *UserRetypepassField;
@property (nonatomic,retain) IBOutlet UITextField *UserFirstNameField;
@property (nonatomic,retain) IBOutlet UITextField *UserLastNameField;

-(IBAction)EditProfileButtonClicked:(id)sender;
-(IBAction)hideKeyboard:(id)sender;
-(IBAction)movetozero:(id)sender;
-(IBAction)movetotop:(id)sender;
-(IBAction)movetotopone:(id)sender;
-(IBAction)ChangeSwitchValue:(id)sender;
@end

@implementation UserAccountViewController
@synthesize MyaccountTableView              = _MyaccountTableView;
@synthesize EditProfileScrollview           = _EditProfileScrollview;

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
    
    UserAccountHelper = [[HelperClass alloc] init];
    
    [_MyaccountTableView setDataSource:self];
    [_MyaccountTableView setDelegate:self];
    
    [UserAccountHelper SetupHeaderView:self.view viewController:self];
    [UserAccountHelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    _EditProfileScrollview = [[UIScrollView alloc] init];
    [_EditProfileScrollview setDelegate:(id)self];
    [_EditProfileScrollview setScrollEnabled:YES];
    [_EditProfileScrollview setUserInteractionEnabled:YES];
    [_EditProfileScrollview showsHorizontalScrollIndicator];
    [_EditProfileScrollview showsVerticalScrollIndicator];
    [_EditProfileScrollview setScrollEnabled:YES];
    [_EditProfileScrollview setBackgroundColor:[UIColor whiteColor]];
    
    [_EditProfileScrollview setFrame:CGRectMake(0, 120, self.view.frame.size.width*3, self.view.frame.size.height+500)];
    [_EditProfileScrollview setContentSize:CGSizeMake(self.view.frame.size.width,self.view.frame.size.height+500)];
    
    [self.navigationController ];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
