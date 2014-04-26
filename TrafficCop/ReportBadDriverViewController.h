//
//  ReportBadDriverViewController.h
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 19/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportBadDriverViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate>
@property (nonatomic,retain) NSString *AVMake;
@property (nonatomic,retain) NSString *AVModel;
@property (nonatomic,retain) NSString *AVYear;
@property (nonatomic,retain) NSString *AVUnch;
@end
