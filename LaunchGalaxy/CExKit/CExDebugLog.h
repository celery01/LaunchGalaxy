//
//  CExDebugMacro.h
//  LaunchGalaxy
//
//  Created by Daniel Lin on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef LaunchGalaxy_CExDebugMacro_h
#define LaunchGalaxy_CExDebugMacro_h




#if (1)//STD_DEBUG_LOG_ON
/***********************************************************************************************
 *
 *
 *
 ***********************************************************************************************/
#define DLOG(fmt,...)       { NSLog(fmt,__VA_ARGS__);}
#define DLOGRECT(rc)        { NSLog(@"%s(%d):<%f,%f,%f,%f>", __PRETTY_FUNCTION__,__LINE__, rc.origin.x, rc.origin.y, rc.size.width, rc.size.height); }
#define DLOGPOINT(pt)       { NSLog(@"%s(%d):<%f,%f>", __PRETTY_FUNCTION__,__LINE__, pt.x, pt.y); }
#define DLOGSIZE(size)      { NSLog(@"%s(%d):<%f,%f>", __PRETTY_FUNCTION__,__LINE__, size.width, size.height); }
#define DLOGINT(num)		{ NSLog(@"%s(%d):<%d>", __PRETTY_FUNCTION__,__LINE__, num); }
#define DLOGFLOAT(num)      { NSLog(@"%s(%d):<%f>", __PRETTY_FUNCTION__,__LINE__, num); }
#define DLOGRANGE(range)	{ NSLog(@"%s(%d):<%d,%d>", __PRETTY_FUNCTION__,__LINE__, range.location, range.length); }
#define DLOGDICT(dict)      { NSLog(@"%s(%d): Dictionary\n%@", __PRETTY_FUNCTION__,__LINE__,(dict)); }
#define DLOGOBJECT(obj)     { NSLog(@"%s(%d):\n%@", __PRETTY_FUNCTION__,__LINE__,(obj)); }


//#else
/***********************************************************************************************
 *
 *
 *
 ***********************************************************************************************/
#define FS_OPEN(VOID)           NSFileManager *defaultManager = [NSFileManager defaultManager];\
                                NSArray *documentFolders = [defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];\
                                NSURL *documentURL = [documentFolders lastObject];\
                                NSString *dbgLogPath = [NSString stringWithFormat:@"%@/debug.log",documentURL.relativePath];\
                                NSError *ioError = nil;\
                                NSStringEncoding encoding;\
                                NSString *dbgLog = [NSString stringWithContentsOfFile:dbgLogPath usedEncoding:&encoding error:&ioError];\
                                NSMutableString *logBuf = [[NSMutableString alloc] init];\
                                if(ioError) {\
                                }\
                                else {\
                                    if(dbgLog)\
                                        [logBuf appendString:dbgLog];\
                                    NSString *sparator = @"\n=================================================================\n";\
                                    [logBuf appendString:sparator];\
                                    [logBuf appendFormat:@"%@\n",[NSDate date]];\
                                }
                            

#define FS_CLOSE(VOID)          [logBuf writeToFile:dbgLogPath atomically:YES encoding:NSUTF8StringEncoding error:&ioError];\
                                [logBuf release];
                            


#define FSLOG(fmt,...)       { [logBuf appendFormat:fmt,__VA_ARGS__];[logBuf appendString:@"\n"];}
#define FSLOGRECT(rc)        { [logBuf appendFormat:@"%s(%d):<%f,%f,%f,%f>\n", __PRETTY_FUNCTION__,__LINE__, rc.origin.x, rc.origin.y, rc.size.width, rc.size.height]; }
#define FSLOGPOINT(pt)       { [logBuf appendFormat:@"%s(%d):<%f,%f>\n", __PRETTY_FUNCTION__,__LINE__, pt.x, pt.y]; }
#define FSLOGSIZE(size)      { [logBuf appendFormat:@"%s(%d):<%f,%f>\n", __PRETTY_FUNCTION__,__LINE__, size.width, size.height]; }
#define FSLOGINT(num)		 { [logBuf appendFormat:@"%s(%d):<%d>\n", __PRETTY_FUNCTION__,__LINE__, num]; }
#define FSLOGFLOAT(num)      { [logBuf appendFormat:@"%s(%d):<%f>\n", __PRETTY_FUNCTION__,__LINE__, num]; }
#define FSLOGRANGE(range)	 { [logBuf appendFormat:@"%s(%d):<%d,%d>\n", __PRETTY_FUNCTION__,__LINE__, range.location, range.length]; }
#define FSLOGDICT(dict)      { [logBuf appendFormat:@"%s(%d): Dictionary\n%@\n", __PRETTY_FUNCTION__,__LINE__,(dict)]; }
#define FSLOGOBJECT(obj)     { [logBuf appendFormat:@"%s(%d):\n%@\n", __PRETTY_FUNCTION__,__LINE__,(obj)]; }


//#define DLOG(fmt,...)      
//#define DLOGRECT(rc)
//#define DLOGPOINT(pt)
//#define DLOGSIZE(size)   
//#define DLOGINT(num)		
//#define DLOGFLOAT(num)   
//#define DLOGRANGE(range)	
//#define DLOGDICT(dict)     
//#define DLOGOBJECT(obj)




#endif




#endif
