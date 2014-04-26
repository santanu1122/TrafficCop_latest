////
////  ReportBadDriverViewController.m
////  TrafficCop
////
////  Created by Santanu Das Adhikary on 19/11/13.
////  Copyright (c) 2013 Esolz. All rights reserved.
////
//
//#import "ReportBadDriverViewController.h"
//#import "HelperClass.h"
//#import "MFSideMenu.h"
//#import <QuartzCore/CoreAnimation.h>
//#import <AVFoundation/AVFoundation.h>
//#import "MBHUDView.h"
//#import "AppDelegate.h"
//#import "AddVehicleDescViewController.h"
//#import "ACEAutocompleteBar.h"
//#import "DashboardViewController.h"
//#import <CoreLocation/CoreLocation.h>
//#import "UserReportViewController.h"
//
//@interface ReportBadDriverViewController ()<ACEAutocompleteDataSource, ACEAutocompleteDelegate,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate, UIPickerViewAccessibilityDelegate> {
//    
//    //int upoloadFirst;
//    int currentTag;
//    int ResponseCounter;
//    int TotalUploadedImage;
//    NSMutableData* webdata;
//    NSURLConnection *connection;
//    HelperClass *ReportBadDriver;
//    NSArray *TableviewDataArray;
//    NSArray *TableviewImageArray;
//    NSMutableDictionary *ImageUploadedData;
//    
//    NSMutableDictionary *ImageUploadedDataAfterDeleteImage;
//    
//    NSMutableDictionary *ObjectCarrier;
//    UIView *PopUp;
//    NSString *isAddreport;
//    NSString *isLocationAdded;
//    BOOL Isreview;
//    NSOperationQueue *operation;
//    NSString *myAddress;
//    NSMutableArray *ImagemutArry;
//    
//    UIView *MakeBackgroundOverlayView;
//    
//    NSString *UserDesiredLocation;
//    
//    UITextView *AddLocationTextView;
//   
//    UIImageView *defauldPusSign;
//    
//    BOOL PreviewData;
//    
//    BOOL ImageDelete;
//    
//}
//@property (strong, nonatomic) IBOutlet UIView *reportBaddriverView;
//
//@property (strong, nonatomic) IBOutlet UIView *ImageShowview;
//
//@property (weak, nonatomic) IBOutlet UIScrollView *imageShowinScroll;
//
//
//@property (weak, nonatomic) IBOutlet UILabel *Titellbl;
//@property (weak, nonatomic) IBOutlet UILabel *descriptionlbl;
//
//-(IBAction)Scrolltoup:(id)sender;
//-(IBAction)Previewdata:(id)sender;
//
//@property (strong, nonatomic) IBOutlet UIView *PriviewShow;
//@property (strong, nonatomic) IBOutlet UIScrollView *PriviewScroll;
//
//
//@property (strong, nonatomic) IBOutlet UILabel *LocationAlert;
//@property (strong, nonatomic) IBOutlet UILabel *photoAlert;
//@property (strong, nonatomic) IBOutlet UILabel *AddDescriptionLbl;
//@property (strong, nonatomic) IBOutlet UILabel *TotalPoint;
//@property (strong, nonatomic) IBOutlet UILabel *LocationPoint;
//@property (strong, nonatomic) IBOutlet UILabel *uploadPhoto;
//
//@property (nonatomic,retain) IBOutlet UITableView *ReportDataTableview;
//@property (nonatomic,retain) IBOutlet UIView *Subview;
//@property (nonatomic,retain) IBOutlet UIView *ReportBadDriver;
//@property (nonatomic,retain) IBOutlet UIView *Titleview;
//@property (nonatomic,retain) IBOutlet UITextField *TitleTextview;
//
//
//@property (nonatomic,retain) IBOutlet UIScrollView *UIScrollViewMain;
//@property (nonatomic,retain) IBOutlet UIView *Descriptionview;
//@property (nonatomic,retain) IBOutlet UITextView *DescTextview;
//@property (nonatomic,retain) IBOutlet UIView *LicencePlateview;
//@property (nonatomic,retain) IBOutlet UITextField *LicencePlateTextview;
//@property (nonatomic,retain) IBOutlet UIView *Locationview;
//@property (nonatomic,retain) IBOutlet UIView *AddPicview;
//@property (nonatomic,retain) IBOutlet UIView *AddVEhicledescview;
//@property (nonatomic,retain) IBOutlet UIView *FooterView;
//@property (nonatomic,retain) IBOutlet UIButton *Savebutton;
//@property (nonatomic,retain) IBOutlet UIButton *Cancelbutton;
//
////@property (nonatomic,retain) IBOutlet UIView *ADDIMAGEVIEW;
//
//@property (nonatomic,retain) IBOutlet UIView *DYNAMICIMAGEVIEW;
//@property (nonatomic,retain) IBOutlet UIScrollView *ImageScrollView;
//
//#pragma mark -
//#pragma mark Method used for add vehicle description section
//@property (strong, nonatomic) IBOutlet UIView *ViewForreview;
//
//@property (nonatomic,retain) IBOutlet UIScrollView *AddVScrollView;
//@property (nonatomic,retain) IBOutlet UIView *Makeview;
//@property (nonatomic,retain) IBOutlet UIView *Modelview;
//@property (nonatomic,retain) IBOutlet UIView *Yearview;
//@property (nonatomic,retain) IBOutlet UIView *Uniquecharacteristicsview;
//@property (nonatomic,retain) IBOutlet UIView *Processview;
//@property (nonatomic,retain) IBOutlet UITextField *Maketextview;
//@property (nonatomic,retain) IBOutlet UITextField *Modeltextview;
//@property (nonatomic,retain) IBOutlet UITextField *Yeartextview;
//@property (nonatomic,retain) IBOutlet UITextField *Uniquecharacteristicstextview;
//@property (nonatomic,retain) IBOutlet UIView *AddVehicleDescView;
//
//@property (nonatomic, strong) NSMutableArray *MakeArray;
//@property (nonatomic, strong) NSMutableArray *ModelArray;
//@property (nonatomic, strong) NSMutableArray *YearArray;
//@property (nonatomic, strong) NSMutableArray *UniqueArray;
//@property (nonatomic, retain) NSString *Lattitude;
//@property (nonatomic, retain) NSString *Longitude;
//@property (nonatomic, retain) NSString *LocationData;
//
//-(IBAction)CancelButtonClicked:(id)sender;
//-(IBAction)DoneButtonClicked:(id)sender;
////-(IBAction)ADDIMAGECancelButtonClicked:(id)sender;
////-(IBAction)ADDIMAGEDoneButtonClicked:(id)sender;
//-(IBAction)FinalSave:(id)sender;
//-(IBAction)FinalCancel:(id)sender;
//
//@property (strong, nonatomic) IBOutlet UILabel *Titelreview;
//@property (strong, nonatomic) IBOutlet UILabel *licenceplatereview;
//@property (strong, nonatomic) IBOutlet UILabel *descriptionreview;
//@property (strong, nonatomic) IBOutlet UILabel *locationReview;
//
//@property (strong, nonatomic) IBOutlet UILabel *PhotoSectionReview;
//
//@property (strong, nonatomic) IBOutlet UILabel *YearSectionReview;
//@property (weak, nonatomic) IBOutlet UITextField *locationShow;
//
//@property (strong, nonatomic) IBOutlet UILabel *makeSection;
//
//@property (strong, nonatomic) IBOutlet UILabel *modelSectionreview;
//
//@property (nonatomic,assign) BOOL isReportTitleComplete;
//@property (nonatomic,assign) BOOL isReportDescComplete;
//@property (nonatomic,assign) BOOL isLicencePlateComplete;
//@property (nonatomic,assign) BOOL isVehiclelocComplete;
//@property (nonatomic,assign) BOOL isVehicleImageComplete;
//@property (nonatomic,assign) BOOL isVehicleDescComplete;
//@property (nonatomic,assign) int ReportId;
//
//@property (nonatomic,retain) CLLocationManager *MyLocation;
//
//// Add user desired location view's property
//
//@property (nonatomic,retain) IBOutlet UIView *UserDesiredlocationView;
//
//@property (nonatomic,strong) UIImageView *ImageVIew;
//@property (nonatomic,strong) UIButton *DeleteButton;
//
//
//-(IBAction)SaveUserDesireLoaction:(id)sender;
//-(IBAction)CaneclUserDesireLoactionView:(id)sender;
//
//@end
//
//
//@implementation ReportBadDriverViewController
//
//int FirstPosition = 0;
//BOOL AccessMyLocation = NO;
//BOOL AccessCustomLocation = NO;
//
//@synthesize ReportDataTableview     = _ReportDataTableview;
//@synthesize Subview                 = _Subview;
//@synthesize Titleview               = _Titleview;
//@synthesize TitleTextview           = _TitleTextview;
//@synthesize UIScrollViewMain        = _UIScrollViewMain;
//@synthesize Descriptionview         = _Descriptionview;
//@synthesize DescTextview            = _DescTextview;
//@synthesize LicencePlateview        = _LicencePlateview;
//@synthesize LicencePlateTextview    = _LicencePlateTextview;
//@synthesize Locationview            = _Locationview;
//@synthesize AddPicview              = _AddPicview;
//@synthesize AddVEhicledescview      = _AddVEhicledescview;
//@synthesize FooterView              = _FooterView;
//@synthesize Savebutton              = _Savebutton;
//@synthesize Cancelbutton            = _Cancelbutton;
////@synthesize ADDIMAGEVIEW            = _ADDIMAGEVIEW;
//@synthesize DYNAMICIMAGEVIEW        = _DYNAMICIMAGEVIEW;
//@synthesize ImageScrollView         = _ImageScrollView;
//@synthesize AVMake                  = _AVMake;
//@synthesize AVModel                 = _AVModel;
//@synthesize AVYear                  = _AVYear;
//@synthesize AVUnch                  = _AVUnch;
//@synthesize AddVScrollView          = _AddVScrollView;
//@synthesize Makeview                =  _Makeview;
//@synthesize Modelview               = _Modelview;
//@synthesize Yearview                = _Yearview;
//@synthesize Uniquecharacteristicsview = _Uniquecharacteristicsview;
//@synthesize Processview             = _Processview;
//@synthesize Maketextview            = _Maketextview;
//@synthesize Modeltextview           = _Modeltextview;
//@synthesize Yeartextview            = _Yeartextview;
//@synthesize Uniquecharacteristicstextview = _Uniquecharacteristicstextview;
//@synthesize MakeArray               = _MakeArray;
//@synthesize ModelArray              = _ModelArray;
//@synthesize YearArray               = _YearArray;
//@synthesize UniqueArray             = _UniqueArray;
//@synthesize AddVehicleDescView      = _AddVehicleDescView;
//@synthesize isVehicleDescComplete   = _isVehicleDescComplete;
//@synthesize isLicencePlateComplete  = _isLicencePlateComplete;
//@synthesize isReportDescComplete    = _isReportDescComplete;
//@synthesize isReportTitleComplete   = _isReportTitleComplete;
//@synthesize isVehicleImageComplete  = _isVehicleImageComplete;
//@synthesize isVehiclelocComplete    = _isVehiclelocComplete;
//@synthesize MyLocation              = _MyLocation;
//@synthesize ReportId                = _ReportId;
//@synthesize Lattitude               = _Lattitude;
//@synthesize Longitude               = _Longitude;
//@synthesize LocationData            = _LocationData;
//@synthesize ReportBadDriver         = _ReportBadDriver;
//@synthesize UserDesiredlocationView = _UserDesiredlocationView;
//@synthesize locationShow            = _locationShow;
//@synthesize ImageVIew               = ImageVIew;
//@synthesize DeleteButton            = DeleteButton;
//
//
//int upoloadFirst = 223;
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//-(void)viewDidAppear:(BOOL)animated
//{
//    
////    _ImageShowview.frame=CGRectMake(0, 511, 320, 100);
////    [self Makeframe:_ImageShowview];
////    
////    [_UIScrollViewMain addSubview:_ImageShowview];
////    NSLog(@"image uploadarry in viewdid appear :%d",[ImagemutArry count]);
////    for (int i=1; i<=TotalUploadedImage; i++)
////    {
////        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10+(90*(i-1))+(10*(i-1)), 5, 90, 90)];
////        [imageView setImage:[UIImage imageWithData:[ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",i]]]];
////        [_imageShowinScroll addSubview:imageView];
////        NSLog(@"chk in viewwwwwwwwdiddloaddd////");
////    }
////    [_imageShowinScroll setContentSize:CGSizeMake(TotalUploadedImage*110, 100)];
//
//    
//}
//
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    
////    _ImageShowview.frame=CGRectMake(0, 511, 320, 100);
////    [self Makeframe:_ImageShowview];
////    
////    [_UIScrollViewMain addSubview:_ImageShowview];
////    NSLog(@"image uploadarry in viewdid appear :%d",[ImagemutArry count]);
////    for (int i=1; i<=TotalUploadedImage; i++)
////    {
////        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10+(90*(i-1))+(10*(i-1)), 5, 90, 90)];
////        [imageView setImage:[UIImage imageWithData:[ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",i]]]];
////        [_imageShowinScroll addSubview:imageView];
////        NSLog(@"chk in viewwwwwwwwdiddloaddd////");
////    }
////    [_imageShowinScroll setContentSize:CGSizeMake(TotalUploadedImage*110, 100)];
//
//}
//
//
//-(void)getLocationByLatLong
//{
//    @try
//    {
//            NSString *URLString=[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=false", _Lattitude, _Longitude];
//            NSLog(@"the string url for the event:%@",URLString);
//            NSData *getData=[NSData dataWithContentsOfURL:[NSURL URLWithString:URLString]];
//            
//            NSDictionary *Output=[NSJSONSerialization JSONObjectWithData:getData options:kNilOptions error:nil];
//        
//            NSArray *Result=[Output objectForKey:@"results"];
//            NSDictionary *Dic1=[Result objectAtIndex:0];
//            NSArray *address_components=[Dic1 objectForKey:@"address_components"];
//            myAddress=[Dic1 valueForKey:@"formatted_address"];
//            //myAddress   = @"Albertina Sisulu Road, Johannesburg 2000, South Africa";
//             NSLog(@"my address:%@",myAddress);
//            NSMutableArray *AddressArray=[[NSMutableArray alloc] initWithCapacity:3];
//            
//            for(NSDictionary *Dic2 in address_components)
//            {
//                NSArray *TypesArray=[Dic2 objectForKey:@"types"];
//                if([(NSString *)[TypesArray objectAtIndex:0] isEqualToString:@"locality"] || [(NSString *)[TypesArray objectAtIndex:0] isEqualToString:@"administrative_area_level_1"])
//                {
//                    [AddressArray addObject:[Dic2 objectForKey:@"long_name"]];
//                }
//                
//            }
//            NSString *NewAddress=[AddressArray componentsJoinedByString:@", "];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                NSUserDefaults *User=[[NSUserDefaults alloc] init];
//                [User setValue:NewAddress forKey:@"location"];
//                NSLog(@"the new address is:%@",NewAddress);
//                [User synchronize];
//                
//            });
//        
////        else
////        {
////            NSInvocationOperation *Invoc=[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(getLocationByLatLong) object:nil];
////            [operation addOperation:Invoc];
////        }
//    }
//    @catch (NSException *juju)
//    {
//        NSLog(@"Reporting juju from getLocationByLatLong: %@", juju);
//    }
//}
//
//-(CLLocationCoordinate2D) getLocation{
//    
//    _MyLocation = [[CLLocationManager alloc] init];
//    _MyLocation.delegate = (id)self;
//    _MyLocation.desiredAccuracy = kCLLocationAccuracyBest;
//    _MyLocation.distanceFilter = kCLDistanceFilterNone;
//    [_MyLocation startUpdatingLocation];
//    CLLocation *location = [_MyLocation location];
//    CLLocationCoordinate2D coordinate = [location coordinate];
//    return coordinate;
//    
//}
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    // defining uiscrollview property
//    
////    Helpobj = [HelperClass SaveVehicleDescDataForReport];
//    
//    
//    
//    FirstPosition = 0;
//    upoloadFirst = 223;
//    
//    _locationShow.enabled = NO;
//    
//    _PriviewShow.frame = CGRectMake(0, 58, _PriviewShow.layer.frame.size.width, _PriviewShow.layer.frame.size.height);
//    
//    _ReportId = 0;
//    Isreview=TRUE;
//    PreviewData = FALSE;
//    UserDesiredLocation = @"";
//    
//    MakeBackgroundOverlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    
//    ImagemutArry=[[NSMutableArray alloc]init];
//    operation=[[NSOperationQueue alloc]init];
//    ReportBadDriver = [[HelperClass alloc] init];
//    [self HideNavigationBar];
//    [ReportBadDriver SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
//    [ReportBadDriver SetupHeaderViewForReport:self.view viewController:self];
//    
//    _ReportDataTableview.delegate = (id)self;
//    _ReportDataTableview.dataSource = (id)self;
//    
//    TableviewDataArray = [[NSArray alloc] initWithObjects:@"Add Title",@"Add Description",@"Add License plate",@"Add Location",@"Add Picture",@"Add Vehicle Description", nil];
//    
//    TableviewImageArray = [[NSArray alloc] initWithObjects:@"public.png",@"car.png",@"sgn.png",@"comm.png",@"cam.png",@"car.png", nil];
//    
//    _isVehicleDescComplete = NO;
//    _isLicencePlateComplete = NO;
//    _isReportDescComplete = NO;
//    _isReportTitleComplete = NO;
//    _isVehicleImageComplete = NO;
//    _isVehiclelocComplete = NO;
//    self.photoAlert.hidden=YES;
//    self.LocationAlert.hidden=YES;
//    CLLocationCoordinate2D coordinate = [self getLocation];
//    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
//    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
//    _Lattitude = latitude;
//    _Longitude = longitude;
//    
//    NSInvocationOperation *operationLocation=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(getLocationByLatLong) object:nil];
//    [operation addOperation:operationLocation];
//    
//    NSLog(@"*dLatitude : %@", latitude);
//    NSLog(@"*dLongitude : %@",longitude);
//    
//    [self fetchdata];
//    
//    TotalUploadedImage = 0;
//    
//    ImageUploadedData = [[NSMutableDictionary alloc] init];
//    
//    [_UIScrollViewMain setDelegate:(id)self];
//    [_UIScrollViewMain setScrollEnabled:YES];
//    _UIScrollViewMain.userInteractionEnabled = YES;
//    _UIScrollViewMain.showsVerticalScrollIndicator = YES;
//    _UIScrollViewMain.scrollEnabled = YES;
//    _UIScrollViewMain.backgroundColor = [UIColor clearColor];
//    [_UIScrollViewMain setContentSize:CGSizeMake(self.view.frame.size.width,self.view.frame.size.height+340)];
//    
//    
//    // Initialize reportbaddriver view
//    
//    _reportBaddriverView.frame = CGRectMake(0, 37, 320, 50);
//    [self Makeframe:_reportBaddriverView];
//    [_UIScrollViewMain addSubview:_reportBaddriverView];
//    
//    // Add report titleview in mainview
//    
//    _Titleview.frame = CGRectMake(0, 86, 320, 75);   //check
//    [self Makeframe:_Titleview];
//    _TitleTextview.returnKeyType = UIReturnKeyDone;
//    _TitleTextview.delegate = (id)self;
//    _TitleTextview.tag = 100;
//    self.ViewForreview.layer.cornerRadius=4.0f;
//    [_UIScrollViewMain addSubview:_Titleview];
//    
//    
//     // Add report description view in mainview
//    
//    _Descriptionview.frame = CGRectMake(0, 162, 320, 138); //check
//    [self Makeframe:_Descriptionview];
//    _DescTextview.returnKeyType = UIReturnKeyDone;
//    _DescTextview.delegate = (id)self;
//    _DescTextview.tag = 101;
//    _DescTextview.textColor = UIColorFromRGB(0xc5c5c5);
//    [_UIScrollViewMain addSubview:_Descriptionview];
//    
//     // Add report LicencePlateview in mainview
//    
//    _LicencePlateview.frame = CGRectMake(0, 300, 320, 77);
//    [self Makeframe:_LicencePlateview];
//    _LicencePlateTextview.returnKeyType = UIReturnKeyDone;
//    _LicencePlateTextview.delegate = (id)self;
//    _LicencePlateTextview.tag = 102;
//    [_UIScrollViewMain addSubview:_LicencePlateview];
//    
//    // Add report Locationview in mainview
//    
//    _Locationview.frame = CGRectMake(0, 378, 320, 81);
//    UITapGestureRecognizer *LocationViewPinch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LocationTap:)];
//    [_Locationview addGestureRecognizer:LocationViewPinch];
//    [self Makeframe:_Locationview];
//    [_UIScrollViewMain addSubview:_Locationview];
//    
//     // Add report AddPicview in mainview
//    
//    _AddPicview.frame = CGRectMake(0, 460, 320, 50);
//    UITapGestureRecognizer *PicViewPinch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PicTap:)];
//    [_AddPicview addGestureRecognizer:PicViewPinch];
//    [self Makeframe:_AddPicview];
//    [_UIScrollViewMain addSubview:_AddPicview];
//    
//    
//    _ImageShowview.frame=CGRectMake(0, 511, 320, 88);
//    [self Makeframe:_ImageShowview];
//    [_UIScrollViewMain addSubview:_ImageShowview];
//    _ImageShowview.hidden=YES;
//    
//    // Add report AddVEhicledescview in mainview
//    
//    //----------------------
//    
// /*   _ImageShowview.frame=CGRectMake(0, 511, 320, 100);
//    [self Makeframe:_ImageShowview];
//    
//    [_UIScrollViewMain addSubview:_ImageShowview];
//    NSLog(@"image uploadarry:%d",[ImagemutArry count]);
//    for (int i=1; i<=TotalUploadedImage; i++)
//    {
//        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10+(90*(i-1))+(10*(i-1)), 5, 90, 90)];
//        [imageView setImage:[UIImage imageWithData:[ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",i]]]];
//        [_imageShowinScroll addSubview:imageView];
//        NSLog(@"chk in viewwwwwwwwdiddloaddd////");
//    }
//    [_imageShowinScroll setContentSize:CGSizeMake(TotalUploadedImage*110, 100)];
//    */
//    
//    
//    
//    _AddVEhicledescview.frame = CGRectMake(0, 511, 320, 50);
//    UITapGestureRecognizer *VehicleDEtailsViewPinch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(VdetailsTap:)];
//    [_AddVEhicledescview addGestureRecognizer:VehicleDEtailsViewPinch];
//    [self Makeframe:_AddVEhicledescview];
//    [_UIScrollViewMain addSubview:_AddVEhicledescview];
//    
//    
///*    _AddVEhicledescview.frame = CGRectMake(0, 600, 320, 50);
//    UITapGestureRecognizer *VehicleDEtailsViewPinch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(VdetailsTap:)];
//    [_AddVEhicledescview addGestureRecognizer:VehicleDEtailsViewPinch];
//    [self Makeframe:_AddVEhicledescview];
//    [_UIScrollViewMain addSubview:_AddVEhicledescview];
//*/
//    
//    currentTag = 0;
//    
//    [ReportBadDriver AddBlackOverlay:self.view xcord:0 ycord:0 width:self.view.frame.size.width height:self.view.frame.size.height backgroundColor:[UIColor blackColor] OpacitY:0.9f Text:@"Please wait" TextColor:[UIColor whiteColor] FontName:globalTEXTFIELDPLACEHOLDERFONT FontSize:18 IsTextEnabled:YES];
//    
//    [_AddVScrollView setDelegate:(id)self];
//    [_AddVScrollView setScrollEnabled:YES];
//    _AddVScrollView.userInteractionEnabled = YES;
//    _AddVScrollView.showsVerticalScrollIndicator = YES;
//    _AddVScrollView.scrollEnabled = YES;
//    _AddVScrollView.backgroundColor = [UIColor clearColor];
//    [_AddVScrollView setContentSize:CGSizeMake(self.view.frame.size.width,self.view.frame.size.height+250)];
//    
//    //_ADDIMAGEVIEW.frame = CGRectMake(0, 150, 320, 300);
//    
//    //_ADDIMAGEVIEW.frame = CGRectMake(0, 55, 320, 520);
//    
//   // [self Makeframe:_ADDIMAGEVIEW];
//  //  _ADDIMAGEVIEW.hidden = YES;
//    //[_UIScrollViewMain addSubview:_ADDIMAGEVIEW];
//  //  [self.view addSubview:_ADDIMAGEVIEW];
//    
//}
//-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    [webdata setLength:0];
//}
//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    [webdata appendData:data];
//}
//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//{
//    NSLog(@"NSURLConnection Error");
//}
//-(void)fetchdata
//{
//    NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
//    [tempDict setObject:AUTOSUGGESSATIONMODE forKey:@"mode"];
//    
//    NSString *REturnedURL = [ReportBadDriver CallURLForServerReturn:tempDict URL:LOGINPAGE];
//    NSLog(@"th value of url is:%@",REturnedURL);
//    NSURL *url = [NSURL URLWithString:REturnedURL];
//    NSURLRequest *restrict1 = [NSURLRequest requestWithURL:url];
//    connection = [NSURLConnection connectionWithRequest:restrict1 delegate:self];
//    if(connection)
//    {
//        webdata = [[NSMutableData alloc]init];
//    }
//}
//-(void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//    _MakeArray = [[NSMutableArray alloc] init];
//    _ModelArray = [[NSMutableArray alloc] init];
//    _YearArray = [[NSMutableArray alloc] init];
//    _UniqueArray = [[NSMutableArray alloc] init];
//    
//    NSDictionary *allData = [NSJSONSerialization JSONObjectWithData:webdata options:0 error:nil];
//    
//    for(NSString *MakeData in [allData objectForKey:@"makelist"]) {
//        [_MakeArray addObject:MakeData];
//    }
//    for(NSString *MakeData1 in [allData objectForKey:@"modellist"]) {
//        [_ModelArray addObject:MakeData1];
//    }
//    for(NSString *MakeData2 in [allData objectForKey:@"yearlist"]) {
//        [_YearArray addObject:MakeData2];
//    }
//    for(NSString *MakeData3 in [allData objectForKey:@"characteristicslist"]) {
//        [_UniqueArray addObject:MakeData3];
//    }
//    
//    [_Maketextview setAutocompleteWithDataSource:self
//                                        delegate:self
//                                       customize:^(ACEAutocompleteInputView *inputView) {
//                                           inputView.font = [UIFont systemFontOfSize:20];
//                                           inputView.textColor = [UIColor whiteColor];
//                                           inputView.backgroundColor = [UIColor clearColor];
//                                       }];
//    
//    [_Modeltextview setAutocompleteWithDataSource:self
//                                         delegate:self
//                                        customize:^(ACEAutocompleteInputView *inputView) {
//                                            inputView.font = [UIFont systemFontOfSize:20];
//                                            inputView.textColor = [UIColor whiteColor];
//                                            inputView.backgroundColor = [UIColor clearColor];
//                                        }];
//    
//    [_Yeartextview setAutocompleteWithDataSource:self
//                                        delegate:self
//                                       customize:^(ACEAutocompleteInputView *inputView) {
//                                           inputView.font = [UIFont systemFontOfSize:20];
//                                           inputView.textColor = [UIColor whiteColor];
//                                           inputView.backgroundColor = [UIColor clearColor];
//                                       }];
//    
//    [_Uniquecharacteristicstextview setAutocompleteWithDataSource:self
//                                                         delegate:self
//                                                        customize:^(ACEAutocompleteInputView *inputView) {
//                                                            inputView.font = [UIFont systemFontOfSize:20];
//                                                            inputView.textColor = [UIColor whiteColor];
//                                                            inputView.backgroundColor = [UIColor clearColor];
//                                                        }];
//    
//    _Maketextview.tag = 999;
//    _Modeltextview.tag = 998;
//    _Yeartextview.tag = 997;
//    _Uniquecharacteristicstextview.tag = 996;
//    currentTag = 999;
//    
//    _Makeview.frame = CGRectMake(0, 60, 320, 70);
//    [self Makeframe:_Makeview];
//    [_AddVScrollView addSubview:_Makeview];
//    
//    _Modelview.frame = CGRectMake(0, 131, 320, 70);
//    [self Makeframe:_Modelview];
//    [_AddVScrollView addSubview:_Modelview];
//    
//    _Yearview.frame = CGRectMake(0, 202, 320, 70);
//    [self Makeframe:_Yearview];
//    [_AddVScrollView addSubview:_Yearview];
//    
//    _Uniquecharacteristicsview.frame = CGRectMake(0, 273, 320, 78);
//    [self Makeframe:_Uniquecharacteristicsview];
//    [_AddVScrollView addSubview:_Uniquecharacteristicsview];
//    
//    _Processview.frame = CGRectMake(0, 392, 320, 50);
//    _Processview.backgroundColor = [UIColor clearColor];
//    [_AddVScrollView addSubview:_Processview];
//    //[_AddVScrollView setScrollEnabled:NO];
//    
//    _AddVScrollView.contentSize = CGSizeMake(320, 720);
//    
//    _AddVehicleDescView.hidden = YES;
//    [self.view addSubview:_AddVehicleDescView];
//    
//    [ReportBadDriver HidePopupView];
//    
//    //if (VehDetlObject.VehicleMake == (id)[NSNull null] || VehDetlObject.VehicleMake.length == 0 ) {
//        _Maketextview.placeholder = @"Vehicle Make";
////        [_Maketextview becomeFirstResponder];
////    } else {
////        [_Maketextview setText:VehDetlObject.VehicleMake];
////    }
//    
////    if (VehDetlObject.VehicleModel == (id)[NSNull null] || VehDetlObject.VehicleModel.length == 0 )
//        _Modeltextview.placeholder = @"Vehicle Model";
////    else
////        [_Modeltextview setText:VehDetlObject.VehicleModel];
//    
//    //if (VehDetlObject.VihicleYear == (id)[NSNull null] || VehDetlObject.VihicleYear.length == 0 )
//        _Yeartextview.placeholder = @"Vehicle Year";
////    else
////        [_Yeartextview setText:VehDetlObject.VihicleYear];
//    
////    if (VehDetlObject.VehicleUnique == (id)[NSNull null] || VehDetlObject.VehicleUnique.length == 0 )
//        _Uniquecharacteristicstextview.placeholder = @"Unique Characteristics";
////    else
////        [_Uniquecharacteristicstextview setText:VehDetlObject.VehicleUnique];
//    
//}
//- (void)textField:(UITextField *)textField didSelectObject:(id)object inInputView:(ACEAutocompleteInputView *)inputView
//{
//    textField.text = object;
//}
//-(void)Makeframe :(UIView *)SubViewAdd {
//    
//    float cellHeight = SubViewAdd.frame.size.height;
//    UILabel *greenLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, cellHeight-1, 95,1)];
//    greenLabel.backgroundColor = UIColorFromRGB(0x1aad4b);
//    [SubViewAdd addSubview:greenLabel];
//    
//    UILabel *yellowlabel = [[UILabel alloc] initWithFrame:CGRectMake(140, cellHeight-1, 90,1)];
//    yellowlabel.backgroundColor = UIColorFromRGB(0xfcb714);
//    [SubViewAdd addSubview:yellowlabel];
//    
//    UILabel *redlabel = [[UILabel alloc] initWithFrame:CGRectMake(210, cellHeight-1, 115,1)];
//    redlabel.backgroundColor = UIColorFromRGB(0xde1d23);
//    [SubViewAdd addSubview:redlabel];
//    
//}
//-(IBAction)SaveUserDesireLoaction:(id)sender {
//    
//    // user desire location added for the service
//    
//    [_UserDesiredlocationView removeFromSuperview];
//    [MakeBackgroundOverlayView removeFromSuperview];
//    
//    UserDesiredLocation = [ReportBadDriver CleanTextField:AddLocationTextView.text];
//    
//    AccessCustomLocation = YES;
//    
//    NSLog(@"UserDesiredLocation ---- %@",UserDesiredLocation);
//    _locationShow.text=nil;
//    _locationShow.text=UserDesiredLocation;
//    
//}
//-(IBAction)CaneclUserDesireLoactionView:(id)sender {
//    
//    [_UserDesiredlocationView removeFromSuperview];
//    [MakeBackgroundOverlayView removeFromSuperview];
//}
//-(void)LocationTap:(UIGestureRecognizer *)Gesture {
//    
//    UIAlertView *AddLocationAlertView = [[UIAlertView alloc] initWithTitle:@"Add Location" message:@"" delegate:self cancelButtonTitle:@"Device Location" otherButtonTitles:@"Enter Location", nil];
//    [AddLocationAlertView setTag:9990];
//    [AddLocationAlertView show];
//    
//}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    
//    if (alertView.tag == 9990) {
//        
//        if (buttonIndex == 0) {
//            
//            // check location is enable for this app or not for this app
//            
//            if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
//                
//                // location service is enabled for this app
//                
//                NSLog(@"Location Tap");
//                CLLocationCoordinate2D coordinate = [self getLocation];
//                NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
//                NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
//                _Lattitude = latitude;
//                _Longitude = longitude;
//                NSLog(@"*dLatitude : %@", latitude);
//                NSLog(@"*dLongitude : %@",longitude);
//                
//                AccessMyLocation = YES;
//                
//                UIAlertView *LocationAlertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Your current location is %@",myAddress] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//                [LocationAlertView show];
//                
//                _locationShow.text = myAddress;     //check
//                
//            } else {
//                
//                // location service is not enabled for this app
//                
//                NSLog(@"Location is not enabled for this app, please go to device settings and enable location for this app");
//                
//                UIAlertView *LocationAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"Location is not enabled for this app, please go to device settings and enable location for this app" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//                [LocationAlertView show];
//
//            }
//            
//        } else if (buttonIndex == 1) {
//            
//            // Give user access to upload his desired location
//            
//            [self.view addSubview:MakeBackgroundOverlayView];
//            [MakeBackgroundOverlayView setBackgroundColor:[UIColor clearColor]];
//            
//            UIView *OverlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.layer.frame.size.width, self.view.frame.size.height)];
//            [OverlayView.layer setOpacity:0.5f];
//            [OverlayView setBackgroundColor:[UIColor blackColor]];
//            [MakeBackgroundOverlayView addSubview:OverlayView];
//            
//            AddLocationTextView = (UITextView *)[_UserDesiredlocationView viewWithTag:9962];
//            AddLocationTextView.text = nil;    //check
//            [AddLocationTextView setBackgroundColor:[UIColor clearColor]];
//            [AddLocationTextView setDelegate:self];
//            [AddLocationTextView setUserInteractionEnabled:YES];
//            [AddLocationTextView.layer setBorderColor:[UIColor darkGrayColor].CGColor];
//            [AddLocationTextView.layer setBorderWidth:1.0f];
//            [AddLocationTextView.layer setCornerRadius:4.0f];
//            
//            [_UserDesiredlocationView setFrame:CGRectMake(10, 100, _UserDesiredlocationView.frame.size.width, _UserDesiredlocationView.frame.size.height)];
//            [MakeBackgroundOverlayView addSubview:_UserDesiredlocationView];
//            [MakeBackgroundOverlayView bringSubviewToFront:_UserDesiredlocationView];
//            
//        }
//    }
//    
//}
//
//-(void)uploadPhotoFirst
//{
//    _ImageShowview.frame=CGRectMake(0, 511, 320, 100);
//    [self Makeframe:_ImageShowview];
//    
//    [_UIScrollViewMain addSubview:_ImageShowview];
//    NSLog(@"image uploadarry in viewdid appear :%d",[ImagemutArry count]);
//    for (int i=1; i<=TotalUploadedImage; i++)
//    {
//        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10+(90*(i-1))+(10*(i-1)), 5, 90, 90)];
//        [imageView setImage:[UIImage imageWithData:[ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",i]]]];
//        [_imageShowinScroll addSubview:imageView];
//        NSLog(@"chk in viewwwwwwwwdiddloaddd////");
//    }
//    [_imageShowinScroll setContentSize:CGSizeMake(TotalUploadedImage*110, 100)];
//
//    
//}
//
////-(void)PicTap:(UIGestureRecognizer *)Gesture {
//
//-(void)PicTap:(UIGestureRecognizer *)Gesture
//{
//    [self textFieldDidBeginEditingone:0];
//    //_ADDIMAGEVIEW.hidden = NO;
//    
//    // upoloadFirst = 223;
//  //  FirstPosition = 0;
//    
//    
//    
//    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"Chosse Your Option" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Snap", @"Choose  From Library", nil];
//    
//    [sheet showInView:self.view];
//    
//}
//
//
//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
//    picker.delegate = (id) self;
//    picker.allowsEditing = YES;
//    
//    if (buttonIndex==0)
//    {
//        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//        {
//            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                                  message:@"Device has no camera"
//                                                                 delegate:nil
//                                                        cancelButtonTitle:@"OK"
//                                                        otherButtonTitles: nil];
//            
//            [myAlertView show];
//        }
//        
//        else
//        {
//            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//            [self.navigationController presentViewController:picker animated:YES completion:NULL];
//        }
//    }
//    
//    if (buttonIndex==1)
//    {
//        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        [self.navigationController presentViewController:picker animated:YES completion:NULL];
//    }
//    
//}
//
//
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    
//    [[picker presentingViewController] dismissViewControllerAnimated:YES completion:^{
//        UIImage *image = info[UIImagePickerControllerEditedImage];
//        
////        UIImageView *ImageviewMain = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
////        [ImageviewMain setImage:image];
////        [_ImageScrollView addSubview:ImageviewMain];
//        
//        
//        [self.imageShowinScroll setNeedsDisplay];
//        
//        UIGraphicsBeginImageContext(image.size);
//        
//        CGContextRef context=(UIGraphicsGetCurrentContext());
//        
//        if (image.imageOrientation == UIImageOrientationRight) {
//            CGContextRotateCTM (context, 90/180*M_PI) ;
//        } else if (image.imageOrientation == UIImageOrientationLeft) {
//            CGContextRotateCTM (context, -90/180*M_PI);
//        } else if (image.imageOrientation == UIImageOrientationDown) {
//            // NOTHING
//        } else if (image.imageOrientation == UIImageOrientationUp) {
//            CGContextRotateCTM (context, 90/180*M_PI);
//        }
//        
//        [image drawAtPoint:CGPointMake(0, 0)];
//        UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        TotalUploadedImage +=1;
//        
////        UIImageView *ImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(FirstPosition, 0, 100, 100)];
//        
//        ImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(FirstPosition, 10, 65, 65)];
//        
//        ImageVIew.backgroundColor = [UIColor clearColor];
//        ImageVIew.image = img;
//        ImageVIew.userInteractionEnabled = YES;
////        FirstPosition+= 105;
//        
//        FirstPosition+= 70;
//        
////        UIButton *DeleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 100-46, 46, 46)];
//        
//        DeleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 65-30, 30, 30)];
//        
//        DeleteButton.tag = 10000+TotalUploadedImage;
//        ImageVIew.tag =DeleteButton.tag+9999999;
//        [DeleteButton setBackgroundImage:[UIImage imageNamed:@"DELETE"] forState:UIControlStateNormal];
//        [DeleteButton addTarget:self action:@selector(DeleteImage:) forControlEvents:UIControlEventTouchUpInside];
//        [ImageVIew addSubview:DeleteButton];
//        
//        //[_ImageScrollView addSubview:ImageVIew];
//        [_imageShowinScroll addSubview:ImageVIew];
//        
//        
//        [ImageUploadedData setObject:UIImageJPEGRepresentation(image, 0.7) forKey:[NSString stringWithFormat:@"uploadedimage%d",TotalUploadedImage]];
//       
//        NSLog(@"chk image uploded data count %d", ImageUploadedData.count);
//        
//        NSLog(@"total uploaded image chkng %d", TotalUploadedImage);
//        NSLog(@"total image uploaded data chkng %d", ImageUploadedData.count);
//        
//        NSMutableDictionary *new_dict = [[NSMutableDictionary alloc] init];
//        [new_dict setObject:[NSString stringWithFormat:@"uploadedimage%d",TotalUploadedImage] forKey:@"imageurloftrending"];
//        [new_dict setObject:UIImageJPEGRepresentation(image, 0.7) forKey:@"trendimage"];
//        
//        [defauldPusSign removeFromSuperview];
//        
//        
//        defauldPusSign = [[UIImageView alloc] initWithFrame:CGRectMake(FirstPosition, 18, 45, 45)];
//        
//        defauldPusSign.backgroundColor = [UIColor clearColor];
//        defauldPusSign.image = [UIImage imageNamed:@"plussign.png"];
//        defauldPusSign.userInteractionEnabled = YES;
//        
//        UITapGestureRecognizer *PicViewPinch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PicTap:)];
//        
//        [defauldPusSign addGestureRecognizer:PicViewPinch];
//        
//        [_imageShowinScroll addSubview:defauldPusSign];
//        
//        
//        
////        _ImageScrollView.contentSize = CGSizeMake(FirstPosition,100);
////        _ImageScrollView.userInteractionEnabled = YES;
////        _ImageScrollView.showsHorizontalScrollIndicator = YES;
////        _ImageScrollView.showsVerticalScrollIndicator = YES;
//        
//        _imageShowinScroll.contentSize = CGSizeMake(FirstPosition+45,65);
//        _imageShowinScroll.userInteractionEnabled = YES;
//        _imageShowinScroll.showsHorizontalScrollIndicator = YES;
//        _imageShowinScroll.showsVerticalScrollIndicator = YES;
//        
////        [ImagemutArry addObject:new_dict];
//        
//         [ImagemutArry addObject:ImageUploadedData];   //check ImageUploadedData
//        
//       
//        
//        
//        if (upoloadFirst==223)
//        {
//            NSLog(@"in ifffffmm");
//            _ImageShowview.hidden=NO;
//            _AddVEhicledescview.frame = CGRectMake(0, 600, 320, 50);
//            UITapGestureRecognizer *VehicleDEtailsViewPinch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(VdetailsTap:)];
//            [_AddVEhicledescview addGestureRecognizer:VehicleDEtailsViewPinch];
//            [self Makeframe:_AddVEhicledescview];
//            [_UIScrollViewMain addSubview:_AddVEhicledescview];
//        }
//        
//        else
//        {
//            NSLog(@"in ellss");
//            _AddVEhicledescview.hidden=YES;
//            _ImageShowview.hidden=NO;
//            
//            //_Makeview.frame = CGRectMake(0, 650, 320, 100);
//            _Makeview.frame = CGRectMake(0, 564, 320, 70);
//            [self Makeframe:_Makeview];
//            [_PriviewScroll addSubview:_Makeview];
//            
//            //_Modelview.frame = CGRectMake(0, 750, 320, 100);
//            _Modelview.frame = CGRectMake(0, 635, 320, 70);
//            [self Makeframe:_Modelview];
//            [_PriviewScroll addSubview:_Modelview];
//            
//            //_Yearview.frame = CGRectMake(0, 850, 320, 100);
//            _Yearview.frame = CGRectMake(0, 705, 320, 70);
//            [self Makeframe:_Yearview];
//            [_PriviewScroll addSubview:_Yearview];
//            
//            //_Uniquecharacteristicsview.frame = CGRectMake(0, 950, 320, 100);
//            _Uniquecharacteristicsview.frame = CGRectMake(0, 776, 320, 78);
//            [self Makeframe:_Uniquecharacteristicsview];
//            [_PriviewScroll addSubview:_Uniquecharacteristicsview];
//            
//            //_Processview.frame = CGRectMake(0, 550, 1000, 50);
//            _Processview.frame = CGRectMake(0, 855, 320, 50);
//            _Processview.backgroundColor = [UIColor clearColor];
//            [_PriviewScroll addSubview:_Processview];
//            
//            //[_PriviewScroll setContentSize:CGSizeMake(320, 1200)];
//            
//            [_PriviewScroll setContentSize:CGSizeMake(320, 1140)];
//        }
//        
//        
//    if (ImageDelete == YES)
//    {
//        [_imageShowinScroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//        
//        [ImageUploadedData setObject:UIImageJPEGRepresentation(image, 0.7) forKey:[NSString stringWithFormat:@"uploadedimage%d",TotalUploadedImage]];
//        
//        for (int i=1; i<=TotalUploadedImage; i++)
//        {
////            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10+(90*(i-1))+(10*(i-1)), 5, 90, 90)];
//            
//            NSLog(@"total uploaded imge TotalUploadedImage is %d", TotalUploadedImage);
//            NSLog(@"total dic isss   ImageUploadedData  %@",ImageUploadedData);
//            NSLog(@"total dic lngthh ImageUploadedData.count isss %d",ImageUploadedData.count);
//            
//            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake((70*(i-1)), 10, 65, 65)];
//            
//            [imageView setImage:[UIImage imageWithData:[ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",i]]]];
//           
//            
//            
//            
//            DeleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 65-30, 30, 30)];
//            DeleteButton.tag = 10000+TotalUploadedImage;
//            ImageVIew.tag =DeleteButton.tag+9999999;
//            [DeleteButton setBackgroundImage:[UIImage imageNamed:@"DELETE"] forState:UIControlStateNormal];
//            [DeleteButton addTarget:self action:@selector(DeleteImage:) forControlEvents:UIControlEventTouchUpInside];
//            
//            DeleteButton.userInteractionEnabled = YES;
//            [imageView addSubview:DeleteButton];
//            
//            
//            
//            
//            [_imageShowinScroll addSubview:imageView];
//            NSLog(@"chk in viewwwwwwwwdiddloaddd////");
//            
//            
//            
//            
//            
//            //NSData *imagedata = [ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",n+1]];
//            
//            NSLog(@"element chkng...%@", [ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",i]]);
//        }
//        
//        [_imageShowinScroll setContentSize:CGSizeMake(TotalUploadedImage*110, 65)];
//    }
//        
//    }];
//}
//
//
//-(IBAction)AddPicture:(id)sender {
//    
//    MBAlertView *destruct = [MBAlertView alertWithBody:@"Select my picture from" cancelTitle:@"Cancel" cancelBlock:nil];
//    //destruct.imageView.image = [UIImage imageNamed:@"image.png"];
//    [destruct addButtonWithText:@"Album" type:MBAlertViewItemTypeDestructive block:^{
//        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
//        picker.delegate = (id)self;
//        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//        picker.allowsEditing = YES;
//        //[self presentModalViewController:picker animated:YES];
//        [self presentViewController:picker animated:YES completion:nil];
//    }];
//    [destruct addButtonWithText:@"Camera" type:MBAlertViewItemTypeDestructive block:^{
//#if TARGET_IPHONE_SIMULATOR
//        {
//            MBAlertView *aler = [[MBAlertView alloc] init];
//            aler = [MBAlertView alertWithBody:@"Device doesnot support camera,Select my picture from album?" cancelTitle:@"Cancel" cancelBlock:nil];
//            [aler addButtonWithText:@"Yes" type:MBAlertViewItemTypeDestructive block:^{
//                NSLog(@"Get Image From Album");
//                UIImagePickerController * picker = [[UIImagePickerController alloc] init];
//                picker.delegate = (id)self;
//                picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//                picker.allowsEditing = YES;
//                [self presentViewController:picker animated:YES completion:nil];
//                //[self presentModalViewController:picker animated:YES];
//            }];
//            [aler addToDisplayQueue];
//        }
//#else
//        {
//            UIImagePickerController * pickerone = [[UIImagePickerController alloc] init];
//            pickerone.delegate = (id)self;
//            pickerone.sourceType = UIImagePickerControllerSourceTypeCamera;
//            pickerone.allowsEditing = YES;
//            [self presentViewController:pickerone animated:YES completion:nil];
//        }
//#endif
//    }];
//    [destruct addToDisplayQueue];
//    
//}
//
//
//-(void)DeleteImage:(id)sender {
//    
//    NSLog(@"dlt btn pressed");
//    
//    ImageDelete = YES;
//    
//    [[_imageShowinScroll viewWithTag:[sender tag]+9999999] removeFromSuperview];
//    NSLog(@"chk img positn---- %d", [sender tag]);
//    
//    TotalUploadedImage = TotalUploadedImage -1;
//    FirstPosition = FirstPosition-70;
//    
//    [ImageUploadedData removeObjectForKey:[NSString stringWithFormat:@"uploadedimage%d",(([sender tag]-10000))]];
//    
//    NSLog(@"chk img positn laterrrr---- %d", [sender tag]);
//    NSLog(@"total uploaded image chkng %d", TotalUploadedImage);
//    NSLog(@"total image uploaded data chkng %d", ImageUploadedData.count);
//    NSLog(@"image uploadarry:%d",[ImagemutArry count]);
//    
///*
//    for (int m=[sender tag]-10000; m<TotalUploadedImage+1; m++)
//    {
//        
//        NSData *imagedata = [ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",m+1]];
//        
//        ImageVIew =[[UIImageView alloc]initWithFrame:CGRectMake((74*(m-1)), 10, 65, 65)];
//        [ImageVIew setImage:[UIImage imageWithData:imagedata]];
//        ImageVIew.userInteractionEnabled=YES;
//        
//        [_imageShowinScroll addSubview:ImageVIew];
//        
//        NSLog(@"chk in for looop image uploaddd data isss %d", ImageUploadedData.count);
//        NSLog(@"chk in for looop m valuse isss %d", m);
//        
//       // [[_imageShowinScroll viewWithTag:[sender tag]+9999999] removeFromSuperview];
//        [[_imageShowinScroll viewWithTag:[sender tag]+9999999] removeFromSuperview];
//        
//
//    }
//*/
//    
//    [_imageShowinScroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    
//    for (int m=1; m<=[sender tag]-10000; m++)
//    {
//        
//        NSLog(@"print m in for is %d", m);
//        
//     // ImageUploadedData = [ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",m]];
//        
//        if (m == [sender tag]-10000)
//        {
//            NSLog(@"print m in first ifff  is %d", m);
//            
//             NSLog(@"in iffffkkk");
//            
//           // [ImageUploadedData setObject:UIImageJPEGRepresentation(ImageVIew, 0.7) forKey:[NSString stringWithFormat:@"uploadedimage%d",TotalUploadedImage]];
//            
//            for (int n=m; n<TotalUploadedImage+1; n++)
//            {
//                
//                
//                NSData *imagedata = [ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",n+1]];
//        
//                //NSString *str = [ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",n]];
//                
//                
//                [ImageUploadedData setObject:imagedata forKey:[NSString stringWithFormat:@"uploadedimage%d",n]];
//                
//        
////       ImageVIew = [ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",m]];
//        
//        //ImagemutArry = [ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",m]];
//        
//        //ImageUploadedData = [ImagemutArry objectAtIndex:m];
//        
//        //ImageVIew = [UIImage imageWithData:ImageUploadedData];
//        
//        
//        //ImageVIew =[[UIImageView alloc]initWithFrame:CGRectMake(10+(90*(m-1))+(10*(m-1)), 5, 45, 45)];
//        
//       // [ImageVIew setImage:[UIImage imageWithData:[ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",m]]]];
//        
//       // ImagemutArry [m] = ImagemutArry [m+1];
//        
//        
//            ImageVIew =[[UIImageView alloc]initWithFrame:CGRectMake((70*(n-1)), 10, 65, 65)];
//        
//            [ImageVIew setImage:[UIImage imageWithData:imagedata]];
//            ImageVIew.userInteractionEnabled=YES;
//                
//               
//                DeleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 65-30, 30, 30)];
//             DeleteButton.tag = 10000+TotalUploadedImage;
//             ImageVIew.tag =DeleteButton.tag+9999999;
//            [DeleteButton setBackgroundImage:[UIImage imageNamed:@"DELETE"] forState:UIControlStateNormal];
//            [DeleteButton addTarget:self action:@selector(DeleteImage:) forControlEvents:UIControlEventTouchUpInside];
//             
//            [ImageVIew addSubview:DeleteButton];
//                
//            [_imageShowinScroll addSubview:ImageVIew];
//                
//            //ImageUploadedDataAfterDeleteImage = [ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",n+1]];
//                
//           // [ImageUploadedData setObject:UIImageJPEGRepresentation(ImageVIew, 0.7) forKey:[NSString stringWithFormat:@"uploadedimage%d",TotalUploadedImage]];
//                
//                NSLog(@"element chkng in deleteee in fst fr lpp...%@", [ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",n]]);
//          }
//        }
//        
//        
//        else
//        {
//            NSLog(@"in elseeee");
//            
//            
//            
//            NSData *imagedata = [ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",m]];
//            
//            ImageVIew =[[UIImageView alloc]initWithFrame:CGRectMake((70*(m-1)), 10, 65, 65)];
//            
//            [ImageVIew setImage:[UIImage imageWithData:imagedata]];
//            ImageVIew.userInteractionEnabled=YES;
//            
//            DeleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 65-30, 30, 30)];
//            DeleteButton.tag = 10000+TotalUploadedImage;
//            ImageVIew.tag =DeleteButton.tag+9999999;
//            [DeleteButton setBackgroundImage:[UIImage imageNamed:@"DELETE"] forState:UIControlStateNormal];
//            [DeleteButton addTarget:self action:@selector(DeleteImage:) forControlEvents:UIControlEventTouchUpInside];
//            
//            
//            [ImageVIew addSubview:DeleteButton];
//            
//            [_imageShowinScroll addSubview:ImageVIew];
//            
//           // ImageUploadedDataAfterDeleteImage = [ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",m]];
//        }
//        
//        NSLog(@"chk in for looop image uploaddd data ImageUploadedData.count  isss %d", ImageUploadedData.count);
//        NSLog(@"chk in for looop image uploaddd  ImageUploadedData full %@", ImageUploadedData);
//        NSLog(@"chk in for looop isss %d", m);
//        //NSLog(@"newww dicc iss %d", ImageUploadedDataAfterDeleteImage.count);
//        
//        NSLog(@"element chkng in deleteee...%@", [ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",m]]);
//        
//        
//    }
//    
//  
//    
//}
//-(void)VdetailsTap:(UIGestureRecognizer *)Gesture {
//    _AddVehicleDescView.hidden = NO;
//}
//
//- (void)textFieldDidEndEditing {
//    [UIView animateWithDuration:.25 animations:^{
//        _UIScrollViewMain.contentOffset = CGPointMake(0, 0);
//    }];
//}
//- (void)textFieldDidBeginEditingone:(float)Dataval {
//    [UIView animateWithDuration:.25 animations:^{
//        _UIScrollViewMain.contentOffset = CGPointMake(0, Dataval);
//    }];
//}
//- (void)textFieldDidEndEditingss {
//    [UIView animateWithDuration:.25 animations:^{
//        _AddVScrollView.contentOffset = CGPointMake(0, 0);
//    }];
//}
//- (void)textFieldDidBeginEditingoness:(float)Dataval {
//    [UIView animateWithDuration:.25 animations:^{
//        _AddVScrollView.contentOffset = CGPointMake(0, Dataval);
//    }];
//}
//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
//{
//  
//    switch (textView.tag)
//    {
//      case 100:
//            if([ReportBadDriver CleanTextField:_TitleTextview.text].length == 0 || [[ReportBadDriver CleanTextField:_TitleTextview.text] isEqualToString:@"Add Title Here"]) {
//                _TitleTextview.text = @"";
//                _TitleTextview.textColor = [UIColor blackColor];
//            }
//            break;
//        case 101:
//            
//                _DescTextview.text = @"";
//                _DescTextview.textColor = [UIColor blackColor];
//            [_AddDescriptionLbl setHidden:YES];
//            [_UIScrollViewMain setContentOffset:CGPointMake(0, 40) animated:YES];
//            
//            break;
//        case 102:
//            if([ReportBadDriver CleanTextField:_LicencePlateTextview.text].length == 0 || [[ReportBadDriver CleanTextField:_LicencePlateTextview.text] isEqualToString:@"Add License plate Here"]) {
//                _LicencePlateTextview.text = @"";
//                _LicencePlateTextview.textColor = [UIColor blackColor];
//                
//            }
//            [self textFieldDidBeginEditingone:120];
//            break;
//        default:
//            break;
//            
//    }
//    return YES;
//    
//}
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView
//{
//    
//  return YES;
//    
//}
//-(void)textViewDidEndEditing:(UITextView *)textView
//{
//   
//    [_UIScrollViewMain setContentOffset:CGPointMake(0, 0) animated:YES];
//    if (_DescTextview.text.length==0)
//     {
//         [_AddDescriptionLbl setHidden:NO];
//     }
//   
//}
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    
//    [_UIScrollViewMain setContentOffset:CGPointMake(0, 0) animated:YES];
//    [textField resignFirstResponder];
//    return NO;
//}
//#pragma mark -
//#pragma mark UITextFieldDelegate methods
//
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    currentTag = textField.tag;
//    switch (textField.tag) {
//        case 996:
//            [self textFieldDidBeginEditingoness:150];
//            break;
//        case 997:
//            [self textFieldDidBeginEditingoness:100];
//            break;
//         case 11:
//            [_UIScrollViewMain setContentOffset:CGPointMake(0, 130) animated:YES];
//            break;
//    }
//    return YES;
//}
//
//-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
//    
//    switch (textField.tag) {
//        case 996:
//            [self textFieldDidEndEditingss];
//            break;
//        case 997:
//            [self textFieldDidEndEditingss];
//            break;
//    }
//    return YES;
//}
//
//#pragma mark - Autocomplete Data Source
//
//- (NSUInteger)minimumCharactersToTrigger:(ACEAutocompleteInputView *)inputView
//{
//    return 1;
//}
//- (void)inputView:(ACEAutocompleteInputView *)inputView itemsFor:(NSString *)query result:(void (^)(NSArray *items))resultBlock;
//{
//    if (resultBlock != nil) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//            
//            NSMutableArray *data = [NSMutableArray array];
//            
//            NSMutableArray *SearchArray;
//            [SearchArray removeAllObjects];
//            NSLog(@"currentTag --- %d",currentTag);
//            
//            switch (currentTag) {
//                case 999:
//                    SearchArray = [NSMutableArray arrayWithArray:_MakeArray];
//                    break;
//                case 998:
//                    SearchArray = [NSMutableArray arrayWithArray:_ModelArray];
//                    break;
//                case 997:
//                    SearchArray = [NSMutableArray arrayWithArray:_YearArray];
//                    break;
//                case 996:
//                    SearchArray = [NSMutableArray arrayWithArray:_UniqueArray];
//                    break;
//                default:
//                    SearchArray = [NSMutableArray arrayWithArray:_MakeArray];
//                    break;
//            }
//            //NSLog(@"SearchArray --- %@",SearchArray);
//            for (NSString *string in SearchArray) {
//                NSRange range = [string rangeOfString:query options:NSCaseInsensitiveSearch];
//                if (range.location != NSNotFound)
//                    [data addObject:string];
//            }
//            dispatch_async(dispatch_get_main_queue(), ^{
//                resultBlock(data);
//            });
//        });
//    }
//}
//
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if([text isEqualToString:@"\n"])
//    {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}
//-(IBAction)CancelButtonClicked:(id)sender {
//    _AddVehicleDescView.hidden = YES;
//    _isVehicleDescComplete = NO;
//}
//-(IBAction)DoneButtonClicked:(id)sender {
//    
////    if(![ReportBadDriver CleanTextField:_Maketextview.text].length > 0) {
////        
////        MBAlertView *alert = [MBAlertView alertWithBody:VIHICLEDESCMAKEERR cancelTitle:@"Cancel" cancelBlock:nil];
////        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
////            [_Maketextview becomeFirstResponder];
////        }];
////        [alert addToDisplayQueue];
////        return;
////        
////    } else if(![ReportBadDriver CleanTextField:_Modeltextview.text].length > 0) {
////        
////        MBAlertView *alert = [MBAlertView alertWithBody:VIHICLEDESCMODELERR cancelTitle:@"Cancel" cancelBlock:nil];
////        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
////            [_Modeltextview becomeFirstResponder];
////        }];
////        [alert addToDisplayQueue];
////        return;
////        
////    } else if(![ReportBadDriver CleanTextField:_Yeartextview.text].length > 0) {
////        
////        MBAlertView *alert = [MBAlertView alertWithBody:VIHICLEDESCYEARERR cancelTitle:@"Cancel" cancelBlock:nil];
////        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
////            [_Yeartextview becomeFirstResponder];
////        }];
////        [alert addToDisplayQueue];
////        return;
////        
////    } else if(![ReportBadDriver CleanTextField:_Uniquecharacteristicstextview.text].length > 0) {
////        
////        MBAlertView *alert = [MBAlertView alertWithBody:VIHICLEDESCUQERR cancelTitle:@"Cancel" cancelBlock:nil];
////        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
////            [_Uniquecharacteristicstextview becomeFirstResponder];
////        }];
////        [alert addToDisplayQueue];
////        return;
////        
////    } else {
//        _AddVehicleDescView.hidden = YES;
//        _isVehicleDescComplete = YES;
//   // }
//    
//}
////-(IBAction)ADDIMAGECancelButtonClicked:(id)sender {
////    _ADDIMAGEVIEW.hidden = YES;
////    _isVehicleImageComplete = NO;
////}
//
////-(IBAction)ADDIMAGEDoneButtonClicked:(id)sender {
////    
////    NSLog(@"ADDIMAGEDoneButtonClicked-----");
////    
////    _ADDIMAGEVIEW.hidden = YES;
////    _isVehicleImageComplete = YES;
////    
////    NSLog(@"chk int valueee iss %d", upoloadFirst);
////    
////    if (upoloadFirst == 223)
////    {
////        NSLog(@"i m in (upoloadFirst == 223)");
////        
////        NSArray *SubviewArry=[_imageShowinScroll subviews];
////        for (UIView *imageview in SubviewArry)
////        {
////            [imageview removeFromSuperview];
////        }
////        
////        [self uploadPhotoFirst];
////    }
////    
////    
////    
////    if (Isreview==FALSE)
////    {
////         NSLog(@"i m in (uIsreview==FALSE)");
////        
////        NSArray *SubviewArry=[_imageShowinScroll subviews];
////        for (UIView *imageview in SubviewArry)
////        {
////            [imageview removeFromSuperview];
////        }
////        
////        if ([ImageUploadedData count]>0)
////        {
////            for (int i=1; i<=TotalUploadedImage; i++)
////            {
////                UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10+(90*(i-1))+(10*(i-1)), 5, 90, 90)];
////                [imageView setImage:[UIImage imageWithData:[ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",i]]]];
////                [_imageShowinScroll addSubview:imageView];
////            }
////            [_imageShowinScroll setContentSize:CGSizeMake(TotalUploadedImage*110, 100)];    //scroll is working
////        }
////        else
////        {
////             NSLog(@"i m in elseessssss...");
////            
////            UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 80)];
////            lable.text=@"You will achieve 5 points for uploading photo.";
////            lable.textColor=[UIColor redColor];
////            lable.font=[UIFont fontWithName:@"Arail" size:15.0f];
////            lable.numberOfLines=1;
////            [_imageShowinScroll addSubview:lable];
////        }
////       
////    }
////}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//-(void)UploadMyImage:(NSMutableDictionary *)ObjectReceiver
//{
//    @try
//    {
//        NSMutableDictionary *DataDictionary = [[NSMutableDictionary alloc] init];
//        [DataDictionary setObject:[ObjectReceiver objectForKey:@"userid"] forKey:@"userid"];
//        [DataDictionary setObject:[ObjectReceiver objectForKey:@"reportid"] forKey:@"reportid"];
//        [DataDictionary setObject:@"upload_image" forKey:@"mode"];
//        NSString *URLString = [ReportBadDriver CallURLForServerReturn:DataDictionary URL:@"pages/addreport.php"];
//        
//        NSLog(@"%@", URLString);
//        
//        NSData *ImageData=(NSData *)[ObjectReceiver objectForKey:@"photoimg"];
//        NSURL* requestURL = [NSURL URLWithString:URLString];
//        
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//        [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
//        [request setHTTPShouldHandleCookies:NO];
//        [request setURL:requestURL];
//        [request setTimeoutInterval:30];
//        [request setHTTPMethod:@"POST"];
//        NSURLResponse *response = nil;
//        NSError *error;
//        NSString *boundary = [NSString stringWithFormat:@"%0.9u",arc4random()];
//        
//        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
//        
//        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
//        NSMutableData *body = [NSMutableData data];
//        
//        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"photoimg\"; filename=\".jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        [body appendData:[[NSString stringWithFormat:@"Content-Type: image/png\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        [body appendData:[NSData dataWithData:ImageData]];
//        
//        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        [request setHTTPBody:body];
//        
//         NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//        
//        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//        
//        NSLog(@"%@",returnString);
//        
//        _ReportId = [returnString intValue];
//        
//        [self performSelectorOnMainThread:@selector(ResponseReceived) withObject:nil waitUntilDone:YES];
//    }
//    @catch (NSException *juju)
//      {
//        NSLog(@"Reporting juju from UploadMyImage %@", juju);
//     }
//}
//
//#pragma mark for main Thread Segment
//
//-(void)ResponseReceived
//{
//   
//    ResponseCounter+=1;
//    if(ResponseCounter == TotalUploadedImage) {
//        NSLog(@"All data Uploaded successfully");
//        [ReportBadDriver HidePopupView];
//        AppDelegate *maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//       // DashboardViewController *Dashboard = [[DashboardViewController alloc] init];
//       // [maindelegate SetUpTabbarControllerwithcenterView:Dashboard];
//        
//        UserReportViewController *UserReport = [[UserReportViewController alloc] init];
//        [maindelegate SetUpTabbarControllerwithcenterView:UserReport];
//        
//    }
//}
//
//-(IBAction)FinalSave:(id)sender {
//    
//    if(_DescTextview.text==(NSString *)[NSNull null]) {
//        _DescTextview.text=@"";
//    }
//    if(_Modeltextview.text==(NSString *)[NSNull null]) {
//        _Modeltextview.text=@"";
//    }
//    if([_Yeartextview.text isEqualToString:nil]) {
//        _Yeartextview.text=@"";
//    }
//    if([_Uniquecharacteristicstextview.text isEqualToString:nil]) {
//        _Uniquecharacteristicstextview.text=@"";
//    }
//
//    if (PreviewData  == FALSE) {
//        
//        NSLog(@"show the preview");
//        // show the preview
//        
//        if (Isreview==TRUE)
//        {
//             NSLog(@"show the preview in (Isreview==TRUE)");
//            
//            Isreview = FALSE;
//            PreviewData = TRUE;                    // Preview complete, set it for final save
//            
//            [_AddVehicleDescView setHidden:YES];
//            
//            _Processview.hidden=YES;
//            
//            [_reportBaddriverView removeFromSuperview];
//            
//            //_ReportBadDriver.frame = CGRectMake(0, 50, 320, 100);
//            _ReportBadDriver.frame = CGRectMake(0, 0, 320, 50);
//            [self Makeframe:_ReportBadDriver];
//            [_PriviewScroll addSubview:_ReportBadDriver];
//            
//            //_Titleview.frame = CGRectMake(0, 100, 320, 100);
//            _Titleview.frame = CGRectMake(0, 49, 320, 75);
//            [self Makeframe:_Titleview];
//            _Titellbl.text=@"Title";
//            _TitleTextview.returnKeyType = UIReturnKeyDone;
//            _TitleTextview.delegate = (id)self;
//            _TitleTextview.tag = 100;
//            [_PriviewScroll addSubview:_Titleview];
//            
//            self.ViewForreview.layer.cornerRadius=4.0f;
//            
//            if ([_DescTextview.text length ]>0) {
//                _descriptionlbl.text=@"Description";
//            }
//            //_Descriptionview.frame = CGRectMake(0, 200, 320, 150);
//            _Descriptionview.frame = CGRectMake(0, 125, 320, 138);
//
//            [self Makeframe:_Descriptionview];
//            _DescTextview.returnKeyType = UIReturnKeyDone;
//            _DescTextview.delegate = (id)self;
//            _DescTextview.tag = 101;
//            
//            _DescTextview.textColor = UIColorFromRGB(0xc5c5c5);
//            [_PriviewScroll addSubview:_Descriptionview];
//            
//            //_LicencePlateview.frame = CGRectMake(0, 350, 320, 100);
//            _LicencePlateview.frame = CGRectMake(0, 264, 320, 77);
//            [self Makeframe:_LicencePlateview];
//            _LicencePlateTextview.returnKeyType = UIReturnKeyDone;
//            _LicencePlateTextview.delegate = (id)self;
//            _LicencePlateTextview.tag = 102;
//            [_PriviewScroll addSubview:_LicencePlateview];
//            
//            // Add report Locationview in mainview
//            
//            //_Locationview.frame = CGRectMake(0, 450, 320, 50);
//            _Locationview.frame = CGRectMake(0, 342, 320, 81);
//            UITapGestureRecognizer *LocationViewPinch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LocationTap:)];
//            [_Locationview addGestureRecognizer:LocationViewPinch];
//            [self Makeframe:_Locationview];
//            [_PriviewScroll addSubview:_Locationview];
//            
//            if ([ImageUploadedData count]>0)
//            {
//                isAddreport=[NSString stringWithFormat:@"%d",1];
//                [self.photoAlert setHidden:NO];
//                [self.photoAlert setText:@"[You achieved 5 points for uploading photo.]"];
//                self.photoAlert.textColor=UIColorFromRGB(0x1aad4b);
//                
//                
//                //_AddPicview.frame = CGRectMake(0, 500, 320, 50);
//                _AddPicview.frame = CGRectMake(0, 424, 320, 50);
//                //                                 UITapGestureRecognizer *PicViewPinch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PicTap:)];
//                //                                 [_AddPicview addGestureRecognizer:PicViewPinch];
//                [self Makeframe:_AddPicview];
//                [_PriviewScroll addSubview:_AddPicview];
//                
//                //problem hereee!!??
//                
//                _ImageShowview.frame=CGRectMake(0, 475, 320, 88);
//                [self Makeframe:_ImageShowview];
//                
//                [_PriviewScroll addSubview:_ImageShowview];
//                NSLog(@"image uploadarry:%d",[ImagemutArry count]);
////                for (int i=1; i<=TotalUploadedImage; i++)
////                {
////                    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10+(90*(i-1))+(10*(i-1)), 5, 90, 90)];
////                    [imageView setImage:[UIImage imageWithData:[ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",i]]]];
////                    [_imageShowinScroll addSubview:imageView];
////                    NSLog(@"chk////");
////                }
//                [_imageShowinScroll setContentSize:CGSizeMake(TotalUploadedImage*110, 65)];
//                
//                NSLog(@"makeview in 3rd");
//                
//                //_Makeview.frame = CGRectMake(0, 650, 320, 100);
//                _Makeview.frame = CGRectMake(0, 564, 320, 70);
//                [self Makeframe:_Makeview];
//                [_PriviewScroll addSubview:_Makeview];
//                
//                //_Modelview.frame = CGRectMake(0, 750, 320, 100);
//                _Modelview.frame = CGRectMake(0, 635, 320, 70);
//                [self Makeframe:_Modelview];
//                [_PriviewScroll addSubview:_Modelview];
//                
//                //_Yearview.frame = CGRectMake(0, 850, 320, 100);
//                _Yearview.frame = CGRectMake(0, 705, 320, 70);
//                [self Makeframe:_Yearview];
//                [_PriviewScroll addSubview:_Yearview];
//                
//                //_Uniquecharacteristicsview.frame = CGRectMake(0, 950, 320, 100);
//                _Uniquecharacteristicsview.frame = CGRectMake(0, 776, 320, 78);
//                [self Makeframe:_Uniquecharacteristicsview];
//                [_PriviewScroll addSubview:_Uniquecharacteristicsview];
//                
//                //_Processview.frame = CGRectMake(0, 550, 1000, 50);
//                _Processview.frame = CGRectMake(0, 855, 320, 50);
//                _Processview.backgroundColor = [UIColor clearColor];
//                [_PriviewScroll addSubview:_Processview];
//                
//                //[_PriviewScroll setContentSize:CGSizeMake(320, 1200)];
//                
//                [_PriviewScroll setContentSize:CGSizeMake(320, 1140)];
//                
//                PreviewData = TRUE;
//                
//            }
//            else
//            {
//                upoloadFirst = 0;
//                _AddVEhicledescview.hidden=YES;
//                
//                NSLog(@"show the preview in elseeeeeess");
//                
//                isAddreport=[NSString stringWithFormat:@"%d",0];
//                _AddPicview.frame = CGRectMake(0, 424, 320, 50);
//                [self.photoAlert setHidden:NO];
//                [self.photoAlert setText:@"[You will achieve 5 points for uploading photo.]"];
//                self.photoAlert.textColor=[UIColor redColor];
//                [self Makeframe:_AddPicview];
//               // _AddPicview.hidden = YES;
//                [_PriviewScroll addSubview:_AddPicview];
//                
//                
//                _ImageShowview.frame=CGRectMake(0, 475, 320, 88);
//                [self Makeframe:_ImageShowview];
//                
//                [_PriviewScroll addSubview:_ImageShowview];
//                NSLog(@"image uploadarry:%d",[ImagemutArry count]);
////                for (int i=1; i<=TotalUploadedImage; i++)
////                {
////                    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10+(90*(i-1))+(10*(i-1)), 5, 90, 90)];
////                    [imageView setImage:[UIImage imageWithData:[ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",i]]]];
////                    [_imageShowinScroll addSubview:imageView];
////                }
//                [_imageShowinScroll setContentSize:CGSizeMake(TotalUploadedImage*110, 65)];
//                
//                
//                
//                NSLog(@"makeview in 4th");
//                
////                _Makeview.frame = CGRectMake(0, 576, 320, 70);
////                [self Makeframe:_Makeview];
////                [_PriviewScroll addSubview:_Makeview];
////                //_Makeview.hidden = YES;
////                
////                _Modelview.frame = CGRectMake(0, 647, 320, 70);
////                [self Makeframe:_Modelview];
////                [_PriviewScroll addSubview:_Modelview];
////                
////                _Yearview.frame = CGRectMake(0, 718, 320, 70);
////                [self Makeframe:_Yearview];
////                [_PriviewScroll addSubview:_Yearview];
////                
////                _Uniquecharacteristicsview.frame = CGRectMake(0, 789, 320, 78);
////                [self Makeframe:_Uniquecharacteristicsview];
////                [_PriviewScroll addSubview:_Uniquecharacteristicsview];
////                
////                _Processview.frame = CGRectMake(0, 868, 900, 50);
////                _Processview.backgroundColor = [UIColor clearColor];
////                [_PriviewScroll addSubview:_Processview];
////                
////                [_PriviewScroll setContentSize:CGSizeMake(320, 1145)];
//                
//                
//                
//                
//                _Makeview.frame = CGRectMake(0, 475, 320, 70);
//                [self Makeframe:_Makeview];
//                [_PriviewScroll addSubview:_Makeview];
//                //_Makeview.hidden = YES;
//                
//                _Modelview.frame = CGRectMake(0, 546, 320, 70);
//                [self Makeframe:_Modelview];
//                [_PriviewScroll addSubview:_Modelview];
//                
//                _Yearview.frame = CGRectMake(0, 617, 320, 70);
//                [self Makeframe:_Yearview];
//                [_PriviewScroll addSubview:_Yearview];
//                
//                _Uniquecharacteristicsview.frame = CGRectMake(0, 688, 320, 78);
//                [self Makeframe:_Uniquecharacteristicsview];
//                [_PriviewScroll addSubview:_Uniquecharacteristicsview];
//                
//                _Processview.frame = CGRectMake(0, 767, 900, 50);
//                _Processview.backgroundColor = [UIColor clearColor];
//                [_PriviewScroll addSubview:_Processview];
//                
//                [_PriviewScroll setContentSize:CGSizeMake(320, 1045)];
//                
//                
//                
//            }
//            [self.view addSubview:_PriviewShow];
//            
//        }
//        //_ADDIMAGEVIEW.frame = CGRectMake(0, 50, 320, 300);
//        
////        _ADDIMAGEVIEW.frame = CGRectMake(0, 0, 320, 520);
////        [self Makeframe:_ADDIMAGEVIEW];
////        _ADDIMAGEVIEW.hidden = YES;
////        [self.PriviewShow addSubview:_ADDIMAGEVIEW];
////        //[_PriviewScroll addSubview:_ADDIMAGEVIEW];
////        _AddVEhicledescview.hidden=YES;
//        
//    } else {
//        
//        // 0.000000
//        
//        NSString *ModifiedLocation      = @" ";
//        NSString *Modifiedlatitude      = @"0.000000";
//        NSString *Modifiedlongitude     = @"0.000000";
//        
//        // if myaddress is nil, set veriable as blank
//        
//        if ((myAddress == nil) || ([ReportBadDriver CleanTextField:myAddress].length>0) || (myAddress == (NSString *)[NSNull null]))
//            myAddress = @" ";
//        
//        if (AccessCustomLocation) {
//            
//            // Accessing custom location provided by user
//            
//            ModifiedLocation    = UserDesiredLocation;
//        }
//        
//        if (AccessMyLocation) {
//            
//            // Accessing user device location
//            
//            ModifiedLocation    = myAddress;
//            Modifiedlatitude    = _Lattitude;
//            Modifiedlongitude   = _Longitude;
//        }
//        
//        
//        ObjectCarrier=[[NSMutableDictionary alloc] init];
//        NSLog(@"The sccond selector call:");
//        
//        [ObjectCarrier setObject:[ReportBadDriver CleanTextField:_TitleTextview.text] forKey:@"add_title"];
//        [ObjectCarrier setObject:[ReportBadDriver CleanTextField:_DescTextview.text] forKey:@"add_desc"];
//        [ObjectCarrier setObject:[ReportBadDriver CleanTextField:_LicencePlateTextview.text] forKey:@"licence_plate"];
//        [ObjectCarrier setObject:ModifiedLocation forKey:@"location"];
//        [ObjectCarrier setObject:Modifiedlatitude forKey:@"latitude"];
//        [ObjectCarrier setObject:Modifiedlongitude forKey:@"longitude"];
//        
////        [ObjectCarrier setObject:myAddress forKey:@"location"];
////        [ObjectCarrier setObject:_Lattitude forKey:@"latitude"];
////        [ObjectCarrier setObject:_Longitude forKey:@"longitude"];
//        
//        [ObjectCarrier setObject:[ReportBadDriver CleanTextField:_Maketextview.text] forKey:@"make"];
//        [ObjectCarrier setObject:[ReportBadDriver CleanTextField:_Modeltextview.text] forKey:@"model"];
//        [ObjectCarrier setObject:[ReportBadDriver CleanTextField:_Yeartextview.text] forKey:@"year"];
//        [ObjectCarrier setObject:[ReportBadDriver CleanTextField:_Uniquecharacteristicstextview.text] forKey:@"characteristics"];
//        [ObjectCarrier setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"] forKey:@"userid"];
//        [ObjectCarrier setObject:@"create_report" forKey:@"mode"];
//        [self SubmitReviewData];
//    }
//}
//-(IBAction)Previewdata:(id)sender {
//    
//    upoloadFirst=0;
//    NSLog(@"chk int value is %d", upoloadFirst);
//    
//    NSLog(@"myAddress -------- %@",myAddress);
//    if (![ReportBadDriver CleanTextField:_TitleTextview.text].length>0) {
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter a Valid Title" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [alert show];
//    } else if (![ReportBadDriver CleanTextField:_LicencePlateTextview.text].length>0) {
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Licence Plate" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [alert show];
//    } else {
//        [self FinalSave:nil];
//    }
////    else if ((myAddress == nil) || ([ReportBadDriver CleanTextField:myAddress].length>0) || (myAddress == (NSString *)[NSNull null])) {
////        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Your Location" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
////        [alert show];
////    }
//}
//-(IBAction)FinalCancel:(id)sender
//{
//    
//   MBAlertView *alert = [MBAlertView alertWithBody:@"Are You Sure To Cancel This Report?" cancelTitle:@"No" cancelBlock:nil];
//    [alert addButtonWithText:@"Yes" type:MBAlertViewItemTypePositive block:^{
//        _isVehicleDescComplete = NO;
//        _isLicencePlateComplete = NO;
//        _isReportDescComplete = NO;
//        _isReportTitleComplete = NO;
//        _isVehicleImageComplete = NO;
//        _isVehiclelocComplete = NO;
//        AppDelegate *maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        DashboardViewController *Dashboard = [[DashboardViewController alloc] init];
//        [maindelegate SetUpTabbarControllerwithcenterView:Dashboard];
//    }];
//    [alert addToDisplayQueue];
//    return;
//}
//
//- (void)backButtonPressed:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//- (void)leftSideMenuButtonPressed:(id)sender {
//    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
//}
//
//- (void)rightSideMenuButtonPressed:(id)sender {
//    [self.menuContainerViewController toggleRightSideMenuCompletion:^{}];
//}
//-(void)HideNavigationBar {
//    [self.navigationController setNavigationBarHidden:YES];
//}
//
//-(NSString *)deviceLocation {
//    
//    NSString *theLocation = [NSString stringWithFormat:@"latitude: %f longitude: %f",_MyLocation.location.coordinate.latitude,_MyLocation.location.coordinate.longitude];
//    return theLocation;
//    
//}
//
//-(UIView *)prepareToOpenPopupInView:(UIView *)screenView
//{
//    
//    UIView *overlayView=[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [screenView frame].size.width, [screenView frame].size.height)];
//    [overlayView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"popup_shadow.png"]]];
//    [overlayView setAlpha:0.0f];
//    [screenView addSubview:overlayView];
//    
//    [UIView animateWithDuration:0.4f animations:^{
//        
//        [overlayView setAlpha:1.0f];
//    }];
//    
//    return overlayView;
//}
//
//- (void)SubmitReviewData
//{
//    //[PopUp removeFromSuperview];
//    
//    [ReportBadDriver AddBlackOverlay:self.view xcord:0 ycord:0 width:self.view.frame.size.width height:self.view.frame.size.height backgroundColor:[UIColor blackColor] OpacitY:0.9f Text:@"Please wait" TextColor:[UIColor whiteColor] FontName:globalTEXTFIELDPLACEHOLDERFONT FontSize:18 IsTextEnabled:YES];
//    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
//     {
//         
//         NSString *URLString = [ReportBadDriver CallURLForServerReturn:ObjectCarrier URL:@"pages/addreport.php"];
//        NSLog(@"URLString ----- %@",URLString);
//         
//         NSData *dataURL =  [NSData dataWithContentsOfURL: [ NSURL URLWithString: URLString ]];
//         NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSUTF8StringEncoding];
//         NSLog(@"the servrer out put:%@",serverOutput);
//         
//         _ReportId = [serverOutput intValue];
//         
//         
//         if ([ImageUploadedData count]>0)
//         {
//         
//         NSOperationQueue *OperationQueue = [NSOperationQueue new];
//         NSInvocationOperation *UploadOperation;
//         for(int ISX = 1; ISX <= [ImageUploadedData count]; ISX++)
//         {
//             
//             NSData *imagedata = [ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",ISX]];
//             
//             
//             
//             NSMutableDictionary *ObjectCarrierforuserid=[[NSMutableDictionary alloc] init];
//             [ObjectCarrierforuserid setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"] forKey:@"userid"];
//             [ObjectCarrierforuserid setObject:[NSString stringWithFormat:@"%d",_ReportId] forKey:@"reportid"];
//             
//             [ObjectCarrierforuserid setObject:imagedata forKey:@"photoimg"];
//             [ImagemutArry addObject:imagedata];
//             
//             
//             UploadOperation=[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(UploadMyImage:) object:ObjectCarrierforuserid];
//             [OperationQueue addOperation:UploadOperation];
//             
//         }
//         }
//         else
//         {
//             dispatch_async(dispatch_get_main_queue(), ^{
//                 NSLog(@"tab bar");
//                 [ReportBadDriver HidePopupView];
//                  AppDelegate *maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//                  DashboardViewController *Dashboard = [[DashboardViewController alloc] init];
//                  [maindelegate SetUpTabbarControllerwithcenterView:Dashboard];
//                 
//             });
//         }
//       
//
//});
//
//
//}
//- (IBAction)ResetreViewdata:(id)sender
// {
//     [PopUp removeFromSuperview];
// }
////-(void)textFieldDidBeginEditing:(UITextField *)textField  {
////   
////        [UIView animateWithDuration:2.0 animations:^{
////            [_UIScrollViewMain setContentOffset:CGPointMake(0, 200) animated:YES];
////        }];
////
////    
////}
////-(void)textFieldDidEndEditing:(UITextField *)textField {
////    [UIView animateWithDuration:2.0 animations:^{
////        [_UIScrollViewMain setContentOffset:CGPointMake(0, 0) animated:YES];
////    }];
////}
//-(IBAction)Scrolltoup:(id)sender {
//    [UIView animateWithDuration:2.0 animations:^{
//        [_UIScrollViewMain setContentOffset:CGPointMake(0, 200) animated:YES];
//    }];
//
//}
//
//
//@end

//
//  ReportBadDriverViewController.m
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 19/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import "ReportBadDriverViewController.h"
#import "HelperClass.h"
#import "MFSideMenu.h"
#import <QuartzCore/CoreAnimation.h>
#import <AVFoundation/AVFoundation.h>
#import "MBHUDView.h"
#import "AppDelegate.h"
#import "AddVehicleDescViewController.h"
#import "ACEAutocompleteBar.h"
#import "DashboardViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "UserReportViewController.h"

@interface ReportBadDriverViewController ()<ACEAutocompleteDataSource, ACEAutocompleteDelegate,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate, UIPickerViewAccessibilityDelegate> {
    
    //int upoloadFirst;
    int currentTag;
    int ResponseCounter;
    int TotalUploadedImage;
    NSMutableData* webdata;
    NSURLConnection *connection;
    HelperClass *ReportBadDriver;
    NSArray *TableviewDataArray;
    NSArray *TableviewImageArray;
    NSMutableDictionary *ImageUploadedData;
    
    NSMutableDictionary *ImageUploadedDataAfterDeleteImage;
    
    NSMutableDictionary *ObjectCarrier;
    UIView *PopUp;
    NSString *isAddreport;
    NSString *isLocationAdded;
    BOOL Isreview;
    NSOperationQueue *operation;
    NSString *myAddress;
    NSMutableArray *ImagemutArry;
    
    UIView *MakeBackgroundOverlayView;
    
    NSString *UserDesiredLocation;
    
    UITextView *AddLocationTextView;
    
    UIImageView *defauldPusSign;
    
    BOOL PreviewData;
    
    BOOL ImageDelete;
    
}
@property (strong, nonatomic) IBOutlet UIView *reportBaddriverView;

@property (strong, nonatomic) IBOutlet UIView *ImageShowview;

@property (weak, nonatomic) IBOutlet UIScrollView *imageShowinScroll;


@property (weak, nonatomic) IBOutlet UILabel *Titellbl;
@property (weak, nonatomic) IBOutlet UILabel *descriptionlbl;

-(IBAction)Scrolltoup:(id)sender;
-(IBAction)Previewdata:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *PriviewShow;
@property (strong, nonatomic) IBOutlet UIScrollView *PriviewScroll;


@property (strong, nonatomic) IBOutlet UILabel *LocationAlert;
@property (strong, nonatomic) IBOutlet UILabel *photoAlert;
@property (strong, nonatomic) IBOutlet UILabel *AddDescriptionLbl;
@property (strong, nonatomic) IBOutlet UILabel *TotalPoint;
@property (strong, nonatomic) IBOutlet UILabel *LocationPoint;
@property (strong, nonatomic) IBOutlet UILabel *uploadPhoto;

@property (nonatomic,retain) IBOutlet UITableView *ReportDataTableview;
@property (nonatomic,retain) IBOutlet UIView *Subview;
@property (nonatomic,retain) IBOutlet UIView *ReportBadDriver;
@property (nonatomic,retain) IBOutlet UIView *Titleview;
@property (nonatomic,retain) IBOutlet UITextField *TitleTextview;


@property (nonatomic,retain) IBOutlet UIScrollView *UIScrollViewMain;
@property (nonatomic,retain) IBOutlet UIView *Descriptionview;
@property (nonatomic,retain) IBOutlet UITextView *DescTextview;
@property (nonatomic,retain) IBOutlet UIView *LicencePlateview;
@property (nonatomic,retain) IBOutlet UITextField *LicencePlateTextview;
@property (nonatomic,retain) IBOutlet UIView *Locationview;
@property (nonatomic,retain) IBOutlet UIView *AddPicview;
@property (nonatomic,retain) IBOutlet UIView *AddVEhicledescview;
@property (nonatomic,retain) IBOutlet UIView *FooterView;
@property (nonatomic,retain) IBOutlet UIButton *Savebutton;
@property (nonatomic,retain) IBOutlet UIButton *Cancelbutton;

//@property (nonatomic,retain) IBOutlet UIView *ADDIMAGEVIEW;

@property (nonatomic,retain) IBOutlet UIView *DYNAMICIMAGEVIEW;
@property (nonatomic,retain) IBOutlet UIScrollView *ImageScrollView;

#pragma mark -
#pragma mark Method used for add vehicle description section
@property (strong, nonatomic) IBOutlet UIView *ViewForreview;

@property (nonatomic,retain) IBOutlet UIScrollView *AddVScrollView;
@property (nonatomic,retain) IBOutlet UIView *Makeview;
@property (nonatomic,retain) IBOutlet UIView *Modelview;
@property (nonatomic,retain) IBOutlet UIView *Yearview;
@property (nonatomic,retain) IBOutlet UIView *Uniquecharacteristicsview;
@property (nonatomic,retain) IBOutlet UIView *Processview;
@property (nonatomic,retain) IBOutlet UITextField *Maketextview;
@property (nonatomic,retain) IBOutlet UITextField *Modeltextview;
@property (nonatomic,retain) IBOutlet UITextField *Yeartextview;
@property (nonatomic,retain) IBOutlet UITextField *Uniquecharacteristicstextview;
@property (nonatomic,retain) IBOutlet UIView *AddVehicleDescView;

@property (nonatomic, strong) NSMutableArray *MakeArray;
@property (nonatomic, strong) NSMutableArray *ModelArray;
@property (nonatomic, strong) NSMutableArray *YearArray;
@property (nonatomic, strong) NSMutableArray *UniqueArray;
@property (nonatomic, retain) NSString *Lattitude;
@property (nonatomic, retain) NSString *Longitude;
@property (nonatomic, retain) NSString *LocationData;

-(IBAction)CancelButtonClicked:(id)sender;
-(IBAction)DoneButtonClicked:(id)sender;
//-(IBAction)ADDIMAGECancelButtonClicked:(id)sender;
//-(IBAction)ADDIMAGEDoneButtonClicked:(id)sender;
-(IBAction)FinalSave:(id)sender;
-(IBAction)FinalCancel:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *Titelreview;
@property (strong, nonatomic) IBOutlet UILabel *licenceplatereview;
@property (strong, nonatomic) IBOutlet UILabel *descriptionreview;
@property (strong, nonatomic) IBOutlet UILabel *locationReview;

@property (strong, nonatomic) IBOutlet UILabel *PhotoSectionReview;

@property (strong, nonatomic) IBOutlet UILabel *YearSectionReview;
@property (weak, nonatomic) IBOutlet UITextField *locationShow;

@property (strong, nonatomic) IBOutlet UILabel *makeSection;

@property (strong, nonatomic) IBOutlet UILabel *modelSectionreview;

@property (nonatomic,assign) BOOL isReportTitleComplete;
@property (nonatomic,assign) BOOL isReportDescComplete;
@property (nonatomic,assign) BOOL isLicencePlateComplete;
@property (nonatomic,assign) BOOL isVehiclelocComplete;
@property (nonatomic,assign) BOOL isVehicleImageComplete;
@property (nonatomic,assign) BOOL isVehicleDescComplete;
@property (nonatomic,assign) int ReportId;

@property (nonatomic,retain) CLLocationManager *MyLocation;

// Add user desired location view's property

@property (nonatomic,retain) IBOutlet UIView *UserDesiredlocationView;

@property (nonatomic,strong) UIImageView *ImageVIew;
@property (nonatomic,strong) UIButton *DeleteButton;


-(IBAction)SaveUserDesireLoaction:(id)sender;
-(IBAction)CaneclUserDesireLoactionView:(id)sender;

@end


@implementation ReportBadDriverViewController

int FirstPosition = 0;
BOOL AccessMyLocation = NO;
BOOL AccessCustomLocation = NO;

@synthesize ReportDataTableview     = _ReportDataTableview;
@synthesize Subview                 = _Subview;
@synthesize Titleview               = _Titleview;
@synthesize TitleTextview           = _TitleTextview;
@synthesize UIScrollViewMain        = _UIScrollViewMain;
@synthesize Descriptionview         = _Descriptionview;
@synthesize DescTextview            = _DescTextview;
@synthesize LicencePlateview        = _LicencePlateview;
@synthesize LicencePlateTextview    = _LicencePlateTextview;
@synthesize Locationview            = _Locationview;
@synthesize AddPicview              = _AddPicview;
@synthesize AddVEhicledescview      = _AddVEhicledescview;
@synthesize FooterView              = _FooterView;
@synthesize Savebutton              = _Savebutton;
@synthesize Cancelbutton            = _Cancelbutton;
//@synthesize ADDIMAGEVIEW            = _ADDIMAGEVIEW;
@synthesize DYNAMICIMAGEVIEW        = _DYNAMICIMAGEVIEW;
@synthesize ImageScrollView         = _ImageScrollView;
@synthesize AVMake                  = _AVMake;
@synthesize AVModel                 = _AVModel;
@synthesize AVYear                  = _AVYear;
@synthesize AVUnch                  = _AVUnch;
@synthesize AddVScrollView          = _AddVScrollView;
@synthesize Makeview                =  _Makeview;
@synthesize Modelview               = _Modelview;
@synthesize Yearview                = _Yearview;
@synthesize Uniquecharacteristicsview = _Uniquecharacteristicsview;
@synthesize Processview             = _Processview;
@synthesize Maketextview            = _Maketextview;
@synthesize Modeltextview           = _Modeltextview;
@synthesize Yeartextview            = _Yeartextview;
@synthesize Uniquecharacteristicstextview = _Uniquecharacteristicstextview;
@synthesize MakeArray               = _MakeArray;
@synthesize ModelArray              = _ModelArray;
@synthesize YearArray               = _YearArray;
@synthesize UniqueArray             = _UniqueArray;
@synthesize AddVehicleDescView      = _AddVehicleDescView;
@synthesize isVehicleDescComplete   = _isVehicleDescComplete;
@synthesize isLicencePlateComplete  = _isLicencePlateComplete;
@synthesize isReportDescComplete    = _isReportDescComplete;
@synthesize isReportTitleComplete   = _isReportTitleComplete;
@synthesize isVehicleImageComplete  = _isVehicleImageComplete;
@synthesize isVehiclelocComplete    = _isVehiclelocComplete;
@synthesize MyLocation              = _MyLocation;
@synthesize ReportId                = _ReportId;
@synthesize Lattitude               = _Lattitude;
@synthesize Longitude               = _Longitude;
@synthesize LocationData            = _LocationData;
@synthesize ReportBadDriver         = _ReportBadDriver;
@synthesize UserDesiredlocationView = _UserDesiredlocationView;
@synthesize locationShow            = _locationShow;
@synthesize ImageVIew               = ImageVIew;
@synthesize DeleteButton            = DeleteButton;


int upoloadFirst = 223;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated
{
    
    //    _ImageShowview.frame=CGRectMake(0, 511, 320, 100);
    //    [self Makeframe:_ImageShowview];
    //
    //    [_UIScrollViewMain addSubview:_ImageShowview];
    //    NSLog(@"image uploadarry in viewdid appear :%d",[ImagemutArry count]);
    //    for (int i=1; i<=TotalUploadedImage; i++)
    //    {
    //        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10+(90*(i-1))+(10*(i-1)), 5, 90, 90)];
    //        [imageView setImage:[UIImage imageWithData:[ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",i]]]];
    //        [_imageShowinScroll addSubview:imageView];
    //        NSLog(@"chk in viewwwwwwwwdiddloaddd////");
    //    }
    //    [_imageShowinScroll setContentSize:CGSizeMake(TotalUploadedImage*110, 100)];
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
    //    _ImageShowview.frame=CGRectMake(0, 511, 320, 100);
    //    [self Makeframe:_ImageShowview];
    //
    //    [_UIScrollViewMain addSubview:_ImageShowview];
    //    NSLog(@"image uploadarry in viewdid appear :%d",[ImagemutArry count]);
    //    for (int i=1; i<=TotalUploadedImage; i++)
    //    {
    //        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10+(90*(i-1))+(10*(i-1)), 5, 90, 90)];
    //        [imageView setImage:[UIImage imageWithData:[ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",i]]]];
    //        [_imageShowinScroll addSubview:imageView];
    //        NSLog(@"chk in viewwwwwwwwdiddloaddd////");
    //    }
    //    [_imageShowinScroll setContentSize:CGSizeMake(TotalUploadedImage*110, 100)];
    
}


-(void)getLocationByLatLong
{
    @try
    {
        NSString *URLString=[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=false", _Lattitude, _Longitude];
        NSLog(@"the string url for the event:%@",URLString);
        NSData *getData=[NSData dataWithContentsOfURL:[NSURL URLWithString:URLString]];
        
        NSDictionary *Output=[NSJSONSerialization JSONObjectWithData:getData options:kNilOptions error:nil];
        
        NSArray *Result=[Output objectForKey:@"results"];
        NSDictionary *Dic1=[Result objectAtIndex:0];
        NSArray *address_components=[Dic1 objectForKey:@"address_components"];
        myAddress=[Dic1 valueForKey:@"formatted_address"];
        //myAddress   = @"Albertina Sisulu Road, Johannesburg 2000, South Africa";
        NSLog(@"my address:%@",myAddress);
        NSMutableArray *AddressArray=[[NSMutableArray alloc] initWithCapacity:3];
        
        for(NSDictionary *Dic2 in address_components)
        {
            NSArray *TypesArray=[Dic2 objectForKey:@"types"];
            if([(NSString *)[TypesArray objectAtIndex:0] isEqualToString:@"locality"] || [(NSString *)[TypesArray objectAtIndex:0] isEqualToString:@"administrative_area_level_1"])
            {
                [AddressArray addObject:[Dic2 objectForKey:@"long_name"]];
            }
            
        }
        NSString *NewAddress=[AddressArray componentsJoinedByString:@", "];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSUserDefaults *User=[[NSUserDefaults alloc] init];
            [User setValue:NewAddress forKey:@"location"];
            NSLog(@"the new address is:%@",NewAddress);
            [User synchronize];
            
        });
        
        //        else
        //        {
        //            NSInvocationOperation *Invoc=[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(getLocationByLatLong) object:nil];
        //            [operation addOperation:Invoc];
        //        }
    }
    @catch (NSException *juju)
    {
        NSLog(@"Reporting juju from getLocationByLatLong: %@", juju);
    }
}

-(CLLocationCoordinate2D) getLocation{
    
    _MyLocation = [[CLLocationManager alloc] init];
    _MyLocation.delegate = (id)self;
    _MyLocation.desiredAccuracy = kCLLocationAccuracyBest;
    _MyLocation.distanceFilter = kCLDistanceFilterNone;
    [_MyLocation startUpdatingLocation];
    CLLocation *location = [_MyLocation location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    return coordinate;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // defining uiscrollview property
    
    //    Helpobj = [HelperClass SaveVehicleDescDataForReport];
    
    
    FirstPosition = 0;
    upoloadFirst = 223;
    
    _locationShow.enabled = NO;
    
    _PriviewShow.frame = CGRectMake(0, 58, _PriviewShow.layer.frame.size.width, _PriviewShow.layer.frame.size.height);
    
    _ReportId = 0;
    Isreview=TRUE;
    PreviewData = FALSE;
    UserDesiredLocation = @"";
    
    MakeBackgroundOverlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    ImagemutArry=[[NSMutableArray alloc]init];
    operation=[[NSOperationQueue alloc]init];
    ReportBadDriver = [[HelperClass alloc] init];
    [self HideNavigationBar];
    [ReportBadDriver SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    [ReportBadDriver SetupHeaderViewForReport:self.view viewController:self];
    
    _ReportDataTableview.delegate = (id)self;
    _ReportDataTableview.dataSource = (id)self;
    
    TableviewDataArray = [[NSArray alloc] initWithObjects:@"Add Title",@"Add Description",@"Add License plate",@"Add Location",@"Add Picture",@"Add Vehicle Description", nil];
    
    TableviewImageArray = [[NSArray alloc] initWithObjects:@"public.png",@"car.png",@"sgn.png",@"comm.png",@"cam.png",@"car.png", nil];
    
    _isVehicleDescComplete = NO;
    _isLicencePlateComplete = NO;
    _isReportDescComplete = NO;
    _isReportTitleComplete = NO;
    _isVehicleImageComplete = NO;
    _isVehiclelocComplete = NO;
    self.photoAlert.hidden=YES;
    self.LocationAlert.hidden=YES;
    CLLocationCoordinate2D coordinate = [self getLocation];
    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    _Lattitude = latitude;
    _Longitude = longitude;
    
    NSInvocationOperation *operationLocation=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(getLocationByLatLong) object:nil];
    [operation addOperation:operationLocation];
    
    NSLog(@"*dLatitude : %@", latitude);
    NSLog(@"*dLongitude : %@",longitude);
    
    [self fetchdata];
    
    TotalUploadedImage = 0;
    
    ImageUploadedData = [[NSMutableDictionary alloc] init];
    
    [_UIScrollViewMain setDelegate:(id)self];
    [_UIScrollViewMain setScrollEnabled:YES];
    _UIScrollViewMain.userInteractionEnabled = YES;
    _UIScrollViewMain.showsVerticalScrollIndicator = YES;
    _UIScrollViewMain.scrollEnabled = YES;
    _UIScrollViewMain.backgroundColor = [UIColor clearColor];
    [_UIScrollViewMain setContentSize:CGSizeMake(self.view.frame.size.width,self.view.frame.size.height+340)];
    
    
    // Initialize reportbaddriver view
    
    _reportBaddriverView.frame = CGRectMake(0, 37, 320, 50);
    [self Makeframe:_reportBaddriverView];
    [_UIScrollViewMain addSubview:_reportBaddriverView];
    
    // Add report titleview in mainview
    
    _Titleview.frame = CGRectMake(0, 86, 320, 75);   //check
    [self Makeframe:_Titleview];
    _TitleTextview.returnKeyType = UIReturnKeyDone;
    _TitleTextview.delegate = (id)self;
    _TitleTextview.tag = 100;
    self.ViewForreview.layer.cornerRadius=4.0f;
    [_UIScrollViewMain addSubview:_Titleview];
    
    
    // Add report description view in mainview
    
    _Descriptionview.frame = CGRectMake(0, 162, 320, 138); //check
    [self Makeframe:_Descriptionview];
    _DescTextview.returnKeyType = UIReturnKeyDone;
    _DescTextview.delegate = (id)self;
    _DescTextview.tag = 101;
    _DescTextview.textColor = UIColorFromRGB(0xc5c5c5);
    [_UIScrollViewMain addSubview:_Descriptionview];
    
    // Add report LicencePlateview in mainview
    
    _LicencePlateview.frame = CGRectMake(0, 300, 320, 77);
    [self Makeframe:_LicencePlateview];
    _LicencePlateTextview.returnKeyType = UIReturnKeyDone;
    _LicencePlateTextview.delegate = (id)self;
    _LicencePlateTextview.tag = 102;
    [_UIScrollViewMain addSubview:_LicencePlateview];
    
    // Add report Locationview in mainview
    
    _Locationview.frame = CGRectMake(0, 378, 320, 81);
    UITapGestureRecognizer *LocationViewPinch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LocationTap:)];
    [_Locationview addGestureRecognizer:LocationViewPinch];
    [self Makeframe:_Locationview];
    [_UIScrollViewMain addSubview:_Locationview];
    
    // Add report AddPicview in mainview
    
    _AddPicview.frame = CGRectMake(0, 460, 320, 50);
    UITapGestureRecognizer *PicViewPinch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PicTap:)];
    [_AddPicview addGestureRecognizer:PicViewPinch];
    [self Makeframe:_AddPicview];
    [_UIScrollViewMain addSubview:_AddPicview];
    
    
    _ImageShowview.frame=CGRectMake(0, 511, 320, 88);
    [self Makeframe:_ImageShowview];
    [_UIScrollViewMain addSubview:_ImageShowview];
    _ImageShowview.hidden=YES;
    
    // Add report AddVEhicledescview in mainview
    
    //----------------------
    
    /*   _ImageShowview.frame=CGRectMake(0, 511, 320, 100);
     [self Makeframe:_ImageShowview];
     
     [_UIScrollViewMain addSubview:_ImageShowview];
     NSLog(@"image uploadarry:%d",[ImagemutArry count]);
     for (int i=1; i<=TotalUploadedImage; i++)
     {
     UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10+(90*(i-1))+(10*(i-1)), 5, 90, 90)];
     [imageView setImage:[UIImage imageWithData:[ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",i]]]];
     [_imageShowinScroll addSubview:imageView];
     NSLog(@"chk in viewwwwwwwwdiddloaddd////");
     }
     [_imageShowinScroll setContentSize:CGSizeMake(TotalUploadedImage*110, 100)];
     */
    
    
    
    _AddVEhicledescview.frame = CGRectMake(0, 511, 320, 50);
    UITapGestureRecognizer *VehicleDEtailsViewPinch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(VdetailsTap:)];
    [_AddVEhicledescview addGestureRecognizer:VehicleDEtailsViewPinch];
    [self Makeframe:_AddVEhicledescview];
    [_UIScrollViewMain addSubview:_AddVEhicledescview];
    
    
    /*    _AddVEhicledescview.frame = CGRectMake(0, 600, 320, 50);
     UITapGestureRecognizer *VehicleDEtailsViewPinch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(VdetailsTap:)];
     [_AddVEhicledescview addGestureRecognizer:VehicleDEtailsViewPinch];
     [self Makeframe:_AddVEhicledescview];
     [_UIScrollViewMain addSubview:_AddVEhicledescview];
     */
    
    currentTag = 0;
    
    [ReportBadDriver AddBlackOverlay:self.view xcord:0 ycord:0 width:self.view.frame.size.width height:self.view.frame.size.height backgroundColor:[UIColor blackColor] OpacitY:0.9f Text:@"Please wait" TextColor:[UIColor whiteColor] FontName:globalTEXTFIELDPLACEHOLDERFONT FontSize:18 IsTextEnabled:YES];
    
    [_AddVScrollView setDelegate:(id)self];
    [_AddVScrollView setScrollEnabled:YES];
    _AddVScrollView.userInteractionEnabled = YES;
    _AddVScrollView.showsVerticalScrollIndicator = YES;
    _AddVScrollView.scrollEnabled = YES;
    _AddVScrollView.backgroundColor = [UIColor clearColor];
    [_AddVScrollView setContentSize:CGSizeMake(self.view.frame.size.width,self.view.frame.size.height+250)];
    
    //_ADDIMAGEVIEW.frame = CGRectMake(0, 150, 320, 300);
    
    //_ADDIMAGEVIEW.frame = CGRectMake(0, 55, 320, 520);
    
    // [self Makeframe:_ADDIMAGEVIEW];
    //  _ADDIMAGEVIEW.hidden = YES;
    //[_UIScrollViewMain addSubview:_ADDIMAGEVIEW];
    //  [self.view addSubview:_ADDIMAGEVIEW];
    
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webdata setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webdata appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"NSURLConnection Error");
}
-(void)fetchdata
{
    NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
    [tempDict setObject:AUTOSUGGESSATIONMODE forKey:@"mode"];
    
    NSString *REturnedURL = [ReportBadDriver CallURLForServerReturn:tempDict URL:LOGINPAGE];
    NSLog(@"th value of url is:%@",REturnedURL);
    NSURL *url = [NSURL URLWithString:REturnedURL];
    NSURLRequest *restrict1 = [NSURLRequest requestWithURL:url];
    connection = [NSURLConnection connectionWithRequest:restrict1 delegate:self];
    if(connection)
    {
        webdata = [[NSMutableData alloc]init];
    }
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _MakeArray = [[NSMutableArray alloc] init];
    _ModelArray = [[NSMutableArray alloc] init];
    _YearArray = [[NSMutableArray alloc] init];
    _UniqueArray = [[NSMutableArray alloc] init];
    
    NSDictionary *allData = [NSJSONSerialization JSONObjectWithData:webdata options:0 error:nil];
    
    for(NSString *MakeData in [allData objectForKey:@"makelist"]) {
        [_MakeArray addObject:MakeData];
    }
    for(NSString *MakeData1 in [allData objectForKey:@"modellist"]) {
        [_ModelArray addObject:MakeData1];
    }
    for(NSString *MakeData2 in [allData objectForKey:@"yearlist"]) {
        [_YearArray addObject:MakeData2];
    }
    for(NSString *MakeData3 in [allData objectForKey:@"characteristicslist"]) {
        [_UniqueArray addObject:MakeData3];
    }
    
    [_Maketextview setAutocompleteWithDataSource:self
                                        delegate:self
                                       customize:^(ACEAutocompleteInputView *inputView) {
                                           inputView.font = [UIFont systemFontOfSize:20];
                                           inputView.textColor = [UIColor whiteColor];
                                           inputView.backgroundColor = [UIColor clearColor];
                                       }];
    
    [_Modeltextview setAutocompleteWithDataSource:self
                                         delegate:self
                                        customize:^(ACEAutocompleteInputView *inputView) {
                                            inputView.font = [UIFont systemFontOfSize:20];
                                            inputView.textColor = [UIColor whiteColor];
                                            inputView.backgroundColor = [UIColor clearColor];
                                        }];
    
    [_Yeartextview setAutocompleteWithDataSource:self
                                        delegate:self
                                       customize:^(ACEAutocompleteInputView *inputView) {
                                           inputView.font = [UIFont systemFontOfSize:20];
                                           inputView.textColor = [UIColor whiteColor];
                                           inputView.backgroundColor = [UIColor clearColor];
                                       }];
    
    [_Uniquecharacteristicstextview setAutocompleteWithDataSource:self
                                                         delegate:self
                                                        customize:^(ACEAutocompleteInputView *inputView) {
                                                            inputView.font = [UIFont systemFontOfSize:20];
                                                            inputView.textColor = [UIColor whiteColor];
                                                            inputView.backgroundColor = [UIColor clearColor];
                                                        }];
    
    _Maketextview.tag = 999;
    _Modeltextview.tag = 998;
    _Yeartextview.tag = 997;
    _Uniquecharacteristicstextview.tag = 996;
    currentTag = 999;
    
    _Makeview.frame = CGRectMake(0, 60, 320, 70);
    [self Makeframe:_Makeview];
    [_AddVScrollView addSubview:_Makeview];
    
    _Modelview.frame = CGRectMake(0, 131, 320, 70);
    [self Makeframe:_Modelview];
    [_AddVScrollView addSubview:_Modelview];
    
    _Yearview.frame = CGRectMake(0, 202, 320, 70);
    [self Makeframe:_Yearview];
    [_AddVScrollView addSubview:_Yearview];
    
    _Uniquecharacteristicsview.frame = CGRectMake(0, 273, 320, 78);
    [self Makeframe:_Uniquecharacteristicsview];
    [_AddVScrollView addSubview:_Uniquecharacteristicsview];
    
    _Processview.frame = CGRectMake(0, 392, 320, 50);
    _Processview.backgroundColor = [UIColor clearColor];
    [_AddVScrollView addSubview:_Processview];
    //[_AddVScrollView setScrollEnabled:NO];
    
    _AddVScrollView.contentSize = CGSizeMake(320, 720);
    
    _AddVehicleDescView.hidden = YES;
    [self.view addSubview:_AddVehicleDescView];
    
    [ReportBadDriver HidePopupView];
    
    //if (VehDetlObject.VehicleMake == (id)[NSNull null] || VehDetlObject.VehicleMake.length == 0 ) {
    _Maketextview.placeholder = @"Vehicle Make";
    //        [_Maketextview becomeFirstResponder];
    //    } else {
    //        [_Maketextview setText:VehDetlObject.VehicleMake];
    //    }
    
    //    if (VehDetlObject.VehicleModel == (id)[NSNull null] || VehDetlObject.VehicleModel.length == 0 )
    _Modeltextview.placeholder = @"Vehicle Model";
    //    else
    //        [_Modeltextview setText:VehDetlObject.VehicleModel];
    
    //if (VehDetlObject.VihicleYear == (id)[NSNull null] || VehDetlObject.VihicleYear.length == 0 )
    _Yeartextview.placeholder = @"Vehicle Year";
    //    else
    //        [_Yeartextview setText:VehDetlObject.VihicleYear];
    
    //    if (VehDetlObject.VehicleUnique == (id)[NSNull null] || VehDetlObject.VehicleUnique.length == 0 )
    _Uniquecharacteristicstextview.placeholder = @"Unique Characteristics";
    //    else
    //        [_Uniquecharacteristicstextview setText:VehDetlObject.VehicleUnique];
    
}
- (void)textField:(UITextField *)textField didSelectObject:(id)object inInputView:(ACEAutocompleteInputView *)inputView
{
    textField.text = object;
}
-(void)Makeframe :(UIView *)SubViewAdd {
    
    float cellHeight = SubViewAdd.frame.size.height;
    UILabel *greenLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, cellHeight-1, 95,1)];
    greenLabel.backgroundColor = UIColorFromRGB(0x1aad4b);
    [SubViewAdd addSubview:greenLabel];
    
    UILabel *yellowlabel = [[UILabel alloc] initWithFrame:CGRectMake(140, cellHeight-1, 90,1)];
    yellowlabel.backgroundColor = UIColorFromRGB(0xfcb714);
    [SubViewAdd addSubview:yellowlabel];
    
    UILabel *redlabel = [[UILabel alloc] initWithFrame:CGRectMake(210, cellHeight-1, 115,1)];
    redlabel.backgroundColor = UIColorFromRGB(0xde1d23);
    [SubViewAdd addSubview:redlabel];
    
}
-(IBAction)SaveUserDesireLoaction:(id)sender {
    
    // user desire location added for the service
    
    [_UserDesiredlocationView removeFromSuperview];
    [MakeBackgroundOverlayView removeFromSuperview];
    
    UserDesiredLocation = [ReportBadDriver CleanTextField:AddLocationTextView.text];
    
    AccessCustomLocation = YES;
    
    NSLog(@"UserDesiredLocation ---- %@",UserDesiredLocation);
    _locationShow.text=nil;
    _locationShow.text=UserDesiredLocation;
    
}
-(IBAction)CaneclUserDesireLoactionView:(id)sender {
    
    [_UserDesiredlocationView removeFromSuperview];
    [MakeBackgroundOverlayView removeFromSuperview];
}
-(void)LocationTap:(UIGestureRecognizer *)Gesture {
    
    UIAlertView *AddLocationAlertView = [[UIAlertView alloc] initWithTitle:@"Add Location" message:@"" delegate:self cancelButtonTitle:@"Device Location" otherButtonTitles:@"Enter Location", nil];
    [AddLocationAlertView setTag:9990];
    [AddLocationAlertView show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 9990) {
        
        if (buttonIndex == 0) {
            
            // check location is enable for this app or not for this app
            
            if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
                
                // location service is enabled for this app
                
                NSLog(@"Location Tap");
                CLLocationCoordinate2D coordinate = [self getLocation];
                NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
                NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
                _Lattitude = latitude;
                _Longitude = longitude;
                NSLog(@"*dLatitude : %@", latitude);
                NSLog(@"*dLongitude : %@",longitude);
                
                AccessMyLocation = YES;
                
                UIAlertView *LocationAlertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Your current location is %@",myAddress] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [LocationAlertView show];
                
                _locationShow.text = myAddress;     //check
                
            } else {
                
                // location service is not enabled for this app
                
                NSLog(@"Location is not enabled for this app, please go to device settings and enable location for this app");
                
                UIAlertView *LocationAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"Location is not enabled for this app, please go to device settings and enable location for this app" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [LocationAlertView show];
                
            }
            
        } else if (buttonIndex == 1) {
            
            // Give user access to upload his desired location
            
            [self.view addSubview:MakeBackgroundOverlayView];
            [MakeBackgroundOverlayView setBackgroundColor:[UIColor clearColor]];
            
            UIView *OverlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.layer.frame.size.width, self.view.frame.size.height)];
            [OverlayView.layer setOpacity:0.5f];
            [OverlayView setBackgroundColor:[UIColor blackColor]];
            [MakeBackgroundOverlayView addSubview:OverlayView];
            
            AddLocationTextView = (UITextView *)[_UserDesiredlocationView viewWithTag:9962];
            AddLocationTextView.text = nil;    //check
            [AddLocationTextView setBackgroundColor:[UIColor clearColor]];
            [AddLocationTextView setDelegate:self];
            [AddLocationTextView setUserInteractionEnabled:YES];
            [AddLocationTextView.layer setBorderColor:[UIColor darkGrayColor].CGColor];
            [AddLocationTextView.layer setBorderWidth:1.0f];
            [AddLocationTextView.layer setCornerRadius:4.0f];
            
            [_UserDesiredlocationView setFrame:CGRectMake(10, 100, _UserDesiredlocationView.frame.size.width, _UserDesiredlocationView.frame.size.height)];
            [MakeBackgroundOverlayView addSubview:_UserDesiredlocationView];
            [MakeBackgroundOverlayView bringSubviewToFront:_UserDesiredlocationView];
            
        }
    }
    
}

-(void)uploadPhotoFirst
{
    _ImageShowview.frame=CGRectMake(0, 511, 320, 100);
    [self Makeframe:_ImageShowview];
    
    [_UIScrollViewMain addSubview:_ImageShowview];
    NSLog(@"image uploadarry in viewdid appear :%d",[ImagemutArry count]);
    for (int i=1; i<=TotalUploadedImage; i++)
    {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10+(90*(i-1))+(10*(i-1)), 5, 90, 90)];
        [imageView setImage:[UIImage imageWithData:[ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",i]]]];
        [_imageShowinScroll addSubview:imageView];
        NSLog(@"chk in viewwwwwwwwdiddloaddd////");
    }
    [_imageShowinScroll setContentSize:CGSizeMake(TotalUploadedImage*110, 100)];
    
    
}

//-(void)PicTap:(UIGestureRecognizer *)Gesture {

-(void)PicTap:(UIGestureRecognizer *)Gesture
{
    [self textFieldDidBeginEditingone:0];
    //_ADDIMAGEVIEW.hidden = NO;
    
    // upoloadFirst = 223;
    //  FirstPosition = 0;
    
    
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"Chosse Your Option" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Snap", @"Choose  From Library", nil];
    
    [sheet showInView:self.view];
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = (id) self;
    picker.allowsEditing = YES;
    
    if (buttonIndex==0)
    {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                  message:@"Device has no camera"
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles: nil];
            
            [myAlertView show];
        }
        
        else
        {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.navigationController presentViewController:picker animated:YES completion:NULL];
        }
    }
    
    if (buttonIndex==1)
    {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.navigationController presentViewController:picker animated:YES completion:NULL];
    }
    
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [[picker presentingViewController] dismissViewControllerAnimated:YES completion:^{
        UIImage *image = info[UIImagePickerControllerEditedImage];
        
        //        UIImageView *ImageviewMain = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
        //        [ImageviewMain setImage:image];
        //        [_ImageScrollView addSubview:ImageviewMain];
        
        
        //   [self.imageShowinScroll setNeedsDisplay];
        
        UIGraphicsBeginImageContext(image.size);
        
        CGContextRef context=(UIGraphicsGetCurrentContext());
        
        if (image.imageOrientation == UIImageOrientationRight) {
            CGContextRotateCTM (context, 90/180*M_PI) ;
        } else if (image.imageOrientation == UIImageOrientationLeft) {
            CGContextRotateCTM (context, -90/180*M_PI);
        } else if (image.imageOrientation == UIImageOrientationDown) {
            // NOTHING
        } else if (image.imageOrientation == UIImageOrientationUp) {
            CGContextRotateCTM (context, 90/180*M_PI);
        }
        
        [image drawAtPoint:CGPointMake(0, 0)];
        UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        TotalUploadedImage +=1;
        
        //        UIImageView *ImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(FirstPosition, 0, 100, 100)];
        
        ImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(FirstPosition, 10, 65, 65)];
        
        ImageVIew.backgroundColor = [UIColor clearColor];
        ImageVIew.image = img;
        ImageVIew.userInteractionEnabled = YES;
        //        FirstPosition+= 105;
        
        FirstPosition+= 70;
        
        //        UIButton *DeleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 100-46, 46, 46)];
        
        DeleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 65-30, 30, 30)];
        
        DeleteButton.tag = 10000+TotalUploadedImage;
        ImageVIew.tag =DeleteButton.tag+9999999;
        [DeleteButton setBackgroundImage:[UIImage imageNamed:@"DELETE"] forState:UIControlStateNormal];
        [DeleteButton addTarget:self action:@selector(DeleteImage:) forControlEvents:UIControlEventTouchUpInside];
        [ImageVIew addSubview:DeleteButton];
        
        //[_ImageScrollView addSubview:ImageVIew];
        [_imageShowinScroll addSubview:ImageVIew];
        
        
        [ImageUploadedData setObject:UIImageJPEGRepresentation(image, 0.7) forKey:[NSString stringWithFormat:@"uploadedimage%d",TotalUploadedImage]];
        
        NSLog(@"chk image uploded data count %d", ImageUploadedData.count);
        
        NSLog(@"total uploaded image chkng %d", TotalUploadedImage);
        NSLog(@"total image uploaded data chkng %d", ImageUploadedData.count);
        
        NSMutableDictionary *new_dict = [[NSMutableDictionary alloc] init];
        [new_dict setObject:[NSString stringWithFormat:@"uploadedimage%d",TotalUploadedImage] forKey:@"imageurloftrending"];
        [new_dict setObject:UIImageJPEGRepresentation(image, 0.7) forKey:@"trendimage"];
        
        [defauldPusSign removeFromSuperview];
        
        
        defauldPusSign = [[UIImageView alloc] initWithFrame:CGRectMake(FirstPosition, 18, 45, 45)];
        
        defauldPusSign.backgroundColor = [UIColor clearColor];
        defauldPusSign.image = [UIImage imageNamed:@"plussign.png"];
        defauldPusSign.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *PicViewPinch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PicTap:)];
        
        [defauldPusSign addGestureRecognizer:PicViewPinch];
        
        [_imageShowinScroll addSubview:defauldPusSign];
        
        
        
        //        _ImageScrollView.contentSize = CGSizeMake(FirstPosition,100);
        //        _ImageScrollView.userInteractionEnabled = YES;
        //        _ImageScrollView.showsHorizontalScrollIndicator = YES;
        //        _ImageScrollView.showsVerticalScrollIndicator = YES;
        
        _imageShowinScroll.contentSize = CGSizeMake(FirstPosition+45,65);
        _imageShowinScroll.userInteractionEnabled = YES;
        _imageShowinScroll.showsHorizontalScrollIndicator = YES;
        _imageShowinScroll.showsVerticalScrollIndicator = YES;
        
        //        [ImagemutArry addObject:new_dict];
        
        [ImagemutArry addObject:ImageUploadedData];   //check ImageUploadedData
        
        
        
        
        if (upoloadFirst==223)
        {
            NSLog(@"in ifffffmm");
            _ImageShowview.hidden=NO;
            _AddVEhicledescview.frame = CGRectMake(0, 600, 320, 50);
            UITapGestureRecognizer *VehicleDEtailsViewPinch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(VdetailsTap:)];
            [_AddVEhicledescview addGestureRecognizer:VehicleDEtailsViewPinch];
            [self Makeframe:_AddVEhicledescview];
            [_UIScrollViewMain addSubview:_AddVEhicledescview];
        }
        
        else
        {
            NSLog(@"in ellss");
            _AddVEhicledescview.hidden=YES;
            _ImageShowview.hidden=NO;
            
            //_Makeview.frame = CGRectMake(0, 650, 320, 100);
            _Makeview.frame = CGRectMake(0, 564, 320, 70);
            [self Makeframe:_Makeview];
            [_PriviewScroll addSubview:_Makeview];
            
            //_Modelview.frame = CGRectMake(0, 750, 320, 100);
            _Modelview.frame = CGRectMake(0, 635, 320, 70);
            [self Makeframe:_Modelview];
            [_PriviewScroll addSubview:_Modelview];
            
            //_Yearview.frame = CGRectMake(0, 850, 320, 100);
            _Yearview.frame = CGRectMake(0, 705, 320, 70);
            [self Makeframe:_Yearview];
            [_PriviewScroll addSubview:_Yearview];
            
            //_Uniquecharacteristicsview.frame = CGRectMake(0, 950, 320, 100);
            _Uniquecharacteristicsview.frame = CGRectMake(0, 776, 320, 78);
            [self Makeframe:_Uniquecharacteristicsview];
            [_PriviewScroll addSubview:_Uniquecharacteristicsview];
            
            //_Processview.frame = CGRectMake(0, 550, 1000, 50);
            _Processview.frame = CGRectMake(0, 855, 320, 50);
            _Processview.backgroundColor = [UIColor clearColor];
            [_PriviewScroll addSubview:_Processview];
            
            //[_PriviewScroll setContentSize:CGSizeMake(320, 1200)];
            
            [_PriviewScroll setContentSize:CGSizeMake(320, 1140)];
        }
        
        
        //    if (ImageDelete == YES)
        //    {
        //        [_imageShowinScroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        //
        //        [ImageUploadedData setObject:UIImageJPEGRepresentation(image, 0.7) forKey:[NSString stringWithFormat:@"uploadedimage%d",TotalUploadedImage]];
        //
        //        for (int i=1; i<=TotalUploadedImage; i++)
        //        {
        ////            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10+(90*(i-1))+(10*(i-1)), 5, 90, 90)];
        //
        //            NSLog(@"total uploaded imge TotalUploadedImage is %d", TotalUploadedImage);
        //            NSLog(@"total dic isss   ImageUploadedData  %@",ImageUploadedData);
        //            NSLog(@"total dic lngthh ImageUploadedData.count isss %d",ImageUploadedData.count);
        //
        //            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake((70*(i-1)), 10, 65, 65)];
        //
        //            [imageView setImage:[UIImage imageWithData:[ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",i]]]];
        //
        //
        //
        //
        //            DeleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 65-30, 30, 30)];
        //            DeleteButton.tag = 10000+TotalUploadedImage;
        //            ImageVIew.tag =DeleteButton.tag+9999999;
        //            [DeleteButton setBackgroundImage:[UIImage imageNamed:@"DELETE"] forState:UIControlStateNormal];
        //            [DeleteButton addTarget:self action:@selector(DeleteImage:) forControlEvents:UIControlEventTouchUpInside];
        //
        //            DeleteButton.userInteractionEnabled = YES;
        //            [imageView addSubview:DeleteButton];
        //
        //            NSLog(@"chk dlt btn tag after aploding image %d", DeleteButton.tag);
        //
        //
        //            [_imageShowinScroll addSubview:imageView];
        //            NSLog(@"chk in viewwwwwwwwdiddloaddd////");
        //
        //
        //
        //
        //
        //            //NSData *imagedata = [ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",n+1]];
        //
        //            NSLog(@"element chkng...%@", [ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",i]]);
        //        }
        //
        //        [_imageShowinScroll setContentSize:CGSizeMake(TotalUploadedImage*110, 65)];
        //    }
        
    }];
}


-(IBAction)AddPicture:(id)sender {
    
    MBAlertView *destruct = [MBAlertView alertWithBody:@"Select my picture from" cancelTitle:@"Cancel" cancelBlock:nil];
    //destruct.imageView.image = [UIImage imageNamed:@"image.png"];
    [destruct addButtonWithText:@"Album" type:MBAlertViewItemTypeDestructive block:^{
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = (id)self;
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.allowsEditing = YES;
        //[self presentModalViewController:picker animated:YES];
        [self presentViewController:picker animated:YES completion:nil];
    }];
    [destruct addButtonWithText:@"Camera" type:MBAlertViewItemTypeDestructive block:^{
#if TARGET_IPHONE_SIMULATOR
        {
            MBAlertView *aler = [[MBAlertView alloc] init];
            aler = [MBAlertView alertWithBody:@"Device doesnot support camera,Select my picture from album?" cancelTitle:@"Cancel" cancelBlock:nil];
            [aler addButtonWithText:@"Yes" type:MBAlertViewItemTypeDestructive block:^{
                NSLog(@"Get Image From Album");
                UIImagePickerController * picker = [[UIImagePickerController alloc] init];
                picker.delegate = (id)self;
                picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                picker.allowsEditing = YES;
                [self presentViewController:picker animated:YES completion:nil];
                //[self presentModalViewController:picker animated:YES];
            }];
            [aler addToDisplayQueue];
        }
#else
        {
            UIImagePickerController * pickerone = [[UIImagePickerController alloc] init];
            pickerone.delegate = (id)self;
            pickerone.sourceType = UIImagePickerControllerSourceTypeCamera;
            pickerone.allowsEditing = YES;
            [self presentViewController:pickerone animated:YES completion:nil];
        }
#endif
    }];
    [destruct addToDisplayQueue];
    
}


-(void)DeleteImage:(id)sender {
    
    NSLog(@"dlt btn pressed");
    
    //ImageDelete = YES;
    
    if (ImageDelete == YES)
    {
        [[_imageShowinScroll viewWithTag:DeleteButton.tag] removeFromSuperview];
        NSLog(@"chk img positn---- %d", DeleteButton.tag);
        NSLog(@"in ifff");
    }
    
    else
    {
        
        [[_imageShowinScroll viewWithTag:[sender tag]+9999999] removeFromSuperview];
        NSLog(@"chk img positn---- %d", [sender tag]);
        NSLog(@"in elseee");
    }
    
    
    //    [[_imageShowinScroll viewWithTag:[sender tag]+9999999] removeFromSuperview];
    //    NSLog(@"chk img positn---- %d", [sender tag]);
    
    
    
    TotalUploadedImage = TotalUploadedImage -1;
    FirstPosition = FirstPosition-70;
    
    [ImageUploadedData removeObjectForKey:[NSString stringWithFormat:@"uploadedimage%d",(([sender tag]-10000))]];
    
    NSLog(@"chk img positn laterrrr---- %d", [sender tag]);
    NSLog(@"total uploaded image chkng %d", TotalUploadedImage);
    NSLog(@"total image uploaded data chkng %d", ImageUploadedData.count);
    NSLog(@"image uploadarry:%d",[ImagemutArry count]);
    [_imageShowinScroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int m=1; m<=[sender tag]-10000; m++)
    {
        ImageDelete = YES;
        
        NSLog(@"print m in for is %d", m);
        
        if (m == [sender tag]-10000)
        {
            NSLog(@"print m in first ifff  is %d", m);
            
            NSLog(@"in iffffkkk");
            
            for (int n=m; n<TotalUploadedImage+1; n++)
            {
                
                
                NSData *imagedata = [ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",n+1]];
                [ImageUploadedData setObject:imagedata forKey:[NSString stringWithFormat:@"uploadedimage%d",n]];
                
                ImageVIew =[[UIImageView alloc]initWithFrame:CGRectMake((70*(n-1)), 10, 65, 65)];
                
                [ImageVIew setImage:[UIImage imageWithData:imagedata]];
                ImageVIew.userInteractionEnabled=YES;
                
                
                DeleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 65-30, 30, 30)];
                DeleteButton.tag = 10000+n;
                ImageVIew.tag =DeleteButton.tag+9999999;
                
                [DeleteButton setBackgroundImage:[UIImage imageNamed:@"DELETE"] forState:UIControlStateNormal];
                [DeleteButton addTarget:self action:@selector(DeleteImage:) forControlEvents:UIControlEventTouchUpInside];
                
                [ImageVIew addSubview:DeleteButton];
                
                [_imageShowinScroll addSubview:ImageVIew];
                
                NSLog(@"chk dlt btn tag in fst fr loop %d", DeleteButton.tag);
                
                NSLog(@"element chkng in deleteee in fst fr lpp...%@", [ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",n]]);
            }
        }
        
        
        else
        {
            NSLog(@"in elseeee");
            
            NSData *imagedata = [ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",m]];
            
            ImageVIew =[[UIImageView alloc]initWithFrame:CGRectMake((70*(m-1)), 10, 65, 65)];
            
            [ImageVIew setImage:[UIImage imageWithData:imagedata]];
            ImageVIew.userInteractionEnabled=YES;
            
            DeleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 65-30, 30, 30)];
            
            NSLog(@"TotalUploadedImage is %d", TotalUploadedImage);
            
            DeleteButton.tag = 10000+m;
            ImageVIew.tag =DeleteButton.tag+9999999;
            [DeleteButton setBackgroundImage:[UIImage imageNamed:@"DELETE"] forState:UIControlStateNormal];
            [DeleteButton addTarget:self action:@selector(DeleteImage:) forControlEvents:UIControlEventTouchUpInside];
            
            [ImageVIew addSubview:DeleteButton];
            [_imageShowinScroll addSubview:ImageVIew];
            NSLog(@"chk dlt btn tag in 2nddd fr loop %d", DeleteButton.tag);
            
            
        }
        
        NSLog(@"chk in for looop image uploaddd data ImageUploadedData.count  isss %d", ImageUploadedData.count);
        // NSLog(@"chk in for looop image uploaddd  ImageUploadedData full %@", ImageUploadedData);
        NSLog(@"element chkng in deleteee...%@", [ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",m]]);
        
        
    }
    
    [defauldPusSign removeFromSuperview];
    defauldPusSign = [[UIImageView alloc] initWithFrame:CGRectMake(FirstPosition, 18, 45, 45)];
    defauldPusSign.backgroundColor = [UIColor clearColor];
    defauldPusSign.image = [UIImage imageNamed:@"plussign.png"];
    defauldPusSign.userInteractionEnabled = YES;
    UITapGestureRecognizer *PicViewPinch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PicTap:)];
    [defauldPusSign addGestureRecognizer:PicViewPinch];
    [_imageShowinScroll addSubview:defauldPusSign];
    
}
-(void)VdetailsTap:(UIGestureRecognizer *)Gesture {
    _AddVehicleDescView.hidden = NO;
}

- (void)textFieldDidEndEditing {
    [UIView animateWithDuration:.25 animations:^{
        _UIScrollViewMain.contentOffset = CGPointMake(0, 0);
    }];
}
- (void)textFieldDidBeginEditingone:(float)Dataval {
    [UIView animateWithDuration:.25 animations:^{
        _UIScrollViewMain.contentOffset = CGPointMake(0, Dataval);
    }];
}
- (void)textFieldDidEndEditingss {
    [UIView animateWithDuration:.25 animations:^{
        _AddVScrollView.contentOffset = CGPointMake(0, 0);
    }];
}
- (void)textFieldDidBeginEditingoness:(float)Dataval {
    [UIView animateWithDuration:.25 animations:^{
        _AddVScrollView.contentOffset = CGPointMake(0, Dataval);
    }];
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    switch (textView.tag)
    {
        case 100:
            if([ReportBadDriver CleanTextField:_TitleTextview.text].length == 0 || [[ReportBadDriver CleanTextField:_TitleTextview.text] isEqualToString:@"Add Title Here"]) {
                _TitleTextview.text = @"";
                _TitleTextview.textColor = [UIColor blackColor];
            }
            break;
        case 101:
            
            _DescTextview.text = @"";
            _DescTextview.textColor = [UIColor blackColor];
            [_AddDescriptionLbl setHidden:YES];
            [_UIScrollViewMain setContentOffset:CGPointMake(0, 40) animated:YES];
            
            break;
        case 102:
            if([ReportBadDriver CleanTextField:_LicencePlateTextview.text].length == 0 || [[ReportBadDriver CleanTextField:_LicencePlateTextview.text] isEqualToString:@"Add License plate Here"]) {
                _LicencePlateTextview.text = @"";
                _LicencePlateTextview.textColor = [UIColor blackColor];
                
            }
            [self textFieldDidBeginEditingone:120];
            break;
        default:
            break;
            
    }
    return YES;
    
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    
    return YES;
    
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    
    [_UIScrollViewMain setContentOffset:CGPointMake(0, 0) animated:YES];
    if (_DescTextview.text.length==0)
    {
        [_AddDescriptionLbl setHidden:NO];
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [_UIScrollViewMain setContentOffset:CGPointMake(0, 0) animated:YES];
    [textField resignFirstResponder];
    return NO;
}
#pragma mark -
#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    currentTag = textField.tag;
    switch (textField.tag) {
        case 996:
            [self textFieldDidBeginEditingoness:150];
            break;
        case 997:
            [self textFieldDidBeginEditingoness:100];
            break;
        case 11:
            [_UIScrollViewMain setContentOffset:CGPointMake(0, 130) animated:YES];
            break;
    }
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    switch (textField.tag) {
        case 996:
            [self textFieldDidEndEditingss];
            break;
        case 997:
            [self textFieldDidEndEditingss];
            break;
    }
    return YES;
}

#pragma mark - Autocomplete Data Source

- (NSUInteger)minimumCharactersToTrigger:(ACEAutocompleteInputView *)inputView
{
    return 1;
}
- (void)inputView:(ACEAutocompleteInputView *)inputView itemsFor:(NSString *)query result:(void (^)(NSArray *items))resultBlock;
{
    if (resultBlock != nil) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            NSMutableArray *data = [NSMutableArray array];
            
            NSMutableArray *SearchArray;
            [SearchArray removeAllObjects];
            NSLog(@"currentTag --- %d",currentTag);
            
            switch (currentTag) {
                case 999:
                    SearchArray = [NSMutableArray arrayWithArray:_MakeArray];
                    break;
                case 998:
                    SearchArray = [NSMutableArray arrayWithArray:_ModelArray];
                    break;
                case 997:
                    SearchArray = [NSMutableArray arrayWithArray:_YearArray];
                    break;
                case 996:
                    SearchArray = [NSMutableArray arrayWithArray:_UniqueArray];
                    break;
                default:
                    SearchArray = [NSMutableArray arrayWithArray:_MakeArray];
                    break;
            }
            //NSLog(@"SearchArray --- %@",SearchArray);
            for (NSString *string in SearchArray) {
                NSRange range = [string rangeOfString:query options:NSCaseInsensitiveSearch];
                if (range.location != NSNotFound)
                    [data addObject:string];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                resultBlock(data);
            });
        });
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
-(IBAction)CancelButtonClicked:(id)sender {
    _AddVehicleDescView.hidden = YES;
    _isVehicleDescComplete = NO;
}
-(IBAction)DoneButtonClicked:(id)sender {
    
    //    if(![ReportBadDriver CleanTextField:_Maketextview.text].length > 0) {
    //
    //        MBAlertView *alert = [MBAlertView alertWithBody:VIHICLEDESCMAKEERR cancelTitle:@"Cancel" cancelBlock:nil];
    //        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
    //            [_Maketextview becomeFirstResponder];
    //        }];
    //        [alert addToDisplayQueue];
    //        return;
    //
    //    } else if(![ReportBadDriver CleanTextField:_Modeltextview.text].length > 0) {
    //
    //        MBAlertView *alert = [MBAlertView alertWithBody:VIHICLEDESCMODELERR cancelTitle:@"Cancel" cancelBlock:nil];
    //        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
    //            [_Modeltextview becomeFirstResponder];
    //        }];
    //        [alert addToDisplayQueue];
    //        return;
    //
    //    } else if(![ReportBadDriver CleanTextField:_Yeartextview.text].length > 0) {
    //
    //        MBAlertView *alert = [MBAlertView alertWithBody:VIHICLEDESCYEARERR cancelTitle:@"Cancel" cancelBlock:nil];
    //        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
    //            [_Yeartextview becomeFirstResponder];
    //        }];
    //        [alert addToDisplayQueue];
    //        return;
    //
    //    } else if(![ReportBadDriver CleanTextField:_Uniquecharacteristicstextview.text].length > 0) {
    //
    //        MBAlertView *alert = [MBAlertView alertWithBody:VIHICLEDESCUQERR cancelTitle:@"Cancel" cancelBlock:nil];
    //        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
    //            [_Uniquecharacteristicstextview becomeFirstResponder];
    //        }];
    //        [alert addToDisplayQueue];
    //        return;
    //
    //    } else {
    _AddVehicleDescView.hidden = YES;
    _isVehicleDescComplete = YES;
    // }
    
}
//-(IBAction)ADDIMAGECancelButtonClicked:(id)sender {
//    _ADDIMAGEVIEW.hidden = YES;
//    _isVehicleImageComplete = NO;
//}

//-(IBAction)ADDIMAGEDoneButtonClicked:(id)sender {
//
//    NSLog(@"ADDIMAGEDoneButtonClicked-----");
//
//    _ADDIMAGEVIEW.hidden = YES;
//    _isVehicleImageComplete = YES;
//
//    NSLog(@"chk int valueee iss %d", upoloadFirst);
//
//    if (upoloadFirst == 223)
//    {
//        NSLog(@"i m in (upoloadFirst == 223)");
//
//        NSArray *SubviewArry=[_imageShowinScroll subviews];
//        for (UIView *imageview in SubviewArry)
//        {
//            [imageview removeFromSuperview];
//        }
//
//        [self uploadPhotoFirst];
//    }
//
//
//
//    if (Isreview==FALSE)
//    {
//         NSLog(@"i m in (uIsreview==FALSE)");
//
//        NSArray *SubviewArry=[_imageShowinScroll subviews];
//        for (UIView *imageview in SubviewArry)
//        {
//            [imageview removeFromSuperview];
//        }
//
//        if ([ImageUploadedData count]>0)
//        {
//            for (int i=1; i<=TotalUploadedImage; i++)
//            {
//                UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10+(90*(i-1))+(10*(i-1)), 5, 90, 90)];
//                [imageView setImage:[UIImage imageWithData:[ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",i]]]];
//                [_imageShowinScroll addSubview:imageView];
//            }
//            [_imageShowinScroll setContentSize:CGSizeMake(TotalUploadedImage*110, 100)];    //scroll is working
//        }
//        else
//        {
//             NSLog(@"i m in elseessssss...");
//
//            UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 80)];
//            lable.text=@"You will achieve 5 points for uploading photo.";
//            lable.textColor=[UIColor redColor];
//            lable.font=[UIFont fontWithName:@"Arail" size:15.0f];
//            lable.numberOfLines=1;
//            [_imageShowinScroll addSubview:lable];
//        }
//
//    }
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)UploadMyImage:(NSMutableDictionary *)ObjectReceiver
{
    @try
    {
        NSMutableDictionary *DataDictionary = [[NSMutableDictionary alloc] init];
        [DataDictionary setObject:[ObjectReceiver objectForKey:@"userid"] forKey:@"userid"];
        [DataDictionary setObject:[ObjectReceiver objectForKey:@"reportid"] forKey:@"reportid"];
        [DataDictionary setObject:@"upload_image" forKey:@"mode"];
        NSString *URLString = [ReportBadDriver CallURLForServerReturn:DataDictionary URL:@"pages/addreport.php"];
        
        NSLog(@"%@", URLString);
        
        NSData *ImageData=(NSData *)[ObjectReceiver objectForKey:@"photoimg"];
        NSURL* requestURL = [NSURL URLWithString:URLString];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        [request setHTTPShouldHandleCookies:NO];
        [request setURL:requestURL];
        [request setTimeoutInterval:30];
        [request setHTTPMethod:@"POST"];
        NSURLResponse *response = nil;
        NSError *error;
        NSString *boundary = [NSString stringWithFormat:@"%0.9u",arc4random()];
        
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"photoimg\"; filename=\".jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Type: image/png\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[NSData dataWithData:ImageData]];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setHTTPBody:body];
        
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",returnString);
        
        _ReportId = [returnString intValue];
        
        [self performSelectorOnMainThread:@selector(ResponseReceived) withObject:nil waitUntilDone:YES];
    }
    @catch (NSException *juju)
    {
        NSLog(@"Reporting juju from UploadMyImage %@", juju);
    }
}

#pragma mark for main Thread Segment

-(void)ResponseReceived
{
    
    ResponseCounter+=1;
    if(ResponseCounter == TotalUploadedImage) {
        NSLog(@"All data Uploaded successfully");
        [ReportBadDriver HidePopupView];
        AppDelegate *maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        // DashboardViewController *Dashboard = [[DashboardViewController alloc] init];
        // [maindelegate SetUpTabbarControllerwithcenterView:Dashboard];
        
        UserReportViewController *UserReport = [[UserReportViewController alloc] init];
        [maindelegate SetUpTabbarControllerwithcenterView:UserReport];
        
    }
}

-(IBAction)FinalSave:(id)sender {
    
    if(_DescTextview.text==(NSString *)[NSNull null]) {
        _DescTextview.text=@"";
    }
    if(_Modeltextview.text==(NSString *)[NSNull null]) {
        _Modeltextview.text=@"";
    }
    if([_Yeartextview.text isEqualToString:nil]) {
        _Yeartextview.text=@"";
    }
    if([_Uniquecharacteristicstextview.text isEqualToString:nil]) {
        _Uniquecharacteristicstextview.text=@"";
    }
    
    if (PreviewData  == FALSE) {
        
        NSLog(@"show the preview");
        // show the preview
        
        if (Isreview==TRUE)
        {
            NSLog(@"show the preview in (Isreview==TRUE)");
            
            Isreview = FALSE;
            PreviewData = TRUE;                    // Preview complete, set it for final save
            
            [_AddVehicleDescView setHidden:YES];
            
            _Processview.hidden=YES;
            
            [_reportBaddriverView removeFromSuperview];
            
            //_ReportBadDriver.frame = CGRectMake(0, 50, 320, 100);
            _ReportBadDriver.frame = CGRectMake(0, 0, 320, 50);
            [self Makeframe:_ReportBadDriver];
            [_PriviewScroll addSubview:_ReportBadDriver];
            
            //_Titleview.frame = CGRectMake(0, 100, 320, 100);
            _Titleview.frame = CGRectMake(0, 49, 320, 75);
            [self Makeframe:_Titleview];
            _Titellbl.text=@"Title";
            _TitleTextview.returnKeyType = UIReturnKeyDone;
            _TitleTextview.delegate = (id)self;
            _TitleTextview.tag = 100;
            [_PriviewScroll addSubview:_Titleview];
            
            self.ViewForreview.layer.cornerRadius=4.0f;
            
            if ([_DescTextview.text length ]>0) {
                _descriptionlbl.text=@"Description";
            }
            //_Descriptionview.frame = CGRectMake(0, 200, 320, 150);
            _Descriptionview.frame = CGRectMake(0, 125, 320, 138);
            
            [self Makeframe:_Descriptionview];
            _DescTextview.returnKeyType = UIReturnKeyDone;
            _DescTextview.delegate = (id)self;
            _DescTextview.tag = 101;
            
            _DescTextview.textColor = UIColorFromRGB(0xc5c5c5);
            [_PriviewScroll addSubview:_Descriptionview];
            
            //_LicencePlateview.frame = CGRectMake(0, 350, 320, 100);
            _LicencePlateview.frame = CGRectMake(0, 264, 320, 77);
            [self Makeframe:_LicencePlateview];
            _LicencePlateTextview.returnKeyType = UIReturnKeyDone;
            _LicencePlateTextview.delegate = (id)self;
            _LicencePlateTextview.tag = 102;
            [_PriviewScroll addSubview:_LicencePlateview];
            
            // Add report Locationview in mainview
            
            //_Locationview.frame = CGRectMake(0, 450, 320, 50);
            _Locationview.frame = CGRectMake(0, 342, 320, 81);
            UITapGestureRecognizer *LocationViewPinch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LocationTap:)];
            [_Locationview addGestureRecognizer:LocationViewPinch];
            [self Makeframe:_Locationview];
            [_PriviewScroll addSubview:_Locationview];
            
            if ([ImageUploadedData count]>0)
            {
                isAddreport=[NSString stringWithFormat:@"%d",1];
                [self.photoAlert setHidden:NO];
                [self.photoAlert setText:@"[You achieved 5 points for uploading photo.]"];
                self.photoAlert.textColor=UIColorFromRGB(0x1aad4b);
                
                
                //_AddPicview.frame = CGRectMake(0, 500, 320, 50);
                _AddPicview.frame = CGRectMake(0, 424, 320, 50);
                //                                 UITapGestureRecognizer *PicViewPinch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PicTap:)];
                //                                 [_AddPicview addGestureRecognizer:PicViewPinch];
                [self Makeframe:_AddPicview];
                [_PriviewScroll addSubview:_AddPicview];
                
                //problem hereee!!??
                
                _ImageShowview.frame=CGRectMake(0, 475, 320, 88);
                [self Makeframe:_ImageShowview];
                
                [_PriviewScroll addSubview:_ImageShowview];
                NSLog(@"image uploadarry:%d",[ImagemutArry count]);
                //                for (int i=1; i<=TotalUploadedImage; i++)
                //                {
                //                    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10+(90*(i-1))+(10*(i-1)), 5, 90, 90)];
                //                    [imageView setImage:[UIImage imageWithData:[ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",i]]]];
                //                    [_imageShowinScroll addSubview:imageView];
                //                    NSLog(@"chk////");
                //                }
                [_imageShowinScroll setContentSize:CGSizeMake(TotalUploadedImage*110, 65)];
                
                NSLog(@"makeview in 3rd");
                
                //_Makeview.frame = CGRectMake(0, 650, 320, 100);
                _Makeview.frame = CGRectMake(0, 564, 320, 70);
                [self Makeframe:_Makeview];
                [_PriviewScroll addSubview:_Makeview];
                
                //_Modelview.frame = CGRectMake(0, 750, 320, 100);
                _Modelview.frame = CGRectMake(0, 635, 320, 70);
                [self Makeframe:_Modelview];
                [_PriviewScroll addSubview:_Modelview];
                
                //_Yearview.frame = CGRectMake(0, 850, 320, 100);
                _Yearview.frame = CGRectMake(0, 705, 320, 70);
                [self Makeframe:_Yearview];
                [_PriviewScroll addSubview:_Yearview];
                
                //_Uniquecharacteristicsview.frame = CGRectMake(0, 950, 320, 100);
                _Uniquecharacteristicsview.frame = CGRectMake(0, 776, 320, 78);
                [self Makeframe:_Uniquecharacteristicsview];
                [_PriviewScroll addSubview:_Uniquecharacteristicsview];
                
                //_Processview.frame = CGRectMake(0, 550, 1000, 50);
                _Processview.frame = CGRectMake(0, 855, 320, 50);
                _Processview.backgroundColor = [UIColor clearColor];
                [_PriviewScroll addSubview:_Processview];
                
                //[_PriviewScroll setContentSize:CGSizeMake(320, 1200)];
                
                [_PriviewScroll setContentSize:CGSizeMake(320, 1140)];
                
                PreviewData = TRUE;
                
            }
            else
            {
                upoloadFirst = 0;
                _AddVEhicledescview.hidden=YES;
                
                NSLog(@"show the preview in elseeeeeess");
                
                isAddreport=[NSString stringWithFormat:@"%d",0];
                _AddPicview.frame = CGRectMake(0, 424, 320, 50);
                [self.photoAlert setHidden:NO];
                [self.photoAlert setText:@"[You will achieve 5 points for uploading photo.]"];
                self.photoAlert.textColor=[UIColor redColor];
                [self Makeframe:_AddPicview];
                // _AddPicview.hidden = YES;
                [_PriviewScroll addSubview:_AddPicview];
                
                
                _ImageShowview.frame=CGRectMake(0, 475, 320, 88);
                [self Makeframe:_ImageShowview];
                
                [_PriviewScroll addSubview:_ImageShowview];
                NSLog(@"image uploadarry:%d",[ImagemutArry count]);
                //                for (int i=1; i<=TotalUploadedImage; i++)
                //                {
                //                    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10+(90*(i-1))+(10*(i-1)), 5, 90, 90)];
                //                    [imageView setImage:[UIImage imageWithData:[ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",i]]]];
                //                    [_imageShowinScroll addSubview:imageView];
                //                }
                [_imageShowinScroll setContentSize:CGSizeMake(TotalUploadedImage*110, 65)];
                
                
                
                NSLog(@"makeview in 4th");
                
                //                _Makeview.frame = CGRectMake(0, 576, 320, 70);
                //                [self Makeframe:_Makeview];
                //                [_PriviewScroll addSubview:_Makeview];
                //                //_Makeview.hidden = YES;
                //
                //                _Modelview.frame = CGRectMake(0, 647, 320, 70);
                //                [self Makeframe:_Modelview];
                //                [_PriviewScroll addSubview:_Modelview];
                //
                //                _Yearview.frame = CGRectMake(0, 718, 320, 70);
                //                [self Makeframe:_Yearview];
                //                [_PriviewScroll addSubview:_Yearview];
                //
                //                _Uniquecharacteristicsview.frame = CGRectMake(0, 789, 320, 78);
                //                [self Makeframe:_Uniquecharacteristicsview];
                //                [_PriviewScroll addSubview:_Uniquecharacteristicsview];
                //
                //                _Processview.frame = CGRectMake(0, 868, 900, 50);
                //                _Processview.backgroundColor = [UIColor clearColor];
                //                [_PriviewScroll addSubview:_Processview];
                //
                //                [_PriviewScroll setContentSize:CGSizeMake(320, 1145)];
                
                
                
                
                _Makeview.frame = CGRectMake(0, 475, 320, 70);
                [self Makeframe:_Makeview];
                [_PriviewScroll addSubview:_Makeview];
                //_Makeview.hidden = YES;
                
                _Modelview.frame = CGRectMake(0, 546, 320, 70);
                [self Makeframe:_Modelview];
                [_PriviewScroll addSubview:_Modelview];
                
                _Yearview.frame = CGRectMake(0, 617, 320, 70);
                [self Makeframe:_Yearview];
                [_PriviewScroll addSubview:_Yearview];
                
                _Uniquecharacteristicsview.frame = CGRectMake(0, 688, 320, 78);
                [self Makeframe:_Uniquecharacteristicsview];
                [_PriviewScroll addSubview:_Uniquecharacteristicsview];
                
                _Processview.frame = CGRectMake(0, 767, 900, 50);
                _Processview.backgroundColor = [UIColor clearColor];
                [_PriviewScroll addSubview:_Processview];
                
                [_PriviewScroll setContentSize:CGSizeMake(320, 1045)];
                
                
                
            }
            [self.view addSubview:_PriviewShow];
            
        }
        //_ADDIMAGEVIEW.frame = CGRectMake(0, 50, 320, 300);
        
        //        _ADDIMAGEVIEW.frame = CGRectMake(0, 0, 320, 520);
        //        [self Makeframe:_ADDIMAGEVIEW];
        //        _ADDIMAGEVIEW.hidden = YES;
        //        [self.PriviewShow addSubview:_ADDIMAGEVIEW];
        //        //[_PriviewScroll addSubview:_ADDIMAGEVIEW];
        //        _AddVEhicledescview.hidden=YES;
        
    } else {
        
        // 0.000000
        
        NSString *ModifiedLocation      = @" ";
        NSString *Modifiedlatitude      = @"0.000000";
        NSString *Modifiedlongitude     = @"0.000000";
        
        // if myaddress is nil, set veriable as blank
        
        if ((myAddress == nil) || ([ReportBadDriver CleanTextField:myAddress].length>0) || (myAddress == (NSString *)[NSNull null]))
            myAddress = @" ";
        
        if (AccessCustomLocation) {
            
            // Accessing custom location provided by user
            
            ModifiedLocation    = UserDesiredLocation;
        }
        
        if (AccessMyLocation) {
            
            // Accessing user device location
            
            ModifiedLocation    = myAddress;
            Modifiedlatitude    = _Lattitude;
            Modifiedlongitude   = _Longitude;
        }
        
        
        ObjectCarrier=[[NSMutableDictionary alloc] init];
        NSLog(@"The sccond selector call:");
        
        [ObjectCarrier setObject:[ReportBadDriver CleanTextField:_TitleTextview.text] forKey:@"add_title"];
        [ObjectCarrier setObject:[ReportBadDriver CleanTextField:_DescTextview.text] forKey:@"add_desc"];
        [ObjectCarrier setObject:[ReportBadDriver CleanTextField:_LicencePlateTextview.text] forKey:@"licence_plate"];
        [ObjectCarrier setObject:ModifiedLocation forKey:@"location"];
        [ObjectCarrier setObject:Modifiedlatitude forKey:@"latitude"];
        [ObjectCarrier setObject:Modifiedlongitude forKey:@"longitude"];
        
        //        [ObjectCarrier setObject:myAddress forKey:@"location"];
        //        [ObjectCarrier setObject:_Lattitude forKey:@"latitude"];
        //        [ObjectCarrier setObject:_Longitude forKey:@"longitude"];
        
        [ObjectCarrier setObject:[ReportBadDriver CleanTextField:_Maketextview.text] forKey:@"make"];
        [ObjectCarrier setObject:[ReportBadDriver CleanTextField:_Modeltextview.text] forKey:@"model"];
        [ObjectCarrier setObject:[ReportBadDriver CleanTextField:_Yeartextview.text] forKey:@"year"];
        [ObjectCarrier setObject:[ReportBadDriver CleanTextField:_Uniquecharacteristicstextview.text] forKey:@"characteristics"];
        [ObjectCarrier setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"] forKey:@"userid"];
        [ObjectCarrier setObject:@"create_report" forKey:@"mode"];
        [self SubmitReviewData];
    }
}
-(IBAction)Previewdata:(id)sender {
    
    upoloadFirst=0;
    NSLog(@"chk int value is %d", upoloadFirst);
    
    NSLog(@"myAddress -------- %@",myAddress);
    if (![ReportBadDriver CleanTextField:_TitleTextview.text].length>0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter a Valid Title" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    } else if (![ReportBadDriver CleanTextField:_LicencePlateTextview.text].length>0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Licence Plate" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        [self FinalSave:nil];
    }
    //    else if ((myAddress == nil) || ([ReportBadDriver CleanTextField:myAddress].length>0) || (myAddress == (NSString *)[NSNull null])) {
    //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Your Location" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    //        [alert show];
    //    }
}
-(IBAction)FinalCancel:(id)sender
{
    
    MBAlertView *alert = [MBAlertView alertWithBody:@"Are You Sure To Cancel This Report?" cancelTitle:@"No" cancelBlock:nil];
    [alert addButtonWithText:@"Yes" type:MBAlertViewItemTypePositive block:^{
        _isVehicleDescComplete = NO;
        _isLicencePlateComplete = NO;
        _isReportDescComplete = NO;
        _isReportTitleComplete = NO;
        _isVehicleImageComplete = NO;
        _isVehiclelocComplete = NO;
        AppDelegate *maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        DashboardViewController *Dashboard = [[DashboardViewController alloc] init];
        [maindelegate SetUpTabbarControllerwithcenterView:Dashboard];
    }];
    [alert addToDisplayQueue];
    return;
}

- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

- (void)rightSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{}];
}
-(void)HideNavigationBar {
    [self.navigationController setNavigationBarHidden:YES];
}

-(NSString *)deviceLocation {
    
    NSString *theLocation = [NSString stringWithFormat:@"latitude: %f longitude: %f",_MyLocation.location.coordinate.latitude,_MyLocation.location.coordinate.longitude];
    return theLocation;
    
}

-(UIView *)prepareToOpenPopupInView:(UIView *)screenView
{
    
    UIView *overlayView=[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [screenView frame].size.width, [screenView frame].size.height)];
    [overlayView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"popup_shadow.png"]]];
    [overlayView setAlpha:0.0f];
    [screenView addSubview:overlayView];
    
    [UIView animateWithDuration:0.4f animations:^{
        
        [overlayView setAlpha:1.0f];
    }];
    
    return overlayView;
}

- (void)SubmitReviewData
{
    //[PopUp removeFromSuperview];
    
    [ReportBadDriver AddBlackOverlay:self.view xcord:0 ycord:0 width:self.view.frame.size.width height:self.view.frame.size.height backgroundColor:[UIColor blackColor] OpacitY:0.9f Text:@"Please wait" TextColor:[UIColor whiteColor] FontName:globalTEXTFIELDPLACEHOLDERFONT FontSize:18 IsTextEnabled:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                   {
                       
                       NSString *URLString = [ReportBadDriver CallURLForServerReturn:ObjectCarrier URL:@"pages/addreport.php"];
                       NSLog(@"URLString ----- %@",URLString);
                       
                       NSData *dataURL =  [NSData dataWithContentsOfURL: [ NSURL URLWithString: URLString ]];
                       NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSUTF8StringEncoding];
                       NSLog(@"the servrer out put:%@",serverOutput);
                       
                       _ReportId = [serverOutput intValue];
                       
                       
                       if ([ImageUploadedData count]>0)
                       {
                           
                           NSOperationQueue *OperationQueue = [NSOperationQueue new];
                           NSInvocationOperation *UploadOperation;
                           for(int ISX = 1; ISX <= [ImageUploadedData count]; ISX++)
                           {
                               
                               NSData *imagedata = [ImageUploadedData objectForKey:[NSString stringWithFormat:@"uploadedimage%d",ISX]];
                               
                               
                               
                               NSMutableDictionary *ObjectCarrierforuserid=[[NSMutableDictionary alloc] init];
                               [ObjectCarrierforuserid setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"] forKey:@"userid"];
                               [ObjectCarrierforuserid setObject:[NSString stringWithFormat:@"%d",_ReportId] forKey:@"reportid"];
                               
                               [ObjectCarrierforuserid setObject:imagedata forKey:@"photoimg"];
                               [ImagemutArry addObject:imagedata];
                               
                               
                               UploadOperation=[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(UploadMyImage:) object:ObjectCarrierforuserid];
                               [OperationQueue addOperation:UploadOperation];
                               
                           }
                       }
                       else
                       {
                           dispatch_async(dispatch_get_main_queue(), ^{
                               NSLog(@"tab bar");
                               [ReportBadDriver HidePopupView];
                               AppDelegate *maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                               DashboardViewController *Dashboard = [[DashboardViewController alloc] init];
                               [maindelegate SetUpTabbarControllerwithcenterView:Dashboard];
                               
                           });
                       }
                       
                       
                   });
    
    
}
- (IBAction)ResetreViewdata:(id)sender
{
    [PopUp removeFromSuperview];
}
//-(void)textFieldDidBeginEditing:(UITextField *)textField  {
//   
//        [UIView animateWithDuration:2.0 animations:^{
//            [_UIScrollViewMain setContentOffset:CGPointMake(0, 200) animated:YES];
//        }];
//
//    
//}
//-(void)textFieldDidEndEditing:(UITextField *)textField {
//    [UIView animateWithDuration:2.0 animations:^{
//        [_UIScrollViewMain setContentOffset:CGPointMake(0, 0) animated:YES];
//    }];
//}
-(IBAction)Scrolltoup:(id)sender {
    [UIView animateWithDuration:2.0 animations:^{
        [_UIScrollViewMain setContentOffset:CGPointMake(0, 200) animated:YES];
    }];
    
}


@end

