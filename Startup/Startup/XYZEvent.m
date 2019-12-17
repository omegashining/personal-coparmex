//
//  XYZEvent.m
//  Startup
//
//  Created by Gabriel Baltazar Perez on 12/30/13.
//  Copyright (c) 2013 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZEvent.h"

@implementation XYZEvent

- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary {
    if(self = [self init]) {
        _identifier = [jsonDictionary objectForKey:@"_id"];
        if (_identifier == nil) {
            _identifier = @"";
        }
        
        _type = [jsonDictionary objectForKey:@"type"];
        if (_type == nil) {
            _type = @"";
        }
        
        _title = [jsonDictionary objectForKey:@"title"];
        if (_title == nil) {
            _title = @"";
        }
        
        _location = [jsonDictionary objectForKey:@"location"];
        if (_location == nil) {
            _location = @"";
        }
        
        _description = [jsonDictionary objectForKey:@"description"];
        if (_description == nil) {
            _description = @"";
        }
        
        _image = [jsonDictionary objectForKey:@"image"];
        if (_image == nil) {
            _image = @"";
        }
        
        _author = [jsonDictionary objectForKey:@"author"];
        if (_author == nil) {
            _author = @"";
        }
        
        _organization = [jsonDictionary objectForKey:@"organization"];
        if (_organization == nil) {
            _organization = @"";
        }
        
        _starsImage = [jsonDictionary objectForKey:@"starsImage"];
        if (_starsImage == nil) {
            _starsImage = @"";
        }
        
        NSString *value = [jsonDictionary objectForKey:@"alarm"];
        if (value == nil) {
            _alarm = NO;
        } else {
            _alarm = [value isEqualToString:@"0"] ? NO : YES;
        }
        
        value = [jsonDictionary objectForKey:@"stared"];
        if (value == nil) {
            _stared = NO;
        } else {
            _stared = [value isEqualToString:@"0"] ? NO : YES;
        }
        
        NSDateFormatter *dateR = [[NSDateFormatter alloc] init];
        [dateR setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
        NSDateFormatter *dateT = [[NSDateFormatter alloc] init];
        [dateT setDateFormat:@"dd/MM/yyy HH:mm"];
        
        if ([_type isEqualToString:@"conference"]) {
            NSString *date = [dateT stringFromDate:[dateR dateFromString:[jsonDictionary objectForKey:@"date"]]];
            _startDate = date;
            _endDate = date;
        } else {
            _startDate = [dateT stringFromDate:[dateR dateFromString:[jsonDictionary objectForKey:@"startDate"]]];
            _endDate = [dateT stringFromDate:[dateR dateFromString:[jsonDictionary objectForKey:@"endDate"]]];
        }
        
        if (_startDate == nil) {
            _startDate = [jsonDictionary objectForKey:@"startDate"];
        }
        if (_endDate == nil) {
            _endDate = [jsonDictionary objectForKey:@"endDate"];
        }
    }
    
    return self;
}

@end
