//
//  NSURL+CExWorkingDirectories.m
//  LaunchGalaxy
//
//  Created by Daniel Lin on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSURL+CExWorkingDirectories.h"

@implementation NSURL (CExWorkingDirectories)

+ (NSURL *)usrDocumentsURL
{
    NSFileManager *defaultManager = [NSFileManager defaultManager];
	NSArray *documentFolders = [defaultManager URLsForDirectory:NSDocumentDirectory 
													  inDomains:NSUserDomainMask];
	NSURL *outURL = [documentFolders lastObject];
	return outURL;
}

+ (NSURL *)cachesURL
{
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    NSArray *cachesFolder = [defaultManager URLsForDirectory:NSCachesDirectory
                                                   inDomains:NSUserDomainMask];
    NSURL *outURL = [cachesFolder lastObject];
    return outURL;
}

@end
