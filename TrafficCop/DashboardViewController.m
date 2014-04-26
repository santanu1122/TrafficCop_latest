



#import "DashboardViewController.h"
#import "MFSideMenu.h"
#import "MostRecentCommentsCell.h"
#import "MostRecentReportsCell.h"
#import "HighestRatedReportsCell.h"
#import "ZSImageView.h"
#import "ReportDetailsViewController.h"
#import "AppDelegate.h"
#import "RecordAudioViewController.h"
#import "SegmentedControl.h"

//BOOL IsHideen = NO;

@interface DashboardViewController ()<UIScrollViewDelegate>
{
    
    NSTimer *UpdatLocationTimer;
    BOOL LoadmorebuttonClick;
    BOOL LoadmorebuttonClick2;
    BOOL LoadmorebuttonClick3;
    
    NSString *Updatedata1;
    NSString *Updatedata2;
    NSString *Updatedata3;
    CGSize    sizeoftext;
    NSString *settinglimit;
    NSString *LatextreportLoadmoreload_more;
    NSString *highstreportLoadmore;
    NSString *EvidenceLockerLoadmore;
    NSInteger priviousupdate;
    
    BOOL Segment1Selected;
    BOOL segment2Selected;
    BOOL segment3Selected;
    
    UILabel *Nodatalabel;
    
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Spinnerload;
@property (strong, nonatomic) IBOutlet UIView *loadmore2;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *Spinner1;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *Spinner2;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *Spinner3;
@property (strong, nonatomic) IBOutlet UIView *Loadmore3;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SegmentedControl *SegmentedControl;

@end


@implementation DashboardViewController

@synthesize DashboardTable;
@synthesize locationmaneger;
@synthesize playlistImageLoader     = _playlistImageLoader;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     Segment1Selected=YES;
     segment2Selected=NO;
     segment3Selected=NO;
     LoadmorebuttonClick=YES;
     LoadmorebuttonClick2=YES;
     LoadmorebuttonClick3=YES;
     DashboardHelper = [[HelperClass alloc] init];
     [self HideNavigationBar];
     [DashboardHelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    
    locationmaneger=[[CLLocationManager alloc]init];
    locationmaneger.delegate=self;
    locationmaneger.desiredAccuracy = kCLLocationAccuracyBest;
    locationmaneger.distanceFilter = .10f;
    locationmaneger.headingFilter = 1;
    self.LoadMoreview.layer.cornerRadius=4.0f;
    self.LoadMoreview.layer.borderColor=[UIColor clearColor].CGColor;
    self.LoadMoreview.layer.borderWidth=1.0f;
    [self UpdateLocation];
    
//    for(NSString* family in [UIFont familyNames]) {
//        NSLog(@"%@", family);
//        for(NSString* name in [UIFont fontNamesForFamilyName: family]) {
//            NSLog(@"  %@", name);
//        }
//    }
    
    [DashboardHelper SetupHeaderView:self.view viewController:self];
    [[self DashboardTable]setDelegate:self];
    [[self DashboardTable]setDataSource:self];
    DashboardTable.hidden = YES;
    
    UILabel *Seperatorlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 320, 1)];
    [Seperatorlabel setBackgroundColor:[UIColor lightGrayColor]];
    [Seperatorlabel.layer setOpacity:0.5f];
    [self.view addSubview:Seperatorlabel];
    
    SegmentedControl *segmentedControl1 = [[SegmentedControl alloc] initWithSectionTitles:@[@"Latest Report", @"Highest Rated", @"Evidence Locker"]];
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
    
    
     [DashboardHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
    
    
    // Fatch latest Reports
    
    NSString *REturnedURL=[NSString stringWithFormat:@"%@appweb.php?mode=latest_report&last_id=%@",DomainURL,@"0"];
    NSLog(@"the REturnedURL value:%@",REturnedURL);
    NSURL *url = [NSURL URLWithString:REturnedURL];
    NSURLRequest *restrict1 = [NSURLRequest requestWithURL:url];
    connection = [NSURLConnection connectionWithRequest:restrict1 delegate:self];
    if(connection) {
        webdata = [[NSMutableData alloc]init];
    }
    
}

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
    
    if (segmentedControl.selectedSegmentIndex==0)
    {
        [DashboardHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
        Updatedata1=@"0";
        LoadmorebuttonClick=YES;
        Segment1Selected=YES;
        segment2Selected=NO;
        segment3Selected=NO;
        [LatestreportArray removeAllObjects];
        [DashboardTable reloadData];
        [self LoadmoreforHeightrelated];
    }
    else if (segmentedControl.selectedSegmentIndex==1)
    {
        
        [DashboardHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
        
        [LatestreportArray removeAllObjects];
        
        Updatedata2=@"0";
        LoadmorebuttonClick2=YES;
        Segment1Selected=NO;
        segment2Selected=YES;
        segment3Selected=NO;
        [DashboardTable reloadData];
        [self LoadmoreFormostrecent];
    }
    else
    {
        [DashboardHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
        
        [LatestreportArray removeAllObjects];
        LoadmorebuttonClick3=YES;
        Updatedata3=@"0";
        Segment1Selected=NO;
        segment2Selected=NO;
        segment3Selected=YES;
        [DashboardTable reloadData];
        [self loadmoreforlicenceplate];
    }
}
-(void)LoadmoreforHeightrelated
{
    
    if (LoadmorebuttonClick==YES)
    {
        [Nodatalabel removeFromSuperview];
        [self.Spinner1 stopAnimating];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            NSString *mainString=[NSString stringWithFormat:@"%@appweb.php?mode=latest_report&last_id=%@",DomainURL,Updatedata1];
            NSLog(@"the latest report:%@",mainString);
            priviousupdate=[Updatedata1 integerValue];
            NSLog(@"The privioos date:%d",priviousupdate);
            NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:mainString]];
            NSDictionary *mainDic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSDictionary *settingLimit=[mainDic valueForKey:@"Settings"];
            LatextreportLoadmoreload_more=[settingLimit valueForKey:@"latest_report_load_more"];
            
            Updatedata1=[settingLimit valueForKey:@"last_id"];
            
            if ([LatextreportLoadmoreload_more integerValue]==0)
            {
                LoadmorebuttonClick=NO;
                
            }
            else
            {
                LoadmorebuttonClick=YES;
            }
            
            
            for(NSDictionary *HigstRatedReport in [mainDic objectForKey:@"Latest Report"])
            {
                
                NSString *report_image = [HigstRatedReport objectForKey:@"report_image"];
                
                
                NSString *report_title = [HigstRatedReport objectForKey:@"report_title"];
                
                NSString *avg_rating = [HigstRatedReport objectForKey:@"avg_rating"];
                
                NSString *report_desc = [HigstRatedReport objectForKey:@"report_desc"];
                
                NSString *reportid = [HigstRatedReport objectForKey:@"reportid"];
                
                NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] initWithCapacity:5];
                
                [tempDict setObject: report_image forKey:@"report_image"];
                
                [tempDict setObject: report_title forKey:@"report_title"];
                
                [tempDict setObject: avg_rating forKey:@"avg_rating"];
                
                [tempDict setObject: report_desc forKey:@"report_desc"];
                
                [tempDict setObject: reportid forKey:@"reportid"];
                
                [LatestreportArray addObject:tempDict];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [DashboardHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
                [DashboardTable reloadData];
                
                
                
                
            });
            
            
            
            
        });
        
    }
    
    
    
}
-(void)LoadmoreFormostrecent
{
    if (LoadmorebuttonClick2==YES)
    {
        [Nodatalabel removeFromSuperview];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            NSString *mainString=[NSString stringWithFormat:@"%@appweb.php?mode=high_rated_report&last_id=%@",DomainURL,Updatedata2];
            NSLog(@"the latest report:%@",mainString);
            priviousupdate=[Updatedata2 integerValue];
            NSLog(@"The privioos date:%d",priviousupdate);
            NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:mainString]];
            NSDictionary *mainDic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            NSLog(@"msin dic in most recent ---  %@", mainDic);
            
            NSDictionary *settingLimit=[mainDic valueForKey:@"Settings"];
            highstreportLoadmore=[settingLimit valueForKey:@"highest_report_load_more"];
            Updatedata2=[settingLimit valueForKey:@"last_id"];
            
            if ([highstreportLoadmore integerValue]==0)
            {
                LoadmorebuttonClick2=NO;
                
            }
            else
            {
                LoadmorebuttonClick2=YES;
            }
            
            for(NSDictionary *HigstRatedReport in [mainDic objectForKey:@"Highest Rated Report"]) {
                
                NSString *report_image = [HigstRatedReport objectForKey:@"report_image"];
                
                
                NSString *report_title = [HigstRatedReport objectForKey:@"report_title"];
                
                NSString *avg_rating = [HigstRatedReport objectForKey:@"avg_rating"];
                
                NSString *report_desc = [HigstRatedReport objectForKey:@"report_desc"];
                
                NSString *reportid = [HigstRatedReport objectForKey:@"reportid"];
                
                NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] initWithCapacity:5];
                
                [tempDict setObject: report_image forKey:@"report_image"];
                
                [tempDict setObject: report_title forKey:@"report_title"];
                
                [tempDict setObject: avg_rating forKey:@"avg_rating"];
                
                [tempDict setObject: report_desc forKey:@"report_desc"];
                
                [tempDict setObject: reportid forKey:@"reportid"];
                
                [LatestreportArray addObject:tempDict];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [DashboardHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
                
                [DashboardTable reloadData];
            });
            
            
            
        });
    }
    
}


-(void)loadmoreforlicenceplate
{
    if (LoadmorebuttonClick3==YES)
    {
        NSLog(@"checkkk");
        
        [Nodatalabel removeFromSuperview];
        [self.Spinner3 startAnimating];
        NSUserDefaults *userDefals=[NSUserDefaults standardUserDefaults];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            NSString *mainString=[NSString stringWithFormat:@"%@appweb.php?mode=evidance_locker_follow&last_id=%@&userid=%@",DomainURL,Updatedata3,[userDefals valueForKey:@"userid"]];
            NSLog(@"the latest report:%@",mainString);
            priviousupdate=[Updatedata3 integerValue];
            NSLog(@"The privioos date:%d",priviousupdate);
            NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:mainString]];
            NSDictionary *mainDic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            NSLog(@"main dic in evidnce loker-- %@", mainDic);
            
            NSDictionary *settingLimit=[mainDic valueForKey:@"Settings"];
            EvidenceLockerLoadmore=[settingLimit valueForKey:@"highest_report_load_more"];
            Updatedata2=[settingLimit valueForKey:@"last_id"];
            
            if ([EvidenceLockerLoadmore integerValue]==0)
            {
                LoadmorebuttonClick3=NO;
                
            }
            else
            {
                LoadmorebuttonClick3=YES;
            }
            for(NSDictionary *HigstRatedReport in [mainDic objectForKey:@"Reports of License Plates You Follow"])
            {
                
                NSString *ImageOfreport = [HigstRatedReport objectForKey:@"getimage"];
                
                NSString *Title = [HigstRatedReport objectForKey:@"title"];
                
                NSString *avg_rating = [HigstRatedReport objectForKey:@"rating"];
                
                NSString *descriotion= [HigstRatedReport objectForKey:@"description"];
                
                NSString *ReportId = [HigstRatedReport objectForKey:@"reportid"];
                
                NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] initWithCapacity:4];
                
                NSLog(@"image %@ Title %@ avg_rating %@ descriptn %@", ImageOfreport, Title, avg_rating, descriotion);
                
                [tempDict setObject: ImageOfreport forKey:@"getimage"];
                
                [tempDict setObject: Title forKey:@"title"];
                
                [tempDict setObject: avg_rating forKey:@"rating"];
                
                [tempDict setObject: descriotion forKey:@"description"];
                
                [tempDict setObject:ReportId forKey:@"reportid"];
                
                [LatestreportArray addObject:tempDict];
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [DashboardHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
                
                NSLog(@"LatestreportArray santanu--- %d",LatestreportArray.count);
                
                if(LatestreportArray.count > 0) {
                    [DashboardTable reloadData];
                } else {
                    
                    Nodatalabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height/2 - 10), 320, 20)];
                    [Nodatalabel setTextAlignment:NSTextAlignmentCenter];
                    [Nodatalabel setText:@"There is no data"];
                    [self.view addSubview:Nodatalabel];
                    //DashboardTable.hidden = YES;
                }
                
            });
            
            
        });
    }
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    
    float reload_distance = -40.0f;
    if(y > h + reload_distance)
    {
        if(Segment1Selected==YES)
        {
            NSLog(@"I ima in 1st");
            [self LoadmoreforHeightrelated];
            
        }
        
        else if (segment2Selected==YES)
        {
            NSLog(@"I ima in 2st");
            [self LoadmoreFormostrecent];
        }
        else
        {
            NSLog(@"I ima in 3st");
            //[self LoadmoreFormostrecent]; //check
            [self loadmoreforlicenceplate];
        }
    }
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    LatestreportArray=[[NSMutableArray alloc]init];
    Hightestrelatedreport=[[NSMutableArray alloc]init];
    RemportofLicenceplate=[[NSMutableArray alloc]init];
    
    NSDictionary *allData = [NSJSONSerialization JSONObjectWithData:webdata options:0 error:nil];
    [self.Spinner1 stopAnimating];
    
    NSDictionary *settingLimit=[allData valueForKey:@"Settings"];
    LatextreportLoadmoreload_more=[settingLimit valueForKey:@"latest_report_load_more"];
    
    Updatedata1=[settingLimit valueForKey:@"last_id"];
    
    if ([LatextreportLoadmoreload_more integerValue]==0)
        LoadmorebuttonClick = NO;
    else
        LoadmorebuttonClick = YES;
    
    
    for(NSDictionary *HigstRatedReport in [allData objectForKey:@"Latest Report"])
    {
        NSString *report_image = [HigstRatedReport objectForKey:@"report_image"];
        NSString *report_title = [HigstRatedReport objectForKey:@"report_title"];
        NSString *avg_rating = [HigstRatedReport objectForKey:@"avg_rating"];
        NSString *report_desc = [HigstRatedReport objectForKey:@"report_desc"];
        NSString *reportid = [HigstRatedReport objectForKey:@"reportid"];
        
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] initWithCapacity:5];
        [tempDict setObject: report_image forKey:@"report_image"];
        [tempDict setObject: report_title forKey:@"report_title"];
        [tempDict setObject: avg_rating forKey:@"avg_rating"];
        [tempDict setObject: report_desc forKey:@"report_desc"];
        [tempDict setObject: reportid forKey:@"reportid"];
        [LatestreportArray addObject:tempDict];
    }
    
    [DashboardHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
    
    self.DashboardTable.hidden=NO;
    [self.DashboardTable reloadData];
    
}
/*
 
 Connection Receive Respose From Server
 
 */


#pragma mark

#pragma mark - UITableView Data Source

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webdata setLength:0];
}

/*
 Connection Receive Data From Server and append the data
 */

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webdata appendData:data];
}

/*
 Connection Failed To Get Data From Server
 */
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"err %@",error);
}
-(void)UpdateLocation
{
    [locationmaneger startUpdatingLocation];
}
#pragma mark -

#pragma mark - UIBarButtonItem Callbacks

- (void)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftSideMenuButtonPressed:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

- (void)rightSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{}];
}

-(void)HideNavigationBar
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    /* double speed = newLocation.speed;
     
     //another way
     if(oldLocation != nil)
     {
     CLLocationDistance distanceChange = [newLocation getDistanceFrom:oldLocation];
     NSTimeInterval sinceLastUpdate = [newLocation.timestamp timeIntervalSinceDate:oldLocation.timestamp];
     speed = distanceChange/sinceLastUpdate;
     
     }
     if (speed>=1.0000f)
     {
     RecordAudioViewController *reportDetais=[[RecordAudioViewController alloc]initWithNibName:@"RecordAudioViewController" bundle:nil];
     [self.navigationController pushViewController:reportDetais animated:YES];
     
     //           AppDelegate *maindeledate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
     //            [maindeledate SetUpTabbarControllerwithcenterView:reportDetais];
     
     
     }*/
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    @autoreleasepool {
        
        UITableViewCell *cell;
        
        cell=[[UITableViewCell alloc]init];
        BOOL theContent=TRUE;
        
        NSMutableDictionary *item =[[NSMutableDictionary alloc] initWithDictionary:[LatestreportArray objectAtIndex:indexPath.row]];
        
        cell.backgroundColor = [UIColor clearColor];
        
        UIImageView *backgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
        backgroundImage.image = [UIImage imageNamed:@"topbar.png"];
        cell.backgroundView = backgroundImage;
        [cell.contentView addSubview:backgroundImage];
        
        NSLog(@"RemportofLicenceplate--- %@",item);
        
        if (segment3Selected == YES && [LatestreportArray count] > 0)
        {
            NSLog(@"chk itemmm ---- %@", item);
            theContent=FALSE;
            
            UIView  *MainCellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 109)];
            [MainCellView setBackgroundColor:[UIColor whiteColor]];
            
            UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 16, 65, 65)];
            ImageView.backgroundColor = [UIColor clearColor];
            [MainCellView addSubview:ImageView];
            
            ZSImageView *imageView = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
            imageView.defaultImage = [UIImage imageNamed:@"NEWNOIMAGE.png"];
            imageView.imageUrl = [item objectForKey:@"getimage"];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.backgroundColor = [UIColor clearColor];
            imageView.corners = ZSRoundCornerAll;
            imageView.cornerRadius = 25;
            [ImageView addSubview:imageView];
            
            UIImageView *ImageOverlay = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
            [ImageOverlay setImage:[UIImage imageNamed:@"out-line.png"]];
            [ImageView addSubview:ImageOverlay];
            
            UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, 250, 25)];
            TitleLabel.backgroundColor = [UIColor clearColor];
            TitleLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:15.0f];
            TitleLabel.textColor = UIColorFromRGB(0x211e1f);
            TitleLabel.text = [DashboardHelper stripTags:[item objectForKey:@"title"]];
            [MainCellView addSubview:TitleLabel];
            TitleLabel.textAlignment = NSTextAlignmentLeft;
            
            int TOTAL = 5;
            
            int YELLOW = [[item objectForKey:@"rating"] intValue];
            
            int GRAY = TOTAL - YELLOW;
            
            float SIZEX = 5;
            
            
            
            for(int i=0; i < YELLOW; i++) {
                
                if(i==0)
                    
                    SIZEX = 90;
                
                UIImageView *ImageViewone = [[UIImageView alloc] initWithFrame:CGRectMake(SIZEX, 35, 20, 20)];
                
                ImageViewone.backgroundColor = [UIColor clearColor];
                
                ImageViewone.image = [UIImage imageNamed:@"starNEW"];
                
                [MainCellView addSubview:ImageViewone];
                
                SIZEX = SIZEX + 22;
                
            }
            
            for(int j=0; j < GRAY; j++) {
                
                if(GRAY==5 && j==0)
                    
                    SIZEX = 90;
                
                UIImageView *ImageViewone = [[UIImageView alloc] initWithFrame:CGRectMake(SIZEX, 35, 20, 20)];
                
                ImageViewone.backgroundColor = [UIColor clearColor];
                
                ImageViewone.image = [UIImage imageNamed:@"star1NEW"];
                
                [MainCellView addSubview:ImageViewone];
                
                SIZEX = SIZEX + 22;
                
            }
            
            UITextView *DetailsTextViewFortext=[[UITextView alloc]init];
            NSString *DecriptionTxt=[DashboardHelper CleanTextField:[item objectForKey:@"description"]];
            NSLog(@"text for detailstextviewfortext %@", DecriptionTxt);
            DetailsTextViewFortext.text=DecriptionTxt;
            
            NSAttributedString *attributed=[[NSAttributedString alloc]initWithString:DecriptionTxt];
            [DetailsTextViewFortext setAttributedText:attributed];
            //CGSize size = [DetailsTextViewFortext sizeThatFits:CGSizeMake(310, FLT_MAX)];
            
            DetailsTextViewFortext.frame = CGRectMake(90, 60, 230, 50);
            [DetailsTextViewFortext setTextAlignment:NSTextAlignmentJustified];
            [DetailsTextViewFortext setFont:[UIFont fontWithName:GLOBALTEXTFONT size:12.0f]];
            [DetailsTextViewFortext setTextColor:UIColorFromRGB(0x575757)];
            DetailsTextViewFortext.editable=NO;
            DetailsTextViewFortext.scrollEnabled=NO;
            [DetailsTextViewFortext setBackgroundColor:[UIColor clearColor]];
            [DetailsTextViewFortext setEditable:NO];
            [MainCellView addSubview:DetailsTextViewFortext];
           // DetailsTextViewFortext.hidden = YES;
            
            
            UILabel *Separetor=[[UILabel alloc]initWithFrame:CGRectMake(0, 50+79, 320, .5)];
            [Separetor setBackgroundColor:[UIColor blackColor]];
            Separetor.layer.opacity=0.2f;
            [MainCellView addSubview:Separetor];
            MainCellView.frame=CGRectMake(0, 0, 320, DetailsTextViewFortext.frame.origin.y+DetailsTextViewFortext.frame.size.height+3);
            [cell.contentView addSubview:MainCellView];
            
            cell.textLabel.text=[item objectForKey:@"reportid"];
            cell.textLabel.textColor = [UIColor clearColor]; // to hide the report id in loading screen...
            
            NSLog(@"cell text --- %@", cell.textLabel.text);
        }
        if (theContent==TRUE)
        {
            
            NSLog(@"Item value for key report ID: --- %@",[item valueForKey:@"reportid"]);
            UIView  *MainCellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 109)];
            
            MainCellView.backgroundColor = [UIColor whiteColor];
            
            
            [cell.contentView addSubview:MainCellView];
            
            UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 16, 65, 65)];
            
            ImageView.backgroundColor = [UIColor clearColor];
            
            [MainCellView addSubview:ImageView];
            
            ZSImageView *imageView = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
            imageView.defaultImage = [UIImage imageNamed:@"NEWNOIMAGE.png"];
            imageView.imageUrl = [item objectForKey:@"report_image"];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.backgroundColor = [UIColor clearColor];
            imageView.corners = ZSRoundCornerAll;
            imageView.cornerRadius = 25;
            [ImageView addSubview:imageView];
            
            UIImageView *ImageOverlay = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
            [ImageOverlay setImage:[UIImage imageNamed:@"out-line.png"]];
            [ImageView addSubview:ImageOverlay];
            
            
            UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, 250, 25)];
            TitleLabel.backgroundColor = [UIColor clearColor];
            TitleLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:15.0];
            [TitleLabel setTextColor:UIColorFromRGB(0x211e1f)];
            TitleLabel.text = [DashboardHelper stripTags:[item objectForKey:@"report_title"]];
            [MainCellView addSubview:TitleLabel];
            
            
            int TOTAL = 5;
            
            int YELLOW = [[item objectForKey:@"avg_rating"] intValue];
            
            int GRAY = TOTAL - YELLOW;
            
            float SIZEX = 5;
            
            
            
            for(int i=0; i < YELLOW; i++) {
                
                if(i==0)
                    
                    SIZEX = 90;
                
                UIImageView *ImageViewone = [[UIImageView alloc] initWithFrame:CGRectMake(SIZEX, 35, 20, 20)];
                
                ImageViewone.backgroundColor = [UIColor clearColor];
                
                ImageViewone.image = [UIImage imageNamed:@"starNEW"];
                
                [MainCellView addSubview:ImageViewone];
                
                SIZEX = SIZEX + 22;
                
            }
            
            for(int j=0; j < GRAY; j++) {
                
                if(GRAY==5 && j==0)
                    
                    SIZEX = 90;
                
                UIImageView *ImageViewone = [[UIImageView alloc] initWithFrame:CGRectMake(SIZEX, 35, 20, 20)];
                
                ImageViewone.backgroundColor = [UIColor clearColor];
                
                ImageViewone.image = [UIImage imageNamed:@"star1NEW"];
                
                [MainCellView addSubview:ImageViewone];
                
                SIZEX = SIZEX + 22;
                
            }
            NSLog(@"Report Detais:%@",[item objectForKey:@"reportid"]);
            NSLog(@"itemmm chk --- %@", item);
            
            cell.textLabel.text=[item objectForKey:@"reportid"];
            cell.textLabel.textColor = [UIColor clearColor]; // to hide the report id in loading screen...
            //cell.textLabel.hidden=YES;
            
            UITextView *Detailslabel = [[UITextView alloc] init];
            NSString *DecriptionText=[DashboardHelper CleanTextField:[item objectForKey:@"report_desc"]];
            NSAttributedString *attributed=[[NSAttributedString alloc]initWithString:DecriptionText];
            [Detailslabel setAttributedText:attributed];
            //CGSize size = [Detailslabel sizeThatFits:CGSizeMake(310, FLT_MAX)];
            
            Detailslabel.frame = CGRectMake(90, 60, 230, 50);
            [Detailslabel setUserInteractionEnabled:NO];
            [Detailslabel setScrollEnabled:NO];
            Detailslabel.backgroundColor = [UIColor clearColor];
            
            Detailslabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:12.0];
            
            Detailslabel.textColor = UIColorFromRGB(0x575757);
            
            Detailslabel.textAlignment = NSTextAlignmentLeft;
            [MainCellView addSubview:Detailslabel];
            MainCellView.frame=CGRectMake(0, 0, 320, Detailslabel.frame.origin.y+Detailslabel.frame.size.height+5);
            [cell.contentView addSubview:MainCellView];
            //Detailslabel.hidden = YES;
            
            UILabel *Seperatorlabel = [[UILabel alloc] initWithFrame:CGRectMake(MainCellView.layer.frame.origin.x, MainCellView.layer.frame.origin.y-(MainCellView.layer.frame.size.height-1), MainCellView.layer.frame.size.width, MainCellView.layer.frame.size.height)];
            [Seperatorlabel setBackgroundColor:[UIColor lightGrayColor]];
            [MainCellView addSubview:Seperatorlabel];
            
        }
        
        return cell;
        
    }
    
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
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
    NSString *FooterData;
    if(section == 0)
        FooterData = @"";
    if(section == 1)
        FooterData = @"";
    if(section == 2)
        FooterData = @"";
    return FooterData;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger CounTReturn;
    CounTReturn = LatestreportArray.count;
    return CounTReturn;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.0f;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
@end