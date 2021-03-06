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
#import "AboutViewController.h"

@implementation HeaderView

@synthesize currrentInterfaceOrientation,wallTitleText, currentItem;

-(void)rotate:(UIInterfaceOrientation)interfaceOrientation animation:(BOOL)animation{
	currrentInterfaceOrientation = interfaceOrientation;
}

-(void) setWallTitleText:(NSString *)wallTitle {
    UIToolbar *toolbar = [UIToolbar new];
    toolbar.barStyle = UIBarStyleBlack;
    [toolbar sizeToFit];		
    toolbar.autoresizingMask = toolbar.autoresizingMask | UIViewAutoresizingFlexibleWidth;
    
    UIBarButtonItem *categoriesButtonItem = [[UIBarButtonItem alloc] initWithTitle:wallTitle style:UIBarButtonItemStyleBordered target:self action:@selector(actionChooseCategory:)];
    categoriesButtonItem.tag = 101;
    
    UIBarButtonItem *aboutButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Info", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(actionAbout:)];

    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    activityIndicator = [[UIActivityIndicatorView alloc] init];
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 20.0f, 20.0f)];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    UIBarButtonItem *activity = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];    
    
    
    NSArray *items = [NSArray arrayWithObjects: aboutButtonItem, flexItem, activity, categoriesButtonItem, nil];
    
    //release buttons
    [activity release];
    [categoriesButtonItem release];
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
    [activityIndicator startAnimating];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationRefreshFeeds object:nil];
}

- (IBAction)actionAbout:(id)sender 
{
    if (catAboutController) {
        [catAboutController dismissPopoverAnimated:YES];
        catAboutController=nil;
    } else {
        AboutViewController *content = [[AboutViewController alloc] init];
        UIPopoverController *popoverController = [[UIPopoverController alloc] 
                                                  initWithContentViewController:content];
        popoverController.popoverContentSize = CGSizeMake(420, 430);
        content.parent = popoverController;
        [popoverController presentPopoverFromBarButtonItem:sender
                                  permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        catAboutController = popoverController;
        [content release];
    }
}

@end
