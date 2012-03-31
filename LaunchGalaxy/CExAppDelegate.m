//
//  CExAppDelegate.m
//  LaunchGalaxy
//
//  Created by Daniel Lin on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CExAppDelegate.h"

#import "CExOrganizerViewController.h"


@interface CExAppDelegate ()

@property (readonly) NSMutableArray *viewControllerStack;

@end

@implementation CExAppDelegate
{
    NSMutableArray          *stack_;
}
@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize viewControllerStack = stack_;


- (void)dealloc
{
    [_window release];
    [_viewController release];
    [stack_ release];
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    stack_ = [[NSMutableArray alloc] init];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[[CExOrganizerViewController alloc] initWithNibName:@"CExOrganizerViewController_iPhone" bundle:nil] autorelease];
    } else {
        self.viewController = [[[CExOrganizerViewController alloc] initWithNibName:@"CExOrganizerViewController_iPad" bundle:nil] autorelease];
    }
    
    self.window.rootViewController = self.viewController;
    [self.viewControllerStack addObject:self.window.rootViewController];

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)pushRootViewController:(UIViewController *)anotherRootVC
{
    [self.viewControllerStack addObject:anotherRootVC];

    [UIView transitionFromView:self.window.rootViewController.view
                        toView:anotherRootVC.view
                      duration:1.0
                       options:UIViewAnimationOptionTransitionFlipFromBottom
                    completion:^(BOOL finished) {
                        self.window.rootViewController = anotherRootVC;
                    }];
    
}

- (void)popRootViewController
{
    [self.viewControllerStack removeLastObject];
    
    UIViewController *theRootVC = [self.viewControllerStack lastObject];
    
    NSAssert((theRootVC != nil),@"viewController stack get wrong error!");
    
    [UIView transitionFromView:self.window.rootViewController.view
                        toView:theRootVC.view
                      duration:1.0
                       options:UIViewAnimationOptionTransitionFlipFromBottom
                    completion:^(BOOL finished) {
                        self.window.rootViewController = theRootVC;
                    }];
}

- (IBAction)backToTests:(id)sender
{
    [self popRootViewController];
}



@end
