//
//  EditProfileViewController.h
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 08/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelperClass.h"

@interface EditProfileViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    HelperClass *EditProfHelper;
}
@property (strong, nonatomic) IBOutlet UIScrollView *EditProfileScroll;
@property (strong, nonatomic) IBOutlet UIView *whiteBackView;
-(IBAction)movetozero:(id)sender;
-(IBAction)movetotop:(id)sender;
-(IBAction)movetotopone:(id)sender;
@end
