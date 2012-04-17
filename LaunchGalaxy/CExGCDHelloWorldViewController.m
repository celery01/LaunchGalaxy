//
//  CExGCDHelloWorldViewController.m
//  LaunchGalaxy
//
//  Created by Daniel Lin on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CExGCDHelloWorldViewController.h"
#import "CExOrganizerRegistery.h"

@interface CExGCDHelloWorldViewController ()

@end

@implementation CExGCDHelloWorldViewController

+ (void)load
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    [CExOrganizerRegistery AddItem:NSStringFromClass([self class])
                            forCategory:@"GCDTests"];    
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

@end
