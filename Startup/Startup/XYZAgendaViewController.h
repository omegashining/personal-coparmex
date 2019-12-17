//
//  XYZProximosEventosViewController.h
//  Startup
//
//  Created by Gabriel Baltazar Perez on 12/26/13.
//  Copyright (c) 2013 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZEvent.h"
#import <UIKit/UIKit.h>

@interface XYZAgendaViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>

@property BOOL conferences;

@property NSMutableArray *events;
@property NSMutableArray *filterEvents;
@property NSMutableArray *searchEvents;

-(IBAction)goToSearch:(id)sender;

@end
