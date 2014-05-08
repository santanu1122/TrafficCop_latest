//
//  SimiarReportViewController.h
//  TrafficCop
//
//  Created by macbook_ms on 11/12/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelperClass.h"
#import "AppDelegate.h"

@interface SimiarReportViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    HelperClass *SimilarreportHelper;
}
@property (strong, nonatomic) IBOutlet UITableView *SimilerReporttbl;
@property (strong, nonatomic) NSString *Reportid;
@property BOOL backBtnEnableInSimilarReport;


@end
