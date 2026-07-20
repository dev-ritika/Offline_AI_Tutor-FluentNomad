#import "AudioReader.h"
#import <AVFoundation/AVFoundation.h>

@implementation AudioReader

- (NSArray<NSNumber *> *)readSamples:(NSString *)audioPath {
NSURL *url = [NSURL fileURLWithPath:audioPath];

    NSError *error = nil;

    AVAudioFile *audioFile =
    [[AVAudioFile alloc] initForReading:url error:&error];

    if (error) {
        NSLog(@"Error opening wav: %@", error);
        return @"Unable to open WAV";
    }

    AVAudioFormat *format = audioFile.processingFormat;

    NSLog(@"=======================");
    NSLog(@"Sample Rate: %f", format.sampleRate);
    NSLog(@"Channels: %u", format.channelCount);
    NSLog(@"Frame Length: %lld", audioFile.length);
    NSLog(@"=======================");

    // -----------------------------
    // STEP 2 : Read the WAV into memory
    // -----------------------------

    AVAudioPCMBuffer *buffer =
    [[AVAudioPCMBuffer alloc]
        initWithPCMFormat:format
        frameCapacity:(AVAudioFrameCount)audioFile.length];

    [audioFile readIntoBuffer:buffer error:&error];

    if (error) {
        NSLog(@"Error reading buffer: %@", error);
        return @"Unable to read audio buffer";
    }

    // -----------------------------
    // STEP 3 : Verify the samples
    // -----------------------------

    NSLog(@"Buffer Frame Length: %u", buffer.frameLength);

    float *samples = buffer.floatChannelData[0];
}

@end