//
//  XYZJSONLoader.m
//  Startup
//
//  Created by Gabriel Baltazar Perez on 1/22/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZFileUtil.h"

#import "XYZAppDelegate.h"
#import "XYZContact.h"
#import "XYZEvent.h"
#import "XYZSponsor.h"

#import "XYZJsonUtil.h"

@implementation XYZJsonUtil

- (NSString *)hash
{
    NSData *data = [[XYZFileUtil alloc] dataFrom:@"login.json"];
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSString *hash = [dictionary objectForKey:@"hash"];
    
    return hash;
}

- (NSDate *)date
{
    NSDateFormatter *dateT = [[NSDateFormatter alloc] init];
    [dateT setDateFormat:@"dd/MM/yyy HH:mm"];
    
    NSDate *date = [dateT dateFromString:@"08/04/2014 19:30"];
    
    return date;
}

- (void)addContactFrom:(NSData *)data to:(NSMutableArray *)contacts
{
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    XYZContact *contactToAdd = [[XYZContact alloc] initWithJSONDictionary:dictionary];
    
    BOOL exists = NO;
    for (XYZContact *contact in contacts)
    {
        if ([contact.code isEqualToString:contactToAdd.code])
        {
            exists = YES;
            break;
        }
    }
    
    if (!exists) {
        [contacts addObject:contactToAdd];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *data = [self contactsDataFrom:contacts];
            
            [[XYZFileUtil alloc] saveData:data inFile:@"contacts.json"];
        });
    } else {
        [[[UIAlertView alloc] initWithTitle:@"No se puede agregar el contacto" message:@"El contacto ya esta en su lista de contactos." delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil] show];
    }
}

- (NSMutableArray *)contactsFrom:(NSString *)fileName
{
    NSMutableArray *contacts = [[NSMutableArray alloc] init];
    
    NSArray *array = [self arrayFrom:fileName];
    
    if (array != nil)
    {
        for(NSDictionary *dictionary in array)
        {
            XYZContact *contact = [[XYZContact alloc] initWithJSONDictionary:dictionary];
            
            [contacts addObject:contact];
        }
    }
    
    return contacts;
}

- (NSData *)contactsDataFrom:(NSMutableArray *)contacts
{
    NSArray *keys = [NSArray arrayWithObjects:@"code", @"name", @"organization", @"job", @"email", @"phone", nil];
    
    NSMutableArray *jsonData = [NSMutableArray array];
    
    for (XYZContact *contact in contacts)
    {
        NSArray *objects = [NSArray arrayWithObjects:contact.code, contact.name, contact.organization, contact.job, contact.email, contact.phone, nil];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        [jsonData addObject:dictionary];
    }
    
    return [NSJSONSerialization dataWithJSONObject:jsonData options:NSJSONWritingPrettyPrinted error:nil];
}

- (NSMutableArray *)eventsFrom:(NSString *)fileName
{
    NSMutableArray *events = [[NSMutableArray alloc] init];
    
    NSArray *array = [self arrayFrom:fileName];
    
    if (array != nil)
    {
        for(NSDictionary *dictionary in array)
        {
            XYZEvent *event = [[XYZEvent alloc] initWithJSONDictionary:dictionary];
            [events addObject:event];
        }
    }
    
    return events;
}

- (NSData *)eventsDataFrom:(NSMutableArray *)events
{
    NSArray *keys = [NSArray arrayWithObjects:@"_id", @"type", @"title", @"startDate", @"endDate", @"location", @"description", @"image", @"author", @"organization", @"alarm", @"stared", @"starsImage", nil];
    
    NSMutableArray *jsonData = [NSMutableArray array];
    
    for (XYZEvent *event in events)
    {
        NSArray *objects = [NSArray arrayWithObjects:event.identifier, event.type, event.title, event.startDate, event.endDate, event.location, event.description, event.image, event.author, event.organization, event.alarm?@"1":@"0", event.stared?@"1":@"0", event.starsImage, nil];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        [jsonData addObject:dictionary];
    }
    
    return [NSJSONSerialization dataWithJSONObject:jsonData options:NSJSONWritingPrettyPrinted error:nil];
}

- (NSMutableArray *)sponsorsFrom:(NSString *)fileName
{
    NSMutableArray *sponsors = [[NSMutableArray alloc] init];
    
    NSArray *array = [self arrayFrom:fileName];
    
    if (array != nil)
    {
        NSMutableArray *section1 = [[NSMutableArray alloc] init];
        NSMutableArray *section2 = [[NSMutableArray alloc] init];
        NSMutableArray *section3 = [[NSMutableArray alloc] init];
        for(NSDictionary *dictionary in array)
        {
            XYZSponsor *sponsor = [[XYZSponsor alloc] initWithJSONDictionary:dictionary];
            
            NSString *subtype = sponsor.subtype;
            
            if ([subtype isEqualToString:@"sponsor"]) {
                [section1 addObject:sponsor];
            } else if ([subtype isEqualToString:@"allied"]) {
                [section2 addObject:sponsor];
            } else {
                [section3 addObject:sponsor];
            }
        }
        
        sponsors = [[NSMutableArray alloc] initWithObjects:section1, section2, section3, nil];
    }
    
    return sponsors;
}

- (NSArray *)arrayFrom:(NSString *)fileName
{
    NSData *data = [[XYZFileUtil alloc] dataFrom:fileName];
    
    if (data != nil)
    {
        return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    }
    
    [self noConnection];
        
    return nil;
}

- (void)noConnection
{
    [[[UIAlertView alloc] initWithTitle:@"No hay conexión a internet" message:@"Debes estar conectado a internet para cargar esta información." delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil] show];
}


@end
