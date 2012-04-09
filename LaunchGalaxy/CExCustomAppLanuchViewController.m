//
//  CExCustomAppLanuchViewController.m
//  LaunchGalaxy
//
//  Created by Daniel Lin on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CExCustomAppLanuchViewController.h"
#import "CExOrganizerViewController.h"

@interface CExCustomAppLanuchViewController ()

@end

@implementation CExCustomAppLanuchViewController
@synthesize resultTextView;

+ (void)load
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    [CExOrganizerViewController AddItem:NSStringFromClass([self class])
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
    self.resultTextView = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)returnToCaller:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"LanuchTestApp://testBack?successed=YES"];
    [[UIApplication sharedApplication] openURL:url];
    
}

@end
