#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

@class MLKObjectLabel;

NS_ASSUME_NONNULL_BEGIN

/** An object detected in an image. */
NS_SWIFT_NAME(Object)
@interface MLKObject : NSObject

/**
 * The rectangle that holds the detected object relative to the image in the view's coordinate
 * system.
 */
@property(nonatomic, readonly) CGRect frame;

/**
 * An array of labels describing the object returned by the detector. The property is empty if the
 * detector option `shouldEnableClassification` is set to `NO`, or no labels with sufficiently high
 * classification confidence scores can be found.
 */
@property(nonatomic, readonly) NSArray<MLKObjectLabel *> *labels;

/**
 * The tracking identifier of the detected object. The value is a non-negative `integerValue`. The
 * value is `nil` if no tracking ID was provided.
 */
@property(nonatomic, readonly, nullable) NSNumber *trackingID;

/** Unavailable. */
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
