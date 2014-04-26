//
//  UserDetailesViewController.m
//  TrafficCop
//
//  Created by macbook_ms on 25/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.

#import "UserDetailesViewController.h"
#import "MFSideMenu.h"
#import "ZSImageView.h"

#import "AppDelegate.h"
#import "ShowAllReportViewController.h"
#import "AppDelegate.h"

@interface UserDetailesViewController ()
{
    // NSString *userId;
    ImageLoader *loadImage;
    NSOperationQueue *operation;
    NSMutableArray *Storebrodgetimage;
    NSInteger k;
    NSDictionary *mainDictionary;
    
}

@end

@implementation UserDetailesViewController

@synthesize reportcmtlbl;
@synthesize commentlbl;
@synthesize pointlbl;
@synthesize reportpointresultlbl;
@synthesize reportresultlbl;
@synthesize reportlbl;
@synthesize userId;

@synthesize profileImage;




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
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    k=0;
    operation=[[NSOperationQueue alloc]init];
    //self.nmpaginator.delegate=self;
    self.commentTbl.delegate=self;
    self.commentTbl.dataSource=self;
    self.reportTbl.delegate=self;
    self.reportTbl.dataSource=self;
    UserDetailhelper=[[HelperClass alloc]init];
    [UserDetailhelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    [UserDetailhelper SetupHeaderView:self.view viewController:self];
    
    loadImage=[[ImageLoader alloc]init];
    reportOfuserlableArray=[[NSMutableArray alloc]init];
    CommentsofUserArray=[[NSMutableArray alloc]init];
    [self preparefastrow];
    // userId=@"28";
    
    [UserDetailhelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
    [self.navigationController setNavigationBarHidden:YES];
    
    
    
    
    
    
    [UserDetailhelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
    
    [self performSelectorOnMainThread:@selector(detailforuser) withObject:nil waitUntilDone:YES];
//    NSInvocationOperation *mainoperation=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(detailforuser) object:nil];
//    [operation addOperation:mainoperation];
    
}
- (IBAction) handleSingleTapOnFooter: (id *) sender
{
    NSLog(@"The footer was tapped!");
    AppDelegate *maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [maindelegate SetUpTabbarController];
    ShowAllCommentViewController *showCmt = [[ShowAllCommentViewController alloc] initWithNibName:@"ShowAllCommentViewController" bundle:Nil];
    showCmt.theUserString=userId;
    [maindelegate SetUpTabbarControllerwithcenterView:showCmt];
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *MainHeaderView;
    
    MainHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [MainHeaderView setBackgroundColor:[UIColor whiteColor]];
    
    
    UILabel *Titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 7, 320, 35)];
    
    [MainHeaderView addSubview:Titlelabel];
    if (section==0)
        Titlelabel.text=@"Reports of this user";
    else
        Titlelabel.text=@"Comments of this user";
    
    
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
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
        return 70.0f;
    
    else
        return 100.0f;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 30.0f;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [footerView setBackgroundColor:[UIColor clearColor]];
    
    if (section==0) {
        if([reportOfuserlableArray count] > 0) {
             UIView *Reportnil = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
             [Reportnil setBackgroundColor:[UIColor clearColor]];
             [footerView addSubview:Reportnil];
             UIButton *ShowAllSimilerreport=[UIButton buttonWithType:UIButtonTypeCustom];
             [ShowAllSimilerreport setBackgroundColor:UIColorFromRGB(0x17b04a)];
             ShowAllSimilerreport.frame=CGRectMake(10, 5, 300, 20);
            
             [ShowAllSimilerreport setTitle:@"Show all Reports" forState:UIControlStateNormal];
             [ShowAllSimilerreport setTitle:@"Show all Reports" forState:UIControlStateHighlighted];
             [ShowAllSimilerreport setTitle:@"Show all Reports" forState:UIControlStateSelected];
             [ShowAllSimilerreport setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             [ShowAllSimilerreport setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
             [ShowAllSimilerreport setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            
            
             ShowAllSimilerreport.titleLabel.font=[UIFont fontWithName:globalTEXTFIELDPLACEHOLDERFONT size:17.f];
            
            [ShowAllSimilerreport addTarget:self action:@selector(GotoTheAllreportPage:) forControlEvents:UIControlEventTouchUpInside];
            [Reportnil addSubview:ShowAllSimilerreport];
            

    
         
        } else {
            UIView *ReportNull = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
            UILabel *Nodatalebl = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 320, 15)];
            Nodatalebl.textColor = [UIColor blackColor];
            Nodatalebl.text = @"No Reports are there";
            Nodatalebl.textAlignment = NSTextAlignmentCenter;
            [Nodatalebl setBackgroundColor:[UIColor clearColor]];
            [ReportNull addSubview:Nodatalebl];
            footerView = ReportNull;
        }
        
    } if (section==1) {
        
        if([CommentsofUserArray count] > 0) {
            UIView *Reportnil1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
            [Reportnil1 setBackgroundColor:[UIColor clearColor]];
            [footerView addSubview:Reportnil1];
            UIButton *ShowAllSimilercomment=[UIButton buttonWithType:UIButtonTypeCustom];
            [ShowAllSimilercomment setBackgroundColor:UIColorFromRGB(0x17b04a)];
            ShowAllSimilercomment.frame=CGRectMake(10, 10, 300, 20);
            
            [ShowAllSimilercomment setTitle:@"Show all Comment" forState:UIControlStateNormal];
            [ShowAllSimilercomment setTitle:@"Show all Comment" forState:UIControlStateHighlighted];
            [ShowAllSimilercomment setTitle:@"Show all Comment" forState:UIControlStateSelected];
            [ShowAllSimilercomment setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [ShowAllSimilercomment setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [ShowAllSimilercomment setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            
            
            ShowAllSimilercomment.titleLabel.font=[UIFont fontWithName:globalTEXTFIELDPLACEHOLDERFONT size:17.f];
            
            [ShowAllSimilercomment addTarget:self action:@selector(handleSingleTapOnFooter:) forControlEvents:UIControlEventTouchUpInside];
            [Reportnil1 addSubview:ShowAllSimilercomment];
                                        }
        else {
            UIView *ReportNull = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
            UILabel *Nodatalebl = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 320, 15)];
            Nodatalebl.textColor = [UIColor blackColor];
            Nodatalebl.text = @"No Comments are there";
            Nodatalebl.textAlignment = NSTextAlignmentCenter;
            [Nodatalebl setBackgroundColor:[UIColor clearColor]];
            [ReportNull addSubview:Nodatalebl];
            footerView = ReportNull;
        }
    }
    
    
    return footerView;
    
}



-(IBAction)GotoTheAllreportPage:(id)sender
{
    
   
    AppDelegate *maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [maindelegate SetUpTabbarController];
    ShowAllReportViewController *showreport = [[ShowAllReportViewController alloc] initWithNibName:@"ShowAllReportViewController" bundle:nil];
    showreport.userid=userId;
    
    
    [maindelegate SetUpTabbarControllerwithcenterView:showreport];
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UITableViewCell *cell;
    cell=[[UITableViewCell alloc]init];
    
    if (indexPath.section==1)
    {
        NSMutableDictionary *item;
        
        
        [cell setFrame:CGRectMake(0, 0, 320, 105)];
        item = [[NSMutableDictionary alloc] initWithDictionary:[CommentsofUserArray objectAtIndex:indexPath.row]];
        UIView  *MainCellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 105)];
        
        MainCellView.backgroundColor = [UIColor clearColor];
        
        
        
        UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        
        ImageView.backgroundColor = [UIColor clearColor];
        
        [MainCellView addSubview:ImageView];
        
        
        
        ZSImageView *imageView = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 10, 40, 40)];
        
        imageView.defaultImage = [UIImage imageNamed:@"FH-noimage-circle.png"];
        
        imageView.imageUrl = [item objectForKey:@"report_image"];
        
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        imageView.clipsToBounds = YES;
        
        // imageView.corners = ZSRoundCornerAll;
        
        imageView.cornerRadius = 0;
        
        [ImageView addSubview:imageView];
        
        UILabel *ReportLable=[[UILabel alloc]initWithFrame:CGRectMake(45, 10, 30,22)];
        
        ReportLable.font=[UIFont fontWithName:@"Arial" size:8];
        ReportLable.text=@"Report: ";
        ReportLable.textColor=[UIColor darkGrayColor];
        [MainCellView addSubview:ReportLable];
        UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 10, 250, 22)];
        
        TitleLabel.backgroundColor = [UIColor clearColor];
        
        TitleLabel.font = [UIFont fontWithName:@"Arial" size:12];
        
        TitleLabel.textColor = UIColorFromRGB(0xfcb714);
        
        TitleLabel.text = [UserDetailhelper stripTags:[item objectForKey:@"reporttitle"]];
        TitleLabel.numberOfLines = 2;
        
        TitleLabel.textAlignment = NSTextAlignmentLeft;
        
        [MainCellView addSubview:TitleLabel];
        
        UIImageView *reportimage=[[UIImageView alloc]initWithFrame:CGRectMake(75, 34, 100, 16)];
        [MainCellView addSubview:reportimage];
        ZSImageView *ReatingimageView = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 0,100, 16)];
        
        //ReatingimageView.defaultImage = [UIImage imageNamed:@"FH-noimage-circle.png"];
        
        ReatingimageView.imageUrl = [item objectForKey:@"rating"];
        
        ReatingimageView.contentMode = UIViewContentModeScaleAspectFill;
        
        ReatingimageView.clipsToBounds = YES;
        
        // imageView.corners = ZSRoundCornerAll;
        
        ReatingimageView.cornerRadius = 0;
        [reportimage addSubview:ReatingimageView];
        //[ImageView addSubview:ReatingimageView];
        
        
        UILabel *Detailslabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 310, 35)];
        
        Detailslabel.backgroundColor = [UIColor clearColor];
        
        Detailslabel.font = [UIFont fontWithName:@"Arial" size:12];
        
        Detailslabel.textColor = UIColorFromRGB(0x1aad4b);
        
        Detailslabel.text = [UserDetailhelper stripTags:[item objectForKey:@"review"]];
        
        Detailslabel.numberOfLines = 0;
        
        Detailslabel.textAlignment = NSTextAlignmentLeft;
        
        
        
        [MainCellView addSubview:Detailslabel];
        [cell.contentView addSubview:MainCellView];
    }
    else
    {
        
        NSLog(@"The indexpath of sectiopnm for report:%d",indexPath.section);
        [cell setFrame:CGRectMake(0, 0, 320, 70)];
        NSMutableDictionary *item1;
        NSLog(@"report tableview");
        item1 = [[NSMutableDictionary alloc] initWithDictionary:[reportOfuserlableArray objectAtIndex:indexPath.row]];
        
        UIView  *MainCellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
        
        MainCellView.backgroundColor = [UIColor clearColor];
        [cell addSubview:MainCellView];
        
        
        
        UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
        
        ImageView.backgroundColor = [UIColor clearColor];
        
        [MainCellView addSubview:ImageView];
        
        
        
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
        
        TitleLabel.text = [UserDetailhelper stripTags:[item1 objectForKey:@"report_title"]];
        
        
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
        
        
    }
    
    
    return cell;
}







- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger nomberofrow;
    
    if (section==0)
        nomberofrow = ([reportOfuserlableArray count] > 3)?3:[reportOfuserlableArray count];
    if (section==1)
        nomberofrow= ([CommentsofUserArray count] > 3)?3:[CommentsofUserArray count];
    
    return nomberofrow;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

#pragma mark - UIScrollViewDelegate Methods




-(void)preparefastrow
{
    self.lable1.font=[UIFont fontWithName:@"Arial" size:14];
    self.lable1.textColor=UIColorFromRGB(0x6b6b6b);
    reportlbl.textColor=UIColorFromRGB(0x606078);
    reportlbl.font=[UIFont fontWithName:@"Arial" size:12];
    commentlbl.textColor=UIColorFromRGB(0x606078);
    commentlbl.font=[UIFont fontWithName:@"Arial" size:12];
    pointlbl.textColor=UIColorFromRGB(0x606078);
    pointlbl.font=[UIFont fontWithName:@"Arial" size:12];
    reportpointresultlbl.font=[UIFont fontWithName:@"Arial" size:10];
    reportpointresultlbl.textColor=UIColorFromRGB(0x333333);
    reportresultlbl.font=[UIFont fontWithName:@"Arial" size:10];
    reportresultlbl.textColor=UIColorFromRGB(0x333333);
    reportcmtlbl.font=[UIFont fontWithName:@"Arial" size:10];
    reportcmtlbl.textColor=UIColorFromRGB(0x0333333);
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma UITableviewDetaSource


-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 40.0f;
    
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

-(void)detailforuser
{
    @try {
        
        NSString *urlString=[NSString stringWithFormat:@"%@userdashboard.php?userid=%@",Domenurl3,userId];
        NSLog(@"the string url:%@",urlString);
        NSURL *url=[NSURL URLWithString:urlString];
        NSData *data=[NSData dataWithContentsOfURL:url];
        mainDictionary=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSDictionary *userDic=[mainDictionary valueForKey:@"userdetails"];
        
        self.lable1.text=[userDic valueForKey:@"name"];
        
        reportresultlbl.text=[NSString stringWithFormat:@"%@ %@",[userDic valueForKey:@"total_report"],@"Report"];
        
        reportcmtlbl.text=[NSString stringWithFormat:@"%@ %@",[userDic valueForKey:@"total_comments"],@"Comment" ];
        reportpointresultlbl.text=[NSString stringWithFormat:@"%@ %@",[userDic valueForKey:@"userpoints"], @"Point"];
       
        
        NSString *userimage=[userDic valueForKey:@"userimage"];
        NSArray *ObjectCarrier=[[NSArray alloc] initWithObjects:profileImage , userimage, @"51", @"Fill", nil];
        [loadImage LoadImage:ObjectCarrier];
        NSDictionary *extraparam=[mainDictionary valueForKey:@"extraparam"];
        NSString *totalreport=[extraparam valueForKey:@"total_report"];
        NSString *totalcmt=[extraparam valueForKey:@"total_comment"];
      
    
             if ([totalcmt integerValue]>0) {
            for(NSDictionary *HigstRatedReport in [mainDictionary objectForKey:@"comment_of_this_user"])
            {
                
                
                
                NSString *report_image = [HigstRatedReport objectForKey:@"userimage"];
                
                NSString *report_title = [HigstRatedReport objectForKey:@"reporttitle"];
                
                NSString *rating = [HigstRatedReport objectForKey:@"rating"];
                
                NSString *reportID = [HigstRatedReport objectForKey:@"reportid"];
                
                NSString *guistId = [HigstRatedReport objectForKey:@"getuserid"];
                
                NSString *review=[HigstRatedReport objectForKey:@"review"];
                
                
                NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] initWithCapacity:6];
                
                [tempDict setObject: report_image forKey:@"userimage"];
                
                [tempDict setObject: report_title forKey:@"reporttitle"];
                
                [tempDict setObject: rating forKey:@"rating"];
                
                [tempDict setObject: reportID forKey:@"reportid"];
                
                [tempDict setObject: guistId forKey:@"getuserid"];
                [tempDict setObject: review forKey:@"review"];
                [CommentsofUserArray addObject:tempDict];
                
            }
            

        }
        
        if ([totalreport integerValue]>0) {
            NSArray *reportofthisuserArray=[mainDictionary objectForKey:@"report_of_this_user"];
            
            
            for (NSDictionary *reportDic in reportofthisuserArray)
            {
                NSString *reportid=[reportDic valueForKey:@"report_id"];
                NSString *Reportimage=[reportDic valueForKey:@"report_image"];
                NSString *totalCmtthisrpt=[reportDic valueForKey:@"total_comment_this_report"];
                NSString *reportTitle=[reportDic valueForKey:@"report_title"];
                NSString *averagratring=[reportDic valueForKey:@"avg_rating"];
                NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] initWithCapacity:6];
                
                [tempDict setObject: reportid forKey:@"report_id"];
                
                [tempDict setObject: Reportimage forKey:@"report_image"];
                
                [tempDict setObject: totalCmtthisrpt forKey:@"total_comment_this_report"];
                
                [tempDict setObject: reportTitle forKey:@"report_title"];
                
                [tempDict setObject: averagratring forKey:@"avg_rating"];
                
                [reportOfuserlableArray addObject:tempDict];
            }

        }
        
        
        for (NSDictionary *bordDic in [mainDictionary valueForKey:@"badgelist"])
        {
            
            NSString *strBodimage=[bordDic valueForKey:@"badge"];
            UIActivityIndicatorView *spinner=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(5+60*k+5, 5, 10, 20)];
            spinner.color=[UIColor blueColor];
            
            [spinner setTag:129];
            
            UIView *imageBackground=[[UIView alloc]initWithFrame:CGRectMake(55*k+10, 5, 50, 50)];
            [imageBackground setBackgroundColor:UIColorFromRGB(0xf2f2f2)];
            imageBackground.layer.borderColor=[UIColor lightGrayColor].CGColor;
            imageBackground.layer.borderWidth=1.0f;
            
            UIImageView *thebudgetImage=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
            [imageBackground addSubview:thebudgetImage];
            
            NSArray *ObjectCarrier=[[NSArray alloc] initWithObjects:thebudgetImage , strBodimage, @"129", @"Fill", nil];
            [loadImage LoadImage:ObjectCarrier];
            [self.brodGateScroll addSubview:imageBackground];
            
            k++;
            
        }
 
        
    }
    @catch (NSException *exception)
    {
        NSLog(@"the exeption is:%@",exception);
    }
    
}




- (void)awakeFromNib

{
    
    [super awakeFromNib];
    
}


@end
@implementation ImageLoader


-(void)LoadImage:(NSArray *)Param
{
    OperationQueueForImageLoader=[[NSOperationQueue alloc] init];
    NSInvocationOperation *LocalOperation=[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(DownloadImage:) object:Param];
    
    [OperationQueueForImageLoader addOperation:LocalOperation];
    
}

-(void)spinnerStart:(UIActivityIndicatorView *)Spinner
{
    [Spinner startAnimating];
    [Spinner setHidden:NO];
}


-(void)DownloadImage:(NSArray *)Param
{
    @try
    {
        UIImage *friendImage;
        
        friendImage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:(NSString *)[Param objectAtIndex:1]]]];
        
        UIActivityIndicatorView *SpinnerView=(UIActivityIndicatorView *)[[[Param objectAtIndex:0] superview] viewWithTag:[[Param objectAtIndex:2] integerValue]];
        //[SpinnerView startAnimating];
        [self performSelectorOnMainThread:@selector(spinnerStart:) withObject:SpinnerView waitUntilDone:NO];
        
        
        NSArray *ObjectCarrier=[[NSArray alloc] initWithObjects:[Param objectAtIndex:0] ,friendImage, [Param objectAtIndex:2],[Param objectAtIndex:[Param count]-1], nil];
        [self performSelectorOnMainThread:@selector(ReportWhenDone:) withObject:ObjectCarrier waitUntilDone:YES];
    }
    @catch (NSException *juju)
    {
        
        NSLog(@"Reporting JUJU From DownloadImage:: %@", juju);
    }
}

-(void)ReportWhenDone:(NSArray *)Param
{
    @try
    {
        UIImageView *friendImage=(UIImageView *)[Param objectAtIndex:0];
        [friendImage setImage:(UIImage *)[Param objectAtIndex:1]];
        [friendImage setContentMode:UIViewContentModeScaleToFill];
        UIActivityIndicatorView *SpinnerView=(UIActivityIndicatorView *)[[friendImage superview] viewWithTag:[[Param objectAtIndex:2] integerValue]];
        [SpinnerView stopAnimating];
        [SpinnerView setHidden:YES];
    }
    @catch (NSException *juju)
    {
        
        NSLog(@"Reporting JUJU From ReportWhenDone:: :: %@", juju);
    }
}


@end




