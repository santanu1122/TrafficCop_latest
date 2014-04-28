//
//  LeaderboardViewController.m
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 22/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import "UserlistViewController.h"
#import "HelperClass.h"
#import "MFSideMenu.h"
#import "MostRecentReportsCell.h"
#import "ZSImageView.h"
#import "UserDetailesViewController.h"
#import "AppDelegate.h"

@interface UserlistViewController () {
    HelperClass *UserListHelper;
    NSMutableArray *DatasourceTableview;
    NSMutableData *webdata;
    NSURLConnection *connection;
    NSUserDefaults *Fetchuserdata;
    NSOperationQueue *operationQ;
}
@property (nonatomic,retain) IBOutlet UITableView *UserListTable;
@property (strong, nonatomic) IBOutlet UIView *Noresultfound;
@property (nonatomic, strong) UITextField *SearchUserTextField;
@end

@implementation UserlistViewController

@synthesize UserListTable            = _UserListTable;
@synthesize SearchUserTextField;
@synthesize Noresultfound;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    Noresultfound.hidden=YES;
    UserListHelper = [[HelperClass alloc] init];
    operationQ=[[NSOperationQueue alloc]init];
    [self HideNavigationBar];
    //ZSImageView *imageView = [[ZSImageView alloc] init];
    [UserListHelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    [UserListHelper SetupHeaderView:self.view viewController:self];
    SearchUserTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 55, 200, 20)];
    SearchUserTextField.delegate = (id)self;
    SearchUserTextField.placeholder = @"Search by name:";
    SearchUserTextField.textColor = UIColorFromRGB(0xc5c5c5);
    _UserListTable.delegate = (id)self;
    _UserListTable.dataSource = (id)self;
    _UserListTable.hidden = YES;
    
    [UserListHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
    
    
     Fetchuserdata = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *tempDictOne = [[NSMutableDictionary alloc] init];
    [tempDictOne setObject:@"userlist" forKey:@"mode"];
    [tempDictOne setObject:[Fetchuserdata objectForKey:@"userid"] forKey:@"loginuser"];
    
    NSString *REturnedURL = [UserListHelper CallURLForServerReturn:tempDictOne URL:LOGINPAGE];
    NSLog(@"REturnedURL ---- %@",REturnedURL);
    NSURL *url = [NSURL URLWithString:REturnedURL];
    NSURLRequest *restrict1 = [NSURLRequest requestWithURL:url];
    connection = [NSURLConnection connectionWithRequest:restrict1 delegate:self];
    if(connection) {
        webdata = [[NSMutableData alloc]init];
    }
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [_UserListTable reloadData];
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
    
    for(NSMutableDictionary *LeaderBoardData in [allData objectForKey:@"userlist"]) {
        
        NSMutableDictionary *TempDictionary = [[NSMutableDictionary alloc] init];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"first_name"] forKey:@"first_name"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"last_name"] forKey:@"last_name"];
        //[TempDictionary setObject:[LeaderBoardData objectForKey:@"rank"] forKey:@"rank"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"totalcomment"] forKey:@"totalcomment"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"totalpoint"] forKey:@"totalpoint"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"totalreport"] forKey:@"totalreport"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"user_badge"] forKey:@"user_badge"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"user_image"] forKey:@"user_image"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"userid"] forKey:@"userid"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"username"] forKey:@"username"];
        
        [DatasourceTableview addObject:TempDictionary];
        
    }
    [UserListHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
    
    _UserListTable.hidden=NO;
    
    [_UserListTable reloadData];
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
    return 125.0f;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate *MainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UserDetailesViewController *UserDetails = [[UserDetailesViewController alloc] init];
    UserDetails.userId = [[DatasourceTableview objectAtIndex:indexPath.row] objectForKey:@"userid"];
    [MainDelegate SetUpTabbarControllerwithcenterView:UserDetails];
    
    NSLog(@"userid --- %@",[[DatasourceTableview objectAtIndex:indexPath.row] objectForKey:@"userid"]);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    @autoreleasepool {
        
        // static NSString *CellIdentifier = @"Cell";
        
        NSMutableDictionary *item = [[NSMutableDictionary alloc] initWithDictionary:[DatasourceTableview objectAtIndex:indexPath.row]];
        
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        UIView *MainCEllView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, cell.contentView.frame.size.height)];
        
        // create user profile imageview
        
//        UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
        
        UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 16, 65, 65)];
        ImageView.backgroundColor = [UIColor clearColor];
        [MainCEllView addSubview:ImageView];
        
        ZSImageView *imageView = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
        //imageView.defaultImage = [UIImage imageNamed:@"FH-noimage-circle.png"];
        imageView.defaultImage = [UIImage imageNamed:@"NEWNOIMAGE.png"];
        imageView.imageUrl = [item objectForKey:@"user_image"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
         imageView.corners = ZSRoundCornerAll;
        imageView.cornerRadius = 25;
        [ImageView addSubview:imageView];
        
        UIImageView *ImageOverlay = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
        [ImageOverlay setImage:[UIImage imageNamed:@"out-line.png"]];
        [ImageView addSubview:ImageOverlay];
        
        
        
        
        
        UIImageView *ImageViewBadghe = [[UIImageView alloc] initWithFrame:CGRectMake(15, 65, 25, 25)];
        ImageViewBadghe.backgroundColor = [UIColor clearColor];
        [MainCEllView addSubview:ImageViewBadghe];
        
        ZSImageView *imageViewBadge = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        imageViewBadge.imageUrl = [item objectForKey:@"user_badge"];
        imageViewBadge.contentMode = UIViewContentModeScaleAspectFill;
        imageViewBadge.clipsToBounds = YES;
        imageViewBadge.cornerRadius = 0;
        [ImageViewBadghe addSubview:imageViewBadge];
        
        
        UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, 250, 25)];
        TitleLabel.backgroundColor = [UIColor clearColor];
        TitleLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:16];
        TitleLabel.textColor = UIColorFromRGB(0x211e1f);
        TitleLabel.text = [item valueForKey:@"username"];//[NSString stringWithFormat:@"%@ %@",[[UserListHelper stripTags:[item objectForKey:@"first_name"]] capitalizedString],[[UserListHelper stripTags:[item objectForKey:@"last_name"]] capitalizedString]];
        [MainCEllView addSubview:TitleLabel];
        

        
       // UIView *documentViewUsername = [[UIView alloc] initWithFrame:CGRectMake(65, 35, 250, 20)];
        
        //[UserListHelper CreateImageviewWithImage:documentViewUsername xcord:0 ycord:3 width:18 height:18 backgroundColor:[UIColor clearColor] imageName:@"SMALL_USER"];
        
       // UILabel *LabelTitleUsername = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 80, 20)];
        //LabelTitleUsername.backgroundColor = [UIColor clearColor];
       // LabelTitleUsername.font = [UIFont fontWithName:@"Arial" size:14];
       // LabelTitleUsername.textColor = UIColorFromRGB(0x000000);
       // LabelTitleUsername.text = @"Username :";
       // [documentViewUsername addSubview:LabelTitleUsername];
        
       // UILabel *LabelTitleUsernameText = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, 140, 20)];
       // LabelTitleUsernameText.backgroundColor = [UIColor clearColor];
       // LabelTitleUsernameText.font = [UIFont fontWithName:GLOBALTEXTFONT size:14];
       // LabelTitleUsernameText.textColor = UIColorFromRGB(0x000000);
       // LabelTitleUsernameText.text = [NSString stringWithFormat:@"%@",[item objectForKey:@"username"]];
       // [documentViewUsername addSubview:LabelTitleUsernameText];
        
        //[documentViewUsername setBackgroundColor:[UIColor clearColor]];
        //[MainCEllView addSubview:documentViewUsername];
        
        // Label for show reports
        
    //    UIView *documentViewReports = [[UIView alloc] initWithFrame:CGRectMake(65, 55, 250, 20)];
        
        UIView *documentViewReports = [[UIView alloc] initWithFrame:CGRectMake(90, 45, 250, 20)];
        
        [UserListHelper CreateImageviewWithImage:documentViewReports xcord:0 ycord:2 width:18 height:18 backgroundColor:[UIColor clearColor] imageName:@"SMALL_BADGHE"];
        
        UILabel *LabelTitleReports = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 80, 20)];
        LabelTitleReports.backgroundColor = [UIColor clearColor];
        LabelTitleReports.font = [UIFont fontWithName:@"OpenSans-Semibold" size:13];
        LabelTitleReports.textColor = UIColorFromRGB(0x000000);
        LabelTitleReports.text = @"Reports :";
        [documentViewReports addSubview:LabelTitleReports];
        
        UILabel *LabelTitleReportsText = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, 130, 20)];
        LabelTitleReportsText.backgroundColor = [UIColor clearColor];
        LabelTitleReportsText.font = [UIFont fontWithName:GLOBALTEXTFONT size:13];
        LabelTitleReportsText.textColor = UIColorFromRGB(0x000000);
        LabelTitleReportsText.text = [NSString stringWithFormat:@"%@ reports",[item objectForKey:@"totalreport"]];
        [documentViewReports addSubview:LabelTitleReportsText];
        
        [documentViewReports setBackgroundColor:[UIColor clearColor]];
        [MainCEllView addSubview:documentViewReports];
        
        // Label for show comments
        
        UIView *documentViewComments = [[UIView alloc] initWithFrame:CGRectMake(90, 70, 250, 20)];
        
        [UserListHelper CreateImageviewWithImage:documentViewComments xcord:0 ycord:0 width:20 height:20 backgroundColor:[UIColor clearColor] imageName:@"SMALL_COMMENT"];
        
        UILabel *LabelTitleComments = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 80, 20)];
        LabelTitleComments.backgroundColor = [UIColor clearColor];
        LabelTitleComments.font = [UIFont fontWithName:@"OpenSans-Semibold" size:13];
        LabelTitleComments.textColor = UIColorFromRGB(0x000000);
        LabelTitleComments.text = @"Comments :";
        [documentViewComments addSubview:LabelTitleComments];
        
        UILabel *LabelTitleCommentsText = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, 130, 20)];
        LabelTitleCommentsText.backgroundColor = [UIColor clearColor];
        LabelTitleCommentsText.font = [UIFont fontWithName:GLOBALTEXTFONT size:13];
        LabelTitleCommentsText.textColor = UIColorFromRGB(0x000000);
        LabelTitleCommentsText.text = [NSString stringWithFormat:@"%@ comments",[item objectForKey:@"totalcomment"]];
        [documentViewComments addSubview:LabelTitleCommentsText];
        
        [documentViewComments setBackgroundColor:[UIColor clearColor]];
        [MainCEllView addSubview:documentViewComments];
        
        
        // Label for show total points
        
        UIView *documentViewTotalpoints = [[UIView alloc] initWithFrame:CGRectMake(90, 95, 250, 20)];
        
        [UserListHelper CreateImageviewWithImage:documentViewTotalpoints xcord:0 ycord:3 width:18 height:18 backgroundColor:[UIColor clearColor] imageName:@"SMALL_USER"];
        
        UILabel *LabelTitleTotalpoints = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 90, 20)];
        LabelTitleTotalpoints.backgroundColor = [UIColor clearColor];
        LabelTitleTotalpoints.font = [UIFont fontWithName:@"OpenSans-Semibold" size:13];
        LabelTitleTotalpoints.textColor = UIColorFromRGB(0x000000);
        LabelTitleTotalpoints.text = @"Total Points :";
        [documentViewTotalpoints addSubview:LabelTitleTotalpoints];
        
        UILabel *LabelTitleTotalpointsText = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, 130, 20)];
        LabelTitleTotalpointsText.backgroundColor = [UIColor clearColor];
        LabelTitleTotalpointsText.font = [UIFont fontWithName:GLOBALTEXTFONT size:13];
        LabelTitleTotalpointsText.textColor = UIColorFromRGB(0x000000);
        LabelTitleTotalpointsText.text = [NSString stringWithFormat:@"%@ points",[item objectForKey:@"totalpoint"]];
        [documentViewTotalpoints addSubview:LabelTitleTotalpointsText];
        
        [documentViewTotalpoints setBackgroundColor:[UIColor clearColor]];
        [MainCEllView addSubview:documentViewTotalpoints];
        //create separator
       
        [MainCEllView setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:MainCEllView];
        UILabel *lblSeparator=[[UILabel alloc]initWithFrame:CGRectMake(0, 124, 320, 0.5f)];
        [lblSeparator setBackgroundColor:[UIColor blackColor]];
        [lblSeparator.layer setOpacity:0.2f];
        [MainCEllView addSubview:lblSeparator];
   
        return cell;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [DatasourceTableview count];
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 90.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *MainHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 90)];
    MainHeaderView.backgroundColor = [UIColor whiteColor];
    
    UILabel *SearchTitlelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 320, 35)];
    SearchTitlelabel.text = @"User List";
    [MainHeaderView addSubview:SearchTitlelabel];
    
  
    [MainHeaderView addSubview:SearchUserTextField];
    
    [UserListHelper CreateButtonWithText:220 ycord:55 width:90 height:20 backgroundColor:[UIColor clearColor] textcolor:UIColorFromRGB(0xc5c5c5) labeltext:Nil fontName:Nil fontSize:12 textNameForUIControlStateNormal:@"Search" textNameForUIControlStateSelected:@"Search" textNameForUIControlStateHighlighted:@"Search" textNameForselectedHighlighted:@"Search" selectMethod:@selector(Searchuserdata) selectEvent:UIControlEventTouchUpInside addView:MainHeaderView viewController:self];
    
    UILabel *greenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 89, 320/3,1)];
    greenLabel.backgroundColor = UIColorFromRGB(0x1aad4b);
    [MainHeaderView addSubview:greenLabel];
    UILabel *yellowlabel = [[UILabel alloc] initWithFrame:CGRectMake(320/3, 89, 320/3,1)];
    yellowlabel.backgroundColor = UIColorFromRGB(0xfcb714);
    [MainHeaderView addSubview:yellowlabel];
    UILabel *redlabel = [[UILabel alloc] initWithFrame:CGRectMake(320/3*2, 89, 320/3+5,1)];
    redlabel.backgroundColor = UIColorFromRGB(0xde1d23);
    [MainHeaderView addSubview:redlabel];
    return MainHeaderView;
}
-(void)Searchuserdata
{
   [UserListHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
  
    NSInvocationOperation *Searchoperation=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(performSearch) object:nil];
    [operationQ addOperation:Searchoperation];

}

-(void)performSearch
{
    [DatasourceTableview removeAllObjects];
    [_UserListTable setHidden:YES];
     NSString *StrString=[NSString stringWithFormat:@"%@appweb.php?mode=userlist&loginuser=%@&search_user=%@",DomainURL,[Fetchuserdata objectForKey:@"userid"],SearchUserTextField.text];
     NSURL *url=[NSURL URLWithString:StrString];
     NSData *data=[NSData dataWithContentsOfURL:url];
    NSLog(@"Th value of search:%@",StrString);
     NSDictionary *allData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    
    for(NSMutableDictionary *LeaderBoardData in [allData objectForKey:@"userlist"])
    {
        NSMutableDictionary *TempDictionary = [[NSMutableDictionary alloc] init];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"first_name"] forKey:@"first_name"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"last_name"] forKey:@"last_name"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"totalcomment"] forKey:@"totalcomment"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"totalpoint"] forKey:@"totalpoint"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"totalreport"] forKey:@"totalreport"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"user_badge"] forKey:@"user_badge"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"user_image"] forKey:@"user_image"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"userid"] forKey:@"userid"];
        [TempDictionary setObject:[LeaderBoardData objectForKey:@"username"] forKey:@"username"];
        [DatasourceTableview addObject:TempDictionary];
    }
    [self performSelectorOnMainThread:@selector(relodetbldata) withObject:Nil waitUntilDone:YES];
}




-(void)relodetbldata
{
     _UserListTable.hidden=NO;
    
    if (DatasourceTableview.count==0) {
        Noresultfound.hidden=NO;
        
    }
    else
    {
        Noresultfound.hidden=YES;
       
    }
    
    [UserListHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
    [_UserListTable reloadData];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self Searchuserdata];
    [textField resignFirstResponder];
    return NO;
}
- (void)textFieldDidEndEditing
{
    
}

- (void)textFieldDidBeginEditing
{
    
}

- (void)textFieldDidBeginEditingone
{
   
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
