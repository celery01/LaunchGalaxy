//
//  CExViewController.m
//  LanuchTestApp
//
//  Created by Daniel Lin on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CExViewController.h"

@interface CExViewController ()

@end

@implementation CExViewController

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

//  
//  Using the target applicaiton info.plist <URL types> key for configure the custom application <handler
//  <URL types>-<Item 0>-<URL Schemes>
//
- (IBAction)launchGalaxyTest:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"LaunchGalaxy://tests.Test?indexPath=kCExOrganizerDefaultCategory.kCExOrganzierItems.CExCustomAppLanuchViewController"];
    [[UIApplication sharedApplication] openURL:url];
}

@end
