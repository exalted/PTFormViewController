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

#import "PTFormView.h"

#import "UIView+PTFormViewFrameAdditions.h"

////////////////////////////////////////////////////////////////////////////////
// (private)
////////////////////////////////////////////////////////////////////////////////

@interface PTFormViewCell ()

+ (NSString *)reuseIdentifierForStyle:(PTFormViewCellStyle)style;

@end

////////////////////////////////////////////////////////////////////////////////
// Form view additions
////////////////////////////////////////////////////////////////////////////////

@interface PTFormView (PTFormViewAdditions)

@property (nonatomic, readonly) UIEdgeInsets insets;

@end

@implementation PTFormView (PTFormViewAdditions)

// (Ref.: http://stackoverflow.com/a/4872199/11895)
- (UIEdgeInsets)insets
{
    CGFloat value;

    if (self.formStyle == PTFormViewStylePlain) {
        value = 0.0;
    }
    else if (self.$width < 400.0 || [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        value = 10.0;
    }
    else if (self.$width < 20.0) {
        value = self.$width - 10.0;
    }
    else {
        value = MAX(31.0, MIN(45.0, self.$width * 0.06));
    }

    return UIEdgeInsetsMake(value, value, value, value);
}

@end

////////////////////////////////////////////////////////////////////////////////
// Form view
////////////////////////////////////////////////////////////////////////////////

@interface PTFormView ()

@property (nonatomic, readwrite) PTFormViewStyle formStyle;

@property (strong, nonatomic) NSCache *cache;

@end

@implementation PTFormView

- (id)initWithFrame:(CGRect)frame style:(PTFormViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.formStyle = style;

        self.cache = [[NSCache alloc] init];
    }
    return self;
}

- (id)dequeueReusableCellWithStyle:(PTFormViewStyle)style
{
    return [self dequeueReusableCellWithIdentifier:[PTFormViewCell reuseIdentifierForStyle:style]];
}

- (NSInteger)numberOfSections
{
    NSString *key = [NSString stringWithFormat:@"%@", NSStringFromSelector(_cmd)];
    id object = [self.cache objectForKey:key];
    if (object == nil) {
        object = [NSNumber numberWithInteger:[self.formDataSource numberOfSectionsInFormView:self]];
        [self.cache setObject:object forKey:key];
    }
    return [object integerValue];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [NSString stringWithFormat:@"%@%d", NSStringFromSelector(_cmd), section];
    id object = [self.cache objectForKey:key];
    if (object == nil) {
        object = [NSNumber numberWithInteger:[self.formDataSource formView:self numberOfRowsInSection:section]];
        [self.cache setObject:object forKey:key];
    }
    return [object integerValue];
}

- (NSString *)titleForHeaderInSection:(NSInteger)section
{
    NSString *key = [NSString stringWithFormat:@"%@%d", NSStringFromSelector(_cmd), section];
    id object = [self.cache objectForKey:key];
    if (object == nil) {
        object = [self.formDataSource formView:self titleForHeaderInSection:section];
        [self.cache setObject:(object ? object : [NSNull null]) forKey:key];
    }
    return (object == [NSNull null] ? nil : object);
}

- (NSString *)titleForFooterInSection:(NSInteger)section
{
    NSString *key = [NSString stringWithFormat:@"%@%d", NSStringFromSelector(_cmd), section];
    id object = [self.cache objectForKey:key];
    if (object == nil) {
        object = [self.formDataSource formView:self titleForFooterInSection:section];
        if (object == nil) {
            object = [NSNull null];
        }
        [self.cache setObject:(object ? object : [NSNull null]) forKey:key];
    }
    return (object == [NSNull null] ? nil : object);
}

- (PTFormViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTFormViewCell *cell = [self.formDataSource formView:self cellForRowAtIndexPath:indexPath];

    // TODO delete assertion below when implemented detailed cell option (a.k.a. "not inline")
    NSAssert(cell.isInline, @"Warning: "
             "Detailed cell option is not supported yet! "
             "You must set \"inline\" cell option for all cells (e.g. \"cell.options = PTFormViewCellInline\").");

    if (cell.style == PTFormViewCellStyleSelectSingle || cell.style == PTFormViewCellStyleSelectMultiple) {
        NSAssert(!cell.isInline || cell.isCompact || [self numberOfRowsInSection:indexPath.section] == 1, @"Error: "
                 "An \"inline\" and \"non-compact\" cell must be the only cell in its section!");
    }

    return cell;
}

- (void)reloadData
{
    [self.cache removeAllObjects];

    [super reloadData];
}

@end
