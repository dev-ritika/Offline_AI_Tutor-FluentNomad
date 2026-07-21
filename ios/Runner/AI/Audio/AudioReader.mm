#import "AudioReader.h"
#import "AudioData.h"

#import <AVFoundation/AVFoundation.h>

@implementation AudioReader

- (AudioData *)readAudio:(NSString *)audioPath
                   error:(NSError **)error {

    NSURL *url = [NSURL fileURLWithPath:audioPath];

    AVAudioFile *audioFile =
        [[AVAudioFile alloc] initForReading:url
                                      error:error];

    if (*error) {
        return nil;
    }

    AVAudioFormat *format = audioFile.processingFormat;

    AVAudioPCMBuffer *buffer =
        [[AVAudioPCMBuffer alloc]
            initWithPCMFormat:format
                frameCapacity:(AVAudioFrameCount)audioFile.length];

    [audioFile readIntoBuffer:buffer
                        error:error];

    if (*error) {
        return nil;
    }

    return [[AudioData alloc] initWithBuffer:buffer];
}

@end