//
//  XYZFileUtil.h
//  Coparmex
//
//  Created by Gabriel Baltazar Perez on 3/14/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZFileUtil : NSObject

- (BOOL)exists:(NSString *)fileName;

- (NSString *)path:(NSString *)fileName;

- (void)deleteFile:(NSString *)fileName;

- (void)saveData:(NSData *)data inFile:(NSString *)fileName;

- (void)saveUrlContent:(NSString *)stringUrl inFile:(NSString *)fileName;

- (void)saveUrlContent:(NSString *)stringUrl updateFile:(NSString *)fileName;

- (NSData *)dataFrom:(NSString *)fileName;

@end
