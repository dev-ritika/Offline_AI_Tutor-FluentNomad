#import "WhisperBridge.h"
#import <whisper/whisper.h>

@implementation WhisperBridge {
    struct whisper_context *_context;
}

- (BOOL)loadModel:(NSString *)modelPath
            error:(NSError **)error {

    NSLog(@"========== WHISPER TEST ==========");
    NSLog(@"Model path: %@", modelPath);

    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:modelPath];
    NSLog(@"File exists: %@", exists ? @"YES" : @"NO");

    struct whisper_context_params params = whisper_context_default_params();

    const char *path = [modelPath UTF8String];

    NSLog(@"Calling whisper_init...");

    _context = whisper_init_from_file_with_params(path, params);

    NSLog(@"Returned from whisper_init");

    if (_context == nullptr) {
        NSLog(@"Model load FAILED");
        return NO;
    }

    NSLog(@"Model load SUCCESS");

    whisper_free(_context);
    _context = nullptr;

    return YES;
}

- (BOOL)isLoaded {
    return _context != nullptr;
}

- (void)releaseModel {
    if (_context) {
        whisper_free(_context);
        _context = nullptr;
    }
}

@end