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

typedef enum {
    PTFormViewCellGroupReadOnly         = (PTFormViewCellStyleTextReadonly | PTFormViewCellStyleGroup),
    PTFormViewCellGroupInputSingleLine  = (PTFormViewCellStyleTextPlainInput | PTFormViewCellStyleTextSecureInput | PTFormViewCellStyleNumberInput),
    PTFormViewCellGroupInputMultiLine   = (PTFormViewCellStyleTextArea),
    PTFormViewCellGroupBoolean          = (PTFormViewCellStyleBoolean),
    PTFormViewCellGroupDateTime         = (PTFormViewCellStyleDate | PTFormViewCellStyleTime | PTFormViewCellStyleDateTime),
    PTFormViewCellGroupSelect           = (PTFormViewCellStyleSelectSingle | PTFormViewCellStyleSelectMultiple),
} PTFormViewCellGroup;

@interface PTFormViewCell ()

- (id)initReadOnlyWithStyle:(PTFormViewCellStyle)style;
- (id)initInputSingleLineWithStyle:(PTFormViewCellStyle)style;
- (id)initInputMultiLineWithStyle:(PTFormViewCellStyle)style;
- (id)initBooleanWithStyle:(PTFormViewCellStyle)style;
- (id)initDateTimeWithStyle:(PTFormViewCellStyle)style;
- (id)initSelectWithStyle:(PTFormViewCellStyle)style;

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
    return [NSString stringWithFormat:@"%@%d", NSStringFromSelector(_cmd), style];
}

- (id)initReadOnlyWithStyle:(PTFormViewCellStyle)style
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PTFormViewCell reuseIdentifierForStyle:style]];
    if (self) {
        if (style == PTFormViewCellStyleGroup) {
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    return self;
}

- (id)initInputSingleLineWithStyle:(PTFormViewCellStyle)style
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PTFormViewCell reuseIdentifierForStyle:style]];
    if (self) {
        // TODO missing implementation
    }
    return self;
}

- (id)initInputMultiLineWithStyle:(PTFormViewCellStyle)style
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PTFormViewCell reuseIdentifierForStyle:style]];
    if (self) {
        // TODO missing implementation
    }
    return self;
}

- (id)initBooleanWithStyle:(PTFormViewCellStyle)style
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PTFormViewCell reuseIdentifierForStyle:style]];
    if (self) {
        // TODO missing implementation
    }
    return self;
}

- (id)initDateTimeWithStyle:(PTFormViewCellStyle)style
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PTFormViewCell reuseIdentifierForStyle:style]];
    if (self) {
        // TODO missing implementation
    }
    return self;
}

- (id)initSelectWithStyle:(PTFormViewCellStyle)style
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PTFormViewCell reuseIdentifierForStyle:style]];
    if (self) {
        // TODO missing implementation
    }
    return self;
}

- (id)initWithStyle:(PTFormViewCellStyle)style
{
    return ((style & PTFormViewCellGroupReadOnly) ? [self initReadOnlyWithStyle:style] :
            (style & PTFormViewCellGroupInputSingleLine) ? [self initInputSingleLineWithStyle:style] :
            (style & PTFormViewCellGroupInputMultiLine) ? [self initInputMultiLineWithStyle:style] :
            (style & PTFormViewCellGroupBoolean) ? [self initBooleanWithStyle:style] :
            (style & PTFormViewCellGroupDateTime) ? [self initDateTimeWithStyle:style] :
            (style & PTFormViewCellGroupSelect) ? [self initSelectWithStyle:style] :
            nil);
}

/*
- (void)prepareForReuse
{
    [super prepareForReuse];
    // Reset attributes of the cell that are not related to content, for example, alpha, editing, and selection state.
}
*/

@end
