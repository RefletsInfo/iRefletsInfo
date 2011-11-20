/*
 This module is licensed under the MIT license.
 
 Copyright (C) 2011 by raw engineering
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
//
//  HeaderView.m
//  FlipView
//
//  Created by Reefaq Mohammed on 16/07/11.
 
//

#import "HeaderView.h"
#import "Constants.h"
#import "CategoriesViewController.h"

@implementation HeaderView

@synthesize currrentInterfaceOrientation,wallTitleText, currentItem;

-(void)rotate:(UIInterfaceOrientation)interfaceOrientation animation:(BOOL)animation{
	currrentInterfaceOrientation = interfaceOrientation;
}

-(void) setWallTitleText:(NSString *)wallTitle {
    UIToolbar *toolbar = [UIToolbar new];
    toolbar.barStyle = UIBarStyleDefault;
    [toolbar sizeToFit];		
    toolbar.autoresizingMask = toolbar.autoresizingMask | UIViewAutoresizingFlexibleWidth;
    
    UIImage *buttonImage = [UIImage imageNamed:@"logo-reflets-button.png"];
    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageButton setImage:buttonImage forState:UIControlStateNormal];
    imageButton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    UIBarButtonItem *imageButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageButton];
    
    UIBarButtonItem *categoriesButtonItem = [[UIBarButtonItem alloc] initWithTitle:wallTitle style:UIBarButtonItemStyleBordered target:self action:@selector(actionChooseCategory:)];
    categoriesButtonItem.tag = 101;
    
    UIBarButtonItem *refreshButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(actionRefresh:)];
    
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *items = [NSArray arrayWithObjects: imageButtonItem, flexItem, categoriesButtonItem,refreshButtonItem, nil];
    
    //release buttons
    [imageButton release];
    [imageButtonItem release];
    [categoriesButtonItem release];
    [refreshButtonItem release];
    [flexItem release];
    
    //add array of buttons to toolbar
    [toolbar setItems:items animated:NO];
    [self addSubview:toolbar]; 
}

-(void) dealloc {
    [activityIndicator release];
	[super dealloc];
}

-(void) startedActivity:(NSNotification *) notification
{
    [activityIndicator startAnimating];
}

-(void) stoppedActivity:(NSNotification *) notification
{
    [activityIndicator stopAnimating];
}

- (IBAction)actionChooseCategory:(id)sender 
{
    if (catPopoverController) {
        [catPopoverController dismissPopoverAnimated:YES];
        [catPopoverController.delegate popoverControllerDidDismissPopover:catPopoverController];
        catPopoverController=nil;
    } else {
        CategoriesViewController *content = [[CategoriesViewController alloc] init];
        UIPopoverController *popoverController = [[UIPopoverController alloc] 
                                                  initWithContentViewController:content];
        popoverController.delegate = self;
        popoverController.popoverContentSize = CGSizeMake(320, 400);
        content.parent = popoverController;
        content.currentItem = self.currentItem;
        [popoverController presentPopoverFromBarButtonItem:sender
                         permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        catPopoverController = popoverController;
        [content release];
    }
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    CategoriesViewController *content = (CategoriesViewController *) popoverController.contentViewController;
    [popoverController release];
    
    NSDictionary *dict = [content getSelectedItem];
    if (dict) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationChangeCategory object:dict];
    }
    
}


- (IBAction)actionRefresh:(id)sender 
{
    NSLog(@"Refresh");
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationRefreshFeeds object:nil];
}

@end
