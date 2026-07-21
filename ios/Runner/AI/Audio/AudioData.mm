#import "AudioData.h"
#import <AVFoundation/AVFoundation.h>

@implementation AudioData

- (instancetype)initWithBuffer:(AVAudioPCMBuffer *)buffer {

    self = [super init];

    if (self) {

        _buffer = buffer;

        _samples = buffer.floatChannelData[0];

        _sampleCount = (int)buffer.frameLength;
    }

    return self;
}

@end