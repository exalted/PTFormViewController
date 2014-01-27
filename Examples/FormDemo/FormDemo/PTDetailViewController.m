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

#import "PTDetailViewController.h"

#import "PTExampleData.h"

@interface PTDetailViewController ()

@end

@implementation PTDetailViewController

- (id)initWithStyle:(PTFormViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
        self.formView.separatorColor = [UIColor blueColor];
    }
    return self;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Form view data source

- (NSInteger)numberOfSectionsInFormView:(PTFormView *)formView
{
    return [[PTExampleData sections] count];
}

- (NSInteger)formView:(PTFormView *)formView numberOfRowsInSection:(NSInteger)section
{
    return [[[[PTExampleData sections] objectAtIndex:section]
             objectForKey:kPTExampleDataSectionItemsKey] count];
}

- (NSString *)formView:(PTFormView *)formView titleForHeaderInSection:(NSInteger)section
{
    return [[[PTExampleData sections] objectAtIndex:section]
            objectForKey:kPTExampleDataSectionHeaderTitleKey];
}

- (NSString *)formView:(PTFormView *)formView titleForFooterInSection:(NSInteger)section
{
    return [[[PTExampleData sections] objectAtIndex:section]
            objectForKey:kPTExampleDataSectionFooterTitleKey];
}

- (PTFormViewCell *)formView:(PTFormView *)formView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = [[[[PTExampleData sections] objectAtIndex:indexPath.section]
                           objectForKey:kPTExampleDataSectionItemsKey]
                          objectAtIndex:indexPath.row];

    PTFormViewCellStyle style = [[item objectForKey:kPTExampleDataItemStyleKey] intValue];

    PTFormViewCell *cell = [formView dequeueReusableCellWithStyle:style];
    if (cell == nil) {
        cell = [[PTFormViewCell alloc] initWithStyle:style];
        cell.options = PTFormViewCellInline;
    }

    cell.textLabel.text = [item objectForKey:kPTExampleDataItemLabelTextKey];

    return cell;
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
