//
//  CExCustomAppLanuchViewController.h
//  LaunchGalaxy
//
//  Created by Daniel Lin on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CExCustomAppLanuchViewController : UIViewController

@property (readwrite,retain,nonatomic) IBOutlet UITextView *resultTextView;

- (IBAction)returnToCaller:(id)sender;

@end
