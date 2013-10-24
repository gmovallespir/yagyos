//
//  Conexion.h
//  yagyos
//
//  Created by Guillermo Vallespir on 24-10-13.
//  Copyright (c) 2013 Guillermo Vallespir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Conexion : NSObject{
    
}


- (NSString *)sendPost: (NSString *)metodo data:(NSString *)data;

@end
