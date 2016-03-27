//
//  SongListCell.h
//  WMidiPlayer
//
//  Created by Denis Andreev on 27.03.16.
//  Copyright © 2016 Denis Andreev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongListCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *songName;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *playActivView;

@end
