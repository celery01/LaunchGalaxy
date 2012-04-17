//
//  CExOrganizerViewController+RegisteryCategory.h
//  LaunchGalaxy
//
//  Created by Daniel Lin on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CExOrganizerViewController.h"

extern NSString *const kCExOrganizerCategoryTitle;
extern NSString *const kCExOrganzierItems;

@interface CExOrganizerItem : NSObject

@property (readwrite,retain) NSString               *itemCategory;
@property (readwrite,retain) NSString               *itemTitle;
@property (readwrite,assign) CExOrganizerItem       *parentItem;

@end


@interface CExOrganizerRegistery

+ (NSMutableArray *)sharedCategories;

+ (void)AddCategory:(NSString *)theCategory;

+ (void)AddItem:(NSString *)theItem;

+ (void)AddItem:(NSString *)theItem forCategory:(NSString *)theCategory;

@end
