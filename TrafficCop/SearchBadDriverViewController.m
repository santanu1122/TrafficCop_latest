//
//  SearchBadDriverViewController.m
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 06/12/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import "SearchBadDriverViewController.h"
#import "HelperClass.h"
#import "SegmentedControl.h"
#import "MBHUDView.h"
#import "ZSImageView.h"
#import "MFSideMenu.h"
#import "AppDelegate.h"
#import "ReportDetailsViewController.h"

typedef enum {
    SearcTypeNone,
    LocationBaseSearch,
    LicencePlateBaseSearch,
    VehicleDeatilsBaseSearch,
} BadadriverSearchType;

@interface SearchBadDriverViewController () {
    HelperClass *SearchBadDriverHelper;
    SegmentedControl *DetailsTabbing;
    NSMutableArray *SearchResultDataArray;
}

@property (nonatomic, assign) BadadriverSearchType SearchType;
@property (nonatomic,retain) IBOutlet UITableView *SearchResultTableView;
@property (nonatomic,retain) IBOutlet UIView *SearchNoResult;
@property (nonatomic,retain) IBOutlet UIView *SearchResultView;
@property (nonatomic, retain) IBOutlet UISearchBar *UIsearchBarTap;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *UIloadingData;

@end

@implementation SearchBadDriverViewController

@synthesize SearchType                      = _SearchType;
@synthesize SearchResultTableView           = _SearchResultTableView;
@synthesize SearchNoResult                  = _SearchNoResult;
@synthesize SearchResultView                = _SearchResultView;
@synthesize UIsearchBarTap                  = _UIsearchBarTap;
@synthesize UIloadingData                   = _UIloadingData;

int NumberOfPages = 1;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    SearchBadDriverHelper = [[HelperClass alloc] init];
    [self HideNavigationBar];
    [SearchBadDriverHelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    [SearchBadDriverHelper SetupHeaderView:self.view viewController:self];
    
//    DetailsTabbing = [[SegmentedControl alloc] initWithSectionTitles:@[@"Location", @"Licence Plate", @"Vehicle Details"]];
//    DetailsTabbing.font = [UIFont fontWithName:@"Arial" size:14];
//    DetailsTabbing.frame = CGRectMake(2, 60, 300, 60);
//    [DetailsTabbing addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
//    DetailsTabbing.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:DetailsTabbing];
    
    
    
    SegmentedControl *segmentedControl1 = [[SegmentedControl alloc] initWithSectionTitles:@[@"Location", @"Licence Plate", @"Vehicle Details"]];
    segmentedControl1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    segmentedControl1.frame = CGRectMake(0, 51, 320, 43);
    segmentedControl1.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    segmentedControl1.selectionStyle = SegmentedControlSelectionStyleFullWidthStripe;
    segmentedControl1.selectionIndicatorLocation = SegmentedControlSelectionIndicatorLocationDown;
    segmentedControl1.selectionIndicatorColor = UIColorFromRGB(0xde2629);
    segmentedControl1.selectedTextColor = UIColorFromRGB(0xde2629);
    segmentedControl1.scrollEnabled = NO;
    [segmentedControl1 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl1];
    
    
    
    
    
    
    
    
    
    
    _SearchType = LocationBaseSearch;
    
    [_SearchResultTableView setDelegate:self];
    [_SearchResultTableView setDataSource:self];
    
    [_SearchResultView setHidden:YES];
    [_SearchResultView setFrame:CGRectMake(10, 160, 300, self.view.frame.size.height - 120)];
    [self.view addSubview:_SearchResultView];
    
    [_SearchNoResult setHidden:YES];
    [_SearchNoResult setFrame:CGRectMake(10, 160, 300, 100)];
    [self.view addSubview:_SearchNoResult];
    
    [_UIsearchBarTap setFrame:CGRectMake(10, 110, 300, 60)];
    [_UIsearchBarTap setDelegate:self];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50.0f;
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_UIsearchBarTap resignFirstResponder];
    [_SearchNoResult setHidden:YES];
    [_SearchResultView setHidden:YES];
    
    if([SearchBadDriverHelper CleanTextField:[_UIsearchBarTap text]].length == 0) {
        
        MBAlertView *alert = [MBAlertView alertWithBody:SEARCHFIELDBLANKALERT cancelTitle:@"Cancel" cancelBlock:nil];
        [alert addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
            _UIsearchBarTap.text = @"";
            [_UIsearchBarTap becomeFirstResponder];
        }];
        [alert addToDisplayQueue];
        
    } else {
        
        // http://www.esolzdemos.com/lab3/trafficcop/IOS/go_search.php?page_count=1&search_by=1&search_location=eco
        
        // http://www.esolzdemos.com/lab3/trafficcop/IOS/go_search.php?page_count=1&search_by=2&search_licence_plate=wb
        
        // http://www.esolzdemos.com/lab3/trafficcop/IOS/go_search.php?page_count=1&search_by=3&search_add_vehicle_desc=a
        
        [_UIloadingData startAnimating];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSMutableDictionary *TempDictionary = [[NSMutableDictionary alloc] init];
            
            switch (_SearchType) {
                case 1:
                    [TempDictionary setObject:@"1" forKey:@"search_by"];
                    break;
                case 2:
                    [TempDictionary setObject:@"2" forKey:@"search_by"];
                    break;
                case 3:
                    [TempDictionary setObject:@"3" forKey:@"search_by"];
                    break;
                default:
                    [TempDictionary setObject:@"1" forKey:@"search_by"];
                    break;
            }
            
            //[TempDictionary setObject:[NSString stringWithFormat:@"%d",NumberOfPages] forKey:@"page_count"];
            
            [TempDictionary setObject:[SearchBadDriverHelper CleanTextField:[_UIsearchBarTap text]] forKey:@"search_terms"];
            NSString *REturnedURL = [SearchBadDriverHelper CallURLForServerReturn:TempDictionary URL:@"go_search.php"];
            NSLog(@"The search url for spacificsearch result:%@",REturnedURL);
            NSLog(@"url format --- %@",REturnedURL);
            
           // exit(0);
            
            NSDictionary *Retrneddata = [SearchBadDriverHelper executeFetch:REturnedURL];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                SearchResultDataArray =  [[NSMutableArray alloc] init];
                [SearchResultDataArray removeAllObjects];
                
                for (NSDictionary *statData in [Retrneddata objectForKey:@"extraparam"]) {
                    
                    if([[statData objectForKey:@"response"] isEqualToString:GLOBALERRSTRING]) {
                         [_UIloadingData stopAnimating];
                         [_SearchNoResult setHidden:NO];
                    } else {
                        for (NSDictionary *statDataone in [Retrneddata objectForKey:@"searchresult"]) {
                            
                            NSMutableDictionary *DtastoreDictionary = [[NSMutableDictionary alloc] init];
                            [DtastoreDictionary setObject:[statDataone objectForKey:@"report_id"] forKey:@"report_id"];
                            [DtastoreDictionary setObject:[statDataone objectForKey:@"report_title"] forKey:@"report_title"];
                            [DtastoreDictionary setObject:[statDataone objectForKey:@"report_desc"] forKey:@"report_desc"];
                            [DtastoreDictionary setObject:[statDataone objectForKey:@"userimage"] forKey:@"userimage"];
                            [DtastoreDictionary setObject:[statDataone objectForKey:@"userprofile_pagelink"] forKey:@"userprofile_pagelink"];
                            [SearchResultDataArray addObject:DtastoreDictionary];
                            
                        }
                        
                        [_UIloadingData stopAnimating];
                        
                        if([SearchResultDataArray count] > 0)
                         {
                            [_SearchResultTableView reloadData];
                            [_SearchResultView setHidden:NO];
                        }
                        else
                        {
                            [_SearchNoResult setHidden:NO];
                        }
                    }
                }
                
            });
            
        });
        
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [SearchResultDataArray count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *tableViewCell = [[UITableViewCell alloc] init];
    NSMutableDictionary *CellData = [SearchResultDataArray objectAtIndex:indexPath.row];
    
    UIView  *MainCellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    MainCellView.backgroundColor = [UIColor clearColor];
    UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 60, 60)];
    ImageView.backgroundColor = [UIColor clearColor];
    [MainCellView addSubview:ImageView];
    ImageView.layer.cornerRadius=6.0f;
    ImageView.layer.borderWidth=2.0f;
    ImageView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    
    ZSImageView *imageView = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    imageView.defaultImage = [UIImage imageNamed:@"Noimage.png"];
    imageView.imageUrl = [CellData objectForKey:@"userimage"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    

    [ImageView addSubview:imageView];
    tableViewCell.textLabel.text=[CellData objectForKey:@"report_id"];
    tableViewCell.textLabel.hidden=YES;
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 220, 20)];
    TitleLabel.backgroundColor = [UIColor clearColor];
    TitleLabel.numberOfLines = 0;
    TitleLabel.font = [UIFont fontWithName:@"Arial" size:16.0f];
    TitleLabel.textColor = UIColorFromRGB(0xfcb714);
    TitleLabel.text = [SearchBadDriverHelper stripTags:[CellData objectForKey:@"report_title"]];
    [MainCellView addSubview:TitleLabel];
    
    UITextView *Detailslabel = [[UITextView alloc] initWithFrame:CGRectMake(67, 35, 223, 40)];
    Detailslabel.backgroundColor = [UIColor clearColor];
    Detailslabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    Detailslabel.textColor = UIColorFromRGB(0x1aad4b);
   
    NSString *reportDescription=[CellData objectForKey:@"report_desc"];
    if (reportDescription.length<2)
    {
          Detailslabel.text=@"No Description Available";
    }
    else
    {
    Detailslabel.text = [SearchBadDriverHelper stripTags:reportDescription];
    }
    
    Detailslabel.userInteractionEnabled=NO;
    Detailslabel.scrollEnabled=NO;
    Detailslabel.textAlignment = NSTextAlignmentLeft;
    UILabel *separetor=[[UILabel alloc]initWithFrame:CGRectMake(0, 79, 320, .5)];
    separetor.layer.opacity=0.2f;
    [separetor setBackgroundColor:[UIColor blackColor]];
    [MainCellView addSubview:separetor];
    [MainCellView addSubview:Detailslabel];
    
    [tableViewCell addSubview:MainCellView];
    return tableViewCell;
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"selected indexpath --- %d",indexPath.row);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)segmentedControlChangedValue:(SegmentedControl *)segmentedControl {
    
    NumberOfPages = 1;
//    switch (segmentedControl.selectedSegmentIndex) {
//        case 0:
//            DetailsTabbing.selectionIndicatorColor = UIColorFromRGB(0xde1d23);
//            _SearchType = LocationBaseSearch;
//            break;
//        case 1:
//            DetailsTabbing.selectionIndicatorColor = UIColorFromRGB(0xfcb714);
//            _SearchType = LicencePlateBaseSearch;
//            break;
//        case 2:
//            DetailsTabbing.selectionIndicatorColor = UIColorFromRGB(0x1aad4b);
//            _SearchType = VehicleDeatilsBaseSearch;
//            break;
//        default:
//            DetailsTabbing.selectionIndicatorColor = UIColorFromRGB(0xde1d23);
//            _SearchType = LocationBaseSearch;
//            break;
    
            
            
            
            switch (segmentedControl.selectedSegmentIndex) {
                case 0: segmentedControl.selectionIndicatorColor = UIColorFromRGB(0xde2629);
                    segmentedControl.selectedTextColor = UIColorFromRGB(0xde2629);
                    _SearchType = LocationBaseSearch;
                    break;
                case 1: segmentedControl.selectionIndicatorColor = UIColorFromRGB(0xfab81e);
                    segmentedControl.selectedTextColor = UIColorFromRGB(0xfab81e);
                    _SearchType = LicencePlateBaseSearch;
                    break;
                case 2: segmentedControl.selectionIndicatorColor = UIColorFromRGB(0x22b350);
                    segmentedControl.selectedTextColor = UIColorFromRGB(0x22b350);
                    _SearchType = VehicleDeatilsBaseSearch;
                    break;
                    
                default:
                    segmentedControl.selectionIndicatorColor = UIColorFromRGB(0xde2629);
                    segmentedControl.selectedTextColor = UIColorFromRGB(0xde2629);
                    _SearchType = LocationBaseSearch;
                    break;
            }

            
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *MainHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [MainHeaderView setBackgroundColor:[UIColor whiteColor]];
    UILabel *Titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 320, 35)];
    Titlelabel.text = [NSString stringWithFormat:@"Search Result For %@",[_UIsearchBarTap text]];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    AppDelegate *MainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    ReportDetailsViewController *reportDetails = [[ReportDetailsViewController alloc] init];
    reportDetails.reportId=cell.textLabel.text;
    [MainDelegate SetUpTabbarControllerwithcenterView:reportDetails];
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
    // Dispose of any resources that can be recreated.
}

@end
