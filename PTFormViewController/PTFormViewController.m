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
    return [self.formView numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.formView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.formView cellForRowAtIndexPath:indexPath];
}

#pragma mark - Form view data source

// required

- (NSInteger)formView:(PTFormView *)formView numberOfRowsInSection:(NSInteger)section
{
    NSAssert(NO, ([NSString stringWithFormat:@"Missing required method implementation '- %@'", NSStringFromSelector(_cmd)]));
    abort();
}

- (PTFormViewCell *)formView:(PTFormView *)formView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, ([NSString stringWithFormat:@"Missing required method implementation '- %@'", NSStringFromSelector(_cmd)]));
    abort();
}

// optional

- (NSInteger)numberOfSectionsInFormView:(PTFormView *)formView
{
    return 1;
}

@end
