//
//  PrivacyPoliceViewController.m
//  TrafficCop
//
//  Created by macbook_ms on 06/02/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "PrivacyPoliceViewController.h"
#import "HelperClass.h"

@interface PrivacyPoliceViewController ()
{
    HelperClass *Privacyhelper;
}
@property (strong, nonatomic) IBOutlet UIView *PrivacybackView;
@property (strong, nonatomic) IBOutlet UITextView *PrivacyTextview;
@property (strong, nonatomic) IBOutlet UIWebView *PrivacyPolicyWebview;

@end

@implementation PrivacyPoliceViewController
@synthesize PrivacybackView;
@synthesize PrivacyTextview;
@synthesize PrivacyPolicyWebview;
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
    Privacyhelper=[[HelperClass alloc]init];
    [[self.navigationController navigationBar] setHidden:YES];
    [Privacyhelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    [Privacyhelper SetupHeaderView:self.view viewController:self];
    
   /* PrivacybackView.layer.cornerRadius=8.0f;
    PrivacybackView.layer.borderWidth=1.0f;
    PrivacybackView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    PrivacyTextview.layer.cornerRadius=4;
    PrivacyTextview.layer.borderWidth=1.0f;
    PrivacyTextview.layer.borderColor=[UIColor clearColor].CGColor;
    PrivacyTextview.font=[UIFont fontWithName:@"Arail" size:16.0f];
    PrivacyTextview.textColor=[UIColor darkGrayColor];
    PrivacyTextview.textAlignment=NSTextAlignmentJustified;
    PrivacyTextview.editable=NO;
    PrivacyTextview.userInteractionEnabled=YES;*/
    [PrivacyPolicyWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:PRIVACYPOLICE]]];
    [PrivacybackView setUserInteractionEnabled:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)HideNavigationBar
{
    [self.navigationController setNavigationBarHidden:YES];
}
@end
