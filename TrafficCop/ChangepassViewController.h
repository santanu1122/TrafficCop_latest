//
//  ChangepassViewController.h
//  TrafficCop
//
//  Created by macbook_ms on 06/12/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelperClass.h"

@interface ChangepassViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    HelperClass *changePassWordHelper;
   
}
@property (strong, nonatomic) IBOutlet UIScrollView *changpassScroll;
@property (strong, nonatomic) NSString *theSuccessMsg;

@end
