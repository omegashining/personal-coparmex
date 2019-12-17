//
//  XYZUrlUtil.h
//  Coparmex
//
//  Created by Gabriel Baltazar Perez on 3/20/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZUrlUtil : NSObject

- (NSString *)stringUrlHash:(NSString *)urlString;

- (NSURL *)urlHash:(NSString *)urlString;

- (NSData *)dataFrom:(NSString *)stringUrl;

@end
