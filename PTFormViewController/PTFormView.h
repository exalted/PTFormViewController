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

#import "PTFormViewCell.h"

@class PTFormView;

typedef enum {
    PTFormViewStylePlain    = UITableViewStylePlain,
    PTFormViewStyleGrouped  = UITableViewStyleGrouped,
} PTFormViewStyle;

////////////////////////////////////////////////////////////////////////////////
// Form view data source
////////////////////////////////////////////////////////////////////////////////

@protocol PTFormViewDataSource <NSObject>

@required

- (NSInteger)formView:(PTFormView *)formView numberOfRowsInSection:(NSInteger)section;

- (PTFormViewCell *)formView:(PTFormView *)formView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSInteger)numberOfSectionsInFormView:(PTFormView *)formView;

@end

////////////////////////////////////////////////////////////////////////////////
// Form view delegate
////////////////////////////////////////////////////////////////////////////////

@protocol PTFormViewDelegate <NSObject>

@optional

- (void)formView:(PTFormView *)formView willDisplayCell:(PTFormViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end

////////////////////////////////////////////////////////////////////////////////
// Form view
////////////////////////////////////////////////////////////////////////////////

@interface PTFormView : UITableView

@property (nonatomic, readonly) PTFormViewStyle formStyle;

@property (unsafe_unretained, nonatomic) id<PTFormViewDataSource> formDataSource;
@property (unsafe_unretained, nonatomic) id<PTFormViewDelegate> formDelegate;

- (id)initWithFrame:(CGRect)frame style:(PTFormViewStyle)style;

- (id)dequeueReusableCellWithStyle:(PTFormViewStyle)style;

- (PTFormViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
