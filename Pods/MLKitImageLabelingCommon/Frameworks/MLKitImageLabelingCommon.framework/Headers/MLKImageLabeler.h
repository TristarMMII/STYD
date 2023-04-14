#import <Foundation/Foundation.h>

@class MLKCommonImageLabelerOptions;
@class MLKImageLabel;

@protocol MLKCompatibleImage;

NS_ASSUME_NONNULL_BEGIN

/**
 * A block containing an array of label results or `nil` if there's an error.
 *
 * @param labels Array of label results in the image or `nil` if there was an error.
 * @param error The error or `nil`.
 */
typedef void (^MLKImageLabelingCallback)(NSArray<MLKImageLabel *> *_Nullable labels,
                                         NSError *_Nullable error)
    NS_SWIFT_NAME(ImageLabelingCallback);

/** An image labeler that processes and labels images. */
NS_SWIFT_NAME(ImageLabeler)
@interface MLKImageLabeler : NSObject

/**
 * Returns an image labeler with the given options.
 *
 * @param options Options for configuring the image labeler.
 * @return An image labeler configured with the given options.
 */
+ (instancetype)imageLabelerWithOptions:(MLKCommonImageLabelerOptions *)options
    NS_SWIFT_NAME(imageLabeler(options:));

/** Unavailable. Use the class methods. */
- (instancetype)init NS_UNAVAILABLE;

/**
 * Processes the given image for labeling.
 *
 * @param image The image to process.
 * @param completion Handler to call back on the main queue with labels or error.
 */

- (void)processImage:(id<MLKCompatibleImage>)image
          completion:(MLKImageLabelingCallback)completion NS_SWIFT_NAME(process(_:completion:));

/**
 * Returns label results in the given image or `nil` if there was an error. The image labeling is
 * performed synchronously on the calling thread.
 *
 * @discussion It is advised to call this method off the main thread to avoid blocking the UI. As a
 *     result, an `NSException` is raised if this method is called on the main thread.
 * @param image The image to get results in.
 * @param error An optional error parameter populated when there is an error getting results.
 * @return Array of label results in the given image or `nil` if there was an error.
 */

- (nullable NSArray<MLKImageLabel *> *)resultsInImage:(id<MLKCompatibleImage>)image
                                                error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
