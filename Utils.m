//
//  Utils.m
//  Vod
//
//  Created by Bazuca Chile SA on 26-08-13.
//  Copyright (c) 2013 Vtr. All rights reserved.
//

#import "Utils.h"
#import <sys/utsname.h>

@implementation Utils

+(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                           blue:((float) b / 255.0f)
                           alpha:1.0f];
}

//FROM: http://stackoverflow.com/questions/17312927/vendor-identifiers-does-not-work-in-ios-version-5-0
+(NSString*) uniqueIdentifier
{
    if( [UIDevice instancesRespondToSelector:@selector(identifierForVendor)] ) {
        // iOS 6+
        return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    } else {
        // before iOS 6, so just generate an identifier and store it
        NSString* uniqueIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"identiferForVendor"];
        if( !uniqueIdentifier ) {
            CFUUIDRef uuid = CFUUIDCreate(NULL);
            uniqueIdentifier = (__bridge_transfer NSString*)CFUUIDCreateString(NULL, uuid);
            CFRelease(uuid);
            [[NSUserDefaults standardUserDefaults] setObject:uniqueIdentifier forKey:@"identifierForVendor"];
        }
        return uniqueIdentifier;
    }
}

+(NSString*) machineName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
}

@end
