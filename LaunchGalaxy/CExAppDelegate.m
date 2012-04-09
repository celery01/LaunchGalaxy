//
//  CExAppDelegate.m
//  LaunchGalaxy
//
//  Created by Daniel Lin on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CExAppDelegate.h"

#import "CExOrganizerViewController.h"

#import "CExKit.h"


#define STD_DEBUG_LOG_ON (1)



@interface CExAppDelegate ()

@property (readonly) NSMutableArray *viewControllerStack;

@end

@implementation CExAppDelegate
{
    NSMutableArray          *stack_;
}
@synthesize window = _window;
@synthesize organizerViewController = _organizerViewController;
@synthesize viewControllerStack = stack_;


- (void)dealloc
{
    [_window release];
    [_organizerViewController release];
    [stack_ release];
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    FS_OPEN();
    FSLOG(@"App:%@ LaunchOptions:%@",application,launchOptions);
    FS_CLOSE();

    stack_ = [[NSMutableArray alloc] init];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.organizerViewController = [[[CExOrganizerViewController alloc] initWithNibName:@"CExOrganizerViewController_iPhone" bundle:nil] autorelease];
    } else {
        self.organizerViewController = [[[CExOrganizerViewController alloc] initWithNibName:@"CExOrganizerViewController_iPad" bundle:nil] autorelease];
    }
    
    self.window.rootViewController = self.organizerViewController;
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

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    DLOGOBJECT(application);
    DLOGOBJECT(url);
    DLOGOBJECT(sourceApplication);
    DLOGOBJECT(annotation);
    
    FS_OPEN();
    FSLOGOBJECT(application);
    FSLOGOBJECT(url);
    FSLOGOBJECT(sourceApplication);
    FSLOGOBJECT(annotation);
    FS_CLOSE();
    
    [url query];
    
    // Pop the testRootViewController , let CExOriganzierViewController to be the rootViewController
    if(self.viewControllerStack.count >= 2)
        [self popRootViewController:UIViewAnimationOptionTransitionCrossDissolve];
    
    
    return YES;
}

//Every single test has its own typical RootViewController
- (void)pushRootViewController:(UIViewController *)anotherRootVC
{
    [self pushRootViewController:anotherRootVC
                         options:UIViewAnimationOptionTransitionFlipFromBottom];
}

- (void)pushRootViewController:(UIViewController *)anotherRootVC options:(UIViewAnimationOptions)option
{
    [self.viewControllerStack addObject:anotherRootVC];
    
    [UIView transitionFromView:self.window.rootViewController.view
                        toView:anotherRootVC.view
                      duration:1.0
                       options:option
                    completion:^(BOOL finished) {
                        self.window.rootViewController = anotherRootVC;
                    }];
}

//Pop the toppest viewController in the stack
- (void)popRootViewController
{
    [self popRootViewController:UIViewAnimationOptionTransitionFlipFromBottom];
}

- (void)popRootViewController:(UIViewAnimationOptions)option
{
    [self.viewControllerStack removeLastObject];
    
    UIViewController *theRootVC = [self.viewControllerStack lastObject];
    
    NSAssert((theRootVC != nil),@"viewController stack get wrong error!");
        
    [UIView transitionFromView:self.window.rootViewController.view
                        toView:theRootVC.view
                      duration:1.0
                       options:option
                    completion:^(BOOL finished) {
                        self.window.rootViewController = theRootVC;
                    }];
}

- (IBAction)backToTests:(id)sender
{
    [self popRootViewController];
}



@end
