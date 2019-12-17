//
//  XYZValidator.m
//  Coparmex
//
//  Created by Gabriel Baltazar Perez on 3/5/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZFileUtil.h"
#import "XYZUrlUtil.h"

#import "XYZValidator.h"

@implementation XYZValidator

- (NSInteger)statusCode:(NSString *)stringUrl
{
    NSURL *url = [[XYZUrlUtil alloc] urlHash:stringUrl];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    NSHTTPURLResponse* response = nil;
    NSError *error = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    //NSString *lastModified;
    //if ([response respondsToSelector:@selector(allHTTPHeaderFields)]) {
    //    lastModified = [[response allHeaderFields] objectForKey:@"Last-Modified"];
    //}
    
    //NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    //[req addValue:lastModified forHTTPHeaderField:@"If-Modified-Since"];
    //NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    
    return [response statusCode];
}

- (BOOL)validateStringUrl:(NSString *)stringUrl
{
    return [self validateStatusCode:[self statusCode:stringUrl]];
}

- (BOOL)validateStatusCode:(NSInteger)statusCode
{
    switch (statusCode)
    {
        case 200:
            return YES;
        case 404:
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Código de registro inválido." delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil] show];
            return NO;
        default:
            [[[UIAlertView alloc] initWithTitle:@"No hay conexión a internet" message:@"Debe estar conectado a internet para realizar esta operación." delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil] show];
            return NO;
    }
}

- (BOOL)sendBody:(NSString *)body withUrl:(NSString *)stringUrl {
    NSURL *url = [[XYZUrlUtil alloc] urlHash:stringUrl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSHTTPURLResponse* response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    return [self  validateStatusCode:[response statusCode]];
}

@end
