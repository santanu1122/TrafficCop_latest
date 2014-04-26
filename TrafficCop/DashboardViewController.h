//
//  DashboardViewController.h
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 08/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelperClass.h"
#import <CoreLocation/CoreLocation.h>


@interface DashboardViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate,UIScrollViewDelegate> {
    HelperClass *DashboardHelper;
    NSMutableArray *LatestreportArray;
    NSMutableArray *Hightestrelatedreport;
    NSMutableArray *RemportofLicenceplate;
    NSMutableData *webdata;
    NSURLConnection *connection;

}
@property (strong, nonatomic) IBOutlet UIView *LoadMoreview;
@property (nonatomic,retain) IBOutlet UITableView *DashboardTable;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *playlistImageLoader;
@property (strong, nonatomic) CLLocationManager *locationmaneger;

@end
