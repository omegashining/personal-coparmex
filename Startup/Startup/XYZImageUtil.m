//
//  XYZImageUtil.m
//  Coparmex
//
//  Created by Gabriel Baltazar Perez on 3/14/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZFileUtil.h"
#import "XYZUrlUtil.h"

#import "XYZImageUtil.h"

@implementation XYZImageUtil

- (UIImage *)getImage:(NSString *)fileName ofType:(NSString *)imageType
{
    XYZFileUtil *fileUtil = [[XYZFileUtil alloc] init];
    
    if(![fileUtil exists:fileName])
    {
        NSString *stringUrl = [NSString stringWithFormat:@"http://conferences.dotrow.com/images/%@/%@", imageType, fileName];
        
        NSData *data = [[XYZUrlUtil alloc] dataFrom:stringUrl];
        
        if (data != nil)
        {
            NSString *filePath = [fileUtil path:fileName];
            [data writeToFile:filePath atomically:YES];
            
            return [UIImage imageWithData:data];
        }
    }
    
    return [UIImage imageWithContentsOfFile:[fileUtil path:fileName]];
}


@end
