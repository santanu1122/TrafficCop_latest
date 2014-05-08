//
//  ForgetPassWordViewController.h
//  TrafficCop
//
//  Created by macbook_ms on 06/12/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelperClass.h"

@interface ForgetPassWordViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    HelperClass *ForgetPassWordHelper;
}
@property (strong, nonatomic) IBOutlet UIScrollView *ForgetScroll;

@end
