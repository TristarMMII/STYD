#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * @enum ObjectDetectorMode
 * Object detector modes.
 */
typedef NSInteger MLKObjectDetectorMode NS_TYPED_ENUM NS_SWIFT_NAME(ObjectDetectorMode);
/** In single image mode, the results are returned when both tracker and detector are finished. */
static const MLKObjectDetectorMode MLKObjectDetectorModeSingleImage = 0;
/**
 * In stream mode, tracker and detector run in parallel. The results are returned when tracker
 * processing is finished. Detection may still be in progress at that time.
 */
static const MLKObjectDetectorMode MLKObjectDetectorModeStream = 1;

/** Common configurations shared by all types of object detectors. */
NS_SWIFT_NAME(CommonObjectDetectorOptions)
@interface MLKCommonObjectDetectorOptions : NSObject

/** Indicates whether the object classification feature is enabled. The default value is `false`. */
@property(nonatomic) BOOL shouldEnableClassification;

/**
 * Indicates whether all detected objects in the image or frame should be returned by the detector.
 * If set to `false`, the detector returns only the most prominent object detected. The default
 * value is `false`.
 */
@property(nonatomic) BOOL shouldEnableMultipleObjects;

/** The mode for the object detector. The default value is `.stream`. */
@property(nonatomic) MLKObjectDetectorMode detectorMode;

/** Unavailable. Use the class methods in subclasses. */
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
