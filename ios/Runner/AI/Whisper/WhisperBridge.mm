#import "WhisperBridge.h"
#import "WhisperEngine.h"

@implementation WhisperBridge {

    WhisperEngine *engine;

}

- (instancetype)init {

    self = [super init];

    if (self) {
        engine = [[WhisperEngine alloc] init];
    }

    return self;
}

- (BOOL)loadModel:(NSString *)modelPath {

    return [engine loadModel:modelPath];

}

- (BOOL)isLoaded {

    return [engine isLoaded];

}

- (void)releaseModel {

    [engine releaseModel];

}

- (nullable NSString *)transcribe:(NSString *)audioPath
                            error:(NSError **)error {
    return [engine transcribe:audioPath
                        error:error];
}

@end
