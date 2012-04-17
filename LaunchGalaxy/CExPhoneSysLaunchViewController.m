//
//  CExPhoneSysLaunchViewController.m
//  LaunchGalaxy
//
//  Created by Daniel Lin on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CExPhoneSysLaunchViewController.h"
#import "CExOrganizerRegistery.h"


@interface CExPhoneSysLaunchViewController ()

@end

@implementation CExPhoneSysLaunchViewController

+ (void)load
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    [CExOrganizerRegistery AddItem:NSStringFromClass([self class])
                            forCategory:@"LaunchTests"];
    
    [pool release];pool=nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)launchPhone:(id)sender
{
    NSURL *phoneUrl = [NSURL URLWithString:@"tel:8613901938801"];

    [self openUrlDelegate:phoneUrl];
}

- (IBAction)launchGMaps:(id)sender
{
    NSURL *mapUrl = [NSURL URLWithString:@"http://maps.google.com/maps?q=shanghai"];
    
    [self openUrlDelegate:mapUrl];
}

- (IBAction)launchText:(id)sender
{
    NSURL *textUrl = [NSURL URLWithString:@"sms:/maps?q=shanghai"];
    
    [self openUrlDelegate:textUrl];
}

- (IBAction)launchiTunes:(id)sender
{
    NSURL *itunesUrl = [NSURL URLWithString:@"http://itunes.apple.com/app/posing-app/id492085243?mt=8"];
    [self openUrlDelegate:itunesUrl];

}

- (IBAction)lauchMail:(id)sender
{
    NSURL *mailUrl = [NSURL URLWithString:@"mailto:foo@example.com?cc=bar@example.com&subject=Greetings%20from%20Cupertino!&body=Wish%20you%20were%20here!"];
    [self openUrlDelegate:mailUrl];
}

- (void)openUrlDelegate:(NSURL *)targetUrl
{
    if([[UIApplication sharedApplication] canOpenURL:targetUrl]) {
        [[UIApplication sharedApplication] openURL:targetUrl];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not open!"
                                                        message:[NSString stringWithFormat:@"%@",targetUrl]
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

@end
