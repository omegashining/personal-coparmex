//
//  XYZEvent.h
//  Startup
//
//  Created by Gabriel Baltazar Perez on 12/30/13.
//  Copyright (c) 2013 Gabriel Baltazar Perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZEvent : NSObject

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *startDate;
@property (strong, nonatomic) NSString *endDate;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *organization;

@property (assign, nonatomic) BOOL alarm;
@property (assign, nonatomic) BOOL stared;
@property (strong, nonatomic) NSString *starsImage;

- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary;

@end
