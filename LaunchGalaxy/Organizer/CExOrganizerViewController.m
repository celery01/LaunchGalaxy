//
//  CExOrganizerViewController.m
//  LaunchGalaxy
//
//  Created by Daniel Lin on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CExOrganizerViewController.h"
#import "CExAppDelegate.h"

#define kCExOrganizerCategoryTitle          @"kCOCT"
#define kCExOrganzierItems                  @"kCOI"

#define kCExClassPrefix                     @"CEx"

NSString *kCExOrganizerDefaultCategory = @"kCExOrganizerDefaultCategory";

@implementation CExOrganizerItem
@synthesize parentItem,itemTitle,itemCategory;
@end


@interface CExOrganizerViewController ()

- (void)pushViewControllerNamed:(NSString *)viewControllerName;
@end

@implementation CExOrganizerViewController

#if FEATURE_OPEN

+ (NSMutableArray *)sharedItemStore
{
    static NSMutableArray *gItemStore = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gItemStore = [[NSMutableArray alloc] init];
    });
    return gItemStore;
}

#endif


#pragma mark - RegisteryCategory
+ (NSMutableArray *)sharedCategories
{   
    static NSMutableArray *gCategories = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gCategories = [[NSMutableArray alloc] init];
    });
    
    return gCategories;
}


+ (void)AddItem:(NSString *)theItem
{
    [CExOrganizerViewController AddItem:theItem 
                            forCategory:nil];
}

+ (void)AddItem:(NSString *)theItem forCategory:(NSString *)theCategory
{
    NSString *categoryTitle = theCategory;
    NSMutableArray *categories = [CExOrganizerViewController sharedCategories];

    if(!categoryTitle) {
        // check the default category
        if(categories.count == 0) {
            [CExOrganizerViewController AddCategory:kCExOrganizerDefaultCategory];
        }
        
        categoryTitle = kCExOrganizerDefaultCategory;
    }
    
    
    BOOL existInCategories = NO;
    for(NSMutableDictionary *categoryDict in categories) {
        if([[categoryDict objectForKey:kCExOrganizerCategoryTitle] isEqualToString:categoryTitle]) {
            
            NSMutableArray *items= [categoryDict objectForKey:kCExOrganzierItems];
            NSAssert((items != nil),@"item shouldn't be nil");
            [items addObject:theItem];
            existInCategories = YES;
            break;
        }                
    }
    
    if(!existInCategories) {
        [categories addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               categoryTitle,                               kCExOrganizerCategoryTitle,
                               [NSMutableArray arrayWithObject:theItem],    kCExOrganzierItems,
                               nil]];
    }
}

+ (void)AddCategory:(NSString *)theCategory 
{
    NSMutableArray *categories = [CExOrganizerViewController sharedCategories];
    BOOL foundCategory = NO;
    for (NSMutableDictionary *categoryDict in categories) {
        if([[categoryDict valueForKey:kCExOrganizerCategoryTitle] isEqualToString:theCategory]) {
            foundCategory = YES;
            break;
        }
    }
    
    if(!foundCategory) {
        NSMutableDictionary *mutableDict = [[[NSMutableDictionary alloc] init] autorelease];
        
        [mutableDict setObject:theCategory 
                        forKey:kCExOrganizerCategoryTitle];
        [mutableDict setObject:[NSMutableArray array]
                        forKey:kCExOrganzierItems];
        
        [[CExOrganizerViewController sharedCategories] addObject:mutableDict];
    }
}

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
    return [CExOrganizerViewController sharedCategories].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSMutableDictionary *cateDict = [[CExOrganizerViewController sharedCategories] objectAtIndex:section];
    
    NSMutableArray *items = [cateDict objectForKey:kCExOrganzierItems];
    
    return items.count;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSMutableDictionary *cateDict = [[CExOrganizerViewController sharedCategories] objectAtIndex:section];
    return [cateDict objectForKey:kCExOrganizerCategoryTitle];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSMutableDictionary *categoryDict = [[CExOrganizerViewController sharedCategories] objectAtIndex:indexPath.section];
    
    NSAssert((categoryDict != nil),@"category nil");
    
    NSMutableArray *items = [categoryDict objectForKey:kCExOrganzierItems];
    
    NSString *rawClassTitle = [items objectAtIndex:indexPath.row];
    NSString *titleLabelText = rawClassTitle;

    NSRange prefixRange = [titleLabelText rangeOfString:kCExClassPrefix];
    
    if(prefixRange.location != NSNotFound) 
        titleLabelText = [rawClassTitle substringFromIndex:prefixRange.location+prefixRange.length];
    
    NSRange suffixRange = [titleLabelText rangeOfString:@"ViewController"];

    if(suffixRange.location != NSNotFound)
        titleLabelText = [titleLabelText substringToIndex:suffixRange.location];
    
    cell.textLabel.text = titleLabelText;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    NSMutableDictionary *categoryDict = [[CExOrganizerViewController sharedCategories] objectAtIndex:indexPath.section];
    
    NSAssert((categoryDict != nil),@"category nil");
    
    NSMutableArray *items = [categoryDict objectForKey:kCExOrganzierItems];
    
    NSString *classString = [items objectAtIndex:indexPath.row];
    
    [self pushViewControllerNamed:classString];
}


#pragma mark Helper
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


@end
