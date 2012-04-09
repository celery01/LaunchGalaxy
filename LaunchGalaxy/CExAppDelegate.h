//
//  CExAppDelegate.h
//  LaunchGalaxy
//
//  Created by Daniel Lin on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CExOrganizerViewController;

@interface CExAppDelegate : UIResponder <UIApplicationDelegate>



@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CExOrganizerViewController *organizerViewController;

- (void)pushRootViewController:(UIViewController *)anotherRootVC;

- (void)popRootViewController;

@end