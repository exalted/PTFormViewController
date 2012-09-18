#import <UIKit/UIKit.h>

/*
 * Credits: Nick Farina
 * (Ref.: http://nfarina.com/post/29883229869/callout-view)
 */
@interface UIView (PTFormViewFrameAdditions)

@property (nonatomic) CGPoint   $origin;
@property (nonatomic) CGSize    $size;
@property (nonatomic) CGFloat   $x, $y, $width, $height;        // normal rect properties
@property (nonatomic) CGFloat   $left, $top, $right, $bottom;   // these will stretch/shrink the rect

@end
