//
//  RecordAudioViewController.h
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 14/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>


@interface RecordAudioViewController : UIViewController <AVAudioRecorderDelegate,AVAudioPlayerDelegate>
{
    NSURL *recordedFile;
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;
    BOOL isRecording;
    NSTimer *currentTimeUpdateTimer;
    NSArray *arr;
    NSOperationQueue *que;
    NSString *audioid;
}

@property (retain,nonatomic) NSTimer *TimeINterval;
@property (nonatomic,retain) NSOperationQueue *ThreadQue;
@property (retain, nonatomic) IBOutlet UIButton *playButton;
@property (retain, nonatomic) IBOutlet UIButton *recordButton;
@property (retain, nonatomic) IBOutlet UISlider *progressBar;
@property (nonatomic, strong) IBOutlet UILabel * timeleftLabel;
@property (nonatomic, strong) IBOutlet UILabel * timetotalLabel;
@property (nonatomic,retain) IBOutlet UILabel *laberecordstatus;
@property (retain, nonatomic) IBOutlet UIButton *saveButton;
@property (nonatomic) BOOL isRecording;
- (IBAction)Savecomments:(id)sender;
- (IBAction)playPause:(id)sender;
- (IBAction)startStopRecording:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *popupsendbut;
@property (strong, nonatomic) IBOutlet UISwitch *blurSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *tapOutsideSwitch;
@property (strong, nonatomic) IBOutlet UITextView *textcontent;



@end
