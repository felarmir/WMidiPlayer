//
//  SongListCell.m
//  WMidiPlayer
//
//  Created by Denis Andreev on 27.03.16.
//  Copyright © 2016 Denis Andreev. All rights reserved.
//

#import "SongListCell.h"

@implementation SongListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_playActivView setHidden:YES];
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
