
#import <MLKitImageLabelingCommon/MLKCommonImageLabelerOptions.h>

NS_ASSUME_NONNULL_BEGIN

/** Options for an image labeler. */
NS_SWIFT_NAME(ImageLabelerOptions)
@interface MLKImageLabelerOptions : MLKCommonImageLabelerOptions

/**
 * Initializes an `ImageLabelerOptions` instance with the `confidenceThreshold` property
 * set to `nil`. If it remains unset, a default confidence threshold value of `0.5` will be used.
 */
- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
