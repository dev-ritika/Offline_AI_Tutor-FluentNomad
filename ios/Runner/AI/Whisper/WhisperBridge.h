#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WhisperBridge : NSObject

@property (nonatomic, copy, nullable)
void (^progressHandler)(int progress);

@property (nonatomic, copy, nullable)
void (^segmentHandler)(NSString *text);

- (BOOL)loadModel:(NSString *)modelPath;

- (BOOL)isLoaded;

- (void)releaseModel;

- (void)cancel;

- (nullable NSString *)transcribe:(NSString *)audioPath
                            error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
