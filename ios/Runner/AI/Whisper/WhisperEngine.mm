#import "WhisperEngine.h"
#import "AudioReader.h"
#import "AudioData.h"
#import <whisper/whisper.h>
#import <AVFoundation/AVFoundation.h>

@implementation WhisperEngine {

    struct whisper_context *_context;

    AudioReader *_audioReader;

}

- (instancetype)init {

    self = [super init];

    if (self) {

        _audioReader = [[AudioReader alloc] init];

    }

    return self;
}

- (void)dealloc {

    if (_context != nullptr) {

        whisper_free(_context);
        _context = nullptr;

    }

}

- (BOOL)loadModel:(NSString *)modelPath {

    if (_context != nullptr) {

        whisper_free(_context);
        _context = nullptr;

    }

    NSLog(@"Loading model...");

    struct whisper_context_params params =
        whisper_context_default_params();

    const char *path = [modelPath UTF8String];

    _context =
        whisper_init_from_file_with_params(path, params);

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

- (NSString *)transcribe:(NSString *)audioPath
                   error:(NSError **)error {

    if (_context == nullptr) {

    if (error) {

        *error = [NSError errorWithDomain:@"WhisperEngine"
                                     code:1001
                                 userInfo:@{
            NSLocalizedDescriptionKey : @"Model not loaded"
        }];

    }

    return nil;
}

    NSLog(@"Audio Path: %@", audioPath);

NSError *readError = nil;

AudioData *audio =
    [_audioReader readAudio:audioPath
                      error:&readError];

if (error && *error != nil) {

    return nil;

}
    
    struct whisper_full_params params =
    whisper_full_default_params(WHISPER_SAMPLING_GREEDY);

    params.print_progress = false;
params.print_realtime = false;
params.print_timestamps = false;

///TODO
params.translate = false;
params.language = "en";
params.n_threads = 4;

int result = whisper_full(
    _context,
    params,
    audio.samples,
    audio.sampleCount
);

if (result != 0) {

    if (error) {

        *error =
        [NSError errorWithDomain:@"WhisperEngine"
                            code:1002
                        userInfo:@{
            NSLocalizedDescriptionKey :
            @"Whisper transcription failed"
        }];

    }

    return nil;
}

int segmentCount = whisper_full_n_segments(_context);

NSLog(@"Segments: %d", segmentCount);

    NSLog(@"First Sample: %f", audio.samples[0]);

    NSMutableString *transcript = [NSMutableString string];

for (int i = 0; i < segmentCount; i++) {

    const char *text = whisper_full_get_segment_text(
        _context,
        i
    );

    NSLog(@"Segment %d: %s", i, text);

    [transcript appendString:
        [NSString stringWithUTF8String:text]];
}

    return transcript;
}

@end