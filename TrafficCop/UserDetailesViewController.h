//
//  UserDetailesViewController.h
//  TrafficCop
//
//  Created by macbook_ms on 25/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelperClass.h"
#import "ShowAllCommentViewController.h"

@interface UserDetailesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
//    LoadMoreTableFooterView *_loadMoreFooterView;
//	
//	//  Reloading var should really be your tableviews datasource
//	//  Putting it here for demo purposes
//	BOOL _reloading;
    
    HelperClass *UserDetailhelper;
    NSMutableArray *reportOfuserlableArray;
    NSMutableArray *CommentsofUserArray;
}

@property (strong, nonatomic) IBOutlet UIView *userDetailView;

@property (strong, nonatomic) IBOutlet UIView *ShowreportFooter;
@property (strong, nonatomic) IBOutlet UITableView *reportTbl;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *lable1;
@property (strong, nonatomic) IBOutlet UILabel *reportlbl;
@property (strong, nonatomic) IBOutlet UILabel *commentlbl;
@property (strong, nonatomic) IBOutlet UILabel *pointlbl;
@property (strong, nonatomic) IBOutlet UILabel *reportresultlbl;
@property (strong, nonatomic) IBOutlet UILabel *reportcmtlbl;
@property (strong, nonatomic) IBOutlet UILabel *reportpointresultlbl;
@property (strong, nonatomic) IBOutlet UITableView *commentTbl;
@property (nonatomic,retain) NSString *userId;

@property (strong, nonatomic) IBOutlet UIView *footerView;


@property (nonatomic, strong) UILabel *footerLabel;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) IBOutlet UIScrollView *brodGateScroll;

@end
@interface ImageLoader : NSObject
{
    NSOperationQueue *OperationQueueForImageLoader;
}

-(void)LoadImage:(NSArray *)Param;
@end
