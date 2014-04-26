//
//  RegisterViewController.h
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 06/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelperClass.h"
#import "MBHUDView.h"

@interface RegisterViewController : UIViewController <UIScrollViewDelegate> {
    HelperClass *RegHelperClass;
    MBAlertView *alert;
}

@property (nonatomic,retain) IBOutlet UIScrollView *REGScrollview;
@property (nonatomic,retain) IBOutlet UITextField *UserNameField;
@property (nonatomic,retain) IBOutlet UITextField *UserEmailField;
@property (nonatomic,retain) IBOutlet UITextField *UserPasswordField;
@property (nonatomic,retain) IBOutlet UITextField *UserRetypepassField;
@property (nonatomic,retain) IBOutlet UITextField *UserFirstNameField;
@property (nonatomic,retain) IBOutlet UITextField *UserLastNameField;



@property (nonatomic,retain) IBOutlet UISwitch *SwitchTerms;
@property (nonatomic,retain) IBOutlet UILabel *TermsAndCondition;
@property (nonatomic,assign) BOOL *AGREETermsAndCondition;

-(IBAction)RegButtonClicked:(id)sender;
-(IBAction)hideKeyboard:(id)sender;
-(IBAction)movetozero:(id)sender;
-(IBAction)movetotop:(id)sender;
-(IBAction)movetotopone:(id)sender;
-(IBAction)ChangeSwitchValue:(id)sender;
-(IBAction)goBack:(id)sender;
@end
