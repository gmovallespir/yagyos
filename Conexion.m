//
//  Conexion.m
//  yagyos
//
//  Created by Guillermo Vallespir on 24-10-13.
//  Copyright (c) 2013 Guillermo Vallespir. All rights reserved.
//

#import "Conexion.h"

@implementation Conexion



- (NSDictionary *)sendPost: (NSString *)metodo data:(NSString *)data{
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat: @"http://yagyos.rededucanet.cl/movil.php"]];
    
    data = [NSString stringWithFormat:@"metodo=%@&%@", metodo, data];
    NSLog(@"%@", data);
    
    NSString *postLength = [NSString stringWithFormat: @"%d", [data length]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[data dataUsingEncoding: NSUTF8StringEncoding allowLossyConversion: YES]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setTimeoutInterval: 90];
    
    NSURLResponse *response = NULL;
    
    NSData *respuesta = [NSURLConnection sendSynchronousRequest: request returningResponse: &response error: nil];
    
    NSDictionary *retorno = [NSJSONSerialization JSONObjectWithData: respuesta options: kNilOptions error: nil];
    
    NSLog(@"%@", retorno);
    
    return retorno;
}


@end
