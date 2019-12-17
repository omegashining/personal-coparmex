//
//  XYZSponsor.h
//  Startup
//
//  Created by Gabriel Baltazar Perez on 2/11/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZSponsor : NSObject

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *subtype;

- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary;

@end
