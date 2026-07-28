#import "WhisperEngine.h"
#import "AudioReader.h"
#import "AudioData.h"
#import <whisper/whisper.h>
#import <AVFoundation/AVFoundation.h>

static void whisperProgressCallback(
    struct whisper_context * ctx,
    struct whisper_state * state,
    int progress,
    void * user_data
) {

    WhisperEngine *engine =
    (__bridge WhisperEngine *)user_data;

    if (engine.progressHandler) {
    engine.progressHandler(progress);
}

}

static bool whisperAbortCallback(
    void * user_data
) {

    WhisperEngine *engine =
    (__bridge WhisperEngine *)user_data;

    return engine->_cancelRequested.load();

}

@implementation WhisperEngine {

    struct whisper_context *_context;

    AudioReader *_audioReader;

    std::atomic<bool> _cancelRequested;

}

- (instancetype)init {

    self = [super init];

    if (self) {

        _audioReader = [[AudioReader alloc] init];

        _cancelRequested = false;

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

- (void)cancel {

    _cancelRequested = true;

}

- (BOOL)isCancellationRequested {

    return _cancelRequested.load();

}

- (NSString *)transcribe:(NSString *)audioPath
                   error:(NSError **)error {

                    _cancelRequested = false;

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
params.progress_callback = whisperProgressCallback;
params.progress_callback_user_data = (__bridge void *)self;

params.abort_callback = whisperAbortCallback;
params.abort_callback_user_data = (__bridge void *)self;


int result = whisper_full(
    _context,
    params,
    audio.samples,
    audio.sampleCount
);

if (result != 0) {

    if ([self isCancellationRequested]) {

        if (error) {

            *error = [NSError errorWithDomain:@"WhisperEngine"
                                         code:1003
                                     userInfo:@{
                NSLocalizedDescriptionKey :
                @"Transcription cancelled"
            }];
        }

        return nil;
    }

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