//
//  FacebookTwitterIntermidiat.h
//  TrafficCop
//
//  Created by macbook_ms on 12/03/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelperClass.h"

@interface FacebookTwitterIntermidiat : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    HelperClass *EditProfHelper;
}
@property (strong, nonatomic) IBOutlet UIScrollView *EditProfileScroll;
@property (strong, nonatomic) IBOutlet UIView *whiteBackView;
@property (assign) BOOL isCommingFromFacebook;

@end
