//
//  MidiPlayerVC.h
//  WMidiPlayer
//
//  Created by Denis Andreev on 26.03.16.
//  Copyright © 2016 Denis Andreev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MidiPlayerVC : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UIButton *playButton;
@property (nonatomic, strong) IBOutlet UIButton *nextButton;
@property (nonatomic, strong) IBOutlet UIButton *backButton;
@property (nonatomic, strong) IBOutlet UISlider *playerSlider;

@property (nonatomic, strong) IBOutlet UILabel *fullTimeLabel;
@property (nonatomic, strong) IBOutlet UILabel *playTimeLabel;
@property (nonatomic, strong) IBOutlet UILabel *songNameLabel;

@property (nonatomic, strong) IBOutlet UITableView *tableView;


- (IBAction)playAction:(id)sender;
- (IBAction)nextAction:(id)sender;
- (IBAction)backAction:(id)sender;

-(IBAction)movePlayerSlider:(id)sender;

@end
