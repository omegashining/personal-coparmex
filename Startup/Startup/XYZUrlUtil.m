//
//  XYZUrlUtil.m
//  Coparmex
//
//  Created by Gabriel Baltazar Perez on 3/20/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZValidator.h"

#import "XYZAppDelegate.h"

#import "XYZUrlUtil.h"

@implementation XYZUrlUtil

- (NSString *)stringUrlHash:(NSString *)stringUrl
{
    XYZAppDelegate *appDelegate = (XYZAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    return [NSString stringWithFormat:@"%@?hash=%@", stringUrl, appDelegate.hash];
}

- (NSURL *)urlHash:(NSString *)stringUrl
{
    NSString *stringUrlHash = [self stringUrlHash:stringUrl];
    
    return [NSURL URLWithString:stringUrlHash];
}

- (NSData *)dataFrom:(NSString *)stringUrl
{    
    NSString *stringUrlHash = [self stringUrlHash:stringUrl];
    
    NSURL *url = [NSURL URLWithString:stringUrlHash];
    
    return [NSData dataWithContentsOfURL:url];
}

@end
