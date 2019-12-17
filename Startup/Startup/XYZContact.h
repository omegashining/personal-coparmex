//
//  XYZCard.h
//  Startup
//
//  Created by Gabriel Baltazar Perez on 2/4/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZContact : NSObject

@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *organization;
@property (strong, nonatomic) NSString *job;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *phone;

- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary;

@end
