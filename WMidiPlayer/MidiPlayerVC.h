//
//  MidiPlayerVC.h
//  WMidiPlayer
//
//  Created by Denis Andreev on 26.03.16.
//  Copyright © 2016 Denis Andreev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MidiPlayerVC : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *playButton;
@property (nonatomic, strong) IBOutlet UIButton *nextButton;
@property (nonatomic, strong) IBOutlet UIButton *backButton;
@property (nonatomic, strong) IBOutlet UISlider *playerSlider;

@property (nonatomic, strong) IBOutlet UILabel *fullTimeLabel;
@property (nonatomic, strong) IBOutlet UILabel *playTimeLabel;


- (IBAction)playAction:(id)sender;
- (IBAction)nextAction:(id)sender;
- (IBAction)backAction:(id)sender;

@end
