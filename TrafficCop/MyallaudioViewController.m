//
//  MyallaudioViewController.m
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 15/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import "MyallaudioViewController.h"
#import "HelperClass.h"
#import "MFSideMenu.h"
#import "MBHUDView.h"
#import "AudioStreamer.h"
#import <QuartzCore/CoreAnimation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CFNetwork/CFNetwork.h>
#import "AvaudioPlayer.h"
#import "AppDelegate.h"

@interface MyallaudioViewController () {
    HelperClass *MyallaudioView;
    NSMutableData *webdata;
    NSURLConnection *connection;
    NSMutableArray *MainDataArray;
}
@property (strong, nonatomic) IBOutlet UIView *myAudioView;
@property (nonatomic,retain) IBOutlet UITableView *MypostedAudio;
@property (nonatomic, strong) IBOutlet UILabel * progressLabel;
@property (nonatomic, strong) IBOutlet UILabel * timeleftLabel;
@property (nonatomic, strong) IBOutlet UILabel * timetotalLabel;
@end

@implementation MyallaudioViewController
@synthesize MypostedAudio;
@synthesize Mainview;
@synthesize isRecording=_isRecording;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setButtonImageNamed:(NSString *)imageName
{
	if (!imageName)
	{
		imageName = @"play_bak.png";
        _PlayStatus = NO;
	}
	//currentImageName = [imageName retain];
	
	UIImage *image = [UIImage imageNamed:imageName];
	
	[button.layer removeAllAnimations];
	[button setImage:image forState:0];
    
	if ([imageName isEqual:@"audioloader.png"])
	{
		[self spinButton];
	}
}



- (void)destroyStreamer
{
	if (streamer)
	{
		[[NSNotificationCenter defaultCenter]
         removeObserver:self
         name:ASStatusChangedNotification
         object:streamer];
		[progressUpdateTimer invalidate];
		progressUpdateTimer = nil;
		
		[streamer stop];
		streamer = nil;
	}
}

//
// createStreamer
//
// Creates or recreates the AudioStreamer object.
//
- (void)createStreamer : (NSString *)streemURL
{
	if (streamer)
	{
		return;
	}
    
	[self destroyStreamer];
	
	NSString *escapedValue =
    (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                         nil,
                                                         (CFStringRef)streemURL,
                                                         NULL,
                                                         NULL,
                                                         kCFStringEncodingUTF8));
    
	NSURL *url = [NSURL URLWithString:escapedValue];
	streamer = [[AudioStreamer alloc] initWithURL:url];
    
	
	progressUpdateTimer =
    [NSTimer
     scheduledTimerWithTimeInterval:0.1
     target:self
     selector:@selector(updateProgress:)
     userInfo:nil
     repeats:YES];
	[[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(playbackStateChanged:)
     name:ASStatusChangedNotification
     object:streamer];
}

//
// spinButton
//
// Shows the spin button when the audio is loading. This is largely irrelevant
// now that the audio is loaded from a local file.
//
- (void)spinButton
{
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
	CGRect frame = [button frame];
	button.layer.anchorPoint = CGPointMake(0.5, 0.5);
	button.layer.position = CGPointMake(frame.origin.x + 0.5 * frame.size.width, frame.origin.y + 0.5 * frame.size.height);
	[CATransaction commit];
    
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
	[CATransaction setValue:[NSNumber numberWithFloat:2.0] forKey:kCATransactionAnimationDuration];
    
	CABasicAnimation *animation;
	animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	animation.fromValue = [NSNumber numberWithFloat:0.0];
	animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
	animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
	animation.delegate = self;
	[button.layer addAnimation:animation forKey:@"rotationAnimation"];
    
	[CATransaction commit];
}

//
// animationDidStop:finished:
//
// Restarts the spin animation on the button when it ends. Again, this is
// largely irrelevant now that the audio is loaded from a local file.
//
// Parameters:
//    theAnimation - the animation that rotated the button.
//    finished - is the animation finised?
//
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)finished
{
	if (finished)
	{
		[self spinButton];
	}
}

//
// buttonPressed:
//
// Handles the play/stop button. Creates, observes and starts the
// audio streamer when it is a play button. Stops the audio streamer when
// it isn't.
//
// Parameters:
//    sender - normally, the play/stop button.
//
- (IBAction)buttonPressed:(id)sender
{
//	if ([currentImageName isEqual:@"play_bak.png"])
//	{
//		[downloadSourceField resignFirstResponder];
//		[self createStreamer];
//		[self setButtonImageNamed:@"audioloader.png"];
//		[streamer start];
//	}
//	else
//	{
//        
//		[streamer stop];
//	}
    NSLog(@"_URLNAME ---- %@",_URLNAME);
    //NSLog(@"currentImageName --- %@",currentImageName);
    if(_PlayStatus == NO) {
        [downloadSourceField resignFirstResponder];
		[self createStreamer:_URLNAME];
		[self setButtonImageNamed:@"audioloader.png"];
		[streamer start];
        _PlayStatus = YES;
	}
	else
	{
		[streamer stop];
	}
}

//
// sliderMoved:
//
// Invoked when the user moves the slider
//
// Parameters:
//    aSlider - the slider (assumed to be the progress slider)
//
- (IBAction)sliderMoved:(UISlider *)aSlider
{
	if (streamer.duration)
	{
		double newSeekTime = (aSlider.value / 100.0) * streamer.duration;
		[streamer seekToTime:newSeekTime];
	}
}

//
// playbackStateChanged:
//
// Invoked when the AudioStreamer
// reports that its playback status has changed.
//
- (void)playbackStateChanged:(NSNotification *)aNotification
{
	if ([streamer isWaiting])
	{
		[self setButtonImageNamed:@"audioloader.png"];
	}
	else if ([streamer isPlaying])
	{
		[self setButtonImageNamed:@"PAUSEONE.png"];
	}
	else if ([streamer isIdle])
	{
		[self destroyStreamer];
		[self setButtonImageNamed:@"play_bak.png"];
        _PlayStatus = NO;
	}
}

//
// updateProgress:
//
// Invoked when the AudioStreamer
// reports that its playback progress has changed.
//
- (void)updateProgress:(NSTimer *)updatedTimer
{
	if (streamer.bitRate != 0.0)
	{
		double progress = streamer.progress;
		double duration = streamer.duration;
        // double timeleft = duration - progress;
        
        int san1 = streamer.duration;
        double seconds1 = san1 % 60;
        double minutes1 = (san1 / 60) % 60;
        
        int san2 = streamer.progress;
        double seconds2 = san2 % 60;
        double minutes2 = (san2 / 60) % 60;
        
        int san3 = streamer.duration - streamer.progress;
        double seconds3 = san3 % 60;
        double minutes3 = (san3 / 60) % 60;
        
		if (duration > 0)
		{
            [_timetotalLabel setText:[NSString stringWithFormat:@"%.0f:%.0f",minutes1,seconds1]];
            [_progressLabel setText:[NSString stringWithFormat:@"%.0f:%.0f",minutes2,seconds2]];
            [_timeleftLabel setText:[NSString stringWithFormat:@"%.0f:%.0f",minutes3,seconds3]];
			[positionLabel setText:
             [NSString stringWithFormat:@"Time Played: %.1f/%.1f seconds",
              progress,
              duration]];
			[progressSlider setEnabled:YES];
            progressSlider.maximumValue = duration;
            progressSlider.value = progress;
		}
		else
		{
			[progressSlider setEnabled:NO];
		}
	}
	else
	{
		positionLabel.text = @"Time Played:";
	}
}

//
// textFieldShouldReturn:
//
// Dismiss the text field when done is pressed
//
// Parameters:
//    sender - the text field
//
// returns YES
//
- (BOOL)textFieldShouldReturn:(UITextField *)sender
{
	[sender resignFirstResponder];
	//[self createStreamer];
	return YES;
}

//
// dealloc
//
// Releases instance memory.
//
- (void)dealloc
{
	[self destroyStreamer];
	if (progressUpdateTimer)
	{
		[progressUpdateTimer invalidate];
		progressUpdateTimer = nil;
	}
}

-(IBAction)ColseAudioPopup:(id)sender {
    if(_IsAudioPlayPopupOpen == YES)
        _IsAudioPlayPopupOpen = NO;
    else
        _IsAudioPlayPopupOpen = YES;
    
    [streamer stop];
    
    [_timetotalLabel setText:@"0.0"];
    [_progressLabel setText:@"0.0"];
    [_timeleftLabel setText:@"0.0"];
    progressSlider.maximumValue = 0.0;
    progressSlider.value = 0.0;
    
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromTop];
    animation.duration = 0.3;
    [Mainview.layer addAnimation:animation forKey:nil];
    Mainview.hidden = YES;
    
}

-(void)viewDidAppear:(BOOL)animated {
    MyallaudioView = [[HelperClass alloc] init];
    [self HideNavigationBar];

    [MyallaudioView SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    
    [MyallaudioView SetupHeaderViewWithCustomButton:self.view viewController:self hideLeftButton:NO hiderightButton:YES leftButtonCustom:NO rightButtonCustom:YES leftButtonText:nil rightButtonText:@"Delete" LeftButtonImgae:nil RightButtonImgae:nil LeftButtonMethod:nil RightButtonMethod:@selector(gotomycommentededitlist)];
    
    [[self MypostedAudio]setDelegate:self];
    [[self MypostedAudio]setDataSource:self];
    self.MypostedAudio.hidden = YES;
    
    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:volumeSlider.bounds];
	[volumeSlider addSubview:volumeView];
	[volumeView sizeToFit];
    _IsAudioPlayPopupOpen = NO;
    Mainview.frame = CGRectMake(0, 0, self.view.layer.frame.size.width,self.view.frame.size.height);
    [self.view addSubview:Mainview];
    Mainview.layer.opacity = 0.8;
    Mainview.hidden  = YES;
    
    progressSlider.backgroundColor = [UIColor clearColor];
//    UIImage *stetchLeftTrack = [[UIImage imageNamed:@"GREENPROG1"] stretchableImageWithLeftCapWidth:1.0 topCapHeight:1.00];
//    UIImage *stetchRightTrack = [[UIImage imageNamed:@"GRAYPROG"] stretchableImageWithLeftCapWidth:1.0 topCapHeight:1.00];
//    [progressSlider setThumbImage: [UIImage imageNamed:@"REDPROG"] forState:UIControlStateNormal];
//    [progressSlider setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
//    [progressSlider setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    progressSlider.continuous = YES;
    
//    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
//    refreshControl.tintColor = UIColorFromRGB(0x3d2b4f);
//    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
//    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
//    [self.MypostedAudio addSubview:refreshControl];
    
    [MyallaudioView SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];

    NSMutableDictionary *tempDictOne = [[NSMutableDictionary alloc] init];
    [tempDictOne setObject:AUDIOUPLOADMODE forKey:@"mode"];
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    [tempDictOne setObject:userid forKey:@"user_id"];
    
    NSString *REturnedURL = [MyallaudioView CallURLForServerReturn:tempDictOne URL:LOGINPAGE];
    
    NSLog(@"REturnedURL --- %@",REturnedURL);
    
    NSURL *url = [NSURL URLWithString:REturnedURL];
    NSURLRequest *restrict1 = [NSURLRequest requestWithURL:url];
    connection = [NSURLConnection connectionWithRequest:restrict1 delegate:self];
    if(connection) {
        webdata = [[NSMutableData alloc]init];
    }
}


//- (void)refresh:(UIRefreshControl *)refreshControl {
//    [self.MypostedAudio reloadData];
//    [refreshControl endRefreshing];
//}
//-(void)refreshView:(UIRefreshControl *)refresh {
//    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"MMM d, h:mm a"];
//    NSString *lastUpdated = [NSString stringWithFormat:@"Last updated on %@",[formatter stringFromDate:[NSDate date]]];
//    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
//    [refresh endRefreshing];
//}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSDictionary *allData = [NSJSONSerialization JSONObjectWithData:webdata options:0 error:nil];
    MainDataArray = [[NSMutableArray alloc] init];
    
    if([[allData objectForKey:@"filedetails"] count] > 0) {
    for(NSMutableDictionary *DICTIDATA in [allData objectForKey:@"filedetails"]) {
        
        NSString *UploadedDate = [DICTIDATA objectForKey:@"uploadeddate"];
        NSString *UploadedFile = [DICTIDATA objectForKey:@"audio_file"];
        NSString *UploadedFileid = [DICTIDATA objectForKey:@"audio_id"];
        
        NSMutableDictionary *TempDirectory = [[NSMutableDictionary alloc] init];
        [TempDirectory setObject:UploadedDate forKey:@"UploadedDate"];
        [TempDirectory setObject:UploadedFile forKey:@"UploadedFile"];
        [TempDirectory setObject:UploadedFileid forKey:@"audio_id"];
        
         [MainDataArray addObject:TempDirectory];
    }
    [MyallaudioView SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
    self.MypostedAudio.hidden = NO;
    [self.MypostedAudio reloadData];
    } else {
        [MyallaudioView SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
        NSLog(@"There is no data");
    }
}

/*
 Connection Receive Respose From Server
 */

#pragma mark
#pragma mark - UITableView Data Source

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webdata setLength:0];
}

/*
 Connection Receive Data From Server and append the data
 */
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webdata appendData:data];
}
/*
 Connection Failed To Get Data From Server
 */

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"err %@",error);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    return 35.0f;
    return 50.0f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _myAudioLbl.font = [UIFont fontWithName:GLOBALTEXTFONT_Title size:16];
    _myAudioLbl.textColor = UIColorFromRGB(0x211e1f);
    
    UIView *MainHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [MainHeaderView setBackgroundColor:[UIColor whiteColor]];
    
    [MainHeaderView addSubview:self.myAudioView];
    
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52.0f;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MainDataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    NSDictionary *item = [MainDataArray objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UIView *CellMainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 52)];
    
        UIImageView *CellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 32, 32)];
        CellMainView.backgroundColor = [UIColor clearColor];
        CellImageView.image = [UIImage imageNamed:@"play_bak.png"];
        [CellMainView addSubview:CellImageView];
    
        UILabel *CellTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 15, 260, 20)];
        CellTextLabel.text = [NSString stringWithFormat:@"Uploaded On %@",[item objectForKey:@"UploadedDate"]];
   
    CellTextLabel.font= [UIFont fontWithName:GLOBALTEXTFONT_Title size:15];
    CellTextLabel.textColor = UIColorFromRGB(0x211e1f);
    
        [CellMainView addSubview:CellTextLabel];
    
    [cell.contentView addSubview:CellMainView];
    
    cell.textLabel.text = [item objectForKey:@"UploadedFile"];
    cell.textLabel.hidden = YES;
    UILabel *separetor=[[UILabel alloc]initWithFrame:CGRectMake(0, 51, 320, .5)];
    [separetor setBackgroundColor:[UIColor blackColor]];
    separetor.layer.opacity=.2f;
    [CellMainView addSubview:separetor];
//    cell.backgroundColor = [UIColor clearColor];
     cell.backgroundColor = [UIColor whiteColor];
    cell.backgroundView = [UIView new] ;
    cell.selectedBackgroundView = [UIView new];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _URLNAME = [[NSMutableString alloc] init];
    [self setButtonImageNamed:@"play_bak.png"];
    _PlayStatus = NO;
    if(_IsAudioPlayPopupOpen == YES)
        _IsAudioPlayPopupOpen = NO;
    else
        _IsAudioPlayPopupOpen = YES;
    
    _URLNAME = [[MainDataArray objectAtIndex:indexPath.row] objectForKey:@"UploadedFile"];
    
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromTop];
    animation.duration = 0.3;
    [Mainview.layer addAnimation:animation forKey:nil];
    Mainview.hidden = NO;

}
- (void)awakeFromNib
{
    [super awakeFromNib];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    editedstatus = @"N";
    
    MypostedAudio.backgroundColor = [UIColor whiteColor];
    
//    _playButton.titleLabel.font = [UIFont fontWithName:GLOBALTEXTFONT_Title size:15];
//    _playButton.titleLabel.textColor = UIColorFromRGB(0x211e1f);
//    
//    
//    _saveButton.titleLabel.font = [UIFont fontWithName:GLOBALTEXTFONT_Title size:15];
//    _saveButton.titleLabel.textColor = UIColorFromRGB(0x211e1f);
//    
//    
//    _recordButton.titleLabel.font = [UIFont fontWithName:GLOBALTEXTFONT_Title size:15];
//    _recordButton.titleLabel.textColor = UIColorFromRGB(0x211e1f);
//    
//    
//    _timeleftLabel.font = [UIFont fontWithName:GLOBALTEXTFONT_Title size:15];
//    _timeleftLabel.textColor = UIColorFromRGB(0x211e1f);
//    
//    
//    _timetotalLabel.font = [UIFont fontWithName:GLOBALTEXTFONT_Title size:15];
//    _timetotalLabel.textColor = UIColorFromRGB(0x211e1f);

    
    
    
    
    _ThreadQue = [NSOperationQueue new];
    
    [self.recordButton setImage:[UIImage imageNamed:@"microphone.png"] forState:UIControlStateNormal];
    
    isRecording = NO;
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
    
    [_timeleftLabel2 setText:@"0.00"];
    [_timeleftLabel2 setTextColor:UIColorFromRGB(0x7a7a7a)];
    [_timeleftLabel2 setBackgroundColor:[UIColor clearColor]];
    [_timeleftLabel2 setFont:[UIFont fontWithName:@"Oswald" size:10.5]];
    [_timeleftLabel2 setShadowColor:UIColorFromRGB(0xcbcacc)];
    [_timeleftLabel2 setShadowOffset:CGSizeMake(0.0f, 0.9f)];
    
    [_timetotalLabel2 setText:@"120"];
    [_timetotalLabel2 setTextColor:UIColorFromRGB(0x7a7a7a)];
    [_timetotalLabel2 setBackgroundColor:[UIColor clearColor]];
    [_timetotalLabel2 setFont:[UIFont fontWithName:@"Oswald" size:10.5]];
    [_timetotalLabel2 setShadowColor:UIColorFromRGB(0xcbcacc)];
    [_timetotalLabel2 setShadowOffset:CGSizeMake(0.0f, 0.9f)];
    
    _progressBar.backgroundColor = [UIColor clearColor];
    UIImage *stetchLeftTrack = [[UIImage imageNamed:@"progressimage.png"] stretchableImageWithLeftCapWidth:1.0 topCapHeight:1.00];
    UIImage *stetchRightTrack = [[UIImage imageNamed:@"testimageone.png"] stretchableImageWithLeftCapWidth:1.0 topCapHeight:1.00];
    [_progressBar setThumbImage: [UIImage imageNamed:@"slidernew.png"] forState:UIControlStateNormal];
    [_progressBar setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    [_progressBar setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    _progressBar.continuous = YES;
    _progressBar.userInteractionEnabled = NO;
    _progressBar.minimumValue = 0.0f;
    _progressBar.maximumValue = 120.0f;
    _progressBar.value = 0.0f;
    
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
    
    [_laberecordstatus setTextColor:[UIColor whiteColor]];
    [_laberecordstatus setFont:[UIFont fontWithName:@"Oswald" size:15.5]];
    [_laberecordstatus setShadowColor:[UIColor blackColor]];
    [_laberecordstatus setShadowOffset:CGSizeMake(0.0f, 0.9f)];
    
    _laberecordstatus.hidden = YES;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(void)processdeletedata:(NSMutableDictionary *)argumentDictionary
{
    NSString *urlString = [MyallaudioView CallURLForServerReturn:argumentDictionary URL:LOGINPAGE];
    
    NSData *dataURL =  [NSData dataWithContentsOfURL: [ NSURL URLWithString: urlString ]];
    NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSUTF8StringEncoding];
    
    NSLog(@"==================");
    NSLog(@"%@",serverOutput);
    NSLog(@"==================");
    [self HideIndicator];
    [self.MypostedAudio reloadData];
}
-(void)HideIndicator {
       [MyallaudioView SetLoader:self.view xcord:80 ycord:self.view.frame.size.height-10 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
//        [MyallaudioView AddBlackOverlay:self.view xcord:0 ycord:0 width:self.view.frame.size.width height:self.view.frame.size.height backgroundColor:[UIColor blackColor] OpacitY:0.9f Text:@"Please wait" TextColor:[UIColor whiteColor] FontName:globalTEXTFIELDPLACEHOLDERFONT FontSize:18 IsTextEnabled:YES];
        
        NSDictionary *str11 = [MainDataArray objectAtIndex:indexPath.row];
        
        NSString *santanu = [str11 objectForKey:@"audio_id"];
        
       /// dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
            [tempDict setObject:santanu forKey:@"audio_id"];
            [tempDict setObject:DELETEAUDIO forKey:@"mode"];
        
        NSURLResponse *response = nil;
        NSError *error;
        NSString *REturnedURL = [MyallaudioView CallURLForServerReturn:tempDict URL:LOGINPAGE];
         NSLog(@"REturnedURL --- %@",REturnedURL);
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:REturnedURL]];
        [request setHTTPMethod:@"POST"];
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        [self HideIndicator];
        
        if (error)
        {
            NSLog(@"Please check your internet connectivity");
            NSLog(@"error -- %@", error);
            dispatch_async(dispatch_get_main_queue(), ^(){
                
                UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"No Connection" message:@"Please check your internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                return ;
            });
        }

        
        else
        {
            NSDictionary *maindic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
            NSLog(@"main dic is %@", maindic);
//            NSString *messEge=[maindic valueForKey:@"message"];
//            NSString *Response=[maindic valueForKey:@"response"];
            
            NSDictionary *mainNewdic = [[maindic objectForKey:@"extraparam"]objectAtIndex:0];
            
            
             if([[mainNewdic objectForKey:@"response"] isEqualToString:@"success"])
             {
                 
                 dispatch_async(dispatch_get_main_queue(), ^(){
                     NSLog(@"sucsess--");
                 UIAlertView *alert=[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@",[mainNewdic valueForKey:@"response"]] message:[NSString stringWithFormat:@"%@",[mainNewdic valueForKey:@"message"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 
                 [alert show];
                     });
             }
        
        }
        
     
       
        [MainDataArray removeObjectAtIndex:indexPath.row];
        
        [self.MypostedAudio beginUpdates];
        [self.MypostedAudio deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
        [self.MypostedAudio endUpdates];
        //UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"success" message:@"Audio Deleted Successfully !!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //[alert show];
        
           // dispatch_async(dispatch_get_main_queue(), ^{
                
//                MBAlertView *alertss = [MBAlertView alertWithBody:@"Audio Deleted Successfully !!" cancelTitle:nil cancelBlock:nil];
//                [alertss addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
//                    
//                    [MyallaudioView SetLoader:self.view xcord:0 ycord:self.view.frame.size.height-10 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
//                    
//                    [
//                    [self.MypostedAudio reloadData];
//                }];
//                [alertss addToDisplayQueue];
           // });
            
        //});
    }
}
- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    
}

- (void)gotomycommentededitlist
{
    if([editedstatus isEqualToString:@"N"]) {
        [self.MypostedAudio setEditing:YES animated:YES];
        editedstatus = @"Y";
    }
    else
    {
        [self.MypostedAudio setEditing:NO animated:YES];
        editedstatus = @"N";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
-(void)HideNavigationBar {
    [self.navigationController setNavigationBarHidden:YES];
}
//methods for Save comment in






- (IBAction)playPause2:(id)sender
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
        _progressBar.value = 0.0f;
        [self.recordButton setEnabled:NO];
        [self.saveButton setEnabled:NO];
        
        // NSLog(@"recorder.currentTime :::: ======== %f",player.duration);
        
        [_timetotalLabel2 setText:[NSString stringWithFormat:@"%.0f",player.duration]];
        _progressBar.maximumValue = player.duration;
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


- (IBAction)startStopRecording2:(id)sender
{
    [currentTimeUpdateTimer invalidate];
    // NSLog(@"Start Recording");
    _progressBar.minimumValue = 0.0f;
    _progressBar.maximumValue = 120.0f;
    _progressBar.value = 0.0f;
    [_timeleftLabel2 setText:@"0"];
    if(!self.isRecording) {
        [_timetotalLabel2 setText:@"120"];
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
        [_laberecordstatus.layer addAnimation:animation forKey:nil];
        _laberecordstatus.hidden = NO;
        //[self.recordButton setImage:[UIImage imageNamed:@"recordpause.png"] forState:UIControlStateNormal];
        [self.recordButton setTitle:@"STOP" forState:UIControlStateNormal];
        [self.playButton.titleLabel setAlpha:0.5];
        
        [recorder prepareToRecord];
        [recorder record];
    } else {
        self.isRecording = NO;
        _laberecordstatus.hidden = YES;
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
    _progressBar.value = currentTime;
    [_timeleftLabel2 setText:[NSString stringWithFormat:@"%.0f",currentTime]];
    if(currentTime > 120) {
        _progressBar.value = 120.0f;
        self.isRecording = NO;
        [self.recordButton setTitle:@"REC" forState:UIControlStateNormal];
        [self.playButton setEnabled:YES];
        [self.saveButton setEnabled:YES];
        [self.playButton.titleLabel setAlpha:1];
        [recorder stop];
        [self.recordButton setImage:[UIImage imageNamed:@"microphone.png"] forState:UIControlStateNormal];
        _laberecordstatus.hidden = YES;
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
    _progressBar.value = currentTime;
    [_timeleftLabel2 setText:[NSString stringWithFormat:@"%.0f",currentTime]];
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
    _progressBar.minimumValue = 0.0f;
    _progressBar.value = 0.0f;
    [_timeleftLabel2 setText:[NSString stringWithFormat:@"0.0"]];
}
- (IBAction)Savecomments:(id)sender
{
    
    [MyallaudioView AddBlackOverlay:self.view xcord:0 ycord:0 width:self.view.frame.size.width height:self.view.frame.size.height backgroundColor:[UIColor blackColor] OpacitY:0.9f Text:@"Please wait" TextColor:[UIColor whiteColor] FontName:globalTEXTFIELDPLACEHOLDERFONT FontSize:18 IsTextEnabled:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        NSData *myData = [NSData dataWithContentsOfURL:recorder.url];
        NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
        
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
        [tempDict setObject:userid forKey:@"user_id"];
        
        NSString *urlString = [MyallaudioView CallURLForServerReturn:tempDict URL:AUDIOUPLOADPAGE];
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
            
//            UIAlertView *alertss = [[UIAlertView alloc]initWithTitle:@"DONE" message:@"Audio Uploded Successfully !!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
                [MyallaudioView SetLoader:self.view xcord:0 ycord:self.view.frame.size.height-10 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
                
                MyallaudioViewController *MyallAudio = [[MyallaudioViewController alloc] init];
                AppDelegate *maindelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                [maindelegate SetUpTabbarControllerwithcenterView:MyallAudio];
                
            }];
            [alertss addToDisplayQueue];
//            [alertss show];
        });
    });
}





@end
