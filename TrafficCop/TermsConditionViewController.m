//
//  TermsConditionViewController.m
//  TrafficCop
//
//  Created by Esolz Tech on 06/05/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "TermsConditionViewController.h"
#import "HelperClass.h"
@interface TermsConditionViewController (){
    HelperClass *termsandConditionhelper;
}
@property (strong, nonatomic) IBOutlet UIWebView *termsAndCondition;
@property (strong, nonatomic) IBOutlet UILabel *termsAndConditionLabel;

@end

@implementation TermsConditionViewController
@synthesize termsAndCondition,termsAndConditionLabel;
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
    termsandConditionhelper=[[HelperClass alloc]init];
     [[self.navigationController navigationBar] setHidden:YES];
    termsAndConditionLabel.font=[UIFont fontWithName:GLOBALTEXTFONT_Title size:16];
    [termsandConditionhelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    [self openuptermsAndconditon];
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
- (IBAction)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
