/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Basic demonstration of how to use the SystemConfiguration Reachablity APIs.
 */

#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
#import <sys/socket.h>
#import <netinet/in.h>

#import <CoreFoundation/CoreFoundation.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

#import "LYSReachability.h"

#pragma mark IPv6 Support
//Reachability fully support IPv6.  For full details, see ReadMe.md.

NSString *LYSReachabilityChangedNotification = @"LYS_kNetworkReachabilityChangedNotification";


#pragma mark - Supporting functions

#define kShouldPrintReachabilityFlags 1

static void ly_PrintReachabilityFlags(SCNetworkReachabilityFlags flags, const char* comment)
{
#if kShouldPrintReachabilityFlags

    NSLog(@"Reachability Flag Status: %c%c %c%c%c%c%c%c%c %s\n",
          (flags & kSCNetworkReachabilityFlagsIsWWAN)				? 'W' : '-',
          (flags & kSCNetworkReachabilityFlagsReachable)            ? 'R' : '-',
          (flags & kSCNetworkReachabilityFlagsTransientConnection)  ? 't' : '-',
          (flags & kSCNetworkReachabilityFlagsConnectionRequired)   ? 'c' : '-',
          (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic)  ? 'C' : '-',
          (flags & kSCNetworkReachabilityFlagsInterventionRequired) ? 'i' : '-',
          (flags & kSCNetworkReachabilityFlagsConnectionOnDemand)   ? 'D' : '-',
          (flags & kSCNetworkReachabilityFlagsIsLocalAddress)       ? 'l' : '-',
          (flags & kSCNetworkReachabilityFlagsIsDirect)             ? 'd' : '-',
          comment
          );
#endif
}


static void ly_ReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info)
{
#pragma unused (target, flags)
	NSCAssert(info != NULL, @"info was NULL in ReachabilityCallback");
	NSCAssert([(__bridge NSObject*) info isKindOfClass: [LYSReachability class]], @"info was wrong class in ReachabilityCallback");

    LYSReachability* noteObject = (__bridge LYSReachability *)info;
    // Post a notification to notify the client that the network reachability changed.
    [[NSNotificationCenter defaultCenter] postNotificationName: LYSReachabilityChangedNotification object: noteObject];
    if (noteObject.notifitionCallBack) {
        noteObject.notifitionCallBack(noteObject);
    }
}


#pragma mark - Reachability implementation

@implementation LYSReachability
{
	SCNetworkReachabilityRef _reachabilityRef;
}

+ (instancetype)ly_reachabilityWithHostName:(NSString *)hostName
{
	LYSReachability* returnValue = NULL;
	SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, [hostName UTF8String]);
	if (reachability != NULL)
	{
		returnValue= [[self alloc] init];
		if (returnValue != NULL)
		{
			returnValue->_reachabilityRef = reachability;
		}
        else {
            CFRelease(reachability);
        }
	}
	return returnValue;
}


+ (instancetype)ly_reachabilityWithAddress:(const struct sockaddr *)hostAddress
{
	SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, hostAddress);

	LYSReachability* returnValue = NULL;

	if (reachability != NULL)
	{
		returnValue = [[self alloc] init];
		if (returnValue != NULL)
		{
			returnValue->_reachabilityRef = reachability;
		}
        else {
            CFRelease(reachability);
        }
	}
	return returnValue;
}


+ (instancetype)ly_reachabilityForInternetConnection
{
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
    
    return [self ly_reachabilityWithAddress: (const struct sockaddr *) &zeroAddress];
}

#pragma mark reachabilityForLocalWiFi
//reachabilityForLocalWiFi has been removed from the sample.  See ReadMe.md for more information.
//+ (instancetype)reachabilityForLocalWiFi


#pragma mark - Start and stop notifier

- (BOOL)startNotifier
{
	BOOL returnValue = NO;
	SCNetworkReachabilityContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};

	if (SCNetworkReachabilitySetCallback(_reachabilityRef, ly_ReachabilityCallback, &context))
	{
		if (SCNetworkReachabilityScheduleWithRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode))
		{
			returnValue = YES;
		}
	}
    
	return returnValue;
}


- (void)stopNotifier
{
	if (_reachabilityRef != NULL)
	{
		SCNetworkReachabilityUnscheduleFromRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
	}
}

- (void)dealloc
{
	[self stopNotifier];
	if (_reachabilityRef != NULL)
	{
		CFRelease(_reachabilityRef);
	}
}

#pragma mark - Network Flag Handling

- (LYSNetworkStatus)networkStatusForFlags:(SCNetworkReachabilityFlags)flags
{
	ly_PrintReachabilityFlags(flags, "networkStatusForFlags");
	if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
	{
		// The target host is not reachable.
		return LYSNetworkStatusNotReachable;
	}

    LYSNetworkStatus returnValue = LYSNetworkStatusNotReachable;

	if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
	{
		/*
         If the target host is reachable and no connection is required then we'll assume (for now) that you're on Wi-Fi...
         */
		returnValue = LYSNetworkStatusReachableViaWiFi;
	}

	if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
        (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
	{
        /*
         ... and the connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs...
         */

        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
        {
            /*
             ... and no [user] intervention is needed...
             */
            returnValue = LYSNetworkStatusReachableViaWiFi;
        }
    }

	if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
	{
		/*
         ... but WWAN connections are OK if the calling application is using the CFNetwork APIs.
         */
		returnValue = LYSNetworkStatusReachableViaWWAN;
        if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
        {
            /*
             ... but WWAN connections are OK if the calling application is using the CFNetwork APIs.
             */
            returnValue = LYSNetworkStatusReachableViaWWAN;
            if ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0) {
                CTTelephonyNetworkInfo *phonyNetwork = [[CTTelephonyNetworkInfo alloc] init];
                NSString *currentStr = phonyNetwork.currentRadioAccessTechnology;
                if (currentStr) {
                    if ([currentStr isEqualToString:CTRadioAccessTechnologyLTE]) {
                        return LYSNetworkStatusRaeachableVia4G;
                    }else if ([currentStr isEqualToString:CTRadioAccessTechnologyGPRS]|| [currentStr isEqualToString:CTRadioAccessTechnologyEdge]){
                        return LYSNetworkStatusReachableVia2G;
                    }else{
                        return LYSNetworkStatusReachableVia3G;
                    }
                }
            }
            if ((flags & kSCNetworkReachabilityFlagsTransientConnection) == kSCNetworkReachabilityFlagsTransientConnection) {
                if((flags & kSCNetworkReachabilityFlagsConnectionRequired) == kSCNetworkReachabilityFlagsConnectionRequired) {
                    return LYSNetworkStatusReachableVia2G;
                }
                return LYSNetworkStatusReachableVia3G;
            }
            return LYSNetworkStatusReachableViaWWAN;
        }
	}
    
	return returnValue;
}


- (BOOL)connectionRequired
{
	NSAssert(_reachabilityRef != NULL, @"connectionRequired called with NULL reachabilityRef");
	SCNetworkReachabilityFlags flags;

	if (SCNetworkReachabilityGetFlags(_reachabilityRef, &flags))
	{
		return (flags & kSCNetworkReachabilityFlagsConnectionRequired);
	}

    return NO;
}


- (LYSNetworkStatus)currentReachabilityStatus
{
	NSAssert(_reachabilityRef != NULL, @"currentNetworkStatus called with NULL SCNetworkReachabilityRef");
	LYSNetworkStatus returnValue = LYSNetworkStatusNotReachable;
	SCNetworkReachabilityFlags flags;
    
	if (SCNetworkReachabilityGetFlags(_reachabilityRef, &flags))
	{
        returnValue = [self networkStatusForFlags:flags];
	}
    
	return returnValue;
}


@end
