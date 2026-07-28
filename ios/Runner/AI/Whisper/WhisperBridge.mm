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

- (void)setProgressHandler:(void (^)(int))progressHandler {

    engine.progressHandler = progressHandler;
}

- (void (^)(int))progressHandler {

    return engine.progressHandler;
}

- (void)setSegmentHandler:(void (^)(NSString *))segmentHandler {

    engine.segmentHandler = segmentHandler;
}


- (void (^)(NSString *))segmentHandler {

    return engine.segmentHandler;
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

- (void)cancel {

    [engine cancel];

}

- (nullable NSString *)transcribe:(NSString *)audioPath
                            error:(NSError **)error {
    return [engine transcribe:audioPath
                        error:error];
}


@end
