#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** Options for an image labeler. */
NS_SWIFT_NAME(CommonImageLabelerOptions)
@interface MLKCommonImageLabelerOptions : NSObject

/**
 * The confidence threshold for labels returned by the image labeler. Labels returned by the
 * image labeler will have a confidence level higher or equal to the given threshold. The value must
 * be a floating-point value in the range [0, 1]. This property does not need to be set. For details
 * on behavior if the `confidenceThreshold` is unset, please refer to documentation in subclass
 * header files. The default value is `nil`.
 */
@property(nonatomic, nullable) NSNumber *confidenceThreshold;

/** Unavailable. Use the class methods in subclasses. */
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
