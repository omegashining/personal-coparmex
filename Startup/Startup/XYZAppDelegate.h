//
//  XYZAppDelegate.h
//  Startup
//
//  Created by Gabriel Baltazar Perez on 12/26/13.
//  Copyright (c) 2013 Gabriel Baltazar Perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic) NSString *hash;
@property (nonatomic) NSDate *date;

@property (nonatomic) BOOL authenticated;

@property (strong, nonatomic) UIWindow *window;

@end
