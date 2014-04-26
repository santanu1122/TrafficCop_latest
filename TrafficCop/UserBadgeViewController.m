//
//  UserBadgeViewController.m
//  TrafficCop
//
//  Created by Iphone_2 on 02/04/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "UserBadgeViewController.h"
#import "HelperClass.h"
#import "MBHUDView.h"
#import "ZSImageView.h"
#import "MFSideMenu.h"
#import "CellUserBadge.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <FacebookSDK/FacebookSDK.h>

typedef enum {
    FacebookShareButtonClicked =1,
    TwitterShatreButtonClicked
} ShareButtonClicked;

@interface UserBadgeViewController ()<UITextViewDelegate,UIAlertViewDelegate> {
    
    HelperClass *UserBadgeClass;
    NSURLConnection *Connecttion;
    NSMutableData* webdata;
    NSMutableArray *UserBadgeDetailsArray;
    NSData *ImageDataForSocialShare;
    NSString *TextDataForSocialShare;
    NSString *LinkDataForSocialShare;
    ShareButtonClicked WhichSharebuttonClicked;
}

@property (nonatomic,retain) IBOutlet UITableView *UserBadgetableView;
@property (nonatomic,retain) IBOutlet UIActivityIndicatorView *UserBadgetableActivityView;
@property (nonatomic,retain) NSURLConnection *Connecttion;

@property (nonatomic,retain) UIView *SharepopupViewMainLayer;
@property (nonatomic,retain) UIView *SharepopupViewLayerOne;
@property (nonatomic,retain) UIView *SharepopupViewLayerTwo;
@property (nonatomic,retain) UIButton *SharepopupviewFacebookButton;
@property (nonatomic,retain) UIButton *SharepopupviewTwitterButton;
@property (nonatomic,retain) UIButton *SharepopupviewCancelButton;
@property (nonatomic,retain) UITextView *SharepopupviewTextView;

-(IBAction)FinalShareOnFacebook:(id)sender;
-(IBAction)FinalShareOnTwitter:(id)sender;
@end

@implementation UserBadgeViewController

@synthesize UserBadgetableView              = _UserBadgetableView;
@synthesize Connecttion                     = _Connecttion;
@synthesize UserBadgetableActivityView      = _UserBadgetableActivityView;
@synthesize SharepopupViewMainLayer         = _SharepopupViewMainLayer;
@synthesize SharepopupViewLayerOne          = _SharepopupViewLayerOne;
@synthesize SharepopupViewLayerTwo          = _SharepopupViewLayerTwo;
@synthesize SharepopupviewFacebookButton    = _SharepopupviewFacebookButton;
@synthesize SharepopupviewTwitterButton     = _SharepopupviewTwitterButton;
@synthesize SharepopupviewTextView          = _SharepopupviewTextView;
@synthesize SharepopupviewCancelButton      = _SharepopupviewCancelButton;

int GlobalSelectedIndexPath = 0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
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
-(void)viewWillAppear:(BOOL)animated {
    
    [_UserBadgetableActivityView startAnimating];
    [_UserBadgetableView setDelegate:self];
    [_UserBadgetableView setDataSource:self];
    [_UserBadgetableView setHidden:YES];
    
    dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),
    ^{
        //http://esolzdemos.com/lab3/trafficcop/IOS/mybadge.php?userid=3
        NSUserDefaults *standeruser=[NSUserDefaults standardUserDefaults];
        NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@mybadge.php?userid=%@",DomainURL,[standeruser objectForKey:@"userid"]]]];
       // NSLog(@"request url ---- %@",request);
        
        _Connecttion = [[NSURLConnection alloc] initWithRequest: request delegate: self startImmediately: NO];
 
        [_Connecttion setDelegateQueue: [NSOperationQueue mainQueue]];
        [_Connecttion start];
   });
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UserBadgeClass = [[HelperClass alloc] init];
    [self HideNavigationBar];
    [UserBadgeClass SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    [UserBadgeClass SetupHeaderView:self.view viewController:self];
    
    [_UserBadgetableView setDelegate:self];
    [_UserBadgetableView setDataSource:self];
    [_UserBadgetableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
   // [_SharepopupViewMainLayer setHidden:YES];
    
}
-(void)HideNavigationBar {
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
    webdata = [[NSMutableData alloc]init];
}
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    [webdata appendData:data];
}
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    NSLog(@"Did Fail");
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    connection=nil;
    NSError *jsonParsingError = nil;
    
    NSDictionary *deserializedData  = [NSJSONSerialization JSONObjectWithData:webdata options:NSJSONReadingAllowFragments error:&jsonParsingError];
    
    [_UserBadgetableActivityView stopAnimating];
    
    NSArray *extraparam=[deserializedData objectForKey:@"extraparam"];
    NSDictionary *ExtraparamDic=[extraparam objectAtIndex:0];
    NSString *reportString=[ExtraparamDic valueForKey:@"response"];
    
    if ([reportString isEqualToString:@"success"]) {
        
        UserBadgeDetailsArray = [[NSMutableArray alloc] init];
        
        NSArray *ReportresultArry=[deserializedData objectForKey:@"searchresult"];
        for (NSDictionary *DicData in ReportresultArry)
        {
            [UserBadgeDetailsArray addObject:[[UserReportObject alloc] initWithBadgeImage:[DicData objectForKey:@"badge"] BadgeName:[DicData objectForKey:@"badge_name"] BadgePostImageUrl:[DicData objectForKey:@"post_image_url"] BadgePostText:[DicData objectForKey:@"post_text"] BadgeSiteUrl:[ExtraparamDic valueForKey:@"siteurl"]]];
        }
        
        [_UserBadgetableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        [_UserBadgetableView setHidden:NO];
        
    } else {
        
        UIAlertView *NoBadgeAlert = [[UIAlertView alloc] initWithTitle:@"No Badge Found" message:@"You havn't earnd any badge yet" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [NoBadgeAlert show];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma uitableview delegate and datasource method

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellUserBadge";
    CellUserBadge *tableCell = (CellUserBadge *)[_UserBadgetableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (tableCell == nil) {
        
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        tableCell = (CellUserBadge *)[nibArray objectAtIndex:0];
    }

    UserReportObject *LocalObject = [UserBadgeDetailsArray objectAtIndex:[indexPath row]];
    
    UIActivityIndicatorView *CellImageBadgeActivity     = (UIActivityIndicatorView *)[tableCell viewWithTag:256];
    UIImageView *CellBadgeImage                         = (UIImageView *)[tableCell viewWithTag:257];
    UILabel *CellBadgeTitleLable                        = (UILabel *)[tableCell viewWithTag:258];
    UILabel *CellBadgeFooterLable                       = (UILabel *)[tableCell viewWithTag:555];
    UIButton *CellBadgeShareOnFacebook                  = (UIButton *)[tableCell viewWithTag:260];
    UIButton *CellBadgeShareOnTwitter                   = (UIButton *)[tableCell viewWithTag:261];
    UIView *CellBadgeShareOnView                        = (UIView *)[tableCell viewWithTag:777];
    UILabel *CellBadgeShareOnLabel                      = (UILabel *)[tableCell viewWithTag:666];
    
    [CellBadgeTitleLable setText:LocalObject.BadgeName];
    [CellBadgeShareOnView setBackgroundColor:UIColorFromRGB(0xF3EFEF)];
    [CellBadgeShareOnLabel setBackgroundColor:UIColorFromRGB(0xc5c5c5)];
    [CellBadgeFooterLable setBackgroundColor:UIColorFromRGB(0xc5c5c5)];
    [CellBadgeTitleLable setTextColor:UIColorFromRGB(0x000000)];
    [CellBadgeTitleLable setFont:[UIFont fontWithName:GLOBALTEXTFONT size:14.0]];
    
    [CellBadgeShareOnFacebook setTitle:[NSString stringWithFormat:@"%d",indexPath.row] forState:UIControlStateNormal];
    [CellBadgeShareOnFacebook.titleLabel setHidden:YES];
    [CellBadgeShareOnFacebook setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    [CellBadgeShareOnFacebook setTitleColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    [CellBadgeShareOnFacebook addTarget:self action:@selector(ShareOnFacebook:) forControlEvents:UIControlEventTouchUpInside];
    
    [CellBadgeShareOnTwitter setTitle:[NSString stringWithFormat:@"%d",indexPath.row] forState:UIControlStateNormal];
    [CellBadgeShareOnTwitter.titleLabel setHidden:YES];
    [CellBadgeShareOnTwitter setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    [CellBadgeShareOnTwitter setTitleColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    [CellBadgeShareOnTwitter addTarget:self action:@selector(ShareOnTwitter:) forControlEvents:UIControlEventTouchUpInside];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        
        [CellImageBadgeActivity startAnimating];
        
        NSError *ImageDownloadError;
        NSURL *ImageUrl         = [[NSURL alloc] initWithString:LocalObject.BadgePostImageUrl];
        NSData *ImageData       = [NSData dataWithContentsOfURL:ImageUrl options:kNilOptions error:&ImageDownloadError];
    
        dispatch_async(dispatch_get_main_queue(), ^(void) {
        
            [CellImageBadgeActivity stopAnimating];
            [CellBadgeImage setImage:[UIImage imageWithData:ImageData]];
        
        });
    
    });
    
    return tableCell;
}

-(void)ShareOnFacebook :(UIButton *)Selecter {
    
    WhichSharebuttonClicked = FacebookShareButtonClicked;
    [self SetupPopupview:[Selecter.titleLabel.text intValue]];
}
-(void)ShareOnTwitter :(UIButton *)Selecter {
    
    WhichSharebuttonClicked = TwitterShatreButtonClicked;
    [self SetupPopupview:[Selecter.titleLabel.text intValue]];
}

-(void)SetupPopupview :(int)IndexpathVal{
    
    GlobalSelectedIndexPath             = IndexpathVal;
    
    NSUserDefaults *prefs               = [NSUserDefaults standardUserDefaults];
    UserReportObject *LocalObject       = [UserBadgeDetailsArray objectAtIndex:IndexpathVal];
    NSString *ShareString               = [NSString stringWithFormat:@"%@ just earned %@ badge with Trafficcop! Start becoming a TrafficCop yourself. %@",[prefs objectForKey:@"username"],LocalObject.BadgeName,LocalObject.BadgeSiteUrl];
    
    _SharepopupViewMainLayer = [[UIView alloc] initWithFrame:CGRectMake(0, 65, 320, self.view.frame.size.height-65)];
    [_SharepopupViewMainLayer setBackgroundColor:[UIColor clearColor]];
    
    _SharepopupViewLayerOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-65)];
    [_SharepopupViewLayerOne setBackgroundColor:[UIColor blackColor]];
    [_SharepopupViewLayerOne.layer setOpacity:0.8f];
    [_SharepopupViewMainLayer addSubview:_SharepopupViewLayerOne];
    
    _SharepopupViewLayerTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 120, 320, self.view.frame.size.height-120)];
    [_SharepopupViewLayerTwo setBackgroundColor:[UIColor whiteColor]];
    [_SharepopupViewMainLayer addSubview:_SharepopupViewLayerTwo];
    
    
    UILabel *ShareTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 290, 20)];
    [ShareTextLabel setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16.0f]];
    [ShareTextLabel setText:@"Shared Content"];
    [ShareTextLabel setBackgroundColor:[UIColor clearColor]];
    [ShareTextLabel setTextColor:[UIColor blackColor]];
    [_SharepopupViewLayerTwo addSubview:ShareTextLabel];
    
    UILabel *ShareTextLabelBorder = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, 290, 1)];
    [ShareTextLabelBorder setBackgroundColor:[UIColor lightGrayColor]];
    [_SharepopupViewLayerTwo addSubview:ShareTextLabelBorder];
    
    _SharepopupviewTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 53, 270, 100)];
    [_SharepopupviewTextView setBackgroundColor:[UIColor clearColor]];
    [_SharepopupviewTextView setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16.0f]];
    [_SharepopupviewTextView setTextColor:[UIColor darkGrayColor]];
    [_SharepopupviewTextView setUserInteractionEnabled:YES];
    [_SharepopupviewTextView setEditable:YES];
    [_SharepopupviewTextView setText:ShareString];
    [_SharepopupviewTextView setDelegate:self];
    [_SharepopupViewLayerTwo addSubview:_SharepopupviewTextView];
    
    UILabel *ShareTextLabelBorderLower = [[UILabel alloc] initWithFrame:CGRectMake(15, 155, 290, 1)];
    [ShareTextLabelBorderLower setBackgroundColor:[UIColor lightGrayColor]];
    [_SharepopupViewLayerTwo addSubview:ShareTextLabelBorderLower];
    
    UILabel *ShareTextLabelOne = [[UILabel alloc] initWithFrame:CGRectMake(15, 160, 290, 20)];
    [ShareTextLabelOne setFont:[UIFont fontWithName:GLOBALTEXTFONT size:10.0f]];
    [ShareTextLabelOne setText:@"Tap on the text to edit it"];
    [ShareTextLabelOne setTextAlignment:NSTextAlignmentRight];
    [ShareTextLabelOne setBackgroundColor:[UIColor clearColor]];
    [ShareTextLabelOne setTextColor:[UIColor blackColor]];
    [_SharepopupViewLayerTwo addSubview:ShareTextLabelOne];
    
    _SharepopupviewFacebookButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_SharepopupviewFacebookButton setFrame:CGRectMake(55, 207, 100, 40)];
    [_SharepopupviewFacebookButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_SharepopupviewFacebookButton.layer setBorderWidth:1.0f];
    [_SharepopupviewFacebookButton.titleLabel setTextColor:[UIColor blackColor]];
    [_SharepopupviewFacebookButton.layer setCornerRadius:3.0f];
    [_SharepopupviewFacebookButton setTintColor:[UIColor darkGrayColor]];
    [_SharepopupviewFacebookButton setTitle:@"Share" forState:UIControlStateNormal];
    [_SharepopupviewFacebookButton setTitle:@"Share" forState:UIControlStateSelected];
    [_SharepopupviewFacebookButton.titleLabel setFont:[UIFont fontWithName:GLOBALTEXTFONT size:18.0f]];
    [_SharepopupviewFacebookButton addTarget:self action:@selector(FinalShareOnFacebook:) forControlEvents:UIControlEventTouchUpInside];
    [_SharepopupViewLayerTwo addSubview:_SharepopupviewFacebookButton];
    
    _SharepopupviewTwitterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_SharepopupviewTwitterButton setFrame:CGRectMake(55, 207, 100, 40)];
    [_SharepopupviewTwitterButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_SharepopupviewTwitterButton.layer setBorderWidth:1.0f];
    [_SharepopupviewTwitterButton.layer setCornerRadius:3.0f];
    [_SharepopupviewTwitterButton setTintColor:[UIColor darkGrayColor]];
    [_SharepopupviewTwitterButton setTitle:@"Share" forState:UIControlStateNormal];
    [_SharepopupviewTwitterButton setTitle:@"Share" forState:UIControlStateSelected];
    [_SharepopupviewTwitterButton.titleLabel setFont:[UIFont fontWithName:GLOBALTEXTFONT size:18.0f]];
    [_SharepopupviewTwitterButton addTarget:self action:@selector(FinalShareOnTwitter:) forControlEvents:UIControlEventTouchUpInside];
    [_SharepopupViewLayerTwo addSubview:_SharepopupviewTwitterButton];
    
    _SharepopupviewCancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_SharepopupviewCancelButton setFrame:CGRectMake(165, 207, 100, 40)];
    [_SharepopupviewCancelButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_SharepopupviewCancelButton.layer setBorderWidth:1.0f];
    [_SharepopupviewCancelButton.layer setCornerRadius:3.0f];
    [_SharepopupviewCancelButton setTintColor:[UIColor darkGrayColor]];
    [_SharepopupviewCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [_SharepopupviewCancelButton setTitle:@"Cancel" forState:UIControlStateSelected];
    [_SharepopupviewCancelButton.titleLabel setFont:[UIFont fontWithName:GLOBALTEXTFONT size:18.0f]];
    [_SharepopupviewCancelButton addTarget:self action:@selector(FinalCancel:) forControlEvents:UIControlEventTouchUpInside];
    [_SharepopupViewLayerTwo addSubview:_SharepopupviewCancelButton];
    
    UILabel *ShareTextLabelon = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, 290, 20)];
    [ShareTextLabelon setFont:[UIFont fontWithName:GLOBALTEXTFONT size:20.0f]];
    [ShareTextLabelon setBackgroundColor:[UIColor clearColor]];
    [ShareTextLabelon setTextAlignment:NSTextAlignmentCenter];
    [ShareTextLabelon setTextColor:[UIColor whiteColor]];
    [_SharepopupViewMainLayer addSubview:ShareTextLabelon];
    
    switch (WhichSharebuttonClicked) {
        case FacebookShareButtonClicked:
            [_SharepopupviewTwitterButton setHidden:YES];
            [ShareTextLabelon setText:@"Share Badge On Facebook"];
            break;
        case TwitterShatreButtonClicked:
            [ShareTextLabelon setText:@"Share Badge On Twitter"];
            [_SharepopupviewFacebookButton setHidden:YES];
            break;
    }
    
    [self.view addSubview:_SharepopupViewMainLayer];
    
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if ([textView.text length] > 140) {
        [textView setText:[textView.text substringToIndex:[textView.text length] - 1]];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    NSData *to_share = ImageDataForSocialShare;
    NSLog(@"Session State Changed: %u", [[FBSession activeSession] state]);
    switch (state) {
        case FBSessionStateOpen:
        {
            [self postImageToFB:to_share];
        }
        break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
        {
            
        }
        break;
        default:
        break;
    }
}
- (void) postImageToFB:(NSData*)imageData
{
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%@",TextDataForSocialShare], @"message",ImageDataForSocialShare, @"source",nil];
    [FBRequestConnection startWithGraphPath:@"me/photos" parameters:params HTTPMethod:@"POST" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
    if(error) {
        [UserBadgeClass HidePopupView];
        NSLog(@" error is %@",error);
        UIAlertView *FacebookAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"failed to post, Please try again later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [FacebookAlertView show];
    } else {
        [UserBadgeClass HidePopupView];
        UIAlertView *FacebookAlertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Badge Shared successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [FacebookAlertView show];
      }
   }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [UserBadgeDetailsArray count];
}

-(IBAction)FinalShareOnFacebook:(UIButton *)sender {
    //exit(0);
    
    [UserBadgeClass AddBlackOverlay:self.view xcord:0 ycord:0 width:self.view.frame.size.width height:self.view.frame.size.height backgroundColor:[UIColor blackColor] OpacitY:0.9f Text:@"Please wait" TextColor:[UIColor whiteColor] FontName:globalTEXTFIELDPLACEHOLDERFONT FontSize:18 IsTextEnabled:YES];
    
    NSError *ImageDownloadError;
    UserReportObject *LocalObject   = [UserBadgeDetailsArray objectAtIndex:GlobalSelectedIndexPath];
    NSURL *ImageUrl                 = [[NSURL alloc] initWithString:LocalObject.BadgePostImageUrl];
    NSData *ImageData               = [NSData dataWithContentsOfURL:ImageUrl options:kNilOptions error:&ImageDownloadError];
    UIImage *ImageOne               = [UIImage imageWithData:ImageData];
    
    ImageDataForSocialShare         = UIImageJPEGRepresentation(ImageOne, 1);
    TextDataForSocialShare          = _SharepopupviewTextView.text;
    LinkDataForSocialShare          = LocalObject.BadgePostImageUrl;
    
    if([[[FBSession activeSession]accessTokenData]accessToken]) {
        
        @try {
            FBSession.activeSession = [[FBSession alloc] initWithAppID:[NSString stringWithFormat:@"%@",@"176357389225508"] permissions:[NSArray arrayWithObjects:@"publish_actions",@"publish_stream",nil] urlSchemeSuffix:@"" tokenCacheStrategy:nil];
            
            [FBSession openActiveSessionWithPublishPermissions:[NSArray arrayWithObjects:@"publish_actions",@"publish_stream",nil] defaultAudience:FBSessionDefaultAudienceFriends allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                if (!error && status == FBSessionStateOpen) {
                    [self postImageToFB:ImageDataForSocialShare];
                } else {
                    [self sessionStateChanged:session state:status error:error];
                }
            }];
        }
        @catch (NSException *exception) {
            NSLog(@" Exception is %@",exception);
            [UserBadgeClass HidePopupView];
            UIAlertView *FacebookAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"failed to post, Please try again later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [FacebookAlertView show];
        }
    } else {
        
        [FBSession openActiveSessionWithPublishPermissions:[NSArray arrayWithObjects:@"publish_actions",@"publish_stream",nil] defaultAudience:FBSessionDefaultAudienceFriends allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            if (!error && status == FBSessionStateOpen) {
                [self postImageToFB:ImageDataForSocialShare];
            } else {
                [self sessionStateChanged:session state:status error:error];
            }
        }];
    }
}
-(IBAction)FinalShareOnTwitter:(UIButton *)sender {
    //exit(0);
    
    [UserBadgeClass AddBlackOverlay:self.view xcord:0 ycord:0 width:self.view.frame.size.width height:self.view.frame.size.height backgroundColor:[UIColor blackColor] OpacitY:0.9f Text:@"Please wait" TextColor:[UIColor whiteColor] FontName:globalTEXTFIELDPLACEHOLDERFONT FontSize:18 IsTextEnabled:YES];
    NSError *ImageDownloadError         = nil;
    UserReportObject *LocalObject       = [UserBadgeDetailsArray objectAtIndex:GlobalSelectedIndexPath];
    NSURL *ImageUrl                     = [[NSURL alloc] initWithString:LocalObject.BadgePostImageUrl];
    NSData *ImageData                   = [NSData dataWithContentsOfURL:ImageUrl options:kNilOptions error:&ImageDownloadError];
    UIImage *ImageOne                   = [UIImage imageWithData:ImageData];
    
    ImageDataForSocialShare             = UIImageJPEGRepresentation(ImageOne, 1);
    TextDataForSocialShare              = _SharepopupviewTextView.text;
    LinkDataForSocialShare              = LocalObject.BadgePostImageUrl;
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        ACAccountStore *accountStore    = [[ACAccountStore alloc] init];
        ACAccountType *accountType      = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
            
            NSArray *accountsArray      = [accountStore accountsWithAccountType:accountType];
            
            if([accountsArray count]>0)
            {
                SLRequestHandler requestHandler =
                ^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    if (responseData) {
                        NSInteger statusCode = urlResponse.statusCode;
                        if (statusCode >= 200 && statusCode < 300) {
                            [UserBadgeClass HidePopupView];
                            NSDictionary *postResponseData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
                            NSLog(@"----- %@",postResponseData);
                        } else {
                            [UserBadgeClass HidePopupView];
                            NSLog(@"[ERROR] Server responded: status code %ld %@", (long)statusCode,[NSHTTPURLResponse localizedStringForStatusCode:statusCode]);
                            UIAlertView *TwitterAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unexpected Error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [TwitterAlertView show];
                        }
                    } else {
                        [UserBadgeClass HidePopupView];
                        NSString *ErrString = [NSString stringWithFormat:@"[ERROR] An error occurred while posting: %@", [error localizedDescription]];
                        UIAlertView *TwitterAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:ErrString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [TwitterAlertView show];
                    }
                };
                ACAccountStoreRequestAccessCompletionHandler accountStoreHandler =
                ^(BOOL granted, NSError *error) {
                    if (granted) {
                        
                        
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            
                            NSURL *url = [NSURL URLWithString:@"https://api.twitter.com"
                                          @"/1.1/statuses/update_with_media.json"];
                            NSDictionary *params = @{@"status" : [NSString stringWithFormat:@"%@",TextDataForSocialShare]};
                            SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                                    requestMethod:SLRequestMethodPOST
                                                                              URL:url
                                                                       parameters:params];
                            [request addMultipartData:ImageDataForSocialShare
                                             withName:@"media[]"
                                                 type:@"image/jpeg"
                                             filename:@"image.jpg"];
                            [request setAccount:[accountsArray lastObject]];
                            [request performRequestWithHandler:requestHandler];
                            [UserBadgeClass HidePopupView];
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                UIAlertView *TwitterAlertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Badge Shared successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                [TwitterAlertView show];
                                
                            });
                            
                        });
                        
                        
                    }
                    else {
                        [UserBadgeClass HidePopupView];
                        NSString *ErrString = [NSString stringWithFormat:@"[ERROR] An error occurred while asking for user authorization: %@",[error localizedDescription]];
                        UIAlertView *TwitterAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:ErrString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [TwitterAlertView show];
                    }
                };
                [accountStore requestAccessToAccountsWithType:accountType options:NULL completion:accountStoreHandler];
            } else {
                [UserBadgeClass HidePopupView];
                NSLog(@"Unknown error occered");
                UIAlertView *TwitterAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unexpected Error,Please Try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [TwitterAlertView show];
            }
        }];
    } else {
        [UserBadgeClass HidePopupView];
        UIAlertView *TwitterAlertView = [[UIAlertView alloc] initWithTitle:@"Account Settings Error" message:@"Set Twitter in your phone settings first" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [TwitterAlertView show];
    }
}

-(IBAction)FinalCancel:(UIButton *)sender
{
    GlobalSelectedIndexPath = 0;
    [_SharepopupViewMainLayer removeFromSuperview];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [self FinalCancel:nil];
}

@end


@implementation UserReportObject

@synthesize BadgeImage          = _BadgeImage;
@synthesize BadgeName           = _BadgeName;
@synthesize BadgePostImageUrl   = _BadgePostImageUrl;
@synthesize BadgePostText       = _BadgePostText;
@synthesize BadgeSiteUrl        = _BadgeSiteUrl;


-(id)initWithBadgeImage:(NSString *)ParamBadgeImage BadgeName:(NSString *)ParamBadgeName BadgePostImageUrl:(NSString *)ParamBadgePostImageUrl BadgePostText:(NSString *)ParamBadgePostText BadgeSiteUrl:(NSString *)ParamBadgeSiteUrl {
    
    self = [super init];
    if (self) {
        
        [self setBadgeImage:ParamBadgeImage];
        [self setBadgeName:ParamBadgeName];
        [self setBadgePostImageUrl:ParamBadgePostImageUrl];
        [self setBadgePostText:ParamBadgePostText];
        [self setBadgeSiteUrl:ParamBadgeSiteUrl];
        
    }
    return self;
}
@end