//
//  CExOrganizerViewController+RegisteryCategory.m
//  LaunchGalaxy
//
//  Created by Daniel Lin on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CExOrganizerRegistery.h"


NSString * const kCExOrganizerCategoryTitle     = @"kCOCT";
NSString * const kCExOrganzierItems             = @"kCOI";

NSString *kCExOrganizerDefaultCategory = @"kCExOrganizerDefaultCategory";

@implementation CExOrganizerItem
@synthesize parentItem,itemTitle,itemCategory;
@end


@implementation CExOrganizerRegistery

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
    [CExOrganizerRegistery AddItem:theItem 
                            forCategory:nil];
}

+ (void)AddItem:(NSString *)theItem forCategory:(NSString *)theCategory
{
    NSString *categoryTitle = theCategory;
    NSMutableArray *categories = [CExOrganizerRegistery sharedCategories];
    
    if(!categoryTitle) {
        // check the default category
        if(categories.count == 0) {
            [CExOrganizerRegistery AddCategory:kCExOrganizerDefaultCategory];
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
    NSMutableArray *categories = [CExOrganizerRegistery sharedCategories];
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
        
        [[CExOrganizerRegistery sharedCategories] addObject:mutableDict];
    }
}


@end
