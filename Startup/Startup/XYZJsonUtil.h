//
//  XYZJSONLoader.h
//  Startup
//
//  Created by Gabriel Baltazar Perez on 1/22/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZContact.h"

#import <Foundation/Foundation.h>

@interface XYZJsonUtil : NSObject

- (NSString *)hash;

- (NSDate *)date;

- (void)addContactFrom:(NSData *)data to:(NSMutableArray *)contacts;

- (NSMutableArray *)contactsFrom:(NSString *)fileName;

- (NSData *)contactsDataFrom:(NSMutableArray *)contacts;

- (NSMutableArray *)eventsFrom:(NSString *)fileName;

- (NSData *)eventsDataFrom:(NSMutableArray *)events;

- (NSMutableArray *)sponsorsFrom:(NSString *)fileName;

@end
