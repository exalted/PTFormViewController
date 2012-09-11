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

#import <UIKit/UIKit.h>

typedef enum {
    // Read only
    PTFormViewCellStyleTextReadonly     = 1 <<  0,
    PTFormViewCellStyleGroup            = 1 <<  1,

    // Single-line input
    PTFormViewCellStyleTextPlainInput   = 1 <<  2,
    PTFormViewCellStyleTextSecureInput  = 1 <<  3,
    PTFormViewCellStyleNumberInput      = 1 <<  4,

    // Multi-line input
    PTFormViewCellStyleTextArea         = 1 <<  5,

    // Boolean
    PTFormViewCellStyleBoolean          = 1 <<  6,

    // Date and time
    PTFormViewCellStyleDate             = 1 <<  7,
    PTFormViewCellStyleTime             = 1 <<  8,
    PTFormViewCellStyleDateTime         = 1 <<  9,

    // Select
    PTFormViewCellStyleSelectSingle     = 1 << 10,
    PTFormViewCellStyleSelectMultiple   = 1 << 11
} PTFormViewCellStyle;

@interface PTFormViewCell : UITableViewCell

+ (NSString *)reuseIdentifierForStyle:(PTFormViewCellStyle)style;

- (id)initWithStyle:(PTFormViewCellStyle)style;

@end
