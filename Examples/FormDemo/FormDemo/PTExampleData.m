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

#import "PTExampleData.h"

#import "PTFormViewCell.h"

@implementation PTExampleData

+ (NSArray *)items
{
    static NSArray *items;
    if (items == nil) {
        /*
         * First section
         */
        NSMutableArray *firstSectionItems = [NSMutableArray array];

        [firstSectionItems addObject:@{
          kPTExampleDataCellStyleKey : [NSNumber numberWithInt:PTFormViewCellStyleTextReadonly],
         kPTExampleDataCellLabelKey : @"Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec ullamcorper nulla non metus auctor fringilla. Etiam porta sem malesuada magna mollis euismod. Donec ullamcorper nulla non metus auctor fringilla. Maecenas sed diam eget risus varius blandit sit amet non magna. Vestibulum id ligula porta felis euismod semper. Donec sed odio dui."
         }];
        
        [firstSectionItems addObject:@{
          kPTExampleDataCellStyleKey : [NSNumber numberWithInt:PTFormViewCellStyleGroup],
         kPTExampleDataCellLabelKey : @"Parturient"
         }];
        
        [firstSectionItems addObject:@{
          kPTExampleDataCellStyleKey : [NSNumber numberWithInt:PTFormViewCellStyleTextReadonly],
         kPTExampleDataCellLabelKey : @"Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Cras mattis consectetur purus sit amet fermentum."
         }];
        
        [firstSectionItems addObject:@{
          kPTExampleDataCellStyleKey : [NSNumber numberWithInt:PTFormViewCellStyleTextReadonly],
         kPTExampleDataCellLabelKey : @"Cras justo odio, dapibus ac facilisis in, egestas eget quam. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Cras justo odio, dapibus ac facilisis in, egestas eget quam.\n\n\
Maecenas faucibus mollis interdum. Etiam porta sem malesuada magna mollis euismod. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Curabitur blandit tempus porttitor. Aenean lacinia bibendum nulla sed consectetur. Donec ullamcorper nulla non metus auctor fringilla."
         }];
        
        [firstSectionItems addObject:@{
          kPTExampleDataCellStyleKey : [NSNumber numberWithInt:PTFormViewCellStyleTextReadonly],
         kPTExampleDataCellLabelKey : @"Nulla vitae elit libero, a pharetra augue. Curabitur blandit tempus porttitor. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor."
         }];
        
        /*
         * Second section
         */
        NSMutableArray *secondSectionItems = [NSMutableArray array];

        [secondSectionItems addObject:@{
           kPTExampleDataCellStyleKey : [NSNumber numberWithInt:PTFormViewCellStyleGroup],
          kPTExampleDataCellLabelKey : @"Sed posuere consectetur est at lobortis."
         }];

        [secondSectionItems addObject:@{
           kPTExampleDataCellStyleKey : [NSNumber numberWithInt:PTFormViewCellStyleGroup],
          kPTExampleDataCellLabelKey : @"Vehicula Ligula"
         }];

        /*
         * Final data
         */
        items = @[
        @{
        kPTExampleDataSectionTitleKey : @"Nullam quis risus eget urna mollis ornare vel eu leo.",
        kPTExampleDataSectionItemsKey : [firstSectionItems copy]
        },
        @{
        kPTExampleDataSectionTitleKey : @"Cras justo odio, dapibus ac facilisis in, egestas eget quam. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit.",
        kPTExampleDataSectionItemsKey : [secondSectionItems copy]
        }];
    }
    return items;
}

@end
