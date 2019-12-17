//
//  XYZValidator.h
//  Coparmex
//
//  Created by Gabriel Baltazar Perez on 3/5/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZValidator : NSObject

- (NSInteger)statusCode:(NSString *)stringUrl;

- (BOOL)validateStringUrl:(NSString *)stringUrl;

- (BOOL)validateStatusCode:(NSInteger)statusCode;

- (BOOL)sendBody:(NSString *)body withUrl:(NSString *)stringUrl;

@end
