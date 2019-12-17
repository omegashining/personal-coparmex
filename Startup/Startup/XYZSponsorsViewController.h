//
//  XYZPatrocinadoresViewController.h
//  Startup
//
//  Created by Gabriel Baltazar Perez on 1/23/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZSponsorsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property NSArray *headers;
@property NSMutableArray *sponsors;

@end
