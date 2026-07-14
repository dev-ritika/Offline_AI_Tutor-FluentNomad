#import "WhisperBridge.h"
#import <whisper/whisper.h>

@implementation WhisperBridge {
    struct whisper_context *_context;
}

- (BOOL)loadModel:(NSString *)modelPath
             {

    NSLog(@"Loading model...");

    struct whisper_context_params params = whisper_context_default_params();

    const char *path = [modelPath UTF8String];

    _context = whisper_init_from_file_with_params(path, params);

    if (_context == nullptr) {
        NSLog(@"Failed to load model");
        return NO;
    }

    NSLog(@"Model loaded successfully");

    return YES;
}

- (BOOL)isLoaded {
    if (_context == nullptr) {
        return NO;
    }

    whisper_is_multilingual(_context);
    return YES;
}

- (void)releaseModel {
    if (_context) {
        whisper_free(_context);
        _context = nullptr;
    }
}

- (NSString *)transcribe:(NSString *)audioPath {

    NSLog(@"Audio Path: %@", audioPath);

    return @"Hello from Whisper";
}

@end
