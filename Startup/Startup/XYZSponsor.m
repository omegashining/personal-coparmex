//
//  XYZSponsor.m
//  Startup
//
//  Created by Gabriel Baltazar Perez on 2/11/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZSponsor.h"

@implementation XYZSponsor

- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary {
    if(self = [self init]) {
        _identifier = [jsonDictionary objectForKey:@"_id"];
        _name = [jsonDictionary objectForKey:@"name"];
        _email = [jsonDictionary objectForKey:@"email"];
        _url = [jsonDictionary objectForKey:@"url"];
        _image = [jsonDictionary objectForKey:@"image"];
        _type = [jsonDictionary objectForKey:@"type"];
        _subtype = [jsonDictionary objectForKey:@"subtype"];
    }
    
    return self;
}

@end
