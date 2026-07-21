#import <Foundation/Foundation.h>

@class AVAudioPCMBuffer;

NS_ASSUME_NONNULL_BEGIN

@interface AudioData : NSObject

@property(nonatomic, strong, readonly) AVAudioPCMBuffer *buffer;

@property(nonatomic, readonly) float *samples;

@property(nonatomic, readonly) int sampleCount;

- (instancetype)initWithBuffer:(AVAudioPCMBuffer *)buffer;

@end

NS_ASSUME_NONNULL_END