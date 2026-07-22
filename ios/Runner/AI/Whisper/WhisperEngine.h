#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WhisperEngine : NSObject

@property (nonatomic, copy, nullable)
void (^progressHandler)(int progress);

- (BOOL)loadModel:(NSString *)modelPath;

- (BOOL)isLoaded;

- (void)releaseModel;

- (nullable NSString *)transcribe:(NSString *)audioPath
                            error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END