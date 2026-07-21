#import <Foundation/Foundation.h>

@class AudioData;

NS_ASSUME_NONNULL_BEGIN

@interface AudioReader : NSObject

- (AudioData *)readAudio:(NSString *)audioPath
                   error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END