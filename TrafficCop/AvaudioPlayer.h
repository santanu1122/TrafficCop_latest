//
//  AvaudioPlayer.h
//  Brettmcfallvip
//
//  Created by Esolz Technologies on 25/03/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


#define kPlayerReadyEvent       @"PlayerReadyEvent"
#define kPlayerItemChangedEvent @"PlayerItemChangedEvent"
#define kPlayerStartedEvent     @"PlayerStartedEvent"
#define kPlayerPausedEvent      @"PlayerPausedEvent"
#define kPlayerProgressUpdatedEvent @"PlayerProgressUpdatedEvent"

@interface AvaudioPlayer : NSObject;

- (void) play;
- (void) pause;
- (void) stop;
- (void)loadTracks;
- (void) seekToTime:(CMTime)currentTime completionHandler:(void (^)(BOOL finished))completionHandler;

@property (nonatomic) CMTime currentTime;
@property (nonatomic) CMTime duration;
@property (nonatomic, strong) NSString * urltrack;

@end