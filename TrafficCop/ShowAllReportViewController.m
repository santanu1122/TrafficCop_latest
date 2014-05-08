//
//  ShowAllReportViewController.m
//  TrafficCop
//
//  Created by macbook_ms on 28/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//  http://esolzdemos.com/lab3/trafficcop/IOS/pages/useractivity.php?userid=28&mode=report

#import "ShowAllReportViewController.h"
#import "MFSideMenu.h"
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
@synthesize isBackEnabled;


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
    NSLog(@"ShowAllReportViewController.m--");
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    reportLableHelper=[[HelperClass alloc]init];
    operation=[[NSOperationQueue alloc]init];
      NSLog(@"the user id of the:%@",userid);
    [reportLableHelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    
    
    if(isBackEnabled==YES){
    [reportLableHelper SetupHeaderViewWithBack:self.view viewController:self];
    }else{
    [reportLableHelper SetupHeaderView:self.view viewController:self];
    }
    
    ReportOftheuserArray=[[NSMutableArray alloc]init];
    [self.navigationController setNavigationBarHidden:YES];
    [reportLableHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
    
    NSInvocationOperation *ShowallReport=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(loadAllReportofuser) object:nil];
    [operation addOperation:ShowallReport];
    
  
    
}
- (void)backButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
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

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 110.0f;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell=[[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, 320, 110)];
    
    NSLog(@"The indexpath of sectiopnm for report:%d",indexPath.section);
    [cell setFrame:CGRectMake(0, 0, 320, 110)];
    NSMutableDictionary *item1;
    NSLog(@"report tableview");
    item1 = [[NSMutableDictionary alloc] initWithDictionary:[ReportOftheuserArray objectAtIndex:indexPath.row]];
    
    UIView  *MainCellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 110)];
    
    MainCellView.backgroundColor = [UIColor clearColor];
    [cell addSubview:MainCellView];
    
    
    
    UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 16, 65, 65)];
    
    ImageView.backgroundColor = [UIColor clearColor];
    
    [MainCellView addSubview:ImageView];
    
    cell.textLabel.text=[item1 valueForKey:@"report_id"];
    cell.textLabel.hidden=YES;
    
    ZSImageView *imageView = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
    
    imageView.defaultImage = [UIImage imageNamed:@"NEWNOIMAGE.png"];
    
    imageView.imageUrl = [item1 objectForKey:@"report_image"];
    
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    imageView.clipsToBounds = YES;
    imageView.corners = ZSRoundCornerAll;
    imageView.cornerRadius = 25;
    
    [ImageView addSubview:imageView];
    
    
    
    UIImageView *ImageOverlay = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
    [ImageOverlay setImage:[UIImage imageNamed:@"out-line.png"]];
    [ImageView addSubview:ImageOverlay];
    
    
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, 225, 20)];
    
    TitleLabel.backgroundColor = [UIColor clearColor];
    
    TitleLabel.font = [UIFont fontWithName:GLOBALTEXTFONT_Title size:14];
    //TitleLabel.textColor = UIColorFromRGB(0x000000);
    TitleLabel.textColor = UIColorFromRGB(0x211e1f);
    
    TitleLabel.text = [reportLableHelper stripTags:[item1 objectForKey:@"report_title"]];
    
    TitleLabel.font = [UIFont fontWithName:GLOBALTEXTFONT_Title size:14];
    //TitleLabel.textColor = UIColorFromRGB(0x000000);
    TitleLabel.textColor = UIColorFromRGB(0x211e1f);
    
    
    [MainCellView addSubview:TitleLabel];
    int TOTAL = 5;
    
    int YELLOW = [[item1 objectForKey:@"avg_rating"] intValue];
    
    int GRAY = TOTAL - YELLOW;
    
    float SIZEX = 5;
    
    
    
    for(int i=0; i < YELLOW; i++) {
        
        if(i==0)
            
            SIZEX = 90;
        
        UIImageView *ImageViewone = [[UIImageView alloc] initWithFrame:CGRectMake(SIZEX, 35, 16, 16)];
        
        ImageViewone.backgroundColor = [UIColor clearColor];
        
        ImageViewone.image = [UIImage imageNamed:@"starNEW"];
        
        [MainCellView addSubview:ImageViewone];
        
        SIZEX = SIZEX + 20;
        
    }
    
    for(int j=0; j < GRAY; j++) {
        
        if(GRAY==5 && j==0)
            
            SIZEX = 90;
        
        UIImageView *ImageViewone = [[UIImageView alloc] initWithFrame:CGRectMake(SIZEX, 35, 16, 16)];
        
        ImageViewone.backgroundColor = [UIColor clearColor];
        
        ImageViewone.image = [UIImage imageNamed:@"star1NEW"];
        
        [MainCellView addSubview:ImageViewone];
        
        SIZEX = SIZEX + 20;
        
    }
    
    
    UILabel *Numborofcmtlabl=[[UILabel alloc]initWithFrame:CGRectMake(90, 55, 80, 25)];
    Numborofcmtlabl.font=[UIFont fontWithName:GLOBALTEXTFONT size:12];
    //        Numborofcmtlabl.textColor = UIColorFromRGB(0x575757);
    Numborofcmtlabl.textColor = UIColorFromRGB(0x000000);
    NSString *detaString=[NSString stringWithFormat:@"%@ %@",[item1 objectForKey:@"total_comment_this_report"],@"Comment"];
    Numborofcmtlabl.text=detaString;
    [MainCellView addSubview:Numborofcmtlabl];
    
    UILabel *Separetor=[[UILabel alloc]initWithFrame:CGRectMake(0, 109, 320, .5)];
    [Separetor setBackgroundColor:[UIColor blackColor]];
    Separetor.layer.opacity=0.5f;
    [MainCellView addSubview:Separetor];
    
    [cell.contentView addSubview:MainCellView];
        
    return cell;
    
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *MainHeaderView;
    
    MainHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [MainHeaderView setBackgroundColor:[UIColor whiteColor]];
    
    
//    UILabel *Titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 7, 320, 35)];
    UILabel *Titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(89, 7, 180, 35)];
    
    [MainHeaderView addSubview:Titlelabel];
//    if (section==0)
//    {
        Titlelabel.text=@"Reports of this user";
        Titlelabel.font = [UIFont fontWithName:GLOBALTEXTFONT_Title size:15];
        Titlelabel.textColor = UIColorFromRGB(0x211e1f);
//    }
//    else
//    {
//        Titlelabel.text=@"Comments of this user";
//        Titlelabel.font = [UIFont fontWithName:GLOBALTEXTFONT_Title size:15];
//        Titlelabel.textColor = UIColorFromRGB(0x211e1f);
//    }
    
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
    
//    AppDelegate *MainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    ReportDetailsViewController *reportDetails = [[ReportDetailsViewController alloc] init];
//    reportDetails.reportId=cell.textLabel.text;
//    [MainDelegate SetUpTabbarControllerwithcenterView:reportDetails];
    
    
    ReportDetailsViewController *reportDetails = [[ReportDetailsViewController alloc]initWithNibName:@"ReportDetailsViewController" bundle:nil];
    reportDetails.reportId=cell.textLabel.text;
    reportDetails.backBtnEnableInReportDetails = YES;
    
    [self.navigationController pushViewController:reportDetails animated:YES];
}

-(void)ReportDetailsmaintablereloag
{
    
    [reportLableHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
    [self.ShowallReportTbl reloadData];
}



- (void)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}


- (void)rightSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{}];
}




@end
