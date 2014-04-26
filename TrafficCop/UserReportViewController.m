//
//  SearchBadDriverViewController.m
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 06/12/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import "UserReportViewController.h"
#import "HelperClass.h"
#import "SegmentedControl.h"
#import "MBHUDView.h"
#import "ZSImageView.h"
#import "MFSideMenu.h"
#import "ReportDetailsViewController.h"
#import "AppDelegate.h"
#import "CellUserReport.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <FacebookSDK/FacebookSDK.h>

typedef enum {
    FacebookShareButtonClicked =1,
    TwitterShatreButtonClicked
} ShareButtonClicked;

@interface UserReportViewController ()<UITextViewDelegate> {
    HelperClass *UserReportClass;
    NSMutableArray *UserReportClassDataArray;
    NSMutableData* webdata;
    NSString *userID;
    NSOperationQueue *operationq;
    
    NSData *ImageDataForSocialShare;
    NSString *TextDataForSocialShare;
    NSString *LinkForSocialShare;
    NSString *LinkDataForSocialShare;
    ShareButtonClicked WhichSharebuttonClicked;
}
@property (nonatomic,retain) IBOutlet UITableView *UserreportResultTableView;
@property (nonatomic,retain) IBOutlet UIView *UserreportNoResult;
@property (nonatomic,retain) IBOutlet UIView *UserreportView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *UIloadingData;

@property (nonatomic,retain) UIView *SharepopupViewMainLayer;
@property (nonatomic,retain) UIView *SharepopupViewLayerOne;
@property (nonatomic,retain) UIView *SharepopupViewLayerTwo;
@property (nonatomic,retain) UIButton *SharepopupviewFacebookButton;
@property (nonatomic,retain) UIButton *SharepopupviewTwitterButton;
@property (nonatomic,retain) UIButton *SharepopupviewCancelButton;
@property (nonatomic,retain) UITextView *SharepopupviewTextView;

@end

@implementation UserReportViewController

@synthesize UserreportResultTableView               = _UserreportResultTableView;
@synthesize UserreportNoResult                      = _UserreportNoResult;
@synthesize UserreportView                          = _UserreportView;
@synthesize UIloadingData                           = _UIloadingData;


@synthesize SharepopupViewMainLayer         = _SharepopupViewMainLayer;
@synthesize SharepopupViewLayerOne          = _SharepopupViewLayerOne;
@synthesize SharepopupViewLayerTwo          = _SharepopupViewLayerTwo;
@synthesize SharepopupviewFacebookButton    = _SharepopupviewFacebookButton;
@synthesize SharepopupviewTwitterButton     = _SharepopupviewTwitterButton;
@synthesize SharepopupviewTextView          = _SharepopupviewTextView;
@synthesize SharepopupviewCancelButton      = _SharepopupviewCancelButton;


int GlobalSelectedIndexPathOne = 0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

-(void)viewWillAppear:(BOOL)animated
{
    _UserreportNoResult.hidden=YES;
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    operationq=[[NSOperationQueue alloc]init];
    UserReportClassDataArray=[[NSMutableArray alloc]init];
    NSUserDefaults *standeruser=[NSUserDefaults standardUserDefaults];
    userID=[standeruser objectForKey:@"userid"];
    NSLog(@"user id:%@",userID);
    UserReportClass = [[HelperClass alloc] init];
    [self HideNavigationBar];
    [UserReportClass SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    [UserReportClass SetupHeaderView:self.view viewController:self];
    [_UserreportResultTableView setDelegate:self];
    [_UserreportResultTableView setDataSource:self];
    NSInvocationOperation *detaFitcheration=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(fetchdataFormyreport) object:nil];
    [operationq addOperation:detaFitcheration];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}

-(void)fetchdataFormyreport
{
    [UserReportClassDataArray removeAllObjects];
    
    NSString *StringUrl=[NSString stringWithFormat:@"%@myreport.php?userid=%@",DomainURL,userID];
    NSLog(@"String Data:%@",StringUrl);
    NSURL *url=[NSURL URLWithString:StringUrl];
    
    NSData *Data=[NSData dataWithContentsOfURL:url];
    NSDictionary *mainDic=[NSJSONSerialization JSONObjectWithData:Data options:kNilOptions error:Nil];
    NSArray *extraparam=[mainDic objectForKey:@"extraparam"];
    NSDictionary *ExtraparamDic=[extraparam objectAtIndex:0];
    NSString *reportString=[ExtraparamDic valueForKey:@"response"];
    
    if ([reportString isEqualToString:@"success"])
    {
        NSArray *ReportresultArry=[mainDic objectForKey:@"searchresult"];
        for (NSDictionary *Dic in ReportresultArry)
        {
            NSMutableDictionary *mutdic=[[NSMutableDictionary alloc]initWithCapacity:5];
            
            [mutdic setValue:[Dic valueForKey:@"user_image"] forKey:@"user_image"];
            [mutdic setValue:[Dic valueForKey:@"report_title"] forKey:@"report_title"];
            [mutdic setValue:[Dic valueForKey:@"report_desc"] forKey:@"report_desc"];
            [mutdic setValue:[Dic valueForKey:@"report_id"] forKey:@"report_id"];
            [mutdic setValue:[Dic valueForKey:@"getlink"] forKey:@"getlink"];
            
            [UserReportClassDataArray addObject:mutdic];
        }
        NSLog(@"The return data:%@",UserReportClassDataArray);
    }
    else
    {
        _UserreportNoResult.hidden=NO;
    }
    
    [self performSelectorOnMainThread:@selector(tablereload) withObject:nil waitUntilDone:YES];
    
}

-(void)tablereload
{
    [self.UIloadingData stopAnimating];
    [self.UserreportResultTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [UserReportClassDataArray count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellUserReport";
    CellUserReport *tableCell = (CellUserReport *)[self.UserreportResultTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (tableCell == nil) {
        
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        tableCell = (CellUserReport *)[nibArray objectAtIndex:0];
        
    }
    NSMutableDictionary *CellData = [UserReportClassDataArray objectAtIndex:indexPath.row];
    
    //  UIActivityIndicatorView *CellImageBadgeActivity     = (UIActivityIndicatorView *)[tableCell viewWithTag:256];
    UIImageView *CellBadgeImage                         = (UIImageView *)[tableCell viewWithTag:257];
    UILabel *CellBadgeTitleLable                        = (UILabel *)[tableCell viewWithTag:258];
    UILabel *CellBadgeFooterLable                       = (UILabel *)[tableCell viewWithTag:555];
    UIButton *CellBadgeShareOnFacebook                  = (UIButton *)[tableCell viewWithTag:260];
    UIButton *CellBadgeShareOnTwitter                   = (UIButton *)[tableCell viewWithTag:261];
    UIView *CellBadgeShareOnView                        = (UIView *)[tableCell viewWithTag:777];
    UILabel *CellBadgeShareOnLabel                      = (UILabel *)[tableCell viewWithTag:666];//654
    UITextView *Detailslabel                            = (UITextView *)[tableCell viewWithTag:654];
    
    
    [CellBadgeTitleLable setText:[CellData objectForKey:@"report_title"]];
    [CellBadgeShareOnView setBackgroundColor:UIColorFromRGB(0xF3EFEF)];
    [CellBadgeShareOnLabel setBackgroundColor:UIColorFromRGB(0xc5c5c5)];
    [CellBadgeFooterLable setBackgroundColor:UIColorFromRGB(0xc5c5c5)];
    [CellBadgeTitleLable setTextColor:UIColorFromRGB(0x211e1f)];
    //[CellBadgeTitleLable setFont:[UIFont fontWithName:GLOBALTEXTFONT size:14.0]];
    [CellBadgeTitleLable setFont:[UIFont fontWithName:@"OpenSans-Semibold" size:14.0]];
    
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
    
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
    //
    //        [CellImageBadgeActivity startAnimating];
    //
    //        NSError *ImageDownloadError;
    //        NSURL *ImageUrl         = [[NSURL alloc] initWithString:[CellData objectForKey:@"user_image"]];
    //        NSData *ImageData       = [NSData dataWithContentsOfURL:ImageUrl options:kNilOptions error:&ImageDownloadError];
    //
    //        dispatch_async(dispatch_get_main_queue(), ^(void) {
    //
    //            [CellImageBadgeActivity stopAnimating];
    //            [CellBadgeImage setImage:[UIImage imageWithData:ImageData]];
    //
    //        });
    //
    //    });
    
    tableCell.textLabel.text=[CellData valueForKey:@"report_id"];
    tableCell.textLabel.hidden=YES;
    
    Detailslabel.userInteractionEnabled=NO;
    Detailslabel.scrollEnabled=NO;
    Detailslabel.backgroundColor = [UIColor clearColor];
    Detailslabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:12];
    Detailslabel.textColor = UIColorFromRGB(0x000000);
    NSString *descriptioText=[CellData objectForKey:@"report_desc"];
    
    NSLog(@"------ %@",[CellData objectForKey:@"report_desc"]);
    if (descriptioText.length<2)
    {
        Detailslabel.text=@"";
    }
    else
    {
        Detailslabel.text = [UserReportClass stripTags:descriptioText];
    }
    
    Detailslabel.textAlignment = NSTextAlignmentLeft;
    [tableCell.contentView addSubview:Detailslabel];
    
    //
    //    tableViewCell=[tableView dequeueReusableCellWithIdentifier:CellID];
    //    if (tableViewCell==nil)
    //    {
    //        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    //        NSMutableDictionary *CellData = [UserReportClassDataArray objectAtIndex:indexPath.row];
    //        UIView  *MainCellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    //        MainCellView.backgroundColor = [UIColor clearColor];
    //    UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 60, 60)];
    //    ImageView.backgroundColor = [UIColor clearColor];
    ////    ImageView.layer.cornerRadius=6.0f;
    ////    ImageView.layer.borderWidth=1.0f;
    ////    ImageView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    //
    //
    //
    //    [MainCellView addSubview:ImageView];
    //
    
    
    ZSImageView *imageView = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    //    imageView.defaultImage = [UIImage imageNamed:@"Noimage.png"];
    imageView.defaultImage = [UIImage imageNamed:@"NEWNOIMAGE.png"];
    imageView.imageUrl = [CellData objectForKey:@"user_image"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.corners = ZSRoundCornerAll;
    imageView.cornerRadius = 20;
    [CellBadgeImage addSubview:imageView];
    
    
    UIImageView *ImageOverlay = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [ImageOverlay setImage:[UIImage imageNamed:@"out-line.png"]];
    [CellBadgeImage addSubview:ImageOverlay];
    
    
    
    //
    //    tableViewCell.textLabel.text=[CellData valueForKey:@"report_id"];
    //    tableViewCell.textLabel.hidden=YES;
    //
    //    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 220, 20)];
    //    TitleLabel.backgroundColor = [UIColor clearColor];
    //    TitleLabel.numberOfLines = 0;
    //    TitleLabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:16];
    //    TitleLabel.textColor = UIColorFromRGB(0x000000);
    //    TitleLabel.text = [UserReportClass stripTags:[CellData objectForKey:@"report_title"]];
    //    [MainCellView addSubview:TitleLabel];
    //
    //    UITextView *Detailslabel = [[UITextView alloc] initWithFrame:CGRectMake(67, 35, 223, 40)];
    //        Detailslabel.userInteractionEnabled=NO;
    //        Detailslabel.scrollEnabled=NO;
    //    Detailslabel.backgroundColor = [UIColor clearColor];
    //    Detailslabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:12];
    //    Detailslabel.textColor = UIColorFromRGB(0x000000);
    //        NSString *descriptioText=[CellData objectForKey:@"report_desc"];
    //        if (descriptioText.length<2)
    //        {
    //            Detailslabel.text=@"Add Description Here";
    //        }
    //        else
    //        {
    //        Detailslabel.text = [UserReportClass stripTags:descriptioText];
    //        }
    //
    //    Detailslabel.textAlignment = NSTextAlignmentLeft;
    //    [MainCellView addSubview:Detailslabel];
    //    UILabel *Separator=[[UILabel alloc]initWithFrame:CGRectMake(67, 79, 320-60, .5)];
    //    [Separator.layer setOpacity:.2];
    //        [Separator setBackgroundColor:[UIColor blackColor]];
    //        [MainCellView addSubview:Separator];
    //
    //    [tableViewCell addSubview:MainCellView];
    //
    //    }
    return tableCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    AppDelegate *maindelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    ReportDetailsViewController *report=[[ReportDetailsViewController alloc]init];
    report.reportId=cell.textLabel.text;
    [maindelegate SetUpTabbarControllerwithcenterView:report];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *MainHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [MainHeaderView setBackgroundColor:[UIColor whiteColor]];
    UILabel *Titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    Titlelabel.backgroundColor=[UIColor whiteColor];
    Titlelabel.text = @"MY REPORTS";
    [Titlelabel setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16.0]];
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

-(void)HideNavigationBar {
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    GlobalSelectedIndexPathOne             = IndexpathVal;
    
    NSUserDefaults *prefs               = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *CellData = [UserReportClassDataArray objectAtIndex:IndexpathVal];
    NSString *ShareString               = [NSString stringWithFormat:@"%@ posted a new report on TrafficCop. %@",[prefs objectForKey:@"username"],[CellData objectForKey:@"getlink"]];
    
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
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%@",TextDataForSocialShare], @"message",@"", @"source",nil];
    [FBRequestConnection startWithGraphPath:@"me/feed" parameters:params HTTPMethod:@"POST" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if(error) {
            [UserReportClass HidePopupView];
            NSLog(@" error is %@",error);
            UIAlertView *FacebookAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"failed to post, Please try again later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [FacebookAlertView show];
        } else {
            [UserReportClass HidePopupView];
            UIAlertView *FacebookAlertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Badge Shared successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [FacebookAlertView show];
        }
    }];
}


-(IBAction)FinalShareOnFacebook:(UIButton *)sender {
    //exit(0);
    
    [UserReportClass AddBlackOverlay:self.view xcord:0 ycord:0 width:self.view.frame.size.width height:self.view.frame.size.height backgroundColor:[UIColor blackColor] OpacitY:0.9f Text:@"Please wait" TextColor:[UIColor whiteColor] FontName:globalTEXTFIELDPLACEHOLDERFONT FontSize:18 IsTextEnabled:YES];
    
    NSMutableDictionary *CellData   = [UserReportClassDataArray objectAtIndex:GlobalSelectedIndexPathOne];
    
    TextDataForSocialShare          = _SharepopupviewTextView.text;
    LinkDataForSocialShare          = [CellData objectForKey:@"getlink"];
    
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
            [UserReportClass HidePopupView];
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
    
    
    
    
    
    [UserReportClass AddBlackOverlay:self.view xcord:0 ycord:0 width:self.view.frame.size.width height:self.view.frame.size.height backgroundColor:[UIColor blackColor] OpacitY:0.9f Text:@"Please wait" TextColor:[UIColor whiteColor] FontName:globalTEXTFIELDPLACEHOLDERFONT FontSize:18 IsTextEnabled:YES];
    
    NSMutableDictionary *CellData   = [UserReportClassDataArray objectAtIndex:GlobalSelectedIndexPathOne];
    
    TextDataForSocialShare              = _SharepopupviewTextView.text;
    LinkDataForSocialShare              = [CellData objectForKey:@"getlink"];
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        ACAccountStore *accountStore    = [[ACAccountStore alloc] init];
        ACAccountType *accountType      = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
            
            NSArray *accountsArray      = [accountStore accountsWithAccountType:accountType];
            
            if([accountsArray count]>0)
            {
                
                @try {
                    
                    SLRequestHandler requestHandler =
                    ^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                        
                        NSLog(@"responseData ------ %@",responseData);
                        if (responseData) {
                            NSInteger statusCode = urlResponse.statusCode;
                            
                            NSLog(@"urlResponse.statusCode ---- %ld",(long)urlResponse.statusCode);
                            if (statusCode >= 200 && statusCode < 300) {
                                [UserReportClass HidePopupView];
                                NSDictionary *postResponseData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
                                NSLog(@"----- %@",postResponseData);
                            } else {
                                [UserReportClass HidePopupView];
                                NSLog(@"[ERROR] Server responded: status code %ld %@", (long)statusCode,[NSHTTPURLResponse localizedStringForStatusCode:statusCode]);
                                UIAlertView *TwitterAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unexpected Error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                [TwitterAlertView show];
                            }
                        } else {
                            [UserReportClass HidePopupView];
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
                                              @"/1.1/statuses/update.json"];
                                NSDictionary *params = @{@"status" : [NSString stringWithFormat:@"%@",TextDataForSocialShare]};
                                SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                                        requestMethod:SLRequestMethodPOST
                                                                                  URL:url
                                                                           parameters:params];
                                [request setAccount:[accountsArray lastObject]];
                                [request performRequestWithHandler:requestHandler];
                                [UserReportClass HidePopupView];
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    
                                    UIAlertView *TwitterAlertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Report Shared successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                    [TwitterAlertView show];
                                    
                                });
                                
                            });
                        }
                        else {
                            [UserReportClass HidePopupView];
                            NSString *ErrString = [NSString stringWithFormat:@"[ERROR] An error occurred while asking for user authorization: %@",[error localizedDescription]];
                            UIAlertView *TwitterAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:ErrString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [TwitterAlertView show];
                        }
                    };
                    [accountStore requestAccessToAccountsWithType:accountType options:NULL completion:accountStoreHandler];
                    
                }
                @catch (NSException *Exception) {
                    NSLog(@"Exception ---- %@",Exception);
                }
            } else {
                [UserReportClass HidePopupView];
                NSLog(@"Unknown error occered");
                UIAlertView *TwitterAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unexpected Error,Please Try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [TwitterAlertView show];
            }
        }];
    } else {
        [UserReportClass HidePopupView];
        UIAlertView *TwitterAlertView = [[UIAlertView alloc] initWithTitle:@"Account Settings Error" message:@"Set Twitter in your phone settings first" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [TwitterAlertView show];
    }
}

-(IBAction)FinalCancel:(UIButton *)sender
{
    GlobalSelectedIndexPathOne = 0;
    [_SharepopupViewMainLayer removeFromSuperview];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [self FinalCancel:nil];
}
@end
