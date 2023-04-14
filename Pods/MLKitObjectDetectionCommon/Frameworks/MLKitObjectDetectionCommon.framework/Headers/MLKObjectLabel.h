#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** A label that describes an object detected in an image. */
NS_SWIFT_NAME(ObjectLabel)
@interface MLKObjectLabel : NSObject

/** The text returned here depends on the classifier model used. */
@property(nonatomic, copy, readonly) NSString *text;

/** The index of the label. */
@property(nonatomic, readonly) NSInteger index;

/**
 * The confidence that the label applies to the detected object. Its range depends on the
 * classifier model used, but by convention it should be [0, 1]. For an `ObjectDetector` created
 * with `ObjectDetectorOptions`, the range is [0, 1].
 */
@property(nonatomic, readonly) float confidence;

/** Unavailable. */
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
