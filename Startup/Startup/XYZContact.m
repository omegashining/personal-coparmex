//
//  XYZCard.m
//  Startup
//
//  Created by Gabriel Baltazar Perez on 2/4/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZContact.h"

@implementation XYZContact

- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary {
    if(self = [self init]) {
        _code = [jsonDictionary objectForKey:@"code"];
        _name = [jsonDictionary objectForKey:@"name"];
        _organization = [jsonDictionary objectForKey:@"organization"];
        _job = [jsonDictionary objectForKey:@"job"];
        _email = [jsonDictionary objectForKey:@"email"];
        _phone = [jsonDictionary objectForKey:@"phone"];
    }
    
    return self;
}

@end
