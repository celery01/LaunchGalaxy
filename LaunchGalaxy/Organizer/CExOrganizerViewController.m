//
//  CExOrganizerViewController.m
//  LaunchGalaxy
//
//  Created by Daniel Lin on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CExOrganizerViewController.h"
#import "CExOrganizerRegistery.h"
#import "CExAppDelegate.h"

#define kCExClassPrefix                     @"CEx"
#define kCExClassSuffix                     @"ViewController"

@interface CExOrganizerViewController ()

- (void)pushViewControllerNamed:(NSString *)viewControllerName;

@end

@implementation CExOrganizerViewController

#pragma mark - init
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.delegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [CExOrganizerRegistery sharedCategories].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSMutableDictionary *cateDict = [[CExOrganizerRegistery sharedCategories] objectAtIndex:section];
    
    NSMutableArray *items = [cateDict objectForKey:kCExOrganzierItems];
    
    return items.count;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSMutableDictionary *cateDict = [[CExOrganizerRegistery sharedCategories] objectAtIndex:section];
    return [cateDict objectForKey:kCExOrganizerCategoryTitle];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSMutableDictionary *categoryDict = [[CExOrganizerRegistery sharedCategories] objectAtIndex:indexPath.section];
    
    NSAssert((categoryDict != nil),@"category nil");
    
    NSMutableArray *items = [categoryDict objectForKey:kCExOrganzierItems];
    
    NSString *rawClassTitle = [items objectAtIndex:indexPath.row];
    NSString *titleLabelText = rawClassTitle;

    NSRange prefixRange = [titleLabelText rangeOfString:kCExClassPrefix];
    
    if(prefixRange.location != NSNotFound) 
        titleLabelText = [rawClassTitle substringFromIndex:prefixRange.location+prefixRange.length];
    
    NSRange suffixRange = [titleLabelText rangeOfString:kCExClassSuffix];

    if(suffixRange.location != NSNotFound)
        titleLabelText = [titleLabelText substringToIndex:suffixRange.location];
    
    cell.textLabel.text = titleLabelText;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    NSMutableDictionary *categoryDict = [[CExOrganizerRegistery sharedCategories] objectAtIndex:indexPath.section];
    
    NSAssert((categoryDict != nil),@"category nil");
    
    NSMutableArray *items = [categoryDict objectForKey:kCExOrganzierItems];
    
    NSString *classString = [items objectAtIndex:indexPath.row];
    
    [self pushViewControllerNamed:classString];
}


#pragma mark - Helper
- (void)pushViewControllerNamed:(NSString *)viewControllerClassName
{
    @try {
        /*    
         const char *cString = [classString cStringUsingEncoding:NSUTF8StringEncoding];
         
         id classObject = objc_getClass(cString);
         
         id theViewControllerInstance = class_createInstance(classObject, 0);
         */
        
        NSString *xibName = nil;
        NSString *newXibName = nil;
        //
        //  checking whether the resource exists, if not using name .xib 
        //
        NSBundle *mainBundle = [NSBundle mainBundle];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            newXibName = [viewControllerClassName stringByAppendingString:@"_iPhone"];
        }
        else {
            newXibName = [viewControllerClassName stringByAppendingString:@"_iPad"];
        }
        
        NSString *resourcePath = [mainBundle pathForResource:newXibName ofType:@"nib"];
        
        if(!resourcePath) {
            xibName = viewControllerClassName;
        }
        else {
            xibName = newXibName;
        }
        
        id theViewController = [[NSClassFromString(viewControllerClassName) alloc] initWithNibName:xibName bundle:nil];
        
        CExAppDelegate* appDelegate = (CExAppDelegate *)[UIApplication sharedApplication].delegate;
        
        [appDelegate pushRootViewController:theViewController];    
        
        [theViewController release];
        
    }
    @catch (NSException *exception) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning!"
                                                        message:[NSString stringWithFormat:@"Could not Found Class Named:%@",viewControllerClassName]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
        
        [alert release];
    }
    @finally {
        
    }
}


#pragma mark - Scroll view Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%s ",__PRETTY_FUNCTION__);
}

// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"%s ",__PRETTY_FUNCTION__);    
}

// called on finger up if the user dragged. velocity is in points/second. targetContentOffset may be changed to adjust where the scroll view comes to rest. not called when pagingEnabled is YES
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset 
{
        NSLog(@"%s ",__PRETTY_FUNCTION__);
}

// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
        NSLog(@"%s ",__PRETTY_FUNCTION__);
}
   // called on finger up as we are moving
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
        NSLog(@"%s ",__PRETTY_FUNCTION__);
}

    // called when scroll view grinds to a halt
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
        NSLog(@"%s ",__PRETTY_FUNCTION__);
};  

// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
        NSLog(@"%s ",__PRETTY_FUNCTION__);
}; 

//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView;   // return a yes if you want to scroll to the top. if not defined, assumes YES
//- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView;      // called when scrolling animation finished. may be called immediately if already at top

    
@end
