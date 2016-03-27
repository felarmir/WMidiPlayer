#import <AudioToolbox/AudioToolbox.h>
@interface MidiPlayer : NSObject {
	MusicPlayer mp;
	MusicSequence ms;
	Float64 longestTrackLength;
	MusicTimeStamp longestTrackBeats;

	BOOL released;
	BOOL stopped;
	BOOL paused;
}

@property (readwrite) AUGraph processingGraph;

@property (nonatomic) Float64 fullTime;

- (void) loadMIDI: (NSString*)path programs: (NSArray*)programs;
- (void) play;
- (void) stop;
- (void) pause;

- (Float64)getTime;
- (void)seekTo:(Float64)time;
- (void)setTime:(Float64)time;
- (void)setTrackSpeed:(Float64)speed;

@end