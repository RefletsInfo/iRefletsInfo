//
//  CategoriesViewController.h
//  iRefletsInfo
//
//  Created by Jérôme Blondon on 20/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoriesViewController : UITableViewController {
    NSArray *categories;
    NSDictionary *currentItem;
    UIPopoverController *parent;
}

@property (nonatomic, retain) NSArray *categories;
@property (nonatomic, retain) UIPopoverController *parent;
@property (nonatomic, retain) NSDictionary *currentItem;

- (NSDictionary *)getSelectedItem;

@end
