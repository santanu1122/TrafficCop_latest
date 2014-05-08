//
//  ShowAllReportViewController.h
//  TrafficCop
//
//  Created by macbook_ms on 28/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShowAllReportViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLConnectionDataDelegate>
@property (strong, nonatomic) IBOutlet UITableView *ShowallReportTbl;
@property (nonatomic, strong) NSString *userid;
@property (assign) BOOL isBackEnabled;


@end
