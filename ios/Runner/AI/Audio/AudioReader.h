#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioReader : NSObject

- (NSArray<NSNumber *> *)readSamples:(NSString *)audioPath;

@end

NS_ASSUME_NONNULL_END