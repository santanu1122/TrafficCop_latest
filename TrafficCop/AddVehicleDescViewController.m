//
//  AddVehicleDescViewController.m
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 21/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import "AddVehicleDescViewController.h"
#import "HelperClass.h"
#import "MFSideMenu.h"
#import <QuartzCore/QuartzCore.h>
#import "ACEAutocompleteBar.h"
#import "MBHUDView.h"
#import "ReportBadDriverViewController.h"
#import "AppDelegate.h"

@interface AddVehicleDescViewController ()<ACEAutocompleteDataSource, ACEAutocompleteDelegate,UITextFieldDelegate> {
    HelperClass *AddvehicleHelper;
    int currentTag;
    NSMutableData* webdata;
    NSURLConnection *connection;
    HelperClass *VehDetlObject;
}

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

@property (nonatomic, strong) NSMutableArray *MakeArray;
@property (nonatomic, strong) NSMutableArray *ModelArray;
@property (nonatomic, strong) NSMutableArray *YearArray;
@property (nonatomic, strong) NSMutableArray *UniqueArray;

-(IBAction)CancelButtonClicked:(id)sender;
-(IBAction)DoneButtonClicked:(id)sender;

@end

@implementation AddVehicleDescViewController
@synthesize AddVScrollView = _AddVScrollView;
@synthesize Makeview =  _Makeview;
@synthesize Modelview = _Modelview;
@synthesize Yearview = _Yearview;
@synthesize Uniquecharacteristicsview = _Uniquecharacteristicsview;
@synthesize Processview = _Processview;
@synthesize Maketextview = _Maketextview;
@synthesize Modeltextview = _Modeltextview;
@synthesize Yeartextview = _Yeartextview;
@synthesize Uniquecharacteristicstextview = _Uniquecharacteristicstextview;
@synthesize MakeArray = _MakeArray;
@synthesize ModelArray = _ModelArray;
@synthesize YearArray = _YearArray;
@synthesize UniqueArray = _UniqueArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    [self fetchdata];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AddvehicleHelper = [[HelperClass alloc] init];
    VehDetlObject = [HelperClass SaveVehicleDescDataForReport];
    
    currentTag = 0;
    
    [AddvehicleHelper AddBlackOverlay:self.view xcord:0 ycord:0 width:self.view.frame.size.width height:self.view.frame.size.height backgroundColor:[UIColor blackColor] OpacitY:0.9f Text:@"Please wait" TextColor:[UIColor whiteColor] FontName:globalTEXTFIELDPLACEHOLDERFONT FontSize:18 IsTextEnabled:YES];
    
    [self HideNavigationBar];
    [AddvehicleHelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    [AddvehicleHelper SetupHeaderView:self.view viewController:self];
    
    [_AddVScrollView setDelegate:(id)self];
    [_AddVScrollView setScrollEnabled:YES];
    _AddVScrollView.userInteractionEnabled = YES;
    _AddVScrollView.showsVerticalScrollIndicator = YES;
    _AddVScrollView.scrollEnabled = YES;
    _AddVScrollView.backgroundColor = [UIColor clearColor];
    [_AddVScrollView setContentSize:CGSizeMake(self.view.frame.size.width,self.view.frame.size.height+250)];
    
    
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
    NSLog(@"Error");
}
-(void)fetchdata
{
    NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
    [tempDict setObject:AUTOSUGGESSATIONMODE forKey:@"mode"];
    
    NSString *REturnedURL = [AddvehicleHelper CallURLForServerReturn:tempDict URL:LOGINPAGE];
    
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
    
    _Makeview.frame = CGRectMake(0, 50, 320, 100);
    [self Makeframe:_Makeview];
    [_AddVScrollView addSubview:_Makeview];
    
    _Modelview.frame = CGRectMake(0, 150, 320, 100);
    [self Makeframe:_Modelview];
    [_AddVScrollView addSubview:_Modelview];
    
    _Yearview.frame = CGRectMake(0, 250, 320, 100);
    [self Makeframe:_Yearview];
    [_AddVScrollView addSubview:_Yearview];
    
    _Uniquecharacteristicsview.frame = CGRectMake(0, 350, 320, 100);
    [self Makeframe:_Uniquecharacteristicsview];
    [_AddVScrollView addSubview:_Uniquecharacteristicsview];
    
    _Processview.frame = CGRectMake(0, 500, 320, 50);
    _Processview.backgroundColor = [UIColor clearColor];
    [_AddVScrollView addSubview:_Processview];
    
    [AddvehicleHelper HidePopupView];
    
    if (VehDetlObject.VehicleMake == (id)[NSNull null] || VehDetlObject.VehicleMake.length == 0 ) {
        _Maketextview.placeholder = @"Vehivle Make";
        [_Maketextview becomeFirstResponder];
    } else {
        [_Maketextview setText:VehDetlObject.VehicleMake];
    }
    
    if (VehDetlObject.VehicleModel == (id)[NSNull null] || VehDetlObject.VehicleModel.length == 0 )
        _Modeltextview.placeholder = @"Vehivle Model";
    else
        [_Modeltextview setText:VehDetlObject.VehicleModel];
    
    if (VehDetlObject.VihicleYear == (id)[NSNull null] || VehDetlObject.VihicleYear.length == 0 )
        _Yeartextview.placeholder = @"Vehivle Year";
    else
        [_Yeartextview setText:VehDetlObject.VihicleYear];
    
    if (VehDetlObject.VehicleUnique == (id)[NSNull null] || VehDetlObject.VehicleUnique.length == 0 )
        _Uniquecharacteristicstextview.placeholder = @"Vehivle Model";
    else
        [_Uniquecharacteristicstextview setText:VehDetlObject.VehicleUnique];
    
}
#pragma mark - Autocomplete Delegate

- (void)textField:(UITextField *)textField didSelectObject:(id)object inInputView:(ACEAutocompleteInputView *)inputView
{
    textField.text = object;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
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
            [self textFieldDidBeginEditingone:150];
            break;
        case 997:
            [self textFieldDidBeginEditingone:100];
            break;
    }
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
   // currentTag = 0;
    switch (textField.tag) {
        case 996:
            [self textFieldDidEndEditing];
            break;
        case 997:
            [self textFieldDidEndEditing];
            break;
    }
    return YES;
}

#pragma mark - Autocomplete Data Source

- (NSUInteger)minimumCharactersToTrigger:(ACEAutocompleteInputView *)inputView
{
    return 1;
}
- (void)textFieldDidEndEditing {
    [UIView animateWithDuration:.25 animations:^{
        _AddVScrollView.contentOffset = CGPointMake(0, 0);
    }];
}
- (void)textFieldDidBeginEditingone:(float)Dataval {
    [UIView animateWithDuration:.25 animations:^{
        _AddVScrollView.contentOffset = CGPointMake(0, Dataval);
    }];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(IBAction)CancelButtonClicked:(id)sender {
    
    VehDetlObject.VehicleMake = @"";
    VehDetlObject.VehicleModel = @"";
    VehDetlObject.VihicleYear = @"";
    VehDetlObject.VehicleUnique = @"";
    VehDetlObject.isVehicleDescComplete = NO;
    
    AppDelegate *Maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    ReportBadDriverViewController *ReportBad = [[ReportBadDriverViewController alloc] init];
    [Maindelegate SetUpTabbarControllerwithcenterView:ReportBad];
    
}
-(IBAction)DoneButtonClicked:(id)sender {
    
    if(![AddvehicleHelper CleanTextField:_Maketextview.text].length > 0) {
        
        MBAlertView *alert = [MBAlertView alertWithBody:USERNAMEBLANKERR cancelTitle:@"Cancel" cancelBlock:nil];
        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
            [_Maketextview becomeFirstResponder];
        }];
        [alert addToDisplayQueue];
        return;
        
    } else if(![AddvehicleHelper CleanTextField:_Modeltextview.text].length > 0) {
        
        MBAlertView *alert = [MBAlertView alertWithBody:USERNAMEBLANKERR cancelTitle:@"Cancel" cancelBlock:nil];
        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
            [_Modeltextview becomeFirstResponder];
        }];
        [alert addToDisplayQueue];
        return;
        
    } else if(![AddvehicleHelper CleanTextField:_Yeartextview.text].length > 0) {
        
        MBAlertView *alert = [MBAlertView alertWithBody:USERNAMEBLANKERR cancelTitle:@"Cancel" cancelBlock:nil];
        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
            [_Yeartextview becomeFirstResponder];
        }];
        [alert addToDisplayQueue];
        return;
        
    } else if(![AddvehicleHelper CleanTextField:_Uniquecharacteristicstextview.text].length > 0) {
        
        MBAlertView *alert = [MBAlertView alertWithBody:USERNAMEBLANKERR cancelTitle:@"Cancel" cancelBlock:nil];
        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
            [_Uniquecharacteristicstextview becomeFirstResponder];
        }];
        [alert addToDisplayQueue];
        return;
        
    } else {
        
        VehDetlObject.VehicleMake = [AddvehicleHelper CleanTextField:_Maketextview.text];
        VehDetlObject.VehicleModel = [AddvehicleHelper CleanTextField:_Modeltextview.text];
        VehDetlObject.VihicleYear = [AddvehicleHelper CleanTextField:_Yeartextview.text];
        VehDetlObject.VehicleUnique = [AddvehicleHelper CleanTextField:_Uniquecharacteristicstextview.text];
        VehDetlObject.isVehicleDescComplete = YES;
        
        AppDelegate *Maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        ReportBadDriverViewController *ReportBad = [[ReportBadDriverViewController alloc] init];
        [Maindelegate SetUpTabbarControllerwithcenterView:ReportBad];
        
    }
    
}
@end
