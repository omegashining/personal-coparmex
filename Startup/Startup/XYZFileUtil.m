//
//  XYZFileUtil.m
//  Coparmex
//
//  Created by Gabriel Baltazar Perez on 3/14/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZUrlUtil.h"

#import "XYZFileUtil.h"

@implementation XYZFileUtil

- (BOOL)exists:(NSString *)fileName
{
    NSString *filePath = [self path:fileName];
    
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

- (NSString *)path:(NSString *)fileName {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
	return [[path objectAtIndex:0] stringByAppendingPathComponent:fileName];
}

- (void)deleteFile:(NSString *)fileName
{
    NSString *filePath = [self path:fileName];
    
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

- (void)saveData:(NSData *)data inFile:(NSString *)fileName
{
    NSString *filePath = [self path:fileName];
    
    [data writeToFile:filePath atomically:YES];
}

- (void)saveUrlContent:(NSString *)stringUrl inFile:(NSString *)fileName {
    if (![self exists:fileName]) {
        NSData *data = [[XYZUrlUtil alloc] dataFrom:stringUrl];
        
        [self saveData:data inFile:fileName];
    }
}

- (void)saveUrlContent:(NSString *)stringUrl updateFile:(NSString *)fileName {
    NSData *data = [[XYZUrlUtil alloc] dataFrom:stringUrl];
        
    [self saveData:data inFile:fileName];
}

- (NSData *)dataFrom:(NSString *)fileName
{
    NSString *filePath = [self path:fileName];
    
    return [NSData dataWithContentsOfFile:filePath];
}

@end
