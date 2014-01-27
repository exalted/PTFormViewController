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

#import "PTFormViewController.h"

#import "UIView+PTFormViewFrameAdditions.h"

#define PT_REQUIRED { NSAssert(NO, ([NSString stringWithFormat:@"Missing required method implementation '- %@'", NSStringFromSelector(_cmd)])); abort(); }
#define PT_NOOP     { }

////////////////////////////////////////////////////////////////////////////////
// (private)
////////////////////////////////////////////////////////////////////////////////

@interface PTFormView ()

@property (nonatomic, readonly) UIEdgeInsets insets;

@end

@interface PTFormViewCell ()

@property (nonatomic, readonly) UIEdgeInsets insets;

@end

////////////////////////////////////////////////////////////////////////////////
// Form view controller
////////////////////////////////////////////////////////////////////////////////

@interface PTFormViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation PTFormViewController

- (id)init
{
    return [self initWithStyle:PTFormViewStylePlain];
}

- (id)initWithStyle:(PTFormViewStyle)style
{
    self = [super init];
    if (self) {
        self.formView = [[PTFormView alloc] initWithFrame:CGRectZero style:style];
    }
    return self;
}

- (void)loadView
{
    self.view = self.formView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.formView.formDataSource == nil) {
        self.formView.formDataSource = self;
    }

    if (self.formView.formDelegate == nil) {
        self.formView.formDelegate = self;
    }

    // this will trigger reloadData automatically
    self.formView.delegate = self;
    self.formView.dataSource = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self.formView flashScrollIndicators];
}

- (void)viewDidUnload
{
    [self setFormView:nil];

    [super viewDidUnload];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [(PTFormView *)tableView numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(PTFormView *)tableView numberOfRowsInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [(PTFormView *)tableView titleForHeaderInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [(PTFormView *)tableView titleForFooterInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [(PTFormView *)tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTFormView *formView = (PTFormView *)tableView;
    PTFormViewCell *formViewCell = [formView cellForRowAtIndexPath:indexPath];

    static CGFloat DefaultHeight = 44.0;

    if (formViewCell.style == PTFormViewCellStyleTextReadonly) {
        CGFloat constraintWidth = formView.$width - (formView.insets.left + formView.insets.right) - (formViewCell.insets.left + formViewCell.insets.right);

        CGSize size = [formViewCell.textLabel.text sizeWithFont:formViewCell.textLabel.font
                                              constrainedToSize:CGSizeMake(constraintWidth, CGFLOAT_MAX)
                                                  lineBreakMode:formViewCell.textLabel.lineBreakMode];

        return MAX(DefaultHeight, size.height + formViewCell.insets.top + formViewCell.insets.bottom);
    }

    return DefaultHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTFormView *formView = (PTFormView *)tableView;
    PTFormViewCell *formViewCell = (PTFormViewCell *)cell;

    formViewCell.backgroundColor = [UIColor magentaColor];
    formViewCell.contentView.backgroundColor = [UIColor yellowColor];
    formViewCell.textLabel.backgroundColor = [UIColor greenColor];

    [formView.formDelegate formView:formView willDisplayCell:formViewCell forRowAtIndexPath:indexPath];
}

#pragma mark - Form view data source

// required

- (NSInteger)formView:(PTFormView *)formView numberOfRowsInSection:(NSInteger)section PT_REQUIRED

- (PTFormViewCell *)formView:(PTFormView *)formView cellForRowAtIndexPath:(NSIndexPath *)indexPath PT_REQUIRED

// optional

- (NSInteger)numberOfSectionsInFormView:(PTFormView *)formView { return 1; }

- (NSString *)formView:(PTFormView *)formView titleForHeaderInSection:(NSInteger)section { return nil; }
- (NSString *)formView:(PTFormView *)formView titleForFooterInSection:(NSInteger)section { return nil; }

#pragma mark - Form view delegate

// required

// ...

// optional

- (void)formView:(PTFormView *)formView willDisplayCell:(PTFormViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath PT_NOOP

@end
