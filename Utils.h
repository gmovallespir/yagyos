//
//  Utils.h
//  Vod
//
//  Created by Bazuca Chile SA on 26-08-13.
//  Copyright (c) 2013 Vtr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+(UIColor*) colorWithHexString:(NSString*)hex;
+(NSString*) uniqueIdentifier;
+(NSString*) machineName;
@end
