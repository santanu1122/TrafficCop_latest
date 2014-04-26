//
//  AvaudioPlayer.m
//  Brettmcfallvip
//
//  Created by Esolz Technologies on 25/03/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import "AvaudioPlayer.h"
#import "DetailsaudioViewController.h"
@interface AvaudioPlayer ()

@property (nonatomic, strong) AVQueuePlayer * queuePlayer;
@property (nonatomic, strong) NSArray * tracks;
@property (nonatomic, strong) NSMutableArray * items;
@property (nonatomic, strong) id timeObserver;

@end

@implementation AvaudioPlayer
@synthesize urltrack;
static NSString * PlayerStatusContext = @"PlayerStatus";
static NSString * PlayerRateContext = @"PlayerRate";
static NSString * CurrentItemContext = @"CurrentItem";
static NSString * PlaybackLikelyToKeepUp = @"PlaybackLikelyToKeepUp";
static NSString * ItemStatusContext = @"ItemStatus";

- (id) init {
    self = [super init];
    if(self) {
        [self loadTracks];
        [self registerObservers];
    }
    return self;
}


- (void)loadTracks {
    
    self.tracks = @[
    @"http://esolzdemos.com/lab1/santanu/slidermaster/testaudio.mp3"];
    
    self.items = [@[] mutableCopy];
    
    [self.tracks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        AVURLAsset * asset = [AVURLAsset assetWithURL:[NSURL URLWithString:obj]];
        AVPlayerItem * item = [[AVPlayerItem alloc] initWithAsset:asset];
        [self.items addObject:item];
    }];
    
    //    self.queuePlayer = [[AVQueuePlayer alloc] initWithItems:items];
    self.queuePlayer = [[AVQueuePlayer alloc] initWithItems:@[self.items[0]]];
}

- (void)rebuildPlayer {
    if(self.queuePlayer) {
        [self unregisterObservers];
        if(self.queuePlayer.currentItem) {
            [self unregisterObserversForItem:self.queuePlayer.currentItem];
        }
    }
    [self loadTracks];
    
    [self registerObservers];
    
    [self play];
}

- (void)timer:(id)sender {
   // NSLog(@"(Timer) Player Status : %d", self.queuePlayer.status);
  //  NSLog(@"(Timer) Current Item Status : %d", self.queuePlayer.currentItem.status);
  //  NSLog(@"(Timer) Playback Rate : %f", self.queuePlayer.rate);
}

- (void)registerObservers {
    [self.queuePlayer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:&PlayerStatusContext];
    [self.queuePlayer addObserver:self forKeyPath:@"currentItem" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:&CurrentItemContext];
    [self.queuePlayer addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:&PlayerRateContext];
    
    __strong AvaudioPlayer * weakSelf = self;
    self.timeObserver =
    [self.queuePlayer addPeriodicTimeObserverForInterval:CMTimeMake(1.0f, 1.0f)
                                                   queue:dispatch_get_main_queue()
                                              usingBlock:^(CMTime time) {
                                                  
                                                  [weakSelf updateProgress:nil];
                                                //  NSLog(@"Player Status : %d", weakSelf.queuePlayer.status);
                                               //   NSLog(@"Current Item Status : %d", weakSelf.queuePlayer.currentItem.status);
                                                //  NSLog(@"Playback Rate : %f", weakSelf.queuePlayer.rate);
                                              }];
}

- (void)unregisterObservers {
    [self.queuePlayer removeObserver:self forKeyPath:@"status"];
    [self.queuePlayer removeObserver:self forKeyPath:@"currentItem"];
    [self.queuePlayer removeObserver:self forKeyPath:@"rate"];
    [self.queuePlayer removeTimeObserver:self.timeObserver];
}

- (void)registerObserversForItem : (AVPlayerItem *)item {
    [item addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:&PlaybackLikelyToKeepUp];
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:&ItemStatusContext];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onTrackFinishedNotification:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:item];
}

- (void)unregisterObserversForItem : (AVPlayerItem *)item {
    [item removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    [item removeObserver:self forKeyPath:@"status"];
}

- (CMTime) currentTime {
    return self.queuePlayer.currentItem.currentTime;
}

- (CMTime) duration {
    return self.queuePlayer.currentItem.duration;
}

- (CGFloat) currentProgress {
    NSTimeInterval currentTime = self.currentTime.value / self.currentTime.timescale;
    NSTimeInterval duration = self.duration.value / self.duration.timescale;
    return (currentTime / duration);
}

- (void) play {
    [self.queuePlayer play];
    [[NSNotificationCenter defaultCenter] postNotificationName:kPlayerStartedEvent object:nil];
}

- (void) pause {
    [self.queuePlayer pause];
    [[NSNotificationCenter defaultCenter] postNotificationName:kPlayerPausedEvent object:nil];
}
- (void) stop
{
    CMTime currentTime = self.currentTime;
    currentTime.value = 0.f;
    [self currentProgress];
}
- (void) seekToTime:(CMTime)currentTime completionHandler:(void (^)(BOOL finished))completionHandler {
    [self.queuePlayer pause];
    
    [self.queuePlayer seekToTime:currentTime completionHandler:^(BOOL finished) {
        
        [self.queuePlayer play];
        
        completionHandler(finished);
    }];
}

- (void)updateProgress:(id)sender {
   // [SilentPlayer sharedInstance]->timeoutBase = time(NULL);
    
    CMTime currentTime = self.currentTime;
    CMTime duration = self.duration;
    
    NSTimeInterval currentTime_ = currentTime.value * 1.0f / currentTime.timescale;
    NSTimeInterval duration_ = duration.value * 1.0f / duration.timescale;
    
    if(duration_ == 0.f) {
        NSLog(@"Illegal status for player item : %@", self.queuePlayer.currentItem);
        NSLog(@"Player status : %d, rate : %f", self.queuePlayer.status, self.queuePlayer.rate);
        NSLog(@"Player item status : %d", self.queuePlayer.currentItem.status);
        currentTime_ = 0.f;
        duration_ = 1.f;
    }
    
    NSDictionary * progress = @{@"currentTime" : [NSNumber numberWithDouble:currentTime_],
    @"duration" : [NSNumber numberWithDouble:duration_] };
    
   // NSLog(@"Progress : %f", currentTime_ * 1.0f/ duration_);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kPlayerProgressUpdatedEvent object:progress];
}
#pragma mark - key value observation
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    
    if (context == &PlayerStatusContext) {
        AVPlayer *thePlayer = (AVPlayer *)object;
        if ([thePlayer status] == AVPlayerStatusFailed) {
            NSError *error = [thePlayer error];
            NSLog(@"Some error occured while preparing player : %@", [error localizedDescription]);
            
            int64_t delayInSeconds = 5.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self rebuildPlayer];
            });
            
            return;
        } else {
            [self registerObserversForItem:self.queuePlayer.currentItem];
            
            // Issue player ready event
            [[NSNotificationCenter defaultCenter] postNotificationName:kPlayerReadyEvent object:nil];
            
            // Issue item changed event
            AVURLAsset * asset = (AVURLAsset *)self.queuePlayer.currentItem.asset;
            [[NSNotificationCenter defaultCenter] postNotificationName:kPlayerItemChangedEvent object:asset];
        }
    } else if(context == &CurrentItemContext) {
        NSLog(@"Current item changed to %@", self.queuePlayer.currentItem);
        AVPlayerItem * oldPlayerItem = change[NSKeyValueChangeOldKey];
        if(oldPlayerItem) {
            [self unregisterObserversForItem:oldPlayerItem];
        }
        [self registerObserversForItem:self.queuePlayer.currentItem];
        
        // Issue item changed event
        AVURLAsset * asset = (AVURLAsset *)self.queuePlayer.currentItem.asset;
        [[NSNotificationCenter defaultCenter] postNotificationName:kPlayerItemChangedEvent object:asset];
        
    } else if(context == &PlayerRateContext) {
        
        float oldRate = [change[NSKeyValueChangeOldKey] floatValue];
        float newRate = [change[NSKeyValueChangeNewKey] floatValue];
        NSLog(@"Player rate changed from %f to %f", oldRate, newRate);
        
    } else if(context == &PlaybackLikelyToKeepUp) {
        AVPlayerItem * item = (AVPlayerItem *)object;
        if(item.playbackLikelyToKeepUp) {
            [self play];
            NSLog(@"Play item due to likelyToKeepUp");
        } else {
            [self pause];
            NSLog(@"Pause item due to likelyToKeepUp");
        }
    } else if(context == &ItemStatusContext) {
        AVPlayerItem * item = (AVPlayerItem *)object;
        if(item.status == AVPlayerItemStatusReadyToPlay) {
            [self play];
            NSLog(@"Play item due to status");
        } else if(item.status == AVPlayerItemStatusFailed) {
            //            NSLog(@"Item status failed !!!!!!!!!!!!!!!!!!");
        } else {
            [self pause];
            NSLog(@"Pausing since item status has changed to unknown");
            // Unknown
        }
    } else {
        return [super observeValueForKeyPath:keyPath ofObject:object
                                      change:change context:context];
    }
    return;
}

-(int)itemstaus:(int)stringval
{
    return stringval;
}

- (void)onTrackFinishedNotification:(NSNotification *)notification {
   [self rebuildPlayer];
  /*  [self.queuePlayer advanceToNextItem];
    
    AVPlayerItem * item = (AVPlayerItem *)notification.object;
    int index = [self.items indexOfObject:item];
    int nextIndex = index + 1;
    int onDeckIndex = index + 2;
    
    AVPlayerItem * nextItem = self.items[nextIndex];
    AVPlayerItem * onDeckItem = self.items[onDeckIndex];
    [self.queuePlayer insertItem:onDeckItem afterItem:nextItem];
    */
}

@end