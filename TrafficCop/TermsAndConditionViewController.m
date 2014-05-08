//
//  TermsAndConditionViewController.m
//  TrafficCop
//
//  Created by macbook_ms on 06/02/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "TermsAndConditionViewController.h"
#import "AppDelegate.h"
#import "MFSideMenu.h"
#import "HelperClass.h"
@interface TermsAndConditionViewController ()
{
    HelperClass *termsandConditionhelper;
}
@property (strong, nonatomic) IBOutlet UIView *TermsbackView;
@property (strong, nonatomic) IBOutlet UITextView *termsTextView;
@property (strong, nonatomic) IBOutlet UIWebView *termsAndCondition;
@property (strong, nonatomic) IBOutlet UILabel *termsAndConditionLabel;

@end

@implementation TermsAndConditionViewController
@synthesize TermsbackView;
@synthesize termsTextView;
@synthesize termsAndCondition;
@synthesize termsAndConditionLabel;
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
//  Do any additional setup after loading the view from its nib.         //
    termsAndConditionLabel.font=[UIFont fontWithName:GLOBALTEXTFONT_Title size:16];
    termsandConditionhelper=[[HelperClass alloc]init];
    [[self.navigationController navigationBar] setHidden:YES];
    [termsandConditionhelper SetupHeaderView:self.view viewController:self];
    [termsandConditionhelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    
  
    [self openuptermsAndconditon];
    
   /* TermsbackView.layer.cornerRadius=8.0f;
    TermsbackView.layer.borderWidth=1.0f;
    TermsbackView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    termsTextView.layer.cornerRadius=4;
    termsTextView.layer.borderWidth=1.0f;
    termsTextView.layer.borderColor=[UIColor clearColor].CGColor;
    termsTextView.textColor=[UIColor darkGrayColor];
    termsTextView.font=[UIFont fontWithName:@"Arail" size:16.0f];
    termsTextView.textAlignment=NSTextAlignmentJustified;
    termsTextView.editable=NO;
    termsTextView.userInteractionEnabled=YES;*/

    
    
}

-(void)openuptermsAndconditon
{
    [termsAndCondition loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:TERMANDCONDITION]]];
    termsAndCondition.userInteractionEnabled=YES;
    
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
