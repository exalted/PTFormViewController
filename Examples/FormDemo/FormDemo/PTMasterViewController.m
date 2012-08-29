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

#import "PTMasterViewController.h"

#import "PTDetailViewController.h"

#import "PTAppDelegate.h"

@interface PTMasterViewController ()

@end

@implementation PTMasterViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.clearsSelectionOnViewWillAppear = NO;
            self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
        }
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }

    if (indexPath.row == 0) {
        cell.textLabel.text = @"Grouped Style";
    }
    else {
        cell.textLabel.text = @"Plain Style";
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTDetailViewController *detailViewController;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if (indexPath.row == 0) {
            detailViewController = [[PTDetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
        }
        else {
            detailViewController = [[PTDetailViewController alloc] initWithStyle:UITableViewStylePlain];
        }
        [self.navigationController pushViewController:detailViewController animated:YES];
    } else {
        detailViewController = [self.detailViewControllers objectAtIndex:indexPath.row];

        PTAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

        PTDetailViewController *previousDetailViewController = [[(UINavigationController *)[appDelegate.splitViewController.viewControllers objectAtIndex:1]
                                                                 viewControllers] objectAtIndex:0];
        if (previousDetailViewController.masterPopoverController != nil) {
            [previousDetailViewController.masterPopoverController dismissPopoverAnimated:YES];
        }

        [detailViewController splitViewController:appDelegate.splitViewController
                           willHideViewController:previousDetailViewController
                                withBarButtonItem:previousDetailViewController.navigationItem.leftBarButtonItem
                             forPopoverController:previousDetailViewController.masterPopoverController];

        appDelegate.splitViewController.delegate = detailViewController;
        appDelegate.splitViewController.viewControllers = @[
            [appDelegate.splitViewController.viewControllers objectAtIndex:0],
            [[UINavigationController alloc] initWithRootViewController:detailViewController]
        ];
    }
}

@end
