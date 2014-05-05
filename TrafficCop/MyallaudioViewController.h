//
//  MyallaudioViewController.h
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 15/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AudioStreamer;
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>



@interface MyallaudioViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,AVAudioPlayerDelegate,AVAudioRecorderDelegate> {
    IBOutlet UITextField *downloadSourceField;
	IBOutlet UIButton *button;
	IBOutlet UIView *volumeSlider;
	IBOutlet UILabel *positionLabel;
	IBOutlet UISlider *progressSlider;
	AudioStreamer *streamer;
	NSTimer *progressUpdateTimer;
	NSString *currentImageName;
    BOOL _IsAudioPlayPopupOpen;
    
    NSString *editedstatus;
    UIButton *buttonusertrouble3;
    
    
    NSURL *recordedFile;
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;
    BOOL isRecording;
    NSTimer *currentTimeUpdateTimer;
    NSArray *arr;
    NSOperationQueue *que;
    NSString *audioid;
    
    
}
@property (nonatomic) BOOL PlayStatus;
@property (nonatomic,retain) NSMutableString *URLNAME;
- (IBAction)buttonPressed:(id)sender;
- (void)spinButton;
- (void)updateProgress:(NSTimer *)aNotification;
- (IBAction)sliderMoved:(UISlider *)aSlider;
@property (nonatomic,retain) IBOutlet UIView *Mainview;
-(IBAction)ColseAudioPopup :(id)sender;

//working Start on record audio page
@property (retain,nonatomic) NSTimer *TimeINterval;
@property (nonatomic,retain) NSOperationQueue *ThreadQue;
@property (retain, nonatomic) IBOutlet UIButton *playButton;
@property (retain, nonatomic) IBOutlet UIButton *recordButton;
@property (retain, nonatomic) IBOutlet UISlider *progressBar;
@property (nonatomic, strong) IBOutlet UILabel * timeleftLabel2;
@property (nonatomic, strong) IBOutlet UILabel * timetotalLabel2;
@property (nonatomic,retain) IBOutlet UILabel *laberecordstatus;
@property (retain, nonatomic) IBOutlet UIButton *saveButton;
@property (nonatomic) BOOL isRecording;
- (IBAction)Savecomments:(id)sender;
- (IBAction)playPause2:(id)sender;
- (IBAction)startStopRecording2:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *myAudioLbl;
@end
