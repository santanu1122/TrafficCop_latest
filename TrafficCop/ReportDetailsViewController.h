//
//  ReportDetailsViewController.h
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 27/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface ReportDetailsViewController : UIViewController<MKMapViewDelegate>


@property (nonatomic, retain) NSString *reportId;

@property (strong, nonatomic) NSString *theisreportpostbyme;
@property (strong, nonatomic) IBOutlet UIScrollView *MAinScrollview;




@property (nonatomic,retain) IBOutlet UIView *UIViewForPostComment;

@property (nonatomic,retain) IBOutlet UIButton *UIButtonForSubMitComment;
@property (weak) IBOutlet UITextView *UITextViewForPostComment;
@property (nonatomic,retain) IBOutlet UILabel *UILabelForPostComment;
@property (nonatomic,retain) IBOutlet UILabel *UILabelForRateComment;

@property (nonatomic,retain) IBOutlet UIView *UIViewForCommentListing;

@property (nonatomic, strong) NSString *reportID;
@property (nonatomic, strong) NSString *ReportPostbyme;

@property (strong, nonatomic) IBOutlet UIScrollView *imageSlider;
@property (strong, nonatomic) IBOutlet UIView *imageSliderview;




@end
