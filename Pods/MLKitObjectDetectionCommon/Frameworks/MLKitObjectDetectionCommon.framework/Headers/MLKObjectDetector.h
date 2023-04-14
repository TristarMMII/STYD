#import <Foundation/Foundation.h>

@class MLKCommonObjectDetectorOptions;
@class MLKObject;

@protocol MLKCompatibleImage;

NS_ASSUME_NONNULL_BEGIN

/**
 * A block containing an array of objects detected or `nil` if there was an error.
 *
 * @param objects Array of objects detected in the image or `nil` if there was an error.
 * @param error The error or `nil`.
 */
typedef void (^MLKObjectDetectionCallback)(NSArray<MLKObject *> *_Nullable objects,
                                           NSError *_Nullable error)
    NS_SWIFT_NAME(ObjectDetectionCallback);

/** An object detector and tracker that detects objects in an image and supports tracking them. */
NS_SWIFT_NAME(ObjectDetector)
@interface MLKObjectDetector : NSObject

/**
 * Returns an object detector with the given options.
 *
 * @param options Options for configuring the object detector. It should be an instance of one of
 *     `CommonObjectDetectorOptions`'s subclasses.
 * @return An object detector configured with the given options.
 */
+ (instancetype)objectDetectorWithOptions:(MLKCommonObjectDetectorOptions *)options
    NS_SWIFT_NAME(objectDetector(options:));

/** Unavailable. Use the class methods. */
- (instancetype)init NS_UNAVAILABLE;

/**
 * Processes the given image for object detection and tracking.
 *
 * @param image The image to process.
 * @param completion Handler to call back on the main thread with objects detected or error.
 */

- (void)processImage:(id<MLKCompatibleImage>)image
          completion:(MLKObjectDetectionCallback)completion
    NS_SWIFT_NAME(process(_:completion:));

/**
 * Returns object results in the given image or `nil` if there was an error. The object detection is
 * performed synchronously on the calling thread.
 *
 * @discussion It is advised to call this method off the main thread to avoid blocking the UI. As a
 *     result, an `NSException` is raised if this method is called on the main thread.
 * @param image The image to get results in.
 * @param error An optional error parameter populated when there is an error getting results.
 * @return Array of object results in the given image or `nil` if there was an error.
 */

- (nullable NSArray<MLKObject *> *)resultsInImage:(id<MLKCompatibleImage>)image
                                            error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
