//
//  AboutViewController.h
//  iRefletsInfo
//
//  Created by Jérôme Blondon on 04/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController <UIWebViewDelegate>{
    UIPopoverController *parent;
    IBOutlet UIWebView *webView;
}

@property (nonatomic, retain) UIPopoverController *parent;
@property (nonatomic, retain) IBOutlet UIWebView *webView;


@end
