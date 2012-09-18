//
// Copyright (C) 2012 Ali Servet Donmez. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "PTFormViewCell.h"

#import "UIView+PTFormViewFrameAdditions.h"

typedef enum {
    PTFormViewCellGroupReadOnly         = (PTFormViewCellStyleTextReadonly | PTFormViewCellStyleGroup),
    PTFormViewCellGroupInputSingleLine  = (PTFormViewCellStyleTextPlainInput | PTFormViewCellStyleTextSecureInput | PTFormViewCellStyleNumberInput),
    PTFormViewCellGroupInputMultiLine   = (PTFormViewCellStyleTextArea),
    PTFormViewCellGroupBoolean          = (PTFormViewCellStyleBoolean),
    PTFormViewCellGroupDateTime         = (PTFormViewCellStyleDate | PTFormViewCellStyleTime | PTFormViewCellStyleDateTime),
    PTFormViewCellGroupSelect           = (PTFormViewCellStyleSelectSingle | PTFormViewCellStyleSelectMultiple),
} PTFormViewCellGroup;

@interface PTFormViewCell (PTFormViewCellAdditions)

@property (nonatomic, readonly) UIEdgeInsets insets;

@end

@implementation PTFormViewCell (PTFormViewCellAdditions)

- (UIEdgeInsets)insets
{
    static NSArray *accessoryTypeWidths;

    CGFloat value;

    if (self.accessoryView) {
        value = self.accessoryView.$width;
    }
    else {
        if (accessoryTypeWidths == nil) {
            accessoryTypeWidths = @[@0.0, @20.0, @33.0, @20.0];
        }
        value = [[accessoryTypeWidths objectAtIndex:self.accessoryType] floatValue];
    }

    return UIEdgeInsetsMake(0.0, 10.0, 0.0, 10.0 + value);
}

@end

@interface PTFormViewCell ()

@property (nonatomic, readwrite) PTFormViewCellStyle style;

- (void)prepareReadOnlyCellWithStyle:(PTFormViewCellStyle)style;
- (void)prepareInputSingleLineCellWithStyle:(PTFormViewCellStyle)style;
- (void)prepareInputMultiLineCellWithStyle:(PTFormViewCellStyle)style;
- (void)prepareBooleanCellWithStyle:(PTFormViewCellStyle)style;
- (void)prepareDateTimeCellWithStyle:(PTFormViewCellStyle)style;
- (void)prepareSelectCellWithStyle:(PTFormViewCellStyle)style;

@end

#warning Mark the cell as needing display when viewable properties change.
/* If you have a custom reusable table cell and it displays a custom property as
 * part of the cell content, you must be sure to send a setNeedsDisplay message
 * to the cell if the value of the property changes. Otherwise UIKit doesn’t
 * know that the cell is “dirty” and therefore won’t invoke the cell’s drawRect:
 * method to have it redraw itself with the new value. A good place to call
 * setNeedsDisplay is in a (non-synthesized) setter method associated with the
 * property.
 */
@implementation PTFormViewCell

+ (NSString *)reuseIdentifierForStyle:(PTFormViewCellStyle)style
{
    return [NSString stringWithFormat:@"%@Style%d", NSStringFromClass(self), style];
}

- (BOOL)isInline
{
    return (self.options & PTFormViewCellInline);
}

- (BOOL)isCompact
{
    return (self.options & PTFormViewCellCompact);
}

- (id)initWithStyle:(PTFormViewCellStyle)style
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PTFormViewCell reuseIdentifierForStyle:style]];
    if (self) {
        self.style = style;
        if ((style & PTFormViewCellGroupReadOnly)) {
            [self prepareReadOnlyCellWithStyle:style];
        }
        else if ((style & PTFormViewCellGroupInputSingleLine)) {
            [self prepareInputSingleLineCellWithStyle:style];
        }
        else if ((style & PTFormViewCellGroupInputMultiLine)) {
            [self prepareInputMultiLineCellWithStyle:style];
        }
        else if ((style & PTFormViewCellGroupBoolean)) {
            [self prepareBooleanCellWithStyle:style];
        }
        else if ((style & PTFormViewCellGroupDateTime)) {
            [self prepareDateTimeCellWithStyle:style];
        }
        else if ((style & PTFormViewCellGroupSelect)) {
            [self prepareSelectCellWithStyle:style];
        }

        self.textLabel.numberOfLines = 0;
        self.textLabel.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
    }
    return self;
}

- (void)prepareReadOnlyCellWithStyle:(PTFormViewCellStyle)style
{
    if (style == PTFormViewCellStyleGroup) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

- (void)prepareInputSingleLineCellWithStyle:(PTFormViewCellStyle)style
{
    // TODO missing implementation

    if (!self.isInline) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

- (void)prepareInputMultiLineCellWithStyle:(PTFormViewCellStyle)style
{
    // TODO missing implementation

    if (!self.isInline) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

- (void)prepareBooleanCellWithStyle:(PTFormViewCellStyle)style
{
    // TODO missing implementation
}

- (void)prepareDateTimeCellWithStyle:(PTFormViewCellStyle)style
{
    // TODO missing implementation

    if (!self.isInline) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

- (void)prepareSelectCellWithStyle:(PTFormViewCellStyle)style
{
    // TODO missing implementation

    if (!self.isInline) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

/*
- (void)prepareForReuse
{
    [super prepareForReuse];
    // Reset attributes of the cell that are not related to content, for example, alpha, editing, and selection state.
}
*/

@end
