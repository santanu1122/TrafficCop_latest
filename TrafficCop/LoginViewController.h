//
//  LoginViewController.h
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 05/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

@class HelperClass;

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "HelperClass.h"
#import "ForgetPassWordViewController.h"

@interface LoginViewController : UIViewController <FBLoginViewDelegate,MyObjDelegate,UITextFieldDelegate>

@end
