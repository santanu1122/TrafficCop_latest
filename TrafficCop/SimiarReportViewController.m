//
//  SimiarReportViewController.m
//  TrafficCop
//
//  Created by macbook_ms on 11/12/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import "SimiarReportViewController.h"
#import "ZSImageView.h"
#import "ReportDetailsViewController.h"
#import "MFSideMenu.h"
#import "AppDelegate.h"
@interface SimiarReportViewController ()
{
    NSMutableArray *AllReports;
    NSString *userID;
}
@property (strong, nonatomic) IBOutlet UIView *NavigationbarView;


@end


@implementation SimiarReportViewController

@synthesize SimilerReporttbl;
@synthesize Reportid;
@synthesize NavigationbarView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
   
    
     [NavigationbarView setBackgroundColor:[UIColor colorWithRed:(247/255.0) green:(247/255.0) blue:(247/255.0) alpha:1]];
     SimilarreportHelper=[[HelperClass alloc]init];
     AllReports=[[NSMutableArray alloc]init];
     NSUserDefaults *userDetails=[NSUserDefaults standardUserDefaults];
     userID=[userDetails valueForKey:@"userid"];
     [SimilarreportHelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
     [SimilerReporttbl setHidden:YES];
     [SimilarreportHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
     [self SemilerReport];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)SemilerReport
{
    
dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
    NSString *StringUrl=[NSString stringWithFormat:@"%@similar_report_details.php?id=%@&loginuser=%@",DomainURL,Reportid,userID];
    NSLog(@"The string url is:%@",StringUrl);
    NSURL *url=[NSURL URLWithString:StringUrl];
    NSData *data=[NSData dataWithContentsOfURL:url];
    NSDictionary *mainDic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSDictionary *SimilerReport=[mainDic valueForKey:@"similar_report_list"];
    NSArray *SimilerCmtArray=[SimilerReport objectForKey:@"similar_list"];
    
    
    
    
    for (NSDictionary *dic in SimilerCmtArray)
    {
        
        NSString *Similerreport_id= [dic objectForKey:@"similar_report_id"];
        
        NSString *Similerreport_image = [dic objectForKey:@"similar_report_image"];
        
        NSString *Similerreport_titel = [dic objectForKey:@"similar_report_title"];
        
        NSString *SimilerReportRating = [dic objectForKey:@"similar_report_rating"];
        
        NSString *Similerreport_comment = [dic objectForKey:@"similar_report_comment_text"];
        
        NSMutableDictionary *tempDic=[[NSMutableDictionary alloc]initWithCapacity:5];
        
        [tempDic setObject:Similerreport_id forKey:@"similar_report_id"];
        [tempDic setObject:Similerreport_image forKey:@"similar_report_image"];
        [tempDic setObject:Similerreport_titel forKey:@"similar_report_title"];
        [tempDic setObject:SimilerReportRating forKey:@"similar_report_rating"];
        [tempDic setObject:Similerreport_comment forKey:@"similar_report_comment_text"];
        
        [AllReports addObject:tempDic];
        
    }
    [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
});
    
}
- (void)leftSideMenuButtonPressed:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

- (void)rightSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{}];
}


-(void)reloadTable
{
     [SimilarreportHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
    SimilerReporttbl.hidden=NO;
    [SimilerReporttbl reloadData];
}

#pragma TableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0f;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger nomberofrow;
    if (AllReports.count==0)
    {
        nomberofrow=1;
    }
    else
    {
       nomberofrow=[AllReports count];
    }
    return nomberofrow;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    cell=[[UITableViewCell alloc]init];
    if ([AllReports count]==0)
    {
        UIView *mainView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
        mainView.backgroundColor=[UIColor whiteColor];
        UILabel *noSuchreport=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
        noSuchreport.font=[UIFont fontWithName:@"Arial" size:20];
        noSuchreport.textAlignment=NSTextAlignmentCenter;
        noSuchreport.textColor=[UIColor blackColor];
        noSuchreport.text=@"NO REPORT FOUND";
        [mainView addSubview:noSuchreport];
        [cell.contentView addSubview:mainView];
    }
    else
    {
    NSMutableDictionary *item = Nil;
    
    
   item = [[NSMutableDictionary alloc] initWithDictionary:[AllReports objectAtIndex:indexPath.row]];
    
    UIView  *MainCellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    
    MainCellView.backgroundColor = [UIColor clearColor];
    
    UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
    
    ImageView.backgroundColor = [UIColor clearColor];
    
    [MainCellView addSubview:ImageView];
    
    cell.textLabel.text=[item objectForKey:@"similar_report_id"];
    cell.textLabel.hidden=YES;
    NSLog(@"The cell textlable:%@",cell.textLabel.text);
    
    ZSImageView *imageView = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    
    imageView.defaultImage = [UIImage imageNamed:@"FH-noimage-circle.png"];
    
    imageView.imageUrl = [item objectForKey:@"similar_report_image"];
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    imageView.clipsToBounds = YES;
    
    // imageView.corners = ZSRoundCornerAll;
    
    imageView.cornerRadius = 0;
    
    [ImageView addSubview:imageView];
    
    
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 5, 250, 25)];
    
    TitleLabel.backgroundColor = [UIColor clearColor];
    
    TitleLabel.font = [UIFont fontWithName:@"Arial" size:16];
    
    TitleLabel.textColor = UIColorFromRGB(0xfcb714);
    
    TitleLabel.text = [SimilarreportHelper stripTags:[item objectForKey:@"similar_report_title"]];
    
    [MainCellView addSubview:TitleLabel];
    
    
    
    int TOTAL = 5;
    
    int YELLOW = [[item objectForKey:@"similar_report_rating"] intValue];
      
    int GRAY = TOTAL - YELLOW;
    
    float SIZEX = 5;
    
    
    
    for(int i=0; i < YELLOW; i++) {
        
        if(i==0)
            
            SIZEX = 60+5;
        
        UIImageView *ImageViewone = [[UIImageView alloc] initWithFrame:CGRectMake(SIZEX, 30, 16, 16)];
        
        ImageViewone.backgroundColor = [UIColor clearColor];
        
        ImageViewone.image = [UIImage imageNamed:@"YELLOWSTER"];
        
        [MainCellView addSubview:ImageViewone];
        
        SIZEX = SIZEX + 16;
        
    }
    
    for(int j=0; j < GRAY; j++) {
        
        if(GRAY==5 && j==0)
            
            SIZEX = 60+5;
        
        UIImageView *ImageViewone = [[UIImageView alloc] initWithFrame:CGRectMake(SIZEX, 30, 16, 16)];
        
        ImageViewone.backgroundColor = [UIColor clearColor];
        
        ImageViewone.image = [UIImage imageNamed:@"GRAYSTAR"];
        
        [MainCellView addSubview:ImageViewone];
        
        SIZEX = SIZEX + 16;
        
    }
    
    
    
    UILabel *Detailslabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 30, 190, 16)];
    
    Detailslabel.backgroundColor = [UIColor clearColor];
    
        Detailslabel.font = [UIFont fontWithName:@"Arial" size:16.0f];
                   
    
    Detailslabel.textColor = UIColorFromRGB(0x1aad4b);
    
    Detailslabel.text = [SimilarreportHelper stripTags:[item objectForKey:@"similar_report_comment_text"]];
    
  
    
    Detailslabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    [MainCellView addSubview:Detailslabel];
    
    
    
    [cell.contentView addSubview:MainCellView];
    
    }
  
    return cell;
    

}


-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50.0f;
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    
    UIView *MainHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [MainHeaderView setBackgroundColor:[UIColor whiteColor]];
    
    
    UILabel *Titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 320, 35)];
    
    Titlelabel.text = @"Similar Reports";
    Titlelabel.textAlignment=NSTextAlignmentCenter;
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



#pragma TableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    if (AllReports.count!=0)
    {
        
        AppDelegate *MainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        ReportDetailsViewController *reportDetails = [[ReportDetailsViewController alloc] init];
        reportDetails.reportId=cell.textLabel.text;
        [MainDelegate SetUpTabbarControllerwithcenterView:reportDetails];

    }
        
    
    

    
}
- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)BackToReportDetais:(id)sender
{
     [self.navigationController popViewControllerAnimated:YES];
    
}



@end
