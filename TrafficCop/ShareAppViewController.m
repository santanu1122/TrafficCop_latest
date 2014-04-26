//
//  ShareAppViewController.m
//  TrafficCop
//
//  Created by Iphone_2 on 03/04/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "ShareAppViewController.h"
#import "HelperClass.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <FacebookSDK/FacebookSDK.h>
#import "MFSideMenu.h"

@interface ShareAppViewController ()<UITextViewDelegate,UIAlertViewDelegate> {
    HelperClass *ShareAppClass;
    NSData *ImageDataForSocialShare;
    NSString *TextDataForSocialShare;
    NSString *LinkDataForSocialShare;
    
    NSURLConnection *Connecttion;
    NSMutableData* webdata;
}

@property (nonatomic,retain) IBOutlet UIView *ShareTopView;
@property (nonatomic,retain) IBOutlet UIView *ShareBottomView;
@property (nonatomic,retain) IBOutlet UILabel *SharedHeadingLabel;
@property (nonatomic,retain) IBOutlet UILabel *SharedTextLabel;
@property (nonatomic,retain) IBOutlet UILabel *SharedEditTextLabel;
@property (nonatomic,retain) IBOutlet UILabel *SharedHeadingLabelLine;
@property (nonatomic,retain) IBOutlet UILabel *SharedBottomLabelLine;

@property (nonatomic,retain) IBOutlet UITextView *SharedTextTextview;

@property (nonatomic,retain) UIButton *ShareOnfacebook;
@property (nonatomic,retain) UIButton *Shareontwitter;
@property (nonatomic,retain) NSURLConnection *Connecttion;

@end

@implementation ShareAppViewController

@synthesize ShareTopView            = _ShareTopView;
@synthesize SharedHeadingLabel      = _SharedHeadingLabel;
@synthesize SharedTextLabel         = _SharedTextLabel;
@synthesize SharedEditTextLabel     = _SharedEditTextLabel;
@synthesize SharedHeadingLabelLine  = _SharedHeadingLabelLine;
@synthesize SharedBottomLabelLine   = _SharedBottomLabelLine;
@synthesize SharedTextTextview      = _SharedTextTextview;
@synthesize ShareOnfacebook         = _ShareOnfacebook;
@synthesize Shareontwitter          = _Shareontwitter;
@synthesize ShareBottomView         = _ShareBottomView;
@synthesize LastVisitedpage         = _LastVisitedpage;
@synthesize Connecttion             = _Connecttion;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ShareAppClass = [[HelperClass alloc] init];
    
    [self.navigationController setNavigationBarHidden:YES];
    [ShareAppClass SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    [ShareAppClass SetupHeaderView:self.view viewController:self];
    
    [ShareAppClass AddBlackOverlay:self.view xcord:0 ycord:0 width:self.view.frame.size.width height:self.view.frame.size.height backgroundColor:[UIColor blackColor] OpacitY:0.9f Text:@"Please wait" TextColor:[UIColor whiteColor] FontName:globalTEXTFIELDPLACEHOLDERFONT FontSize:18 IsTextEnabled:YES];
    
    // top view
    
    [_ShareTopView setBackgroundColor:[UIColor blackColor]];
    [_ShareTopView.layer setOpacity:0.8f];
    
    //
    
    [_SharedHeadingLabel setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16.0f]];
    [_SharedHeadingLabel setBackgroundColor:[UIColor clearColor]];
    
    // TextView
    
    [_SharedTextTextview setBackgroundColor:[UIColor clearColor]];
    [_SharedTextTextview setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16.0f]];
    [_SharedTextTextview setTextColor:[UIColor darkGrayColor]];
    [_SharedTextTextview setUserInteractionEnabled:YES];
    [_SharedTextTextview setEditable:YES];
//    if ([_LastVisitedpage isEqualToString:@"R"]) {
//        [_SharedTextTextview setText:@"I posted a new report on traffic-cop, Please visit http://esolzdemos.com/lab3/trafficcop"];
//    } else {
//        [_SharedTextTextview setText:@"I am using TrafficCop App, It's Awesome. Please visit http://esolzdemos.com/lab3/trafficcop"];
//    }
    [_SharedTextTextview setDelegate:self];
    
    [_SharedEditTextLabel setFont:[UIFont fontWithName:GLOBALTEXTFONT size:10.0f]];
    [_SharedEditTextLabel setText:@"Tap on the text to edit it"];
    [_SharedEditTextLabel setTextAlignment:NSTextAlignmentRight];
    [_SharedEditTextLabel setBackgroundColor:[UIColor clearColor]];
    [_SharedEditTextLabel setTextColor:[UIColor blackColor]];
    
    _ShareOnfacebook = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_ShareOnfacebook setFrame:CGRectMake(55, 230, 100, 40)];
    [_ShareOnfacebook.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_ShareOnfacebook.layer setBorderWidth:1.0f];
    [_ShareOnfacebook.titleLabel setTextColor:[UIColor blackColor]];
    [_ShareOnfacebook.layer setCornerRadius:3.0f];
    [_ShareOnfacebook setTintColor:[UIColor darkGrayColor]];
    [_ShareOnfacebook setTitle:@"Facebook" forState:UIControlStateNormal];
    [_ShareOnfacebook setTitle:@"Facebook" forState:UIControlStateSelected];
    [_ShareOnfacebook.titleLabel setFont:[UIFont fontWithName:GLOBALTEXTFONT size:18.0f]];
    [_ShareOnfacebook addTarget:self action:@selector(FinalShareOnFacebook:) forControlEvents:UIControlEventTouchUpInside];
    [_ShareBottomView addSubview:_ShareOnfacebook];
    
    _Shareontwitter = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_Shareontwitter setFrame:CGRectMake(165, 230, 100, 40)];
    [_Shareontwitter.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_Shareontwitter.layer setBorderWidth:1.0f];
    [_Shareontwitter.layer setCornerRadius:3.0f];
    [_Shareontwitter setTintColor:[UIColor darkGrayColor]];
    [_Shareontwitter setTitle:@"Twitter" forState:UIControlStateNormal];
    [_Shareontwitter setTitle:@"Twitter" forState:UIControlStateSelected];
    [_Shareontwitter.titleLabel setFont:[UIFont fontWithName:GLOBALTEXTFONT size:18.0f]];
    [_Shareontwitter addTarget:self action:@selector(FinalShareOnTwitter:) forControlEvents:UIControlEventTouchUpInside];
    [_ShareBottomView addSubview:_Shareontwitter];
    
    dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),
                   ^{
                       NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@getappstaticdata.php",DomainURL]]];
                       // NSLog(@"request url ---- %@",request);
                       
                       _Connecttion = [[NSURLConnection alloc] initWithRequest: request delegate: self startImmediately: NO];
                       
                       [_Connecttion setDelegateQueue: [NSOperationQueue mainQueue]];
                       [_Connecttion start];
                   });
    
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
    
    @try {
        NSDictionary *deserializedData  = [NSJSONSerialization JSONObjectWithData:webdata options:NSJSONReadingAllowFragments error:&jsonParsingError];
        
        NSArray *extraparam=[deserializedData objectForKey:@"extraparam"];
        NSDictionary *ExtraparamDic=[extraparam objectAtIndex:0];
        NSString *reportString=[ExtraparamDic valueForKey:@"response"];
        
        if ([reportString isEqualToString:@"success"]) {
            NSDictionary *ReportresultArry=[deserializedData objectForKey:@"searchresult"];
            NSLog(@"ReportresultArry --- %@",ReportresultArry);

                //NSLog(@"DicData --- %@",ReportresultArry);
                [_SharedTextTextview setText:[NSString stringWithFormat:@"%@ %@",[ReportresultArry objectForKey:@"text_data"],[ReportresultArry objectForKey:@"site_url"]]];
           // }
            [ShareAppClass HidePopupView];
        } else {
            [ShareAppClass HidePopupView];
        }
    }
    @catch (NSException *exception) {
        [ShareAppClass HidePopupView];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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
#pragma mark - UIBarButtonItem Callbacks
- (void)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)leftSideMenuButtonPressed:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}
- (void)rightSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{}];
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
            [ShareAppClass HidePopupView];
            NSLog(@" error is %@",error);
            UIAlertView *FacebookAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"failed to post, Please try again later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [FacebookAlertView show];
        } else {
            [ShareAppClass HidePopupView];
            UIAlertView *FacebookAlertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Shared successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [FacebookAlertView show];
        }
    }];
}
-(IBAction)FinalShareOnFacebook:(UIButton *)sender {
    //exit(0);
    
    [ShareAppClass AddBlackOverlay:self.view xcord:0 ycord:0 width:self.view.frame.size.width height:self.view.frame.size.height backgroundColor:[UIColor blackColor] OpacitY:0.9f Text:@"Please wait" TextColor:[UIColor whiteColor] FontName:globalTEXTFIELDPLACEHOLDERFONT FontSize:18 IsTextEnabled:YES];
    
    UIImage *ImageOne               = [UIImage imageNamed:@"traffic_logo.png"];
    ImageDataForSocialShare         = UIImageJPEGRepresentation(ImageOne, 1);
    TextDataForSocialShare          = _SharedTextTextview.text;
    
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
            [ShareAppClass HidePopupView];
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
    
    [ShareAppClass AddBlackOverlay:self.view xcord:0 ycord:0 width:self.view.frame.size.width height:self.view.frame.size.height backgroundColor:[UIColor blackColor] OpacitY:0.9f Text:@"Please wait" TextColor:[UIColor whiteColor] FontName:globalTEXTFIELDPLACEHOLDERFONT FontSize:18 IsTextEnabled:YES];

    UIImage *ImageOne                   = [UIImage imageNamed:@"traffic_logo.png"];
    ImageDataForSocialShare             = UIImageJPEGRepresentation(ImageOne, 1);
    TextDataForSocialShare              = _SharedTextTextview.text;
    
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
                            [ShareAppClass HidePopupView];
                            NSDictionary *postResponseData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
                            NSLog(@"----- %@",postResponseData);
                        } else {
                            [ShareAppClass HidePopupView];
                            NSLog(@"[ERROR] Server responded: status code %ld %@", (long)statusCode,[NSHTTPURLResponse localizedStringForStatusCode:statusCode]);
                            UIAlertView *TwitterAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unexpected Error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [TwitterAlertView show];
                        }
                    } else {
                        [ShareAppClass HidePopupView];
                        NSString *ErrString = [NSString stringWithFormat:@"[ERROR] An error occurred while posting: %@", [error localizedDescription]];
                        UIAlertView *TwitterAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:ErrString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [TwitterAlertView show];
                    }
                };
                ACAccountStoreRequestAccessCompletionHandler accountStoreHandler =
                ^(BOOL granted, NSError *error) {
                    if (granted) {
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
                        [ShareAppClass HidePopupView];
                        UIAlertView *TwitterAlertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Shared successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [TwitterAlertView show];
                    }
                    else {
                        [ShareAppClass HidePopupView];
                        NSString *ErrString = [NSString stringWithFormat:@"[ERROR] An error occurred while asking for user authorization: %@",[error localizedDescription]];
                        UIAlertView *TwitterAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:ErrString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [TwitterAlertView show];
                    }
                };
                [accountStore requestAccessToAccountsWithType:accountType options:NULL completion:accountStoreHandler];
            } else {
                [ShareAppClass HidePopupView];
                NSLog(@"Unknown error occered");
                UIAlertView *TwitterAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unexpected Error,Please Try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [TwitterAlertView show];
            }
        }];
    } else {
        [ShareAppClass HidePopupView];
        UIAlertView *TwitterAlertView = [[UIAlertView alloc] initWithTitle:@"Account Settings Error" message:@"Set Twitter in your phone settings first" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [TwitterAlertView show];
    }
}

@end
