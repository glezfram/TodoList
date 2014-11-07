//
//  CommonFunctions.h
//  Gas Control
//
//  Created by Francisco González Jiménez on 4/26/10.
//  Copyright 2010. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>
#include <SystemConfiguration/SCNetworkReachability.h>
#import <UIKit/UIKit.h>

#define	UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface CommonFunctions : NSObject
{
	UIActivityIndicatorView *activityIndicator;
    UIAlertView *alertView;
}

+ (CommonFunctions *)getCommonFunctions;

- (void)showAlert:(NSString *)title WithMessage:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles;
- (void)hideAlert;
- (void)addActivityIndicator:(UIView *)viewWindow;
- (NSString *)getDate;
- (NSString *)getMonth;
- (NSString *)getDay;
- (NSString *)getYear;
- (NSString *)getTimeWithPoints;
- (NSString *)getTime;
- (void)startActivityIndicator;
- (void)stopActivityIndicator;

- (BOOL)connectedToNetwork;
- (BOOL)connectedToWiFi;

@end
