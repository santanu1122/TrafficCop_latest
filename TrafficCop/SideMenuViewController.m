//
//  SideMenuViewController.m
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import "SideMenuViewController.h"
#import "SideMenuViewControllerOne.h"
#import "MFSideMenu.h"
#import "ZSImageView.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "DashboardViewController.h"
#import "MFSideMenuContainerViewController.h"
#import "ReportBadDriverViewController.h"
#import "LeaderboardViewController.h"
#import "UserlistViewController.h"
#import "EditProfileViewController.h"
#import "SearchBadDriverViewController.h"
#import "SimiarReportViewController.h"
#import "RecordAudioViewController.h"
#import "MyallaudioViewController.h"
#import "pushNotificationViewController.h"
#import "UserReportViewController.h"
#import "EvedenceLockerView.h"
#import "MyallaudioViewController.h"
#import "UserBadgeViewController.h"

@interface SideMenuViewController()
{
    NSArray *MenuTextArray;
    NSArray *ImageArray;
}
@end

@implementation SideMenuViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    MenuTextArray = [[NSArray alloc] initWithObjects:@"Home",@"Safe Driving Tips",@"Search for an Incident",@"Report an Incident",@"My Reports",@"My Badges",@"Evidence Locker",@"Search for a user",@"Leaderboard",@"Record a Memo", nil];
    
    ImageArray = [[NSArray alloc] initWithObjects:@"NEWhome.png",@"NEWsave-driving.png",@"NEWsearch-for-incident.png",@"NEWreport-incident.png",@"NEWmy-reports.png",@"user profile.png",@"NEWevidence-locker.png",@"NEWsearch-for-user.png",@"NEWleader-board.png",@"NEWrecord-memo.png", nil];
}

#pragma mark -
#pragma mark - UITableViewDataSource
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    tableView.alwaysBounceHorizontal = NO;
    tableView.alwaysBounceVertical = NO;
    tableView.frame = CGRectMake(0, 0, 300, 580);
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,130)];
    UILabel *greenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width/3,1.5f)];
    greenLabel.backgroundColor = UIColorFromRGB(0x1aad4b);
    [headerView addSubview:greenLabel];
    
    UILabel *yellowlabel = [[UILabel alloc] initWithFrame:CGRectMake(headerView.frame.size.width/3, 0, headerView.frame.size.width/3,1.5f)];
    yellowlabel.backgroundColor = UIColorFromRGB(0xfcb714);
    [headerView addSubview:yellowlabel];
    
    UILabel *redlabel = [[UILabel alloc] initWithFrame:CGRectMake(headerView.frame.size.width/3*2, 0, headerView.frame.size.width/3,1.5f)];
    redlabel.backgroundColor = UIColorFromRGB(0xde1d23);
    [headerView addSubview:redlabel];
    
    UIView *MenuTextView = [[UIView alloc] initWithFrame:CGRectMake(0, 1.5f, tableView.frame.size.width, 23.5)];
    MenuTextView.backgroundColor = UIColorFromRGB(0x292929);
    [headerView addSubview:MenuTextView];
    
//    UILabel *textlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 1, headerView.frame.size.width-10,20)];
//    textlabel.backgroundColor = [UIColor clearColor];
//    textlabel.textColor = UIColorFromRGB(0xffffff);
//    textlabel.font = [UIFont fontWithName:@"OpenSans" size:14];
//    textlabel.text = @"Menu";
//    [MenuTextView addSubview:textlabel];
    
    
    UIView *MenuTextViewone = [[UIView alloc] initWithFrame:CGRectMake(0, 25.0f, tableView.frame.size.width, 79)];
    MenuTextViewone.backgroundColor = UIColorFromRGB(0xfcb714);
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    ZSImageView *imageView = [[ZSImageView alloc] initWithFrame:CGRectMake(10, 10, 55, 55)];
	imageView.defaultImage = [UIImage imageNamed:@"NEWNOIMAGE"];
	imageView.imageUrl = [prefs objectForKey:@"user_image"];
	imageView.contentMode = UIViewContentModeScaleAspectFill;
	imageView.clipsToBounds = YES;
	imageView.corners = ZSRoundCornerAll;
	imageView.cornerRadius = 30;
	[MenuTextViewone addSubview:imageView];
    
    
    UILabel *textlabelone = [[UILabel alloc] initWithFrame:CGRectMake(75, 18, MenuTextViewone.frame.size.width/2,20)];
    textlabelone.backgroundColor = [UIColor clearColor];
    textlabelone.textColor = UIColorFromRGB(0x614906);
    textlabelone.numberOfLines = 0;
    textlabelone.font = [UIFont fontWithName:@"OpenSans" size:13];
    textlabelone.text = @"Welcome";
    [MenuTextViewone addSubview:textlabelone];
    
    UILabel *textlabelname = [[UILabel alloc] initWithFrame:CGRectMake(75, 28, MenuTextViewone.frame.size.width-100,35)];
    textlabelname.backgroundColor = [UIColor clearColor];
    textlabelname.textColor = UIColorFromRGB(0x292b2a);
    textlabelname.numberOfLines = 0;
    textlabelname.font = [UIFont fontWithName:@"OpenSans" size:18];
    textlabelname.text =[[prefs objectForKey:@"username"] capitalizedString];
    [MenuTextViewone addSubview:textlabelname];
    
    [headerView addSubview:MenuTextViewone];
    
    return headerView;
    
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return  100.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [MenuTextArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = NO;
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UIImage *MyimageOne = [UIImage imageNamed:[ImageArray objectAtIndex:indexPath.row]];
    
    UIImageView *CellImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, MyimageOne.size.width/2, MyimageOne.size.height/2)];
    [CellImage setCenter:CGPointMake(22, 21)];
    CellImage.backgroundColor = [UIColor clearColor];
    CellImage.image = [UIImage imageNamed:[ImageArray objectAtIndex:indexPath.row]];
    [cell addSubview:CellImage];
    
    UILabel *Textlabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 9, 165, 25)];
    Textlabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:16];
    Textlabel.text = [MenuTextArray objectAtIndex:indexPath.row];
    [cell addSubview:Textlabel];
    
    UILabel *redlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 270,1)];
    [redlabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"NEWdivider.png"]]];
    
    [cell addSubview:redlabel];
    return cell;
}


#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AppDelegate *maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    DashboardViewController *Dashboard = [[DashboardViewController alloc] init];
    pushNotificationViewController *DrivingTips = [[pushNotificationViewController alloc] init];
    ReportBadDriverViewController *reportbadDriver=[[ReportBadDriverViewController alloc]init];
    LeaderboardViewController *LedaerBoard = [[LeaderboardViewController alloc] init];
    UserlistViewController *UserList = [[UserlistViewController alloc] init];
       SearchBadDriverViewController *SearchBadDriver = [[SearchBadDriverViewController alloc] init];
    UserReportViewController *userreport=[[UserReportViewController alloc]init];

    //RecordAudioViewController *RecordAudio = [[RecordAudioViewController alloc] init];
    EvedenceLockerView *evedencelocker=[[EvedenceLockerView alloc]init];
    MyallaudioViewController *MYAudio=[[MyallaudioViewController alloc]init];
    
    UserBadgeViewController *UserBadge = [[UserBadgeViewController alloc] init];
   NSLog(@"The evdence locker button click:%d",indexPath.row);
    
    switch (indexPath.row) {
        case 0:
            [maindelegate SetUpTabbarControllerwithcenterView:Dashboard];
            break;
        case 1:
            [maindelegate SetUpTabbarControllerwithcenterView:DrivingTips];
            break;
        case 2:
            [maindelegate SetUpTabbarControllerwithcenterView:SearchBadDriver];
            break;
        case 3:
            [maindelegate SetUpTabbarControllerwithcenterView:reportbadDriver];
            break;
        case 4:
            [maindelegate SetUpTabbarControllerwithcenterView:userreport];
            break;
        case 5:
            [maindelegate SetUpTabbarControllerwithcenterView:UserBadge];
            break;
        case 6:
            [maindelegate SetUpTabbarControllerwithcenterView:evedencelocker];
            break;
        case 7:
            [maindelegate SetUpTabbarControllerwithcenterView:UserList];
            break;
        case 8:
            [maindelegate SetUpTabbarControllerwithcenterView:LedaerBoard];
            break;
        case 9:
            [maindelegate SetUpTabbarControllerwithcenterView:MYAudio];
            break;
        default:
            break;
    }
}

@end
