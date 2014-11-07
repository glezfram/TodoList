//
//  CommonFunctions.m
//  Gas Control
//
//  Created by Francisco González Jiménez on 4/26/10.
//  Copyright 2010. All rights reserved.
//

#import "CommonFunctions.h"

@implementation CommonFunctions

#pragma mark -
#pragma mark Singleton Functions

/**
 Create instance
 **/
+ (CommonFunctions *)getCommonFunctions
{
	static CommonFunctions * functions;
	
	if (functions == nil)
	{
		functions = [[CommonFunctions alloc] init];
	}
	
	return functions;
}

#pragma mark - Alerts methods

- (void)showAlert:(NSString *)title WithMessage:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles
{
    if (!alertView.visible)
    {
        alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
	
        [alertView show];
    }
}

- (void)hideAlert
{
    [alertView dismissWithClickedButtonIndex:0 animated:NO];
}

#pragma mark - Spinner methods

- (void)addActivityIndicator:(UIView *)viewWindow
{
    activityIndicator = [[UIActivityIndicatorView alloc] init];
    activityIndicator.frame = CGRectMake(150.0f, 150.0f, 37.0f, 37.0f);
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicator setColor:UIColorFromRGB(0x036F43)];
    [viewWindow addSubview:activityIndicator];
    [activityIndicator stopAnimating];
}

- (void)startActivityIndicator
{
    if (![activityIndicator isAnimating])
    {
        [activityIndicator startAnimating];
    }
}

- (void)stopActivityIndicator
{
    if ([activityIndicator isAnimating])
    {
        [activityIndicator stopAnimating];
    }
}

#pragma mark - Wireless methods

- (BOOL) connectedToNetwork
{
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof (zeroAddress));
	zeroAddress.sin_len = sizeof (zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	//Recover reachability flags
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	SCNetworkReachabilityFlags flags;
	
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	
	if (!didRetrieveFlags)
	{
		//NSLog(@"NO TIENE DATOS");
	}
	
	BOOL isCellularConnection = ((flags & kSCNetworkReachabilityFlagsIsWWAN) != 0);
	
	if (!isCellularConnection)
	{
		BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
		BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
		
		return (isReachable && !needsConnection) ? YES : NO;
	}
    else
    {
        return YES;
    }
	
	return NO;
}

- (BOOL)connectedToWiFi
{
    struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof (zeroAddress));
	zeroAddress.sin_len = sizeof (zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	//Recover reachability flags
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	SCNetworkReachabilityFlags flags;
	
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	
	if (!didRetrieveFlags)
	{
		//NSLog(@"NO TIENE DATOS");
	}
	
	BOOL isCellularConnection = ((flags & kSCNetworkReachabilityFlagsIsWWAN) != 0);
	
	if (isCellularConnection)
	{
        return FALSE;
    }
        
    return TRUE;

}

#pragma mark - Dates method

- (NSString *)getDate
{
    NSString *stringDate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	[formatter setDateFormat:@"MM"];
	NSString *month = [formatter stringFromDate:[NSDate date]];
	
	[formatter setDateFormat:@"dd"];
	NSString *day = [formatter stringFromDate:[NSDate date]];
	
	[formatter setDateFormat:@"yyyy"];
	NSString *year = [formatter stringFromDate:[NSDate date]];
	
	stringDate = [NSString stringWithFormat:@"%@%@%@", year, month, day];
    
    return stringDate;
}


- (NSString *)getMonth
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	[formatter setDateFormat:@"MM"];
	NSString *stringMonth = [formatter stringFromDate:[NSDate date]];
    
    NSInteger intMonth = [stringMonth intValue];
    
    switch (intMonth)
    {
        case 1:
            stringMonth = [NSString stringWithFormat:@"Enero"];
            break;
        case 2:
            stringMonth = [NSString stringWithFormat:@"Febrero"];
            break;
        case 3:
            stringMonth = [NSString stringWithFormat:@"Marzo"];
            break;
        case 4:
            stringMonth = [NSString stringWithFormat:@"Abril"];
            break;
        case 5:
            stringMonth = [NSString stringWithFormat:@"Mayo"];
            break;
        case 6:
            stringMonth = [NSString stringWithFormat:@"Junio"];
            break;
        case 7:
            stringMonth = [NSString stringWithFormat:@"Julio"];
            break;
        case 8:
            stringMonth = [NSString stringWithFormat:@"Agosto"];
            break;
        case 9:
            stringMonth = [NSString stringWithFormat:@"Septiembre"];
            break;
        case 10:
            stringMonth = [NSString stringWithFormat:@"Octubre"];
            break;
        case 11:
            stringMonth = [NSString stringWithFormat:@"Noviembre"];
            break;
        case 12:
            stringMonth = [NSString stringWithFormat:@"Diciembre"];
            break;
    }
    
    return stringMonth;
}
- (NSString *)getDay
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    
    [formatter setDateFormat:@"dd"];
	NSString *stringDay = [formatter stringFromDate:[NSDate date]];
    
    return stringDay;
}

- (NSString *)getYear
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    
    [formatter setDateFormat:@"YYYY"];
	NSString *stringYear = [formatter stringFromDate:[NSDate date]];
    
    return stringYear;
}

- (NSString *)getTimeWithPoints
{
    NSString *stringTime;
    
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm"];
    stringTime = [formatter stringFromDate:currentTime];
    
    return stringTime;
}

- (NSString *)getTime
{
    NSString *stringTime;
    
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hhmm"];
    stringTime = [formatter stringFromDate:currentTime];
    
    return stringTime;
}

#pragma mark -
#pragma mark Memory Management

/**
 Clear memory
 **/
- (void)dealloc
{	

}

@end
