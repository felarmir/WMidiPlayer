//
//  MidiPlayerVC.m
//  WMidiPlayer
//
//  Created by Denis Andreev on 26.03.16.
//  Copyright © 2016 Denis Andreev. All rights reserved.
//

#import "MidiPlayerVC.h"
#import "MidiPlayer.h"
#import "SongListCell.h"

@interface MidiPlayerVC ()

@end

@implementation MidiPlayerVC
{
    BOOL isPlay;
    MidiPlayer *player;
    NSTimer *timer;
    NSArray *songList;
    SongListCell *oldSelectedCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    player = [[MidiPlayer alloc] init];
    isPlay = NO;
    [_playerSlider setValue:0.0];
    _fullTimeLabel.text = @"0.00";

    self.tableView.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    songList = @[@"1.mid",@"2.mid",@"3.mid",@"4.mid",@"5.mid",@"6.mid",@"7.mid",@"8.mid",@"9.mid",@"10.mid",];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void)setTrackName:(NSString*)fileName{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        [player loadMIDI:path programs:@[@0, @2]];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)playAction:(id)sender{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    SongListCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell.playActivView stopAnimating];
    cell.playActivView.hidden = YES;
    
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
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath == nil) {
        indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    } else {
        indexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:0];
    }
    if (indexPath.row == [self.tableView numberOfRowsInSection:0]-1) {
        _nextButton.enabled = NO;
    }
    if (indexPath.row == 0) {
        _backButton.enabled = NO;
    } else {
        _backButton.enabled = YES;
    }
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self playSong:indexPath];
}

-(IBAction)backAction:(id)sender{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath == nil) {
        indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    } else if(indexPath.row >= 1) {
        indexPath = [NSIndexPath indexPathForRow:indexPath.row-1 inSection:0];
    }
    if (indexPath.row == 0) {
        _backButton.enabled = NO;
    }
    if (indexPath.row < [self.tableView numberOfRowsInSection:0]-1) {
        _nextButton.enabled = YES;
    }
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self playSong:indexPath];
}

#pragma mark UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [songList count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *IDENT = @"SONG";
    SongListCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENT];
    if (!cell) {
        cell = [[SongListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDENT];
    }
    cell.songName.text = [songList objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self playSong:indexPath];
}

-(void)playSong:(NSIndexPath*)indexPath
{
    [player stop];
    if (isPlay) {
        [oldSelectedCell.playActivView stopAnimating];
        oldSelectedCell.playActivView.hidden = YES;
        [_playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        isPlay = NO;
    }
    _songNameLabel.text = [songList objectAtIndex:indexPath.row];
    [self setTrackName:[songList objectAtIndex:indexPath.row]];
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(playAction:) userInfo:nil repeats:NO];
    SongListCell *cell = (SongListCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.playActivView.hidden = NO;
    [cell.playActivView startAnimating];
    oldSelectedCell = cell;
}

@end
