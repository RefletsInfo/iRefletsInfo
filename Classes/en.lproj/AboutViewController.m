//
//  AboutViewController.m
//  iRefletsInfo
//
//  Created by Jérôme Blondon on 04/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController
@synthesize parent;
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    // Do any additional setup after loading the view from its nib.
    [super viewDidLoad];
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"about" ofType:@"html" inDirectory:[language stringByAppendingPathExtension:@"lproj"]];  
    NSData *htmlData = [NSData dataWithContentsOfFile:filePath];  
    if (htmlData) {  
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        [webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];  

        //Remove the shadow from the webview.
        //Code from https://github.com/markrickert/UIWebView-RemoveShadow
        for(UIScrollView* webScrollView in [webView subviews]) {
          if ([webScrollView isKindOfClass:[UIScrollView class]]) {
            for(UIView* subview in [webScrollView subviews]) {
              if ([subview isKindOfClass:[UIImageView class]]) {
                ((UIImageView*)subview).image = nil;
                subview.backgroundColor = [UIColor clearColor];
              }
            }
          }
        }
        webView.backgroundColor = [UIColor clearColor];
        webView.opaque = NO;
    }  
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ( navigationType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    return YES;
}

@end
