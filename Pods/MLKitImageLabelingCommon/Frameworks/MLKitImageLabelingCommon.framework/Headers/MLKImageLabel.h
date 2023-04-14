#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** Represents a label for an image. */
NS_SWIFT_NAME(ImageLabel)
@interface MLKImageLabel : NSObject

/** The text of the label returned by the classifier model. */
@property(nonatomic, copy, readonly) NSString *text;

/** The index of the label. */
@property(nonatomic, readonly) NSInteger index;

/**
 * The confidence of the label. Its range depends on the classifier model used, but by convention
 * it should be [0, 1]. For an `ImageLabeler` created with `ImageLabelerOptions`, the range is [0,
 * 1].
 */
@property(nonatomic, readonly) float confidence;

/** Unavailable. */
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
