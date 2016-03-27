//
//  MidiPlayerVC.m
//  WMidiPlayer
//
//  Created by Denis Andreev on 26.03.16.
//  Copyright © 2016 Denis Andreev. All rights reserved.
//

#import "MidiPlayerVC.h"
#import "MidiPlayer.h"

@interface MidiPlayerVC ()

@end

@implementation MidiPlayerVC
{
    BOOL isPlay;
    MidiPlayer *player;
    NSTimer *timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Sonata14.mid" ofType:nil];
    player = [[MidiPlayer alloc] init];
    [player loadMIDI:path programs:@[@0, @2]];
    isPlay = NO;
    [_playerSlider setValue:0.0];
    _fullTimeLabel.text = @"0.00";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)playAction:(id)sender{
    if (!isPlay) {
        [player play];
        [_playButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        isPlay = YES;
        
        _fullTimeLabel.text = [self timeCalculator:[player fullTime]];
        [_playerSlider setMaximumValue:[player fullTime]];
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(timerCheck)
                                               userInfo:nil
                                                repeats:YES];
        
    } else {
        [player pause];
        isPlay = NO;
        [_playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }
}

-(NSString*)timeCalculator:(int32_t)time {
    int sec = time % 60;
    int min = time/60;
    if (sec < 10) {
        return [NSString stringWithFormat:@"%i:0%i", min, sec];
    }
    return [NSString stringWithFormat:@"%i:%i", min, sec];
}

-(void)timerCheck{
    Float64 sec = player.getTime;
    _playerSlider.value = sec;
    _playTimeLabel.text = [self timeCalculator:sec];
}

-(IBAction)movePlayerSlider:(id)sender{
    [player setTime:_playerSlider.value];
}

-(IBAction)nextAction:(id)sender{

}

-(IBAction)backAction:(id)sender{

}

@end
