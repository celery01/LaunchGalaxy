//
//  CExPhoneSysLaunchViewController.m
//  LaunchGalaxy
//
//  Created by Daniel Lin on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CExPhoneSysLaunchViewController.h"
#import "CExOrganizerViewController.h"


@interface CExPhoneSysLaunchViewController ()

@end

@implementation CExPhoneSysLaunchViewController

+ (void)load
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    [CExOrganizerViewController AddItem:NSStringFromClass([self class])];
    
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
    [[UIApplication sharedApplication] openURL:phoneUrl];

}

- (IBAction)launchGMaps:(id)sender
{
    NSURL *mapUrl = [NSURL URLWithString:@"http://maps.google.com/maps?q=cupertino"];
    [[UIApplication sharedApplication] openURL:mapUrl];
}

- (IBAction)launchText:(id)sender
{
    NSURL *textUrl = [NSURL URLWithString:@"sms:/maps?q=cupertino"];
    [[UIApplication sharedApplication] openURL:textUrl];
}

- (IBAction)launchiTunes:(id)sender
{
    NSURL *itunesUrl = [NSURL URLWithString:@"http://itunes.apple.com/app/posing-app/id492085243?mt=8"];
    [[UIApplication sharedApplication] openURL:itunesUrl];
}

- (IBAction)lauchMail:(id)sender
{
    NSURL *mailUrl = [NSURL URLWithString:@"mailto:foo@example.com?cc=bar@example.com&subject=Greetings%20from%20Cupertino!&body=Wish%20you%20were%20here!"];
    [[UIApplication sharedApplication] openURL:mailUrl];

}

@end
