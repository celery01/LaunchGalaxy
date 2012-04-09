//
//  CExOrganizerViewController.h
//  LaunchGalaxy
//
//  Created by Daniel Lin on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CExOrganizerItem : NSObject

@property (readwrite,retain) NSString               *itemCategory;
@property (readwrite,retain) NSString               *itemTitle;
@property (readwrite,assign) CExOrganizerItem       *parentItem;


@end



@interface CExOrganizerViewController : UITableViewController



@end


@interface CExOrganizerViewController(RegisteryCategory)

+ (NSMutableArray *)sharedCategories;

+ (void)AddCategory:(NSString *)theCategory;



+ (void)AddItem:(NSString *)theItem;

+ (void)AddItem:(NSString *)theItem forCategory:(NSString *)theCategory;

@end
