//
//  RecordAudioViewController.m
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 14/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import "RecordAudioViewController.h"
#import "HelperClass.h"
#import "MFSideMenu.h"
#import <QuartzCore/CoreAnimation.h>
#import "AppDelegate.h"
#import "MBHUDView.h"
#import "MyallaudioViewController.h"

#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

@interface RecordAudioViewController () {
    HelperClass *RecordAudioClass;
}

@end

@implementation RecordAudioViewController

@synthesize playButton          = _playButton;
@synthesize recordButton        = _recordButton;
@synthesize isRecording         = _isRecording;
@synthesize saveButton          = _saveButton;
@synthesize ThreadQue           = _ThreadQue;
@synthesize progressBar;
@synthesize laberecordstatus;

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
    
    [self HideNavigationBar];
    
    RecordAudioClass = [[HelperClass alloc] init];
    
    [RecordAudioClass SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    
    [RecordAudioClass SetupHeaderView:self.view viewController:self];
    
    _ThreadQue = [NSOperationQueue new];
    
    [self.recordButton setImage:[UIImage imageNamed:@"microphone.png"] forState:UIControlStateNormal];
    
    self.isRecording = NO;
    [self.playButton setEnabled:NO];
    [self.saveButton setEnabled:NO];
    self.playButton.titleLabel.alpha = 0.5;
    recordedFile = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingString:@"RecordedFile"]];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if(session == nil)
        NSLog(@"Error creating session: %@", [sessionError description]);
    else
        [session setActive:YES error:nil];
    
    [_timeleftLabel setText:@"0.00"];
    [_timeleftLabel setTextColor:UIColorFromRGB(0x7a7a7a)];
    [_timeleftLabel setBackgroundColor:[UIColor clearColor]];
    [_timeleftLabel setFont:[UIFont fontWithName:@"Oswald" size:10.5]];
    [_timeleftLabel setShadowColor:UIColorFromRGB(0xcbcacc)];
    [_timeleftLabel setShadowOffset:CGSizeMake(0.0f, 0.9f)];
    
    [_timetotalLabel setText:@"120"];
    [_timetotalLabel setTextColor:UIColorFromRGB(0x7a7a7a)];
    [_timetotalLabel setBackgroundColor:[UIColor clearColor]];
    [_timetotalLabel setFont:[UIFont fontWithName:@"Oswald" size:10.5]];
    [_timetotalLabel setShadowColor:UIColorFromRGB(0xcbcacc)];
    [_timetotalLabel setShadowOffset:CGSizeMake(0.0f, 0.9f)];
    
    progressBar.backgroundColor = [UIColor clearColor];
    UIImage *stetchLeftTrack = [[UIImage imageNamed:@"progressimage.png"] stretchableImageWithLeftCapWidth:1.0 topCapHeight:1.00];
    UIImage *stetchRightTrack = [[UIImage imageNamed:@"testimageone.png"] stretchableImageWithLeftCapWidth:1.0 topCapHeight:1.00];
    [progressBar setThumbImage: [UIImage imageNamed:@"slidernew.png"] forState:UIControlStateNormal];
    [progressBar setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    [progressBar setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    progressBar.continuous = YES;
    progressBar.userInteractionEnabled = NO;
    progressBar.minimumValue = 0.0f;
    progressBar.maximumValue = 120.0f;
    progressBar.value = 0.0f;
    
    NSError *err = nil;
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSURL *url = [NSURL fileURLWithPath:[documentsDirectory stringByAppendingPathComponent:[self dateString]]];
    
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithInt:kAudioFormatMPEG4AAC], AVFormatIDKey,
                              [NSNumber numberWithFloat:44100.0], AVSampleRateKey,
                              [NSNumber numberWithInt:1], AVNumberOfChannelsKey, nil];
    
    recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&err];
    
    if (!recorder) { /* handle error */ }
    
    [recorder setDelegate:self];
    
    [laberecordstatus setTextColor:[UIColor whiteColor]];
    [laberecordstatus setFont:[UIFont fontWithName:@"Oswald" size:15.5]];
    [laberecordstatus setShadowColor:[UIColor blackColor]];
    [laberecordstatus setShadowOffset:CGSizeMake(0.0f, 0.9f)];
  
    laberecordstatus.hidden = YES;
}

#pragma mark -
#pragma mark - UIBarButtonItem Callbacks

- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

- (void)rightSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{}];
}

-(void)HideNavigationBar
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)playPause:(id)sender
{
    //If the track is playing, pause and achange playButton text to "Play"
    if([player isPlaying])
    {
        [player pause];
        [self.recordButton setEnabled:YES];
        [self.saveButton setEnabled:YES];
        [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
    }
    //If the track is not player, play the track and change the play button to "Pause"
    else {
        [player play];
        progressBar.value = 0.0f;
        [self.recordButton setEnabled:NO];
        [self.saveButton setEnabled:NO];
        
       // NSLog(@"recorder.currentTime :::: ======== %f",player.duration);
        
        [_timetotalLabel setText:[NSString stringWithFormat:@"%.0f",player.duration]];
        progressBar.maximumValue = player.duration;
        currentTimeUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                                  target:self selector:@selector(updateAudioDisplayplay)
                                                                userInfo:NULL repeats:YES];
        
        [self.playButton setTitle:@"Pause" forState:UIControlStateNormal];
        
    }
}

- (NSString *) dateString
{
    
    // return a formatted string for a file name
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"ddMMMYY_hhmmssa";
    return [[formatter stringFromDate:[NSDate date]] stringByAppendingString:@".mp4"];
}


- (IBAction)startStopRecording:(id)sender
{
    [currentTimeUpdateTimer invalidate];
   // NSLog(@"Start Recording");
    progressBar.minimumValue = 0.0f;
    progressBar.maximumValue = 120.0f;
    progressBar.value = 0.0f;
    [_timeleftLabel setText:@"0"];
    if(!self.isRecording) {
        [_timetotalLabel setText:@"120"];
        currentTimeUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                                  target:self selector:@selector(updateAudioDisplay)
                                                                userInfo:NULL repeats:YES];
        self.isRecording = YES;
        [self.playButton setEnabled:NO];
        [self.saveButton setEnabled:NO];
        
        CATransition *animation = [CATransition animation];
        [animation setType:kCATransitionPush];
        [animation setSubtype:kCATransitionFromTop];
        animation.duration = 0.3;
        [laberecordstatus.layer addAnimation:animation forKey:nil];
        laberecordstatus.hidden = NO;
        //[self.recordButton setImage:[UIImage imageNamed:@"recordpause.png"] forState:UIControlStateNormal];
        [self.recordButton setTitle:@"STOP" forState:UIControlStateNormal];
        [self.playButton.titleLabel setAlpha:0.5];
      
        [recorder prepareToRecord];
        [recorder record];
    } else {
        self.isRecording = NO;
        laberecordstatus.hidden = YES;
        //[self.recordButton setImage:[UIImage imageNamed:@"microphone.png"] forState:UIControlStateNormal];
        [self.recordButton setTitle:@"REC" forState:UIControlStateNormal];
        [self.playButton setEnabled:YES];
        [self.saveButton setEnabled:YES];
        [self.playButton.titleLabel setAlpha:1];
        [recorder stop];
        [self playAudio:recorder.url];
    }
}
- (void) updateAudioDisplay {
    
    double currentTime = recorder.currentTime;
    progressBar.value = currentTime;
    [_timeleftLabel setText:[NSString stringWithFormat:@"%.0f",currentTime]];
    if(currentTime > 120) {
        progressBar.value = 120.0f;
        self.isRecording = NO;
        [self.recordButton setTitle:@"REC" forState:UIControlStateNormal];
        [self.playButton setEnabled:YES];
        [self.saveButton setEnabled:YES];
        [self.playButton.titleLabel setAlpha:1];
        [recorder stop];
        [self.recordButton setImage:[UIImage imageNamed:@"microphone.png"] forState:UIControlStateNormal];
        laberecordstatus.hidden = YES;
        [self playAudio:recorder.url];
    } else {
        EXIT_SUCCESS;
    }
}
-(void)playAudio:(NSURL *)recordedFile
{
    NSError *playerError;
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:&playerError];
    if (player == nil) {
        NSLog(@"ERror creating player: %@", [playerError description]);
    }
    player.delegate = self;
    [currentTimeUpdateTimer invalidate];
}
- (void) updateAudioDisplayplay {
    double currentTime = player.currentTime;
    progressBar.value = currentTime;
    [_timeleftLabel setText:[NSString stringWithFormat:@"%.0f",currentTime]];
    if(currentTime > player.duration) {
        [currentTimeUpdateTimer invalidate];
    }
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [currentTimeUpdateTimer invalidate];
    [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
    [self.recordButton setEnabled:YES];
    [self.saveButton setEnabled:YES];
    progressBar.minimumValue = 0.0f;
    progressBar.value = 0.0f;
    [_timeleftLabel setText:[NSString stringWithFormat:@"0.0"]];
}
- (IBAction)Savecomments:(id)sender {
    
    [RecordAudioClass AddBlackOverlay:self.view xcord:0 ycord:0 width:self.view.frame.size.width height:self.view.frame.size.height backgroundColor:[UIColor blackColor] OpacitY:0.9f Text:@"Please wait" TextColor:[UIColor whiteColor] FontName:globalTEXTFIELDPLACEHOLDERFONT FontSize:18 IsTextEnabled:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        NSData *myData = [NSData dataWithContentsOfURL:recorder.url];
        NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
        
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
        [tempDict setObject:userid forKey:@"user_id"];
        
        NSString *urlString = [RecordAudioClass CallURLForServerReturn:tempDict URL:AUDIOUPLOADPAGE];
       // NSLog(@"urlString --- %@",urlString);
        
        NSString *filename = @"123audio";
        NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"POST"];
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        NSMutableData *postbody = [NSMutableData data];
        [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@.mp3\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[NSData dataWithData:myData]];
        [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:postbody];
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *str = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        NSLog(@"Responce Data ---- %@", str);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self HideIndicator];
            MBAlertView *alertss = [MBAlertView alertWithBody:@"Audio Uploded Successfully !!" cancelTitle:nil cancelBlock:nil];
            [alertss addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
                
                [RecordAudioClass SetLoader:self.view xcord:0 ycord:self.view.frame.size.height-10 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
                
                MyallaudioViewController *MyallAudio = [[MyallaudioViewController alloc] init];
                AppDelegate *maindelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [maindelegate SetUpTabbarControllerwithcenterView:MyallAudio];
                
            }];
            [alertss addToDisplayQueue];
        });
    });
}

-(void)HideIndicator {
    
    AppDelegate *AppDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [RecordAudioClass SetLoader:AppDel.window xcord:80 ycord:self.view.frame.size.height-10 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
    
}
- (void)viewDidUnload
{
    [self setPlayButton:nil];
    [self setRecordButton:nil];
    recorder = nil;
    player = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtURL:recordedFile error:nil];
    recordedFile = nil;
    [self setBlurSwitch:nil];
    [self setTapOutsideSwitch:nil];
    [super viewDidUnload];
}

@end
