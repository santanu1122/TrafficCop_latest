//
//  SideMenuViewController.m
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import "SideMenuViewControllerOne.h"
#import "MFSideMenu.h"


#import "AppDelegate.h"

#import "EditProfileViewController.h"
#import "PassWordChange.h"
#import "ShareAppViewController.h"
#import "TermsAndConditionViewController.h"
#import "PrivacyPoliceViewController.h"
#import "ProfileViewController.h"


@interface SideMenuViewControllerOne()
{
    NSArray *MenuTextArray;
    NSArray *ImageArray;
}
@end

@implementation SideMenuViewControllerOne

- (void) viewDidLoad {
    [super viewDidLoad];
    
    MenuTextArray = [[NSArray alloc] initWithObjects:@"My Profile",@"Share App",@"Edit Profile ",@"Change Password",@"Terms and Conditions",@"Privacy Policy",@"Sign Out",nil];
    ImageArray = [[NSArray alloc] initWithObjects:@"user profile.png",@"setng_pic@2x",@"setng_pic@2x",@"setng_pic@2x",@"setng_pic@2x",@"user profile.png",
                  @"sign out.png", nil];
}

#pragma mark -
#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Section %d", section];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    tableView.alwaysBounceHorizontal = NO;
    tableView.alwaysBounceVertical = NO;
    tableView.frame = CGRectMake(48, 0, 300, 580);
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,130)];
    UILabel *greenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width/3,1.5)];
    greenLabel.backgroundColor = UIColorFromRGB(0x1aad4b);
    [headerView addSubview:greenLabel];
    
    UILabel *yellowlabel = [[UILabel alloc] initWithFrame:CGRectMake(headerView.frame.size.width/3, 0, headerView.frame.size.width/3,1.5)];
    yellowlabel.backgroundColor = UIColorFromRGB(0xfcb714);
    [headerView addSubview:yellowlabel];
    
    UILabel *redlabel = [[UILabel alloc] initWithFrame:CGRectMake(headerView.frame.size.width/3*2, 0, headerView.frame.size.width/3,1.5)];
    redlabel.backgroundColor = UIColorFromRGB(0xde1d23);
    [headerView addSubview:redlabel];
    
    UIView *MenuTextView = [[UIView alloc] initWithFrame:CGRectMake(0, 1.5f, tableView.frame.size.width, 23.5)];
    MenuTextView.backgroundColor = UIColorFromRGB(0x292929);
    [headerView addSubview:MenuTextView];
    
    return headerView;
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return  23.5;
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
    
    UIImageView *CellImage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, MyimageOne.size.width/2, MyimageOne.size.height/2)];
    [CellImage setCenter:CGPointMake(42, 21)];
    CellImage.backgroundColor = [UIColor clearColor];
    CellImage.image = [UIImage imageNamed:[ImageArray objectAtIndex:indexPath.row]];
    [cell addSubview:CellImage];
    
    UILabel *Textlabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 9, 165, 25)];
    Textlabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:16];
    Textlabel.text = [MenuTextArray objectAtIndex:indexPath.row];
    [cell addSubview:Textlabel];
    
    UILabel *redlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 270,0.5f)];
    [redlabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"NEWdivider.png"]]];
    
    [cell addSubview:redlabel];
    return cell;
}
#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
     cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    AppDelegate *maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    EditProfileViewController *editprofile=[[EditProfileViewController alloc]init];
    PassWordChange *changepass=[[PassWordChange alloc]init];
    ShareAppViewController *ShareApp = [[ShareAppViewController alloc] init];
    TermsAndConditionViewController *terms=[[TermsAndConditionViewController alloc]init];
    PrivacyPoliceViewController    *privacy=[[PrivacyPoliceViewController alloc]init];
    ProfileViewController *profileobj=[[ProfileViewController alloc]init];
    
   
    switch (indexPath.row) {
        case 0:
            [maindelegate SetUpTabbarControllerwithcenterView:profileobj];
            break;
        case 1:
            ShareApp.LastVisitedpage = @"N";
            [maindelegate SetUpTabbarControllerwithcenterView:ShareApp];
            break;
         case 2:
            [maindelegate SetUpTabbarControllerwithcenterView:editprofile];
            break;
           case 3:
            [maindelegate SetUpTabbarControllerwithcenterView:changepass];
            break;
            case 4:
            [maindelegate SetUpTabbarControllerwithcenterView:terms];
            break;
            case 5:
            [maindelegate SetUpTabbarControllerwithcenterView:privacy];
            break;  
            default:
            [maindelegate RemovetabbarController];
            break;
    }
    
  }

@end
