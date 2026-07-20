#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WhisperEngine : NSObject

- (BOOL)loadModel:(NSString *)modelPath;

- (BOOL)isLoaded;

- (void)releaseModel;

- (NSString *)transcribe:(NSString *)audioPath;

@end

NS_ASSUME_NONNULL_END