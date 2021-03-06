//
//  ReportDetailsViewController.m
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 27/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//  http://www.esolzdemos.com/lab3/trafficcop/IOS/result_details.php?id=29&loginuser=43
//http://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg

#import "ReportDetailsViewController.h"
#import "SegmentedControl.h"
#import "HelperClass.h"
#import "MFSideMenu.h"
#import "SimiarReportViewController.h"
#import "UserDetailesViewController.h"
#import "MBHUDView.h"
#import "ZSImageView.h"

#define METERS_PER_MILE 1609.344

typedef enum {
    ImageViewButtonClickedNone,
    ImageViewButtonClickedLeft,
    ImageViewButtonClickedRight,
}ImageViewButtonClickedType;


typedef enum {
    
    SegmentClickedDetails,
    SegmentClickedMap,
    SegmentClickedComment,
    
} SegmentClicked;

@interface ReportDetailsViewController ()<UIAlertViewDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    HelperClass *ReportDetailsHelper;
    SegmentedControl *DetailsTabbing;
    int currentImage;
    NSMutableArray *ImageArray;
    
    CGFloat commentBoxPosition;
    CGFloat HightOfTheComment;
    UIView *ShowAll;
    NSString *userID;
    NSMutableDictionary *UserDetailDic;
    
    
    NSOperationQueue *ReportOperation;
    
    
    UITextView *DetailsTextView;
    NSURLConnection *connection;
    AppDelegate *MainDelegate;
    UITapGestureRecognizer *tapGesture;
    UILabel *Evidencelocker;
    BOOL isAddedToAvidencelocker;
    
    BOOL isAddedtoevidenceLocker;
    UIButton *buttonEvidencel;
    
    NSString *rating;
    NSString *userimage;
    NSString *Name;
    NSString *curDate;
    NSMutableArray *AllComment;
    
    
    NSString *Errorstatus;
    
    BOOL isCommentpost;
    NSMutableArray *CommentArray;
    BOOL iscommentpresh;
    NSString *theReviewtext;
    UIButton *GreyImageButton;
    UILabel *NolocationLablel;
    
    SegmentedControl *segmentedControl1;
    
    NSMutableDictionary *item; //used in cellForRowAtIndexPath
    
    NSString *userIdForGoToDetailsPage;
    
    BOOL gotoUserDetailsFromNameorComment;
    
}
@property (weak) IBOutlet UIView *backgroundRatting;
@property (strong, nonatomic) IBOutlet UIButton *Addnewcomment;

@property (strong, nonatomic) IBOutlet UIView *noCommentFound;

@property (strong, nonatomic) IBOutlet UITableView *commentShowtable;

@property (assign) SegmentClicked *WhichSegmentClicked;

@property (weak,nonatomic) IBOutlet MKMapView *LocationMap;
@property (nonatomic,retain) IBOutlet UIView *LocationMapView;


@property (nonatomic, strong) SegmentedControl *SegmentedControl;

@property (nonatomic, retain) NSString *report_title;
@property (nonatomic, retain) NSString *reportAvaragerate;
@property (nonatomic, retain) NSString *postby;
@property (nonatomic, retain) NSString *licenceplate;
@property (nonatomic, retain) NSString *makeby;
@property (nonatomic, retain) NSString *model;
@property (nonatomic, retain) NSString *year;
@property (nonatomic, retain) NSString *characteristics;
@property (nonatomic, retain) NSString *report_description;
@property (nonatomic, retain) NSString *totalComment;
@property (nonatomic, retain) NSString *Latetude;
@property (nonatomic, retain) NSString *Longitude;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSString *ItsEvidencelocker;
@property (nonatomic ,retain) NSString *photos;


@end

@implementation ReportDetailsViewController
@synthesize reportId;
@synthesize MAinScrollview;
@synthesize LocationMap = _LocationMap;
@synthesize LocationMapView = _LocationMapView;

@synthesize report_description,report_title,reportAvaragerate,makeby, Latetude, licenceplate, theisreportpostbyme, title, totalComment,postby,Longitude,year,characteristics,location,ItsEvidencelocker,photos;

@synthesize UITextViewForPostComment                = _UITextViewForPostComment;

@synthesize UIViewForPostComment                    = _UIViewForPostComment;
@synthesize UIButtonForSubMitComment                = _UIButtonForSubMitComment;
@synthesize UILabelForPostComment                   = _UILabelForPostComment;
@synthesize UILabelForRateComment                   = _UILabelForRateComment;

@synthesize UIViewForCommentListing                 = _UIViewForCommentListing;
@synthesize WhichSegmentClicked                     = _WhichSegmentClicked;
@synthesize commentShowtable;

#define DetailPageGlobalGreenFontName      @"OpenSans-Semibold";
#define DetailPageGlobalGreenFontSize      13;


bool Is_Any_Image                           = NO;
int TotalCommentbyme                        = 0;
float Basic_height                          = 0.0f;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) setBack{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)leftSideMenuButtonPressed:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

- (void)rightSideMenuButtonPressed:(id)sender
{
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{}];
}




-(void)viewWillAppear:(BOOL)animated
{
    
    //    NSLog(@"in view will appear");
    //
    //    currentImage = 0;
    //    iscommentpresh=YES;
    //
    //      AllComment=[[NSMutableArray alloc]init];
    //
    //    MainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //
    //
    //
    //    NSUserDefaults *userDefalds=[NSUserDefaults standardUserDefaults];
    //    userID=[userDefalds valueForKey:@"userid"];
    //
    //    ReportDetailsHelper = [[HelperClass alloc] init];
    //    [ReportDetailsHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
    //    UserDetailDic=[[NSMutableDictionary alloc]initWithCapacity:9];
    //    [ReportDetailsHelper SetupHeaderView:self.view viewController:self];
    //    [ReportDetailsHelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    //
    //    [self.navigationController setNavigationBarHidden:YES];
    //    ReportOperation=[[NSOperationQueue alloc]init];
    //
    ////    DetailsTabbing = [[SegmentedControl alloc] initWithSectionTitles:@[@"Description", @"Map", @"Comment"]];
    ////    DetailsTabbing.frame = CGRectMake(10, 60, 300, 60);
    ////    [DetailsTabbing addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    ////    DetailsTabbing.backgroundColor = [UIColor clearColor];
    ////    [self.view addSubview:DetailsTabbing];
    //    NSInvocationOperation *operation=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(LoadAlldata) object:nil];
    //    [ReportOperation addOperation:operation];
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    /*
     Scroll View declaration
     */
//    [super viewDidLoad];
    
    NSLog(@"in view will appear");
    
    
    
    
    
}

- (void)viewDidLoad
{
    
   
    
    _UILabelForPostComment.font = [UIFont fontWithName:GLOBALTEXTFONT_Title size:15.0];
    [_UILabelForPostComment setTextColor:UIColorFromRGB(0x211e1f)];
    
    _UILabelForRateComment.font = [UIFont fontWithName:GLOBALTEXTFONT_Title size:15.0];
    [_UILabelForRateComment setTextColor:UIColorFromRGB(0x211e1f)];
    
    
    segmentedControl1 = [[SegmentedControl alloc] initWithSectionTitles:@[@"Report Details", @"Map", @"Comment"]];
    segmentedControl1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    segmentedControl1.frame = CGRectMake(0, 51, 320, 43);
    segmentedControl1.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    segmentedControl1.selectionStyle = SegmentedControlSelectionStyleFullWidthStripe;
    segmentedControl1.selectionIndicatorLocation = SegmentedControlSelectionIndicatorLocationDown;
    segmentedControl1.selectionIndicatorColor = UIColorFromRGB(0xde2629);
    segmentedControl1.selectedTextColor = UIColorFromRGB(0xde2629);
    [segmentedControl1 setFont:[UIFont fontWithName:GLOBALTEXTFONT size:14.0f]];
    segmentedControl1.scrollEnabled = NO;
    [segmentedControl1 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl1];
    
    
    
    
    Basic_height = 0;  //for managing the scrolling when there is no image..
    
    currentImage = 0;
    iscommentpresh=YES;
    
    AllComment=[[NSMutableArray alloc]init];
    
    MainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    
    NSUserDefaults *userDefalds=[NSUserDefaults standardUserDefaults];
    userID=[userDefalds valueForKey:@"userid"];
    
    ReportDetailsHelper = [[HelperClass alloc] init];
    [ReportDetailsHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
    UserDetailDic=[[NSMutableDictionary alloc]initWithCapacity:9];
 //   [ReportDetailsHelper SetupHeaderView:self.view viewController:self];
    [ReportDetailsHelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    
    [self.navigationController setNavigationBarHidden:YES];
    ReportOperation=[[NSOperationQueue alloc]init];
    
    
    
    if(self.backBtnEnableInReportDetails == YES){
        [ReportDetailsHelper SetupHeaderViewWithBack:self.view viewController:self];
    }
    
    else{
        [ReportDetailsHelper SetupHeaderView:self.view viewController:self];
    }
    
    
    //    DetailsTabbing = [[SegmentedControl alloc] initWithSectionTitles:@[@"Description", @"Map", @"Comment"]];
    //    DetailsTabbing.frame = CGRectMake(10, 60, 300, 60);
    //    [DetailsTabbing addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    //    DetailsTabbing.backgroundColor = [UIColor clearColor];
    //    [self.view addSubview:DetailsTabbing];
    NSInvocationOperation *operation=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(LoadAlldata) object:nil];
    [ReportOperation addOperation:operation];

    
}


-(void)LoadAlldata
{
    [self.view setUserInteractionEnabled:NO];
    ImageArray = nil;
    _WhichSegmentClicked = SegmentClickedDetails;
    
    
    
        ImageArray=[[NSMutableArray alloc]init];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void)
                   {
                       
                       NSString *StringUrl=[NSString stringWithFormat:@"%@result_details.php?id=%@&loginuser=%@",DomainURL,reportId,userID];
                       NSLog(@"the value for key:%@",StringUrl);
                       NSURL *url=[NSURL URLWithString:StringUrl];
                       NSData *data=[NSData dataWithContentsOfURL:url];
                       NSDictionary *mainDic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                       NSArray *reportImageArray=[mainDic objectForKey:@"reportimage"];
                       
                       NSDictionary *reportDetail=[mainDic valueForKey:@"reportdetails"];
                       report_title=[reportDetail valueForKey:@"report_title"];
                       reportAvaragerate=[reportDetail valueForKey:@"report_avg_rating"];
                       postby=[reportDetail valueForKey:@"posted_by"];
                       
                       userIdForGoToDetailsPage =[reportDetail valueForKey:@"post_by_user"];
                       
                       
                       //modified
                       
                       licenceplate=[reportDetail valueForKey:@"licence_plate"];
                       NSString *makeBywhom=[reportDetail valueForKey:@"make"];
                       if ([makeBywhom isKindOfClass:NULL]||[makeBywhom isEqualToString:@""])
                       {
                           makeby=@"N/A";
                       }
                       else
                       {
                           makeby=[reportDetail valueForKey:@"make"];
                       }
                       
                       
                       self.model=[reportDetail valueForKey:@"model"];
                       if ([self.model isKindOfClass:NULL]||[self.model isEqualToString:@""]) {
                           self.model=@"N/A";
                       }
                       year=[reportDetail valueForKey:@"year"];
                       if ([year isKindOfClass:NULL]||[year isEqualToString:@""])
                       {
                           year=@"N/A";
                       }
                       characteristics=[reportDetail valueForKey:@"characteristics"];
                       if ([characteristics isKindOfClass:NULL]||[characteristics isEqualToString:@""])
                       {
                           characteristics=@"N/A";
                       }
                       report_description=[reportDetail valueForKey:@"report_desc"];
                       if ([report_description isKindOfClass:NULL]||[report_description isEqualToString:@""])
                       {
                           report_description=@"N/A";
                       }
                       totalComment=[reportDetail valueForKey:@"report_comment_text"];
                       Latetude=[reportDetail valueForKey:@"latitude"];
                       Longitude=[reportDetail valueForKey:@"longitude"];
                       
//                       if ([Latetude isEqualToString:@"0.000000"] && [Longitude isEqualToString:@"0.000000"]) {
//                           location= @"N/A";
//                           
//                           //need to check
//                           
//                       }
                       
                       if (![[reportDetail valueForKey:@"location"] length]>0)
                       {
                           location= @"N/A";
                           //need to check
                       }
                       
                       
                       else {
                           location=[reportDetail valueForKey:@"location"];
                       }
                       
                       NSLog(@"lat and long is--- %@   --  %@", Latetude, Longitude);
                       
                       ItsEvidencelocker=[reportDetail valueForKey:@"its_evidance_locker"];
                       photos=[reportDetail valueForKey:@"report_total_image_text"];
                       for (NSString *imageReport in reportImageArray)
                       {
                           [ImageArray addObject:imageReport];
                       }
                       NSLog(@"the image array:%@",ImageArray);
                       
                  
//                    if(ImageArray == nil || [ImageArray count]<1)
//                       {
//                           NSLog(@"no image heree");
//                       }
//                       
//                       else
//                       {
                       dispatch_async( dispatch_get_main_queue(), ^(void)
                                      {
                                          [self REportDetailsview];
                                      });
//                       }
                                            
                       
                   });
}


-(IBAction)GotoTheAllSimilerreportPage:(id)sender
{
    
    SimiarReportViewController *SimilerreportDetails = [[SimiarReportViewController alloc] initWithNibName:@"SimiarReportViewController" bundle:nil];
    SimilerreportDetails.Reportid=reportId;
    SimilerreportDetails.backBtnEnableInSimilarReport = YES;
    [self.navigationController pushViewController:SimilerreportDetails animated:YES];
    
}


#pragma Details comment view
-(void)REportDetailsview
{
    // Hide loader Indecater
    
    [ReportDetailsHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
    
    // Check there is any image or not
    
    [MAinScrollview setBackgroundColor:[UIColor whiteColor]];
    [MAinScrollview setFrame:CGRectMake(0, 75, 320, self.view.frame.size.height-77)];
    
   // [MAinScrollview setFrame:CGRectMake(0, 75, 320, 568)];
    
    if ([ImageArray count]>0)
    {
        
         NSLog(@"i m in ifffgg");
        //[MAinScrollview setFrame:CGRectMake(0, 75, 320, self.view.frame.size.height-77)];
        
        
        NSInteger numbour        =   [ImageArray count];
        CGRect frame            =   [MAinScrollview frame];
        [self.imageSliderview setFrame:CGRectMake(0, 0, 320, 185)];
        
        [MAinScrollview addSubview:self.imageSliderview];
        
        frame.origin.y+=0;
        [MAinScrollview setFrame:frame];
        
        for (int i=0; i<[ImageArray count]; i++)
        {
            ZSImageView *imageview=[[ZSImageView alloc]initWithFrame:CGRectMake(i*320, 0, 320, 185)];
            imageview.imageUrl=[ImageArray objectAtIndex:i];
            imageview.contentMode = UIViewContentModeScaleAspectFit;
            [self.imageSlider addSubview:imageview];
        }
        [self.imageSlider setPagingEnabled:YES];
        [self.imageSlider setContentSize:CGSizeMake(numbour*320, 185)];
        
        Basic_height = 185.0f;
    }
    
    
    else
    {
        NSLog(@"i m in elsee");
        NSLog(@"scroll h8 is %f", MAinScrollview.layer.frame.size.height);
        [MAinScrollview setContentSize:CGSizeMake(320, 460)];
    }
    
    
    
    // Add TitleView
    
    Basic_height                = Basic_height+2.0f;
    
    UITextView *TitleTextView       =   [[UITextView alloc] init];
    TitleTextView.text              =   report_title;
    [TitleTextView setFont:[UIFont fontWithName:@"OpenSans-Semibold" size:14.0f]];
    
    NSAttributedString *attributed=[[NSAttributedString alloc]initWithString:report_title];
    [TitleTextView setAttributedText:attributed];
    CGSize size = [TitleTextView sizeThatFits:CGSizeMake(300, FLT_MAX)];
    
    float TitleViewHeight       = size.height;
    
    TitleTextView.frame = CGRectMake(10, Basic_height, 300, TitleViewHeight);
    [TitleTextView setTextAlignment:NSTextAlignmentLeft];
    [TitleTextView setTextColor:UIColorFromRGB(0x211e1f)];
    [TitleTextView setFont:[UIFont fontWithName:@"OpenSans-Semibold" size:15.0f]];
    [TitleTextView setBackgroundColor:[UIColor clearColor]];
    [TitleTextView setEditable:NO];
    [TitleTextView sizeToFit];
    [TitleTextView setUserInteractionEnabled:NO];
    [MAinScrollview addSubview:TitleTextView];
    
    Basic_height                = Basic_height + TitleTextView.layer.frame.size.height;
    
    int TOTAL = 5;
    int YELLOW = [reportAvaragerate integerValue] ;
    int GRAY = TOTAL - YELLOW;
    float SIZEX = 15;
    for(int i=0; i < YELLOW; i++)
    {
        [ReportDetailsHelper CreateImageviewWithImage:MAinScrollview xcord:SIZEX ycord:Basic_height width:20 height:20 backgroundColor:[UIColor clearColor] imageName:@"starNEW"];
        SIZEX = SIZEX + 22;
    }
    for(int j=0; j < GRAY; j++)
    {
        if(GRAY==5 && j==0)
            SIZEX = 15;
        [ReportDetailsHelper CreateImageviewWithImage:MAinScrollview xcord:SIZEX ycord:Basic_height width:20 height:20 backgroundColor:[UIColor clearColor] imageName:@"star1NEW"];
        SIZEX = SIZEX + 22;
    }
    
    [ReportDetailsHelper CreatelabelWithValueCenter:SIZEX+30 ycord:Basic_height+3 width:30 height:16 backgroundColor:[UIColor clearColor] textcolor:[UIColor redColor] labeltext:[NSString stringWithFormat:@"%@",totalComment] fontName:GLOBALTEXTFONT fontSize:15.0f addView:MAinScrollview];
    
    [ReportDetailsHelper CreatelabelWithValueCenter:SIZEX+44 ycord:Basic_height+3 width:100 height:16 backgroundColor:[UIColor clearColor] textcolor:[UIColor darkGrayColor] labeltext:@"Comment" fontName:GLOBALTEXTFONT fontSize:15.0f addView:MAinScrollview];
    
    
    UIButton *buttonForCommentTitle = [[UIButton alloc]initWithFrame:CGRectMake(SIZEX+20, Basic_height-4, 125, 35)];
    buttonForCommentTitle.backgroundColor = [UIColor clearColor];
    [buttonForCommentTitle addTarget:self action:@selector(CommentTitlePressed) forControlEvents:UIControlEventTouchUpInside];
    
    [MAinScrollview addSubview:buttonForCommentTitle];
    
    
    Basic_height                = Basic_height + 22 + 5;
    
    
    DetailsTextView = [[UITextView alloc] init];
    DetailsTextView.text=report_description;
    
    NSAttributedString *attributed1=[[NSAttributedString alloc]initWithString:report_description];
    [DetailsTextView setAttributedText:attributed1];
    CGSize size1 = [DetailsTextView sizeThatFits:CGSizeMake(300, FLT_MAX)];
    
    DetailsTextView.frame = CGRectMake(10, Basic_height, 300, size1.height);
    [DetailsTextView setTextAlignment:NSTextAlignmentLeft];
    [DetailsTextView setFont:[UIFont fontWithName:GLOBALTEXTFONT size:12]];
    [DetailsTextView setTextColor:UIColorFromRGB(0x575757)];
    [DetailsTextView setBackgroundColor:[UIColor clearColor]];
    [DetailsTextView setEditable:NO];
    [DetailsTextView sizeToFit];
    [DetailsTextView setUserInteractionEnabled:NO];
    [MAinScrollview addSubview:DetailsTextView];
    
    Basic_height                = Basic_height + DetailsTextView.layer.frame.size.height;
    
    UIView *ViewForPostedComment = [[UIView alloc] initWithFrame:CGRectMake(0, Basic_height, 310, 20)];
    [ReportDetailsHelper CreatelabelWithValueCenter:15 ycord:0 width:100 height:35 backgroundColor:[UIColor clearColor] textcolor:UIColorFromRGB(0x1ab04c) labeltext:@"Posted By" fontName:@"OpenSans-Semibold" fontSize:13.0f addView:ViewForPostedComment];
    [MAinScrollview addSubview:ViewForPostedComment];
    
    UIButton *buttonAbovePostedBy = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
    [buttonAbovePostedBy setBackgroundColor:[UIColor clearColor]];
    [buttonAbovePostedBy addTarget:self action:@selector(goToDetailsPage) forControlEvents:UIControlEventTouchUpInside];
    [ViewForPostedComment addSubview:buttonAbovePostedBy];
    
    
    
    Basic_height                = Basic_height + 20 + 5;
    
    UIView *ViewForLocation = [[UIView alloc] initWithFrame:CGRectMake(0, Basic_height, 310, 20)];
    [ReportDetailsHelper CreatelabelWithValueCenter:15 ycord:0 width:100 height:35 backgroundColor:[UIColor clearColor] textcolor:UIColorFromRGB(0x1ab04c) labeltext:@"Location" fontName:@"OpenSans-Semibold" fontSize:13.0f addView:ViewForLocation];
    [MAinScrollview addSubview:ViewForLocation];
    
    Basic_height                = Basic_height + 20 + 5;
    
    UIView *ViewForLicensePlate = [[UIView alloc] initWithFrame:CGRectMake(0, Basic_height, 320, 52)];
    [ReportDetailsHelper CreatelabelWithValueCenter:15 ycord:0 width:100 height:35 backgroundColor:[UIColor clearColor] textcolor:UIColorFromRGB(0x1ab04c) labeltext:@"License Plate" fontName:@"OpenSans-Semibold" fontSize:13.0f addView:ViewForLicensePlate];
    Evidencelocker=[[UILabel alloc]initWithFrame:CGRectMake(15, 37, 140, 20)];
    
//    buttonEvidencel=[[UIButton alloc]initWithFrame:CGRectMake(15, 37, 130, 20)];
    
    buttonEvidencel=[[UIButton alloc]initWithFrame:CGRectMake(10, 30, 300, 34)];
    
   // [buttonEvidencel setBackgroundColor:UIColorFromRGB(0x17b04a)];
    
    [buttonEvidencel setBackgroundColor:[UIColor clearColor]];
    UILabel *labelUnderButton = [[UILabel alloc]initWithFrame:CGRectMake(10, 37, 300, 20)];
    labelUnderButton.backgroundColor = UIColorFromRGB(0x17b04a);
    [ViewForLicensePlate addSubview:labelUnderButton];
    
    
    
    if ([ItsEvidencelocker integerValue]==1)
    {
        isAddedToAvidencelocker=YES;
//        [buttonEvidencel setBackgroundImage:[UIImage imageNamed:@"RemoveFromEvidenceLocker.jpg"] forState:UIControlStateNormal];
        
//        [buttonEvidencel setBackgroundImage:[UIImage imageNamed:@"login_pic.png"] forState:UIControlStateNormal];
//        buttonEvidencel.titleLabel.text = @"RemoveFromEvidenceLocker";
//        buttonEvidencel.titleLabel.textColor = [UIColor whiteColor];
        
        [buttonEvidencel setTitle:@"RemoveFromEvidenceLocker" forState:UIControlStateNormal];
        [buttonEvidencel setTitle:@"RemoveFromEvidenceLocker" forState:UIControlStateHighlighted];
        [buttonEvidencel setTitle:@"RemoveFromEvidenceLocker" forState:UIControlStateSelected];
        [buttonEvidencel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buttonEvidencel setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [buttonEvidencel setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        buttonEvidencel.titleLabel.font=[UIFont fontWithName:GLOBALTEXTFONT size:15.0f];
        
        
    }
    else
    {
        isAddedToAvidencelocker=NO;
        
//        [buttonEvidencel setBackgroundImage:[UIImage imageNamed:@"AddToEvidenceLocker.jpg"] forState:UIControlStateNormal];
        
//        [buttonEvidencel setBackgroundImage:[UIImage imageNamed:@"login_pic.png"] forState:UIControlStateNormal];
//        buttonEvidencel.titleLabel.text = @"AddToEvidenceLocker";
//        buttonEvidencel.titleLabel.textColor = [UIColor whiteColor];
        
        [buttonEvidencel setTitle:@"AddToEvidenceLocker" forState:UIControlStateNormal];
        [buttonEvidencel setTitle:@"AddToEvidenceLocker" forState:UIControlStateHighlighted];
        [buttonEvidencel setTitle:@"AddToEvidenceLocker" forState:UIControlStateSelected];
        [buttonEvidencel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buttonEvidencel setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [buttonEvidencel setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        buttonEvidencel.titleLabel.font=[UIFont fontWithName:GLOBALTEXTFONT size:14.0f];
        
        
        
    }
    
    [buttonEvidencel addTarget:self action:@selector(buttonEvidenceclick) forControlEvents:UIControlEventTouchUpInside];
    
    //tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AddToAvidenceLocker:)];
    //[tapGesture setNumberOfTapsRequired:1];
    //[ViewForLicensePlate addGestureRecognizer:tapGesture];
    Evidencelocker.textAlignment=NSTextAlignmentCenter;
    Evidencelocker.textColor=[UIColor greenColor];
    Evidencelocker.font=[UIFont systemFontOfSize:10.0f];
    [ViewForLicensePlate addSubview:buttonEvidencel];
    
    [ViewForLicensePlate addSubview:Evidencelocker];
    [ViewForLicensePlate setBackgroundColor:[UIColor clearColor]];
    [MAinScrollview addSubview:ViewForLicensePlate];
    
    Basic_height                = Basic_height + 50 + 5;
    
    UIView *ViewForMake = [[UIView alloc] initWithFrame:CGRectMake(0, Basic_height, 310, 20)];
    [ReportDetailsHelper CreatelabelWithValueCenter:15 ycord:0 width:100 height:35 backgroundColor:[UIColor clearColor] textcolor:UIColorFromRGB(0x1ab04c) labeltext:@"Make" fontName:@"OpenSans-Semibold" fontSize:13.0f addView:ViewForMake];
    [ViewForMake setBackgroundColor:[UIColor clearColor]];
    [MAinScrollview addSubview:ViewForMake];
    
    Basic_height                = Basic_height + 20 + 5;
    
    UIView *ViewForModel = [[UIView alloc] initWithFrame:CGRectMake(0, Basic_height, 310, 20)];
    [ReportDetailsHelper CreatelabelWithValueCenter:15 ycord:0 width:100 height:35 backgroundColor:[UIColor clearColor] textcolor:UIColorFromRGB(0x1ab04c) labeltext:@"Model" fontName:@"OpenSans-Semibold" fontSize:13.0f addView:ViewForModel];
    [ViewForModel setBackgroundColor:[UIColor clearColor]];
    [MAinScrollview addSubview:ViewForModel];
    
    Basic_height                = Basic_height + 20 + 5;
    
    UIView *ViewForYear = [[UIView alloc] initWithFrame:CGRectMake(0, Basic_height, 310, 20)];
    [ReportDetailsHelper CreatelabelWithValueCenter:15 ycord:0 width:100 height:35 backgroundColor:[UIColor clearColor] textcolor:UIColorFromRGB(0x1ab04c) labeltext:@"Year" fontName:@"OpenSans-Semibold" fontSize:13.0f addView:ViewForYear];
    [ViewForYear setBackgroundColor:[UIColor clearColor]];
    [MAinScrollview addSubview:ViewForYear];
    
    Basic_height                = Basic_height + 20 + 5;
    
    UIView *ViewForCharacteristics = [[UIView alloc] initWithFrame:CGRectMake(0, Basic_height, 310, 20)];
    
    [ReportDetailsHelper CreatelabelWithValueCenter:15 ycord:0 width:100 height:35 backgroundColor:[UIColor clearColor] textcolor:UIColorFromRGB(0x1ab04c) labeltext:@"Characteristics" fontName:@"OpenSans-Semibold" fontSize:13.0f addView:ViewForCharacteristics];
    [ViewForCharacteristics setBackgroundColor:[UIColor clearColor]];
    [MAinScrollview addSubview:ViewForCharacteristics];
    
    [ReportDetailsHelper CreatelabelWithValueCenter:120 ycord:0 width:180 height:35 backgroundColor:[UIColor clearColor] textcolor:[UIColor darkGrayColor] labeltext:postby fontName:GLOBALTEXTFONT fontSize:15.0f addView:ViewForPostedComment];
    
    [ReportDetailsHelper CreatelabelWithValueCenter:120 ycord:1.5f width:180 height:35 backgroundColor:[UIColor clearColor] textcolor:[UIColor darkGrayColor] labeltext:licenceplate fontName:GLOBALTEXTFONT fontSize:13.0f addView:ViewForLicensePlate];
    
    [ReportDetailsHelper CreatelabelWithValueCenter:120 ycord:3 width:200 height:35 backgroundColor:[UIColor clearColor] textcolor:[UIColor darkGrayColor] labeltext:makeby fontName:GLOBALTEXTFONT fontSize:13.0f addView:ViewForMake];
    
    [ReportDetailsHelper CreatelabelWithValueCenter:120 ycord:3 width:200 height:35 backgroundColor:[UIColor clearColor] textcolor:[UIColor darkGrayColor] labeltext:year fontName:GLOBALTEXTFONT fontSize:13.0f addView:ViewForYear];
    
    [ReportDetailsHelper CreatelabelWithValueCenter:120 ycord:3 width:200 height:35 backgroundColor:[UIColor clearColor] textcolor:[UIColor darkGrayColor] labeltext:self.model fontName:GLOBALTEXTFONT fontSize:13.0f addView:ViewForModel];
    
    [ReportDetailsHelper CreatelabelWithValueCenter:120 ycord:3 width:180 height:35 backgroundColor:[UIColor clearColor] textcolor:[UIColor darkGrayColor] labeltext:location fontName:GLOBALTEXTFONT fontSize:13.0f addView:ViewForLocation];
    
    [ReportDetailsHelper CreatelabelWithValueCenter:120 ycord:1.5f width:200 height:35 backgroundColor:[UIColor clearColor] textcolor:[UIColor darkGrayColor] labeltext:characteristics fontName:GLOBALTEXTFONT fontSize:13.0f addView:ViewForCharacteristics];
    
    Basic_height = Basic_height +50;
    
    UIButton *ShowAllSimilerreport=[UIButton buttonWithType:UIButtonTypeCustom];
    [ShowAllSimilerreport setBackgroundColor:UIColorFromRGB(0x17b04a)];
    ShowAllSimilerreport.frame=CGRectMake(10,Basic_height, 300, 30);
    [ShowAllSimilerreport setTitle:@"Similar Reports" forState:UIControlStateNormal];
    [ShowAllSimilerreport setTitle:@"Similar Reports" forState:UIControlStateHighlighted];
    [ShowAllSimilerreport setTitle:@"Similar Reports" forState:UIControlStateSelected];
    [ShowAllSimilerreport setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ShowAllSimilerreport setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [ShowAllSimilerreport setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    ShowAllSimilerreport.titleLabel.font=[UIFont fontWithName:GLOBALTEXTFONT size:17.0f];
    [ShowAllSimilerreport addTarget:self action:@selector(GotoTheAllSimilerreportPage:) forControlEvents:UIControlEventTouchUpInside];
    [MAinScrollview addSubview:ShowAllSimilerreport];
    
    Basic_height = Basic_height +30;
    
    [MAinScrollview setContentSize:CGSizeMake(320, Basic_height+50)];
    
    [self.view setUserInteractionEnabled:YES];
}


-(void)CommentTitlePressed
{
    NSLog(@"comment title pressed");
    [_imageSliderview setHidden:YES];

    segmentedControl1.selectedSegmentIndex = 2;
    MAinScrollview.frame=CGRectMake(0, 98, 320, 470);
    [_imageSliderview setHidden:YES];
    [self commentoperation];
    
}

-(void)buttonEvidenceclick
{
    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    if (isAddedToAvidencelocker) {
        // dispatch_async(dispatch_get_main_queue(), ^(){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"Remove this from Evidence Locker?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alert show];
        //});
    }
    else
    {
        // dispatch_async(dispatch_get_main_queue(), ^(){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"Add this to Evidence Locker?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alert show];
        // });
    }
    // });
}

- (void)uisegmentedControlChangedValue:(UISegmentedControl *)segmentedControl {
    // NSLog(@"Selected index %i", segmentedControl.selectedSegmentIndex);
}


-(void)LoadDetailsAgain
{
    NSArray *array=[MAinScrollview subviews];
    for (UIView *subview in array)
    {
        [subview removeFromSuperview];
    }
    
    NSInvocationOperation *operation2=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(LoadAlldata) object:nil];
    [ReportOperation addOperation:operation2];
}


-(void)commentoperation
{
    
    NSArray *arrayForcontect=[_backgroundRatting subviews];
    for (UIView * muview in arrayForcontect)
    {
        [muview removeFromSuperview];
    }
    
    self.noCommentFound.hidden=YES;
    NSArray *array=[MAinScrollview subviews];
    for (UIView *subview in array)
    {
        [subview removeFromSuperview];
        
    }
    [self CommentPageopen];
}

-(void)Loadmapview
{
    
    
    NSLog(@"i am in Loadmapview");
    
    NSArray *array=[MAinScrollview subviews];
    for (UIView *subview in array)
    {
        [subview removeFromSuperview];
    }
    
    if (![[Latetude stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@"0.000000"] || ![[Longitude stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@"0.000000"]) {
        
//        _LocationMapView.frame=CGRectMake(10, 20, _LocationMapView.frame.size.width, _LocationMapView.frame.size.height);
        
        _LocationMapView.frame=CGRectMake(10, -20, _LocationMapView.frame.size.width, _LocationMapView.frame.size.height);
        [MAinScrollview addSubview:_LocationMapView];
        
        NSLog(@"Latetude ------ %@ ++++++++ Longitude %@",Latetude,Longitude);
        
        CLLocationCoordinate2D annotationCoord;
        annotationCoord.latitude = [Latetude doubleValue];
        annotationCoord.longitude = [Longitude doubleValue];
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(annotationCoord, 800, 800);
        [_LocationMap setRegion:[_LocationMap regionThatFits:region] animated:YES];
        
        // Add an annotation
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = annotationCoord;
        point.title = @"Report Location";
        [_LocationMap addAnnotation:point];
    } else {
        
        NolocationLablel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 220, 50)];
        [NolocationLablel setBackgroundColor:[UIColor clearColor]];
        [NolocationLablel setTextAlignment:NSTextAlignmentCenter];
        [NolocationLablel setTextColor:[UIColor blackColor]];
        [NolocationLablel setFont:[UIFont fontWithName:GLOBALTEXTFONT size:14]];
        [NolocationLablel setNumberOfLines:0];
        NSString *Textdata = (![[location stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""])?[NSString stringWithFormat:@"Report location : %@",location]:@"No location found";
        [NolocationLablel setText:Textdata];
        MAinScrollview.contentSize = CGSizeMake(320, 420);
        [MAinScrollview addSubview:NolocationLablel];
        
    }
    
    
}

-(void)HideButton :(UIButton *)ButtonName
{
    [ButtonName setHidden:YES];
    [ButtonName setUserInteractionEnabled:NO];
}

-(void)ShowButton :(UIButton *)ButtonName {
    [ButtonName setHidden:NO];
    [ButtonName setUserInteractionEnabled:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma UIAlertViewDelegate implemantation
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        if (alertView.tag == 9119)
        {
             [_UITextViewForPostComment becomeFirstResponder];
        }
        
        
        if (alertView.tag == 13331)
        {
            [_UITextViewForPostComment becomeFirstResponder];
        }
        
    }
    else if (buttonIndex==1)
    {
        if(isAddedToAvidencelocker==NO)
        {
            [self Addtoevidence];
        }
        else
        {
            [self Addtoevidence];
        }
    }
}

-(void)Addtoevidence
{
    NSString *strAdd;
    
    if (isAddedToAvidencelocker)
    {
        strAdd=[NSString stringWithFormat:@"%@appweb.php?mode=delete_evidance_locker&getuser=%@&licence=%@",DomainURL,userID,licenceplate];
        
//        [buttonEvidencel setBackgroundImage:[UIImage imageNamed:@"AddToEvidenceLocker.jpg"] forState:UIControlStateNormal];
    
        //modified
        
        [buttonEvidencel setTitle:@"AddToEvidenceLocker" forState:UIControlStateNormal];
        [buttonEvidencel setTitle:@"AddToEvidenceLocker" forState:UIControlStateHighlighted];
        [buttonEvidencel setTitle:@"AddToEvidenceLocker" forState:UIControlStateSelected];
        [buttonEvidencel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buttonEvidencel setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [buttonEvidencel setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        buttonEvidencel.titleLabel.font=[UIFont fontWithName:GLOBALTEXTFONT size:17.0f];
        
        
        isAddedToAvidencelocker=NO;
        
    }
    else
    {
        
        strAdd=[NSString stringWithFormat:@"%@appweb.php?mode=add_evidance_locker&getuser=%@&licence=%@",DomainURL,userID,licenceplate];
        
//        [buttonEvidencel setBackgroundImage:[UIImage imageNamed:@"RemoveFromEvidenceLocker.jpg"] forState:UIControlStateNormal];
        
        
        [buttonEvidencel setTitle:@"RemoveFromEvidenceLocker" forState:UIControlStateNormal];
        [buttonEvidencel setTitle:@"RemoveFromEvidenceLocker" forState:UIControlStateHighlighted];
        [buttonEvidencel setTitle:@"RemoveFromEvidenceLocker" forState:UIControlStateSelected];
        [buttonEvidencel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buttonEvidencel setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [buttonEvidencel setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        buttonEvidencel.titleLabel.font=[UIFont fontWithName:GLOBALTEXTFONT size:17.0f];
        
        
        isAddedToAvidencelocker=YES;
    }
    NSLog(@"strAdd --- %@",strAdd);
    
    @try {
        NSURL *Url=[NSURL URLWithString:strAdd];
        NSData *datta=[NSData dataWithContentsOfURL:Url];
        NSDictionary *dicTion=[NSJSONSerialization JSONObjectWithData:datta options:kNilOptions error:nil];
        NSString *message=[dicTion valueForKey:@"message"];
        NSString *responce=[dicTion valueForKey:@"response"];
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:responce message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    @catch (NSException *exception) {
        NSLog(@"exception is  ---- %@",exception);
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Try again later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        isAddedToAvidencelocker=NO;
        [alert show];
    }
    
  
}
-(void)CommentPageopen
{
    [_UIViewForPostComment removeFromSuperview];
    
    NSUserDefaults *userdefals=[NSUserDefaults standardUserDefaults];
    Name=[NSString stringWithFormat:@"%@ %@",[userdefals valueForKey:@"first_name"],[userdefals valueForKey:@"last_name"]];
    
    NSDate *currentDate = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    curDate = [dateFormatter stringFromDate:currentDate];
    [ReportDetailsHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
    [commentShowtable setDelegate:self];
    [commentShowtable setDataSource:self];
    [MAinScrollview setScrollEnabled:NO];
    [MAinScrollview setContentOffset:CGPointMake(0, 0)];
    
    _UIViewForCommentListing.frame=CGRectMake(0, 0, 320, 454);
    [MAinScrollview addSubview:_UIViewForCommentListing];
    [_UIViewForPostComment setFrame:CGRectMake(0, 0, 320, 456)];
    //modified new
    [_UIViewForCommentListing addSubview:_UIViewForPostComment];
    self.UIViewForPostComment.hidden=YES;
    
    [_UITextViewForPostComment setTag:100];
    [_UITextViewForPostComment setDelegate:self];
    [_UITextViewForPostComment setText:@"Add Comment Here"];
    [_UITextViewForPostComment setTextColor:UIColorFromRGB(0xc5c5c5)];
    _UIViewForPostComment.layer.cornerRadius=4.0f;
    
    [_UIViewForPostComment addSubview:_UITextViewForPostComment];
    // [_backgroundRatting removeFromSuperview];
    
    float SIZEX = 0;
    float SIZEY = 3;
    float SIZEW = 20;
    float SIZEH = 20;
    //modified      30
    for(int i=0; i < 5; i++)
    {
        if(i==0)
//            SIZEX = 10;
              SIZEX = 0;
        GreyImageButton = [[UIButton alloc] initWithFrame:CGRectMake(SIZEX, SIZEY, SIZEW, SIZEH)];
        [GreyImageButton setImage:[UIImage imageNamed:@"star1NEW"] forState:UIControlStateNormal];
        //modified
        [GreyImageButton setImage:[UIImage imageNamed:@"starNEW"] forState:UIControlStateHighlighted];
        [GreyImageButton setImage:[UIImage imageNamed:@"starNEW"] forState:UIControlStateReserved];
        [GreyImageButton setImage:[UIImage imageNamed:@"starNEW"] forState:UIControlStateSelected];
        [GreyImageButton addTarget:self action:@selector(UiGreyImageButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [GreyImageButton setTag:(10000+i)];
        [_backgroundRatting addSubview:GreyImageButton];
        SIZEX = SIZEX + SIZEW;
    }
    
    [self fetchAllooent];
}

-(void)fetchAllooent
{
    NSLog(@" i am in all comment");
    [AllComment removeAllObjects];
    AllComment=[[NSMutableArray alloc]init];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void)
                   {
                       NSString *StringUrl=[NSString stringWithFormat:@"%@comment_list_details.php?id=%@",DomainURL,reportId];
                       NSLog(@"The string url:%@",StringUrl);
                       NSURL *url=[NSURL URLWithString:StringUrl];
                       NSData *data=[NSData dataWithContentsOfURL:url];
                       NSDictionary *mainDic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                       
                       NSDictionary *reportCommentList=[mainDic valueForKey:@"report_comment_list"];
                       NSDictionary *paramdic=[reportCommentList valueForKey:@"params"];
                       Errorstatus=[paramdic valueForKey:@"response"];
                       if ([Errorstatus isEqualToString:@"success"])
                       {
                           NSArray *AllcommentList=[reportCommentList objectForKey:@"comment_list"];
                           for (NSDictionary *dic2 in AllcommentList)
                           {
                               NSString *comment_id=[dic2 valueForKey:@"comment_id"];
                               NSString *comment_image=[dic2 valueForKey:@"image"];
                               NSString *comment_name=[dic2 valueForKey:@"name"];
                               NSString *comment_get_userid=[dic2 valueForKey:@"get_userid"];
                               NSString *comment_Getbdgimage=[dic2 valueForKey:@"get_badge"];
                               NSString *comment_ratingimg=[dic2 valueForKey:@"rating_image"];
                               NSString *comment_review=[dic2 valueForKey:@"review"];
                               
                               NSString *commentSubmit_on=[dic2 valueForKey:@"submit_on"];
                               
                               
                               NSMutableDictionary *mutDic=[[NSMutableDictionary alloc]initWithCapacity:7];
                               
                               
                               [mutDic setObject:comment_id forKey:@"comment_id"];
                               [mutDic setObject:comment_image forKey:@"image"];
                               [mutDic setObject:comment_name forKey:@"name"];
                               [mutDic setObject:comment_get_userid forKey:@"get_userid"];
                               [mutDic setObject:comment_Getbdgimage forKey:@"get_badge"];
                               [mutDic setObject:comment_ratingimg forKey:@"rating_image"];
                               [mutDic setObject:comment_review forKey:@"review"];
                               [mutDic setObject:commentSubmit_on forKey:@"submit_on"];
                               [AllComment addObject:mutDic];
                               
                               
                           }
                           
                           
                       }
                       else
                       {
                           dispatch_async(dispatch_get_main_queue(), ^{
                               
                               self.noCommentFound.hidden=NO;
                           });
                       }
                       
                       
                       [self performSelectorOnMainThread:@selector(reloadAllCmtforuser) withObject:nil waitUntilDone:YES];
                       
                   });
    
}
-(void)reloadAllCmtforuser
{
    [ReportDetailsHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor   clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
    commentShowtable.hidden=NO;
    [commentShowtable reloadData];
}
-(IBAction)UiGreyImageButtonSelected:(UIButton *)sender
{
    TotalCommentbyme=0;
    
    int LastButtonTapped            = sender.tag;
    int ButtonShouldBehighLited     = LastButtonTapped - 9999;
    
    // reset all the button image in graystar
    
    for(int rst = 0; rst < 5 ; rst++)
    {
        
        UIButton *_infoButton = (UIButton *)[_UIViewForPostComment viewWithTag:(10000+rst)];
        [_infoButton setImage:[UIImage imageNamed:@"star1NEW"] forState:UIControlStateNormal];
         //modified
    }
    
    // set all the button image in yellowstar
    
    for(int s = 0; s < ButtonShouldBehighLited ; s++)
    {
        
        UIButton *_infoButton = (UIButton *)[_UIViewForPostComment viewWithTag:(10000+s)];
        [_infoButton setImage:[UIImage imageNamed:@"starNEW"] forState:UIControlStateNormal];
         //modified
    }
    
    TotalCommentbyme = ButtonShouldBehighLited;
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    
    
    switch (textView.tag)
    {
            
        case 100:
            if([ReportDetailsHelper CleanTextField:_UITextViewForPostComment.text].length == 0 || [[ReportDetailsHelper CleanTextField:_UITextViewForPostComment.text] isEqualToString:@"Add Comment Here"]) {
                _UITextViewForPostComment.text = @"";
                [UIView animateWithDuration:.25 animations:^{
                    
                }];
                _UITextViewForPostComment.textColor = [UIColor blackColor];
            }
            break;
        default:
            break;
            
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    
    switch (textView.tag) {
            
        case 100:
            if([ReportDetailsHelper CleanTextField:_UITextViewForPostComment.text].length == 0 || [[ReportDetailsHelper CleanTextField:_UITextViewForPostComment.text] isEqualToString:[ReportDetailsHelper CleanTextField:@"Add Comment Here"]]) {
                _UITextViewForPostComment.text = @"Add Comment Here";
                _UITextViewForPostComment.textColor = UIColorFromRGB(0xc5c5c5);
                
                [UIView animateWithDuration:.25 animations:^{
                    //                    MAinScrollview.contentOffset = CGPointMake(0, 0);
                    //                    [_UIViewForPostComment setFrame:CGRectMake(10, 100, 300, 300)];
                    //                    [MAinScrollview addSubview:_UIViewForPostComment];
                }];
            }
            break;
        default:
            break;
            
    }
    return YES;
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
        
    }
    return YES;
}

-(IBAction)SaveComment:(id)sender {
    
    [commentShowtable reloadData];
    ReportOperation=[[NSOperationQueue alloc]init];
    
    if([ReportDetailsHelper CleanTextField:_UITextViewForPostComment.text].length == 0 || [[ReportDetailsHelper CleanTextField:_UITextViewForPostComment.text] isEqualToString:@"Add Comment Here"]) {
//        
//        MBAlertView *Alert = [MBAlertView alertWithBody:@"Add Comment First !!" cancelTitle:nil cancelBlock:nil];
//        [Alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
//            [_UITextViewForPostComment becomeFirstResponder];
//        }];
//        [Alert addToDisplayQueue];
        
        
        UIAlertView *submitAlert = [[UIAlertView alloc] initWithTitle:@"Warning.!" message:@"Add Comment First" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [submitAlert setTag:9119];
        [submitAlert show];

        
    } else if (TotalCommentbyme == 0) {
        
//        MBAlertView *Alert = [MBAlertView alertWithBody:@"Please Rate Your Comment" cancelTitle:nil cancelBlock:nil];
//        [Alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
//        }];
//        [Alert addToDisplayQueue];
        
        
        UIAlertView *rateCommentAlert = [[UIAlertView alloc] initWithTitle:@"Warning.!" message:@"Please Rate Your Comment" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [rateCommentAlert setTag:9229];
        [rateCommentAlert show];
        
        
    }
    else
    {
        
        NSInteger restrictedLength=250;
        
       // NSString *textRestrictionChecking = _UITextViewForPostComment.text;
        
        if([[_UITextViewForPostComment text] length] > restrictedLength)
        
        {
        
            UIAlertView *textRestrictionCheckingAlert = [[UIAlertView alloc] initWithTitle:@"Warning.!" message:@"Your comment should be within 250 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [textRestrictionCheckingAlert setTag:13331];
            [textRestrictionCheckingAlert show];
        
        }
        
        
        else
        {
        
        rating=[NSString stringWithFormat:@"%d",TotalCommentbyme];
        theReviewtext=[_UITextViewForPostComment.text  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _UITextViewForPostComment.text=nil;
        NSLog(@"The user id:%@",userID);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            //            NSMutableDictionary *mutDic=[[NSMutableDictionary alloc]initWithCapacity:8];
            NSString *Strurl=[NSString stringWithFormat:@"%@save_reviewdata.php?review=%@&rating=%@&userid=%@&reportid=%@",DomainURL,theReviewtext,rating,userID,reportId];
            NSLog(@"The string url is:%@",Strurl);
            NSURL *urlForCooment=[NSURL URLWithString:Strurl];
            NSData *dataForcomment=[NSData dataWithContentsOfURL:urlForCooment];
            NSDictionary *mainDictionary=[NSJSONSerialization JSONObjectWithData:dataForcomment options:kNilOptions error:nil];
            NSDictionary *extraparam=[mainDictionary valueForKey:@"extraparam"];
            NSString *massage=[extraparam valueForKey:@"response"];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([massage isEqualToString:@"success"])
                {
                    self.noCommentFound.hidden=YES;
                    
                    
                    [self commentoperation];
                }
                
                
                
            });
        });
            
    }
        
        
  }
}
//Slide Content Slidercalue

- (void)segmentedControlChangedValue:(SegmentedControl *)segmentedControl {
    
    switch (segmentedControl.selectedSegmentIndex) {
        case 0: segmentedControl.selectionIndicatorColor = UIColorFromRGB(0xde2629);
            segmentedControl.selectedTextColor = UIColorFromRGB(0xde2629);
            break;
        case 1: segmentedControl.selectionIndicatorColor = UIColorFromRGB(0xfab81e);
            segmentedControl.selectedTextColor = UIColorFromRGB(0xfab81e);
            break;
        case 2: segmentedControl.selectionIndicatorColor = UIColorFromRGB(0x22b350);
            segmentedControl.selectedTextColor = UIColorFromRGB(0x22b350);
            break;
    }
    
    [segmentedControl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:14.0f]];
    
    if (segmentedControl.selectedSegmentIndex==0)
    {
        gotoUserDetailsFromNameorComment=NO;
        [MAinScrollview setScrollEnabled:YES];
       //  [MAinScrollview setContentOffset:CGPointMake(320, 470)];
        //MAinScrollview.frame=CGRectMake(0, 75, 320, 470);
        
        if (![ImageArray count]>0)
        {
             Basic_height = 0;  //for managing the scrolling when there is no image..
        }
        
        [_imageSliderview setHidden:NO];
        
        
        [ReportDetailsHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
        
        [self LoadDetailsAgain];
    }
    else if (segmentedControl.selectedSegmentIndex==1)
    {
        gotoUserDetailsFromNameorComment=NO;
        [MAinScrollview setScrollEnabled:NO];
        //[MAinScrollview setContentOffset:CGPointMake(320, 470)];
        [_imageSliderview setHidden:YES];
        MAinScrollview.frame=CGRectMake(0, 98, 320, 470);
        [self Loadmapview];
    }
    
    else
    {
        gotoUserDetailsFromNameorComment=YES;
        
        [MAinScrollview setScrollEnabled:YES];
        MAinScrollview.frame=CGRectMake(0, 98, 320, 470);
        [_imageSliderview setHidden:YES];
        [self commentoperation];
    }

    
}


/*
 - (IBAction)ShowContentOnebyone:(UISegmentedControl *)sender
 {
 NSLog(@"hereee");
 
 if (sender.selectedSegmentIndex==0)
 {
 [MAinScrollview setScrollEnabled:YES];
 // [MAinScrollview setContentOffset:CGPointMake(320, 470)];
 [_imageSliderview setHidden:NO];
 [self LoadDetailsAgain];
 }
 else if (sender.selectedSegmentIndex==1)
 {
 [MAinScrollview setScrollEnabled:YES];
 //[MAinScrollview setContentOffset:CGPointMake(320, 470)];
 [_imageSliderview setHidden:YES];
 MAinScrollview.frame=CGRectMake(0, 98, 320, 470);
 [self Loadmapview];
 }
 else if (sender.selectedSegmentIndex==2)
 {
 MAinScrollview.frame=CGRectMake(0, 98, 320, 470);
 [_imageSliderview setHidden:YES];
 [self commentoperation];
 }
 else
 {
 
 NSLog(@"No such data Present");
 }
 }
 */


-(void)tablereloadForremprtdetais
{
    NSLog(@"The uitableview:%@",commentShowtable);
    
    self.noCommentFound.hidden=YES;
    for(int s = 0; s < 5 ; s++)
    {
        
        UIButton *_infoButton = (UIButton *)[_UIViewForPostComment viewWithTag:(10000+s)];
        [_infoButton setImage:[UIImage imageNamed:@"star1NEW"] forState:UIControlStateNormal];
        //modified  star1NEW
    }
    
    [commentShowtable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSMutableDictionary *item;
    item = [[NSMutableDictionary alloc] initWithDictionary:[AllComment objectAtIndex:indexPath.row]];
    
    NSLog(@"AllComment ---- %@",AllComment);
    
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    UIView  *MainCellView = [[UIView alloc] init];
//    UIView  *MainCellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, cell.contentView.frame.size.height)];
    
    MainCellView.backgroundColor = [UIColor clearColor];
    
    
    UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 16, 65, 65)];
    
    ImageView.backgroundColor = [UIColor clearColor];
    
    [MainCellView addSubview:ImageView];
    
    
    ZSImageView *imageView = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
    
    imageView.defaultImage = [UIImage imageNamed:@"NEWNOIMAGE.png"];
    
    imageView.imageUrl = [item objectForKey:@"image"];
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    imageView.clipsToBounds = YES;
    
    imageView.corners = ZSRoundCornerAll;
    
    imageView.cornerRadius = 25;
    [ImageView addSubview:imageView];
    
    UIImageView *ImageOverlay = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
    [ImageOverlay setImage:[UIImage imageNamed:@"out-line.png"]];
    [ImageView addSubview:ImageOverlay];
    
    
    UIButton *buttonAboveImage = [[UIButton alloc] initWithFrame:CGRectMake(5, 11, 72, 72)];
    buttonAboveImage.backgroundColor = [UIColor clearColor];
    [buttonAboveImage addTarget:self action:@selector(goToDetailsPage) forControlEvents:UIControlEventTouchUpInside];
    [MainCellView addSubview:buttonAboveImage];

    
    UIImageView *brodgate_image=[[UIImageView alloc]initWithFrame:CGRectMake(258, 16, 14, 14)];
    brodgate_image.backgroundColor = [UIColor clearColor];
    [MainCellView addSubview:brodgate_image];
    
    ZSImageView *BrodGateView = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    
    BrodGateView.imageUrl = [item objectForKey:@"get_badge"];
    
    BrodGateView.contentMode = UIViewContentModeScaleAspectFill;
    
    BrodGateView.clipsToBounds = YES;
    
    [brodgate_image addSubview:BrodGateView];
    [MainCellView addSubview:brodgate_image];
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, 220, 25)];
    
    cell.textLabel.text=[item valueForKey:@"comment_id"];
    cell.textLabel.hidden=YES;
    cell.textLabel.textColor = [UIColor clearColor];
    
    TitleLabel.backgroundColor = [UIColor clearColor];
    
    TitleLabel.font = [UIFont fontWithName:GLOBALTEXTFONT_Title size:15];
    
//    TitleLabel.textColor = UIColorFromRGB(0x000000);
    TitleLabel.textColor = UIColorFromRGB(0x211e1f);
    TitleLabel.text = [ReportDetailsHelper stripTags:[item objectForKey:@"name"]];
    TitleLabel.textAlignment = NSTextAlignmentLeft;
    [MainCellView addSubview:TitleLabel];
    
    
    UIButton *buttonAboveTitleLabel = [[UIButton alloc] initWithFrame:CGRectMake(85, 5, 220, 33)];
    buttonAboveTitleLabel.backgroundColor = [UIColor clearColor];
    [buttonAboveTitleLabel addTarget:self action:@selector(goToDetailsPage) forControlEvents:UIControlEventTouchUpInside];
    [MainCellView addSubview:buttonAboveTitleLabel];
    
    
    UILabel *DateLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 35, 110, 25)];
    
    DateLabel.backgroundColor = [UIColor clearColor];
    
    DateLabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:14];
    
//    DateLabel.textColor = UIColorFromRGB(0x211e1f);
    
    DateLabel.textColor = UIColorFromRGB(0x575757);
    
    DateLabel.text = [ReportDetailsHelper stripTags:[item objectForKey:@"submit_on"]];
    
    
    DateLabel.textAlignment = NSTextAlignmentLeft;
    
    [MainCellView addSubview:DateLabel];
    
    UIImageView *reportimage=[[UIImageView alloc]initWithFrame:CGRectMake(90, 62, 110, 16)];
    [MainCellView addSubview:reportimage];
    ZSImageView *ReatingimageView = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 0,110, 16)];
    
    ReatingimageView.imageUrl = [item objectForKey:@"rating_image"];
    
    ReatingimageView.contentMode = UIViewContentModeScaleAspectFill;
    
    ReatingimageView.clipsToBounds = YES;
    
    ReatingimageView.cornerRadius = 0;
    [reportimage addSubview:ReatingimageView];
    [MainCellView addSubview:reportimage];
    
    
    UITextView *DetailsTextViewFortext=[[UITextView alloc]init];
    DetailsTextViewFortext.text=[item objectForKey:@"review"];
    
    NSAttributedString *attributed=[[NSAttributedString alloc]initWithString:[item objectForKey:@"review"]];
    [DetailsTextViewFortext setAttributedText:attributed];
    CGSize size = [DetailsTextViewFortext sizeThatFits:CGSizeMake(310, FLT_MAX)];
    
    DetailsTextViewFortext.frame = CGRectMake(90, 83, 225, size.height);
    [DetailsTextViewFortext setTextAlignment:NSTextAlignmentJustified];
    [DetailsTextViewFortext setFont:[UIFont fontWithName:GLOBALTEXTFONT size:12.0f]];
    //[DetailsTextViewFortext setTextColor:[UIColor darkGrayColor]];
    DetailsTextViewFortext.textColor = UIColorFromRGB(0x575757);
    DetailsTextViewFortext.editable=NO;
    DetailsTextViewFortext.scrollEnabled=NO;
    [DetailsTextViewFortext setBackgroundColor:[UIColor clearColor]];
    [DetailsTextViewFortext setEditable:NO];
    
    [MainCellView addSubview:DetailsTextViewFortext];
//    UIView *theCellSparetoe=[[UIView alloc]initWithFrame:CGRectMake(5, size.height+99, 320, 0.5f)];
    
    MainCellView.frame=CGRectMake(0, 0, 320, DetailsTextViewFortext.frame.origin.y+DetailsTextViewFortext.frame.size.height+3);
    
//    UIView *theCellSparetoe=[[UIView alloc]initWithFrame:CGRectMake(5, MainCellView.layer.frame.size.height, 320, 0.5f)];
    
    UIView *theCellSparetoe=[[UIView alloc]initWithFrame:CGRectMake(0,DetailsTextViewFortext.frame.origin.y+DetailsTextViewFortext.frame.size.height+2, 320, 0.5f)];
    [theCellSparetoe setBackgroundColor:[UIColor blackColor]];
    theCellSparetoe.layer.opacity = 0.5f;
    
    [MainCellView addSubview:theCellSparetoe];

    [cell.contentView addSubview:MainCellView];
    
    
    
    return cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *MainHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [MainHeaderView setBackgroundColor:[UIColor whiteColor]];
    UILabel *Titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 320, 35)];
    
    if (AllComment.count > 0)
    {
        Titlelabel.frame = CGRectMake(12, 10, 320, 35);
        Titlelabel.text = @"Comments";
        Titlelabel.font = [UIFont fontWithName:GLOBALTEXTFONT_Title size:15.0f];
        Titlelabel.textColor = UIColorFromRGB(0x211e1f);
        Titlelabel.textAlignment = NSTextAlignmentLeft;
    }
    else
    {
        
        Titlelabel.text = @"No Comments Yet";
        Titlelabel.font = [UIFont fontWithName:GLOBALTEXTFONT_Title size:15.0f];
        Titlelabel.textColor = UIColorFromRGB(0x211e1f);
        Titlelabel.textAlignment = NSTextAlignmentLeft;
    }
    
//    Titlelabel.text = @"Total Comments";
    [MainHeaderView addSubview:Titlelabel];
    
    UILabel *greenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 49, 320/3,1)];
    greenLabel.backgroundColor = UIColorFromRGB(0x1aad4b);
    [MainHeaderView addSubview:greenLabel];
    
    UILabel *yellowlabel = [[UILabel alloc] initWithFrame:CGRectMake(320/3, 49, 320/3,1)];
    yellowlabel.backgroundColor = UIColorFromRGB(0xfcb714);
    [MainHeaderView addSubview:yellowlabel];
    
    UILabel *redlabel = [[UILabel alloc] initWithFrame:CGRectMake(320/3*2, 49, 320/3+5,1)];
    redlabel.backgroundColor = UIColorFromRGB(0xde1d23);
    [MainHeaderView addSubview:redlabel];
    
    return MainHeaderView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    // NSMutableDictionary *item;
    
    item = [[NSMutableDictionary alloc] initWithDictionary:[AllComment objectAtIndex:indexPath.row]];
    
    UITextView *thetexttest=[[UITextView alloc]init];
    
    thetexttest.text=[item objectForKey:@"review"];
    //thetexttest.text=[item objectForKey:@"review"];
    
    NSAttributedString *attributed=[[NSAttributedString alloc]initWithString:[item objectForKey:@"review"]];
    [thetexttest setAttributedText:attributed];
    CGSize size = [thetexttest sizeThatFits:CGSizeMake(300, FLT_MAX)];
    thetexttest.hidden=YES;
    thetexttest=nil;
    
    
//    return size.height+100;
    return size.height+86;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [AllComment count];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}
- (IBAction)cancelcommentButton:(id)sender
{
    
    [UIView animateWithDuration:0.6f animations:^{
        
        _UIViewForPostComment.alpha=0;
        
    }
                     completion:^(BOOL finished)
     {
         _UIViewForPostComment.hidden=YES;
         //[_backgroundRatting removeFromSuperview];
//         [_UIViewForPostComment removeFromSuperview];
          //modified new
     }];
    
    
}

- (IBAction)AddcommentToview:(id)sender
{
    
    //    if ([theisreportpostbyme integerValue]==1)
    //    {
    //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"You Can,t Add comment on Your Own Report ?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //        [alert show];
    //        
    //    }
    //    
    //    else
    //    {
    
    NSLog(@"add comment btn pressed");
    _UITextViewForPostComment.text = nil;
    [_UITextViewForPostComment setText:@"Add Comment Here"];
    [_UITextViewForPostComment setTextColor:UIColorFromRGB(0xc5c5c5)];
    
    _UIViewForPostComment.alpha=0;
    _UIViewForPostComment.hidden=NO;
    
    [UIView animateWithDuration:0.6f animations:^{
        
        _UIViewForPostComment.alpha=1;
        
    }
                     completion:^(BOOL finished)
     {
         
         self.UIViewForPostComment.layer.shadowOffset = CGSizeMake(0, 10);
         self.UIViewForPostComment.layer.shadowRadius = 5;
         self.UIViewForPostComment.layer.shadowOpacity = 0.5;
         
     }];
    
    //  }
    
}


-(void)goToDetailsPage
{
    
//      AppDelegate *maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
//    DashboardViewController *Dashboard = [[DashboardViewController alloc] init];
//    [maindelegate SetUpTabbarControllerwithcenterView:Dashboard];
//    UserDetailesViewController *UserDetails = [[UserDetailesViewController alloc]init];
    
    UserDetailesViewController *UserDetails = [[UserDetailesViewController alloc]initWithNibName:@"UserDetailesViewController" bundle:nil];
    
    
    if (gotoUserDetailsFromNameorComment==YES)
    {
        
        UserDetails.userId = [item objectForKey:@"get_userid"];
    }
    else
    {
        UserDetails.userId = userIdForGoToDetailsPage;

    }
    
//    userIdForGoToDetailsPage = [item objectForKey:@"get_userid"];
//    UserDetails.userId = userIdForGoToDetailsPage;
    
    UserDetails.backBtnEnable = YES;
    [self.navigationController pushViewController:UserDetails animated:YES];
//    [maindelegate SetUpTabbarControllerwithcenterView:UserDetails];
}


@end