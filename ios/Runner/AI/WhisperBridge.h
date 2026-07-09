//
//  WhisperBridge.h
//  Runner
//
//  Created by el RED on 09/07/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WhisperBridge : NSObject

- (BOOL)loadModel:(NSString *)modelPath
            error:(NSError **)error;

- (BOOL)isLoaded;

- (void)releaseModel;

@end

NS_ASSUME_NONNULL_END
