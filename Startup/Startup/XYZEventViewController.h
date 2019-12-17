//
//  XYZEventoViewController.h
//  Startup
//
//  Created by Gabriel Baltazar Perez on 1/3/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZEvent.h"

#import <UIKit/UIKit.h>

@interface XYZEventViewController : UIViewController<UIAlertViewDelegate>

@property NSString *idEvent;
@property XYZEvent *event;

@end
