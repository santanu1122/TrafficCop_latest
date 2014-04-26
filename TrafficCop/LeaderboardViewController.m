//
//  LeaderboardViewController.m
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 22/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import "LeaderboardViewController.h"
#import "HelperClass.h"
#import "MFSideMenu.h"
#import "MostRecentReportsCell.h"
#import "ZSImageView.h"
#import "UserDetailesViewController.h"
#import "AppDelegate.h"

@interface LeaderboardViewController ()
{
    HelperClass *LeaderBoardHelper;
    NSMutableArray *DatasourceTableview;
    NSMutableData *webdata;
    NSURLConnection *connection;
}
@property (nonatomic,retain) IBOutlet UITableView *LeaderBoardTable;
@end

@implementation LeaderboardViewController

@synthesize LeaderBoardTable            = _LeaderBoardTable;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    LeaderBoardHelper = [[HelperClass alloc] init];
    [self HideNavigationBar];
    //ZSImageView *imageView = [[ZSImageView alloc] init];
    [LeaderBoardHelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    [LeaderBoardHelper SetupHeaderView:self.view viewController:self];
    
    _LeaderBoardTable.delegate = (id)self;
    _LeaderBoardTable.dataSource = (id)self;
    _LeaderBoardTable.hidden = YES;
    
    [LeaderBoardHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
    
    NSMutableDictionary *tempDictOne = [[NSMutableDictionary alloc] init];
    [tempDictOne setObject:@"leaderboard" forKey:@"mode"];
    
    NSString *REturnedURL = [LeaderBoardHelper CallURLForServerReturn:tempDictOne URL:LOGINPAGE];
    NSLog(@"The leader bord:%@",REturnedURL);
    NSURL *url = [NSURL URLWithString:REturnedURL];
    NSURLRequest *restrict1 = [NSURLRequest requestWithURL:url];
    connection = [NSURLConnection connectionWithRequest:restrict1 delegate:self];
    if(connection) {
        webdata = [[NSMutableData alloc]init];
    }
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [_LeaderBoardTable reloadData];
    [refreshControl endRefreshing];
}

-(void)refreshView:(UIRefreshControl *)refresh {
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"Last updated on %@",[formatter stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    [refresh endRefreshing];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSDictionary *allData = [NSJSONSerialization JSONObjectWithData:webdata options:0 error:nil];
    DatasourceTableview = [[NSMutableArray alloc] init];
    
    for(NSMutableDictionary *LeaderBoardData in [allData objectForKey:@"leaderdetails"]) {
        
        NSMutableDictionary *TempDictionary = [[NSMutableDictionary alloc] init];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"first_name"] forKey:@"first_name"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"last_name"] forKey:@"last_name"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"rank"] forKey:@"rank"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"totalcomment"] forKey:@"totalcomment"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"totalpoint"] forKey:@"totalpoint"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"totalreport"] forKey:@"totalreport"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"user_badge"] forKey:@"user_badge"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"user_image"] forKey:@"user_image"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"userid"] forKey:@"userid"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"username"] forKey:@"username"];
        
        [DatasourceTableview addObject:TempDictionary];
        
    }
    [LeaderBoardHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
    
    _LeaderBoardTable.hidden=NO;
    
    [_LeaderBoardTable reloadData];
}

/*
 Connection Receive Respose From Server
 */

#pragma mark
#pragma mark - UITableView Data Source

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [webdata setLength:0];
}

/*
 Connection Receive Data From Server and append the data
 */

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [webdata appendData:data];
}

/*
 Connection Failed To Get Data From Server
 */

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"err %@",error);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 145.0f;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   // @autoreleasepool {
        
       // static NSString *CellIdentifier = @"Cell";
        
        NSMutableDictionary *item = [[NSMutableDictionary alloc] initWithDictionary:[DatasourceTableview objectAtIndex:indexPath.row]];
        
        UITableViewCell *cell = [[UITableViewCell alloc]init];
             UIView *MainCEllView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, cell.contentView.frame.size.height)];
             
             // create user profile imageview
        
             UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
             ImageView.backgroundColor = [UIColor clearColor];
             [MainCEllView addSubview:ImageView];
        
             ZSImageView *imageView = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
             imageView.defaultImage = [UIImage imageNamed:@"FH-noimage-circle.png"];
             imageView.imageUrl = [item objectForKey:@"user_image"];
             imageView.contentMode = UIViewContentModeScaleAspectFill;
             imageView.clipsToBounds = YES;
             // imageView.corners = ZSRoundCornerAll;
             imageView.cornerRadius = 0;
             [ImageView addSubview:imageView];
        
        
        UIImageView *ImageViewBadghe = [[UIImageView alloc] initWithFrame:CGRectMake(15, 65, 25, 25)];
        ImageViewBadghe.backgroundColor = [UIColor clearColor];
        [MainCEllView addSubview:ImageViewBadghe];
        
        ZSImageView *imageViewBadge = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        imageViewBadge.imageUrl = [item objectForKey:@"user_badge"];
        imageViewBadge.contentMode = UIViewContentModeScaleAspectFill;
        imageViewBadge.clipsToBounds = YES;
        imageViewBadge.cornerRadius = 0;
        [ImageViewBadghe addSubview:imageViewBadge];
        
        
          UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 250, 25)];
          TitleLabel.backgroundColor = [UIColor clearColor];
          TitleLabel.font = [UIFont fontWithName:@"Arial" size:16];
          TitleLabel.textColor = UIColorFromRGB(0xfcb714);
         TitleLabel.text = [item objectForKey:@"username"];//[NSString stringWithFormat:@"%@ %@",[[LeaderBoardHelper stripTags:[item objectForKey:@"first_name"]] capitalizedString],[[LeaderBoardHelper stripTags:[item objectForKey:@"last_name"]] capitalizedString]];
        [MainCEllView addSubview:TitleLabel];
        
        // Label for show rank
        
        UIView *documentViewRank = [[UIView alloc] initWithFrame:CGRectMake(65, 35, 250, 20)];
        
        [LeaderBoardHelper CreateImageviewWithImage:documentViewRank xcord:0 ycord:3 width:15 height:15 backgroundColor:[UIColor clearColor] imageName:@"SMALL_BADGHE"];
        
        UILabel *LabelTitleRank = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 70, 20)];
        LabelTitleRank.backgroundColor = [UIColor clearColor];
        LabelTitleRank.font = [UIFont fontWithName:@"Arial" size:12];
        LabelTitleRank.textColor = UIColorFromRGB(0x000000);
        LabelTitleRank.text = @"Rank :";
        [documentViewRank addSubview:LabelTitleRank];
    
        cell.textLabel.text=[item valueForKey:@"userid"];
        cell.textLabel.hidden=YES;
        NSLog(@"the cell text lable is :%@",cell.textLabel.text);
        UILabel *LabelTitleRankText = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 130, 20)];
        LabelTitleRankText.backgroundColor = [UIColor clearColor];
        LabelTitleRankText.font = [UIFont fontWithName:@"Arial" size:12];
        LabelTitleRankText.textColor = UIColorFromRGB(0x000000);
        LabelTitleRankText.text = [NSString stringWithFormat:@"%@",[item objectForKey:@"rank"]];
        [documentViewRank addSubview:LabelTitleRankText];

        [documentViewRank setBackgroundColor:[UIColor clearColor]];
        [MainCEllView addSubview:documentViewRank];
        
        // Label for show username
        
        UIView *documentViewUsername = [[UIView alloc] initWithFrame:CGRectMake(65, 55, 250, 20)];
        
        [LeaderBoardHelper CreateImageviewWithImage:documentViewUsername xcord:0 ycord:3 width:15 height:15 backgroundColor:[UIColor clearColor] imageName:@"SMALL_USER"];
        
        UILabel *LabelTitleUsername = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 70, 20)];
        LabelTitleUsername.backgroundColor = [UIColor clearColor];
        LabelTitleUsername.font = [UIFont fontWithName:@"Arial" size:12];
        LabelTitleUsername.textColor = UIColorFromRGB(0x000000);
        LabelTitleUsername.text = @"Username :";
        [documentViewUsername addSubview:LabelTitleUsername];
        
        UILabel *LabelTitleUsernameText = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 130, 20)];
        LabelTitleUsernameText.backgroundColor = [UIColor clearColor];
        LabelTitleUsernameText.font = [UIFont fontWithName:@"Arial" size:12];
        LabelTitleUsernameText.textColor = UIColorFromRGB(0x000000);
        LabelTitleUsernameText.text = [NSString stringWithFormat:@"%@",[item objectForKey:@"username"]];
        [documentViewUsername addSubview:LabelTitleUsernameText];
        
        [documentViewUsername setBackgroundColor:[UIColor clearColor]];
        [MainCEllView addSubview:documentViewUsername];
        
        // Label for show reports
        
        UIView *documentViewReports = [[UIView alloc] initWithFrame:CGRectMake(65, 75, 250, 20)];
        
        [LeaderBoardHelper CreateImageviewWithImage:documentViewReports xcord:0 ycord:3 width:15 height:15 backgroundColor:[UIColor clearColor] imageName:@"SMALL_BADGHE"];
        
        UILabel *LabelTitleReports = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 70, 20)];
        LabelTitleReports.backgroundColor = [UIColor clearColor];
        LabelTitleReports.font = [UIFont fontWithName:@"Arial" size:12];
        LabelTitleReports.textColor = UIColorFromRGB(0x000000);
        LabelTitleReports.text = @"Reports :";
        [documentViewReports addSubview:LabelTitleReports];
        
        UILabel *LabelTitleReportsText = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 130, 20)];
        LabelTitleReportsText.backgroundColor = [UIColor clearColor];
        LabelTitleReportsText.font = [UIFont fontWithName:@"Arial" size:12];
        LabelTitleReportsText.textColor = UIColorFromRGB(0x000000);
        LabelTitleReportsText.text = [NSString stringWithFormat:@"%@ reports",[item objectForKey:@"totalreport"]];
        [documentViewReports addSubview:LabelTitleReportsText];
        
        [documentViewReports setBackgroundColor:[UIColor clearColor]];
        [MainCEllView addSubview:documentViewReports];
        
        // Label for show comments
        
        UIView *documentViewComments = [[UIView alloc] initWithFrame:CGRectMake(65, 95, 250, 20)];
        
        [LeaderBoardHelper CreateImageviewWithImage:documentViewComments xcord:0 ycord:3 width:15 height:15 backgroundColor:[UIColor clearColor] imageName:@"SMALL_COMMENT"];
        
        UILabel *LabelTitleComments = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 70, 20)];
        LabelTitleComments.backgroundColor = [UIColor clearColor];
        LabelTitleComments.font = [UIFont fontWithName:@"Arial" size:12];
        LabelTitleComments.textColor = UIColorFromRGB(0x000000);
        LabelTitleComments.text = @"Comments :";
        [documentViewComments addSubview:LabelTitleComments];
        
        UILabel *LabelTitleCommentsText = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 130, 20)];
        LabelTitleCommentsText.backgroundColor = [UIColor clearColor];
        LabelTitleCommentsText.font = [UIFont fontWithName:@"Arial" size:12];
        LabelTitleCommentsText.textColor = UIColorFromRGB(0x000000);
        LabelTitleCommentsText.text = [NSString stringWithFormat:@"%@ comments",[item objectForKey:@"totalcomment"]];
        [documentViewComments addSubview:LabelTitleCommentsText];
        
        [documentViewComments setBackgroundColor:[UIColor clearColor]];
        [MainCEllView addSubview:documentViewComments];
        
        
        // Label for show total points
        
        UIView *documentViewTotalpoints = [[UIView alloc] initWithFrame:CGRectMake(65, 115, 250, 20)];
        
        [LeaderBoardHelper CreateImageviewWithImage:documentViewTotalpoints xcord:0 ycord:3 width:15 height:15 backgroundColor:[UIColor clearColor] imageName:@"SMALL_USER"];
        
        UILabel *LabelTitleTotalpoints = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 70, 20)];
        LabelTitleTotalpoints.backgroundColor = [UIColor clearColor];
        LabelTitleTotalpoints.font = [UIFont fontWithName:@"Arial" size:12];
        LabelTitleTotalpoints.textColor = UIColorFromRGB(0x000000);
        LabelTitleTotalpoints.text = @"Total Points :";
        [documentViewTotalpoints addSubview:LabelTitleTotalpoints];
        
        UILabel *LabelTitleTotalpointsText = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 130, 20)];
        LabelTitleTotalpointsText.backgroundColor = [UIColor clearColor];
        LabelTitleTotalpointsText.font = [UIFont fontWithName:@"Arial" size:12];
        LabelTitleTotalpointsText.textColor = UIColorFromRGB(0x000000);
        LabelTitleTotalpointsText.text = [NSString stringWithFormat:@"%@ points",[item objectForKey:@"totalpoint"]];
        [documentViewTotalpoints addSubview:LabelTitleTotalpointsText];
        
        [documentViewTotalpoints setBackgroundColor:[UIColor clearColor]];
        [MainCEllView addSubview:documentViewTotalpoints];
             
             [MainCEllView setBackgroundColor:[UIColor clearColor]];
             [cell.contentView addSubview:MainCEllView];
    
        return cell;
    }


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [DatasourceTableview count];
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *MainHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    MainHeaderView.backgroundColor = [UIColor whiteColor];
    UILabel *Titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 320, 35)];
    Titlelabel.text = @"Leader Board";
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
    AppDelegate *appdel=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    UserDetailesViewController *userdetais=[[UserDetailesViewController alloc]initWithNibName:@"UserDetailesViewController" bundle:nil];
    userdetais.userId=cell.textLabel.text;
    [appdel SetUpTabbarControllerwithcenterView:userdetais];
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
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

@end
