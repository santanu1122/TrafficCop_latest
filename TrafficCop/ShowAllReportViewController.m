//
//  ShowAllReportViewController.m
//  TrafficCop
//
//  Created by macbook_ms on 28/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//  http://esolzdemos.com/lab3/trafficcop/IOS/pages/useractivity.php?userid=28&mode=report

#import "ShowAllReportViewController.h"
#import "ZSImageView.h"
#import "HelperClass.h"
#import "AppDelegate.h"
#import "ReportDetailsViewController.h"

@interface ShowAllReportViewController ()
{
    HelperClass *reportLableHelper;
    NSMutableArray *ReportOftheuserArray;
    NSOperationQueue *operation;
  
}

@end

@implementation ShowAllReportViewController
@synthesize userid;


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
    reportLableHelper=[[HelperClass alloc]init];
    operation=[[NSOperationQueue alloc]init];
      NSLog(@"the user id of the:%@",userid);
    [reportLableHelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    [reportLableHelper SetupHeaderView:self.view viewController:self];
    ReportOftheuserArray=[[NSMutableArray alloc]init];
    [self.navigationController setNavigationBarHidden:YES];
    [reportLableHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
    
    NSInvocationOperation *ShowallReport=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(loadAllReportofuser) object:nil];
    [operation addOperation:ShowallReport];
    
  
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableViewDetaSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ReportOftheuserArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell=[[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
    
    NSLog(@"The indexpath of sectiopnm for report:%d",indexPath.section);
    [cell setFrame:CGRectMake(0, 0, 320, 70)];
    NSMutableDictionary *item1;
    NSLog(@"report tableview");
    item1 = [[NSMutableDictionary alloc] initWithDictionary:[ReportOftheuserArray objectAtIndex:indexPath.row]];
    
    UIView  *MainCellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
    
    MainCellView.backgroundColor = [UIColor clearColor];
    [cell addSubview:MainCellView];
    
    
    
    UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
    
    ImageView.backgroundColor = [UIColor clearColor];
    
    [MainCellView addSubview:ImageView];
    
    cell.textLabel.text=[item1 valueForKey:@"report_id"];
    cell.textLabel.hidden=YES;
    
    ZSImageView *imageView = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    
    imageView.defaultImage = [UIImage imageNamed:@"FH-noimage-circle.png"];
    
    imageView.imageUrl = [item1 objectForKey:@"report_image"];
    
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    imageView.clipsToBounds = YES;
    
    // imageView.corners = ZSRoundCornerAll;
    
    imageView.cornerRadius = 0;
    
    [ImageView addSubview:imageView];
    
    
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 5, 260, 25)];
    
    TitleLabel.backgroundColor = [UIColor clearColor];
    
    TitleLabel.font = [UIFont fontWithName:@"Arial" size:12];
    
    TitleLabel.textColor = UIColorFromRGB(0xfcb714);
    
    TitleLabel.text = [reportLableHelper stripTags:[item1 objectForKey:@"report_title"]];
    
    
    [MainCellView addSubview:TitleLabel];
    int TOTAL = 5;
    
    int YELLOW = [[item1 objectForKey:@"avg_rating"] intValue];
    
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
    
    
    UILabel *Numborofcmtlabl=[[UILabel alloc]initWithFrame:CGRectMake(150, 30, 80, 16)];
    Numborofcmtlabl.textColor=[UIColor darkGrayColor];
    Numborofcmtlabl.font=[UIFont fontWithName:@"Arial" size:11];
    NSString *detaString=[NSString stringWithFormat:@"%@ %@",[item1 objectForKey:@"total_comment_this_report"],@"Comment"];
    Numborofcmtlabl.text=detaString;
    [MainCellView addSubview:Numborofcmtlabl];
    UIView *sepateroview=[[UIView alloc]initWithFrame:CGRectMake(0, 69, 320, 1)];
    [sepateroview setBackgroundColor:[UIColor lightGrayColor]];
    [MainCellView addSubview:sepateroview];
    return cell;
    
}

-(void)loadAllReportofuser
{
    
    @try
    {
        
    
        NSString *urlString=[NSString stringWithFormat:@"%@useractivity.php?userid=%@&mode=report",Domenurl3,userid];
        NSLog(@"the string url:%@",urlString);
        NSURL *url=[NSURL URLWithString:urlString];
        NSData *data=[NSData dataWithContentsOfURL:url];
        NSDictionary *mainDictionary=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        
        
        for(NSDictionary *HigstRatedReport in [mainDictionary objectForKey:@"report_of_this_user"])
        {
            NSString *report_image = [HigstRatedReport objectForKey:@"report_image"];
            
            NSString *report_title = [HigstRatedReport objectForKey:@"report_title"];
            
            NSString *rating = [HigstRatedReport objectForKey:@"avg_rating"];
            
            NSString *reportID = [HigstRatedReport objectForKey:@"report_id"];
            NSString *totalcommet=[HigstRatedReport objectForKey:@"total_comment_this_report"];
          
            
            
            NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] initWithCapacity:5];
            
            [tempDict setObject: report_image forKey:@"report_image"];
            
            [tempDict setObject: report_title forKey:@"report_title"];
            
            [tempDict setObject: rating forKey:@"avg_rating"];
            
            [tempDict setObject: reportID forKey:@"report_id"];
            
            [tempDict setObject: totalcommet forKey:@"total_comment_this_report"];
            [ReportOftheuserArray addObject:tempDict];
            
           
        }
        [self performSelectorOnMainThread:@selector(ReportDetailsmaintablereloag) withObject:nil waitUntilDone:YES];
        
    }
    @catch (NSException *exception) {
        NSLog(@"the Exseption:%@",exception);
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    AppDelegate *MainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    ReportDetailsViewController *reportDetails = [[ReportDetailsViewController alloc] init];
    reportDetails.reportId=cell.textLabel.text;
    [MainDelegate SetUpTabbarControllerwithcenterView:reportDetails];
}

-(void)ReportDetailsmaintablereloag
{
    
    [reportLableHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
    [self.ShowallReportTbl reloadData];
}

@end
