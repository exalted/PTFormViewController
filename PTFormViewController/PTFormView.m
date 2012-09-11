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

- (PTFormViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.formDataSource formView:self cellForRowAtIndexPath:indexPath];
}

- (id)dequeueReusableCellWithStyle:(PTFormViewStyle)style
{
    return [self dequeueReusableCellWithIdentifier:[PTFormViewCell reuseIdentifierForStyle:style]];
}

- (void)reloadData
{
    [self.cache removeAllObjects];

    [super reloadData];
}

@end
