//
//  PassWordChange.h
//  TrafficCop
//
//  Created by macbook_ms on 10/12/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelperClass.h"
#import "MFSideMenuShadow.h"

@interface PassWordChange : UIViewController<UITextFieldDelegate>
{
 HelperClass *changePassWordHelper;
}
@property (strong, nonatomic) IBOutlet UIScrollView *changePassScroll;


@end
