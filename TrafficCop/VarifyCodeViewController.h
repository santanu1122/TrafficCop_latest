//
//  VarifyCodeViewController.h
//  TrafficCop
//
//  Created by macbook_ms on 06/12/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelperClass.h"


@interface VarifyCodeViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    HelperClass *VarifyCodeHelper;
}
@property (strong, nonatomic) IBOutlet UIScrollView *VarifyCodeScroll;
@property (strong, nonatomic) NSString *TheUsermassage;
@end
